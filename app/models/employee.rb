class Employee < ActiveRecord::Base
  has_many :salaries

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :start_date, presence: true

  scope :current, -> { where('start_date < ? AND (end_date IS NULL OR end_date > ?)', Date.today, Date.today) }

  def employed_on?(date)
    date >= start_date && (end_date.nil? || date <= end_date)
  end

  def salary_on(date)
    return nil unless employed_on?(date)

    salary_match = salaries.where('start_date <= ?', date).order('start_date DESC').first
    salary_match.annual_amount
  end

  def weighted_years_experience
    (days_employed + prior_experience_day_equivalent) / 365.0
  end

  def formatted_experience
    years = days_employed / 365
    months = days_employed%365 /30

    "Here: #{years} years, #{months} months\nPrior: #{direct_experience} months direct, #{indirect_experience} months indirect"
  end

  private

  def days_employed
    experience_end = end_date || Date.today
    (experience_end - start_date).to_i
  end

  def prior_experience_day_equivalent
    (direct_experience * 15) + (indirect_experience * 8)
  end
end
