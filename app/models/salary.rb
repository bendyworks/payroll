class Salary < ActiveRecord::Base
  belongs_to :employee, dependent: :destroy
  validates :start_date, presence: true
  validates :annual_amount, presence: true

  def self.ordered_dates
    select('distinct start_date').order('start_date').map(&:start_date)
  end
end
