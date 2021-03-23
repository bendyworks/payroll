# frozen_string_literal: true

class Employee < ActiveRecord::Base
  has_many :salaries, dependent: :destroy
  has_many :tenures, dependent: :destroy
  accepts_nested_attributes_for :tenures,
    reject_if: proc { |attributes| attributes['start_date'].blank? }, allow_destroy: true

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :starting_salary, presence: true

  default_scope { order :first_name }
  scope :past, -> { joins(:tenures).where 'tenures.end_date < :today', today: Time.zone.today }
  scope :current, lambda {
    joins(:tenures).where 'tenures.start_date <= :today' \
          ' AND (tenures.end_date IS NULL OR tenures.end_date >= :today)', today: Time.zone.today
  }
  scope :future, -> { joins(:tenures).where 'tenures.start_date > :today', today: Time.zone.today }
  scope :non_current, lambda {
    joins(:tenures)
      .where('tenures.start_date = (SELECT MAX(tenures.start_date) ' \
             'FROM tenures WHERE tenures.employee_id = employees.id)')
      .group('employees.id')
      .where('tenures.start_date > :today OR tenures.end_date < :today', today: Time.zone.today)
  }
  scope :billed, -> { where billable: true }
  scope :support, -> { where billable: false }

  scope :past, lambda {
    joins(:tenures)
      .where('tenures.start_date = (SELECT MAX(tenures.start_date) ' \
             'FROM tenures WHERE tenures.employee_id = employees.id)')
      .group('employees.id')
      .where 'tenures.end_date < :today', today: Time.zone.today }

  scope :current, lambda {
    joins(:tenures).where 'tenures.start_date <= :today' \
          ' AND (tenures.end_date IS NULL OR tenures.end_date >= :today)', today: Time.zone.today
  }

  scope :past_or_current, lambda {
    joins(:tenures)
      .where('tenures.start_date = (SELECT MAX(tenures.start_date) ' \
             'FROM tenures WHERE tenures.employee_id = employees.id)')
      .group('employees.id')
      .where('(tenures.start_date <= :today' \
          ' AND (tenures.end_date IS NULL OR tenures.end_date >= :today))' \
          ' OR tenures.end_date < :today', today: Time.zone.today)
  }

  scope :current_or_future, lambda {
    joins(:tenures).where('(tenures.start_date <= :today' \
          ' AND (tenures.end_date IS NULL OR tenures.end_date >= :today))' \
          ' or tenures.start_date > :today', today: Time.zone.today)
  }

  scope :past_or_future, lambda {
    joins(:tenures)
    .where('tenures.start_date = (SELECT MAX(tenures.start_date) ' \
           'FROM tenures WHERE tenures.employee_id = employees.id)')
    .group('employees.id')
    .where('tenures.start_date > :today or tenures.end_date < :today', today: Time.zone.today)
  }

  def self.ordered_start_dates
    select('distinct start_date').unscoped.order('start_date').map(&:start_date)
  end

  def start_date
    (tenures.map { |tenure| tenure.start_date }).compact.min
  end

  def end_date
    end_dates = (tenures.map { |tenure| tenure.end_date })
    end_dates.include?(nil) ? nil : end_dates.min
  end

  def employed_on?(date)
    tenures.any? \
      { |tenure| date >= tenure.start_date && (tenure.end_date.nil? || date <= tenure.end_date) }
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
    data = []
    tenures.each do |tenure|
      data << { c: [date_for_js(tenure.start_date), salary_on(tenure.start_date)] }
    end

    salaries.ordered_dates_with_previous_dates.each do |date|
      data << { c: [date_for_js(date), salary_on(date)] }
    end

    for ending_salary_hash in ending_salary_data_hashes
      data << ending_salary_hash
    end
    data.sort_by { |salary| salary[:c][0]}
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

  def bip_planning_raise_date
    planning_raise_date.try(:strftime, '%m/%d/%Y')
  end

  private

  def date_for_js(date)
    # Multiply by 1000 to convert from seconds since the epoch to
    # milliseconds since the epoch
    date.to_time.to_f * 1000
  end

  def ending_salary_data_hashes
    data = []
    for tenure in tenures
      if tenure.end_date
        data << { c: [date_for_js(tenure.end_date), salary_on(tenure.end_date)] }
        if tenure != tenures.last
          data << { c: [date_for_js(tenure.end_date + 1), salary_on(tenure.end_date + 1)] }
        end
      elsif employed_on?(Time.zone.today) && !future_raise?
        data << { c: [date_for_js(Time.zone.today), salary_on(Time.zone.today)] }
      end
    end
    data
  end

  def days_employed
    total_days = 0
    for tenure in tenures
      break if Time.zone.today < tenure.start_date

      experience_end = [tenure.end_date, Time.zone.today].compact.min
      total_days += (experience_end - tenure.start_date).to_i
    end
    total_days
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
