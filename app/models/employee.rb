class Employee < ActiveRecord::Base
  has_many :salaries

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :start_date, presence: true

  def salary_on(date)
    return nil if date < start_date
    return nil if end_date && date > end_date

    salary_match = salaries.where('start_date <= ?', date).order('start_date DESC').first
    salary_match.annual_amount
  end

  def days_employed
    experience_end = end_date || Date.today
    (experience_end - start_date).to_i
  end

  def experience_num
    days_employed / 365.0
  end

  def experience_string
    years = days_employed / 365
    months = days_employed%365 /30

    "#{years} years, #{months} months"
  end
end
