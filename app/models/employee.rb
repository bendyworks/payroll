class Employee < ActiveRecord::Base
  has_many :salaries

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :start_date, presence: true
end
