class Employee < ActiveRecord::Base
  has_many :salaries

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :billable, presence: true
end
