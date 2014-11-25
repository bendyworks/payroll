class Salary < ActiveRecord::Base
  belongs_to :employee, dependent: :destroy
  validates :start_date, presence: true, uniqueness: { scope: :employee }
  validates :annual_amount, presence: true

  def self.ordered_dates
    select('distinct start_date').order('start_date').map(&:start_date)
  end

  def self.ordered_dates_with_previous_dates
    ordered_dates.map { |date| [date-1, date] }.flatten
  end
end
