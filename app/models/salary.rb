class Salary < ActiveRecord::Base
  belongs_to :employee, dependent: :destroy
  validates :start_date, presence: true
  validates :annual_amount, presence: true
end
