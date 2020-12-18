# frozen_string_literal: true
class Salary < ActiveRecord::Base
  belongs_to :employee
  validates :start_date, presence: true, uniqueness: { scope: :employee_id }
  validates :employee_id, presence: true
  validates :annual_amount, presence: true
  validate :no_salaries_outside_employment_dates, if: :employee

  delegate :first_name, :last_name, to: :employee, prefix: true

  default_scope { order('start_date') }

  def self.ordered_dates
    select('distinct start_date').order('start_date').map(&:start_date)
  end

  def self.ordered_dates_with_previous_dates
    ordered_dates.map { |date| [date - 1, date] }.flatten
  end

  def self.all_dates
    (Salary.history_dates << Time.zone.today).sort.uniq
  end

  def self.history_dates
    (Salary.ordered_dates_with_previous_dates + Employee.ordered_start_dates).sort.uniq
  end

  private

  def no_salaries_outside_employment_dates
    unless employee.employed_on?(start_date)
      errors.add(:start_date, 'must be between employee start and end dates')
    end
  end
end
