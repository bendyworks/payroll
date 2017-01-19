# frozen_string_literal: true
class Employee < ActiveRecord::Base
  has_many :salaries, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :start_date, presence: true
  validates :starting_salary, presence: true

  default_scope { order :first_name }
  scope :past, -> { where 'end_date < :today', today: Time.zone.today }
  scope :current, lambda {
    where 'start_date <= :today AND (end_date IS NULL OR end_date >= :today)',
          today: Time.zone.today
  }
  scope :future, -> { where 'start_date > :today', today: Time.zone.today }
  scope :non_current, lambda {
    where 'start_date > :today OR end_date < :today', today: Time.zone.today
  }
  scope :billed, -> { where billable: true }
  scope :support, -> { where billable: false }

  def self.current
    where 'start_date <= :today AND (end_date IS NULL OR end_date >= :today)',
          today: Time.zone.today
  end

  def self.past_or_current
    where '(start_date <= :today AND (end_date IS NULL OR end_date >= :today))' \
          ' or end_date < :today', today: Time.zone.today
  end

  def self.current_or_future
    where '(start_date <= :today AND (end_date IS NULL OR end_date >= :today))' \
          ' or start_date > :today', today: Time.zone.today
  end

  def employed_on?(date)
    date >= start_date && (end_date.nil? || date <= end_date)
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
    salary = current_or_last_pay
    salary_in_ks = salary / 1000
    "$#{format('%g', salary_in_ks)}K"
  end

  def self.ordered_start_dates
    select('distinct start_date').unscoped.order('start_date').map(&:start_date)
  end

  def experience_tooltip
    "#{first_name}:\n#{all_experience_formatted}\n\$#{current_or_last_pay} salary"
  end

  def employee_path_for_js
    Rails.application.routes.url_helpers.employee_path(self)
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
end
