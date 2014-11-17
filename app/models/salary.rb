class Salary < ActiveRecord::Base
  belongs_to :employee, dependent: :destroy
  validates :start_date, presence: true
  validates :annual_amount, presence: true

  default_scope { order('start_date') }

  def self.ordered_dates
     self.all.map(&:start_date)
  end
end
