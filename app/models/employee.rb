# frozen_string_literal: true

class Employee < ActiveRecord::Base
  has_many :salaries, dependent: :destroy
  has_many :tenures, dependent: :destroy
  accepts_nested_attributes_for :tenures, reject_if: proc { |attributes| attributes['start_date'].blank? }, allow_destroy: true

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :starting_salary, presence: true

  default_scope { order :first_name }
  scope :past, -> { joins(:tenures).where 'tenures.end_date < :today', today: Time.zone.today }
  scope :current, lambda {
    joins(:tenures).where 'tenures.start_date <= :today AND (tenures.end_date IS NULL OR tenures.end_date >= :today)',
          today: Time.zone.today
  }
  scope :future, -> { joins(:tenures).where 'tenures.start_date > :today', today: Time.zone.today }
  scope :non_current, lambda {
    joins(:tenures).where 'tenures.start_date > :today OR tenures.end_date < :today', today: Time.zone.today
  }
  scope :billed, -> { where billable: true }
  scope :support, -> { where billable: false }

  def self.past_or_current
    joins(:tenures).where '(tenures.start_date <= :today AND (tenures.end_date IS NULL OR tenures.end_date >= :today))' \
          ' or tenures.end_date < :today', today: Time.zone.today
  end

  def self.current_or_future
    joins(:tenures).where '(tenures.start_date <= :today AND (tenures.end_date IS NULL OR tenures.end_date >= :today))' \
          ' or tenures.start_date > :today', today: Time.zone.today
  end

  def start_date
    tenures.first.start_date
  end

  def end_date
    tenures.first.end_date
  end

  def employed_on?(date)
    date >= start_date && (end_date.nil? || date <= end_date)
  end

  def display_name
    "#{first_name} #{last_name}"
  end

  def salary_on(date)
    return nil unless employed_on?(date)

    salary_match = salaries.where('start_date <= ?', date).last
    salary_match ? salary_match.annual_amount : starting_salary
  end

  def salary_data
    data = [{ c: [date_for_js(start_date), starting_salary] }]

    salaries.ordered_dates_with_previous_dates.each do |date|
      data << { c: [date_for_js(date), salary_on(date)] }
    end

    ending_salary_hash = ending_salary_data_hash
    data << ending_salary_hash if ending_salary_hash
    data
  end

  def ending_salary
    end_date ? salary_on(end_date) : nil
  end

  def weighted_years_experience
    (days_employed + prior_experience_day_equivalent) / 365.0
  end

  def experience_here_formatted
    years = days_employed / 365
    months = days_employed % 365 / 30

    "#{years} years, #{months} months"
  end

  def all_experience_formatted
    "Here: #{experience_here_formatted}\nPrior: #{direct_experience} months direct," \
      " #{indirect_experience} months indirect"
  end

  def current_or_last_pay
    salary_on(Time.zone.today) || ending_salary || starting_salary
  end

  def display_pay
    format_salary current_or_last_pay
  end

  def display_previous_pay
    format_salary(previous_pay)
  end

  def previous_pay
    if salaries.empty?
      nil
    else
      salaries[-2].try(:annual_amount) || starting_salary
    end
  end

  def last_raise_date
    if salaries.empty?
      start_date
    else
      salaries.last.try(:start_date)
    end
  end

  def experience_tooltip
    "#{first_name}:\n#{all_experience_formatted}\n\$#{current_or_last_pay} salary"
  end

  def employee_path_for_js
    Rails.application.routes.url_helpers.employee_path(self)
  end

  def bip_planning_raise_date
    planning_raise_date.try(:strftime, '%m/%d/%Y')
  end

  def new_start_date
    start_date
  end

  private

  def date_for_js(date)
    # Multiply by 1000 to convert from seconds since the epoch to
    # milliseconds since the epoch
    date.to_time.to_f * 1000
  end

  def ending_salary_data_hash
    if end_date
      { c: [date_for_js(end_date), ending_salary] }
    elsif employed_on?(Time.zone.today) && !future_raise?
      { c: [date_for_js(Time.zone.today), salary_on(Time.zone.today)] }
    end
  end

  def days_employed
    return 0 if Time.zone.today < start_date

    experience_end = [end_date, Time.zone.today].compact.min
    (experience_end - start_date).to_i
  end

  def prior_experience_day_equivalent
    (direct_experience * 15) + (indirect_experience * 8)
  end

  def future_raise?
    salaries.last && (salaries.last.start_date > Time.zone.today)
  end

  def format_salary(salary)
    if salary
      salary_in_ks = salary / 1000
      "$#{format('%g', salary_in_ks)}K"
    end
  end
end
