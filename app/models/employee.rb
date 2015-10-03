class Employee < ActiveRecord::Base
  has_many :salaries, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :start_date, presence: true
  validates :starting_salary, presence: true

  default_scope { order :first_name }

  def self.current
    where 'start_date <= ? AND (end_date IS NULL OR end_date >= ?)', Date.today, Date.today
  end
  def self.non_current
    where 'start_date > ? OR end_date < ?', Date.today, Date.today
  end
  def self.future
    where 'start_date > ?', Date.today
  end
  def self.past
    where 'end_date < ?', Date.today
  end
  def self.billed
    where billable: true
  end
  def self.support
    where billable: false
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
    data = [{c: [start_date, starting_salary]}]

    salaries.ordered_dates_with_previous_dates.each do |date|
      data << {c: [date, salary_on(date)]}
    end

    if end_date
      data << {c: [end_date, ending_salary]}
    elsif employed_on?(Date.today) && !has_future_raise?
      data << {c: [Date.today, salary_on(Date.today)]}
    end
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
    months = days_employed%365 /30

    "#{years} years, #{months} months"
  end

  def all_experience_formatted
    "Here: #{experience_here_formatted}\nPrior: #{direct_experience} months direct," +
      " #{indirect_experience} months indirect"
  end

  def current_or_last_pay
    salary_on(Date.today) || ending_salary || starting_salary
  end

  def self.ordered_start_dates
    select('distinct start_date').unscoped.order('start_date').map(&:start_date)
  end

  def experience_tooltip
    "#{first_name}:\n#{all_experience_formatted}\n\$#{current_or_last_pay} salary"
  end

  private

  def days_employed
    return 0 if Date.today < start_date

    experience_end = [end_date, Date.today].compact.min
    (experience_end - start_date).to_i
  end

  def prior_experience_day_equivalent
    (direct_experience * 15) + (indirect_experience * 8)
  end

  def has_future_raise?
    salaries.last && (salaries.last.start_date > Date.today)
  end
end
