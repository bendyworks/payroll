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

  def experience
    end_experience = end_date || Date.today
    (end_experience - start_date) / 365.0
  end
end
