# frozen_string_literal: true

class Salary < ActiveRecord::Base
  belongs_to :tenure
  has_one :employee, through: :tenure
  validates :start_date, presence: true, uniqueness: { scope: :tenure_id }
  validates_presence_of :tenure
  validates :annual_amount, presence: true
  validate :no_salaries_outside_tenure_dates, if: :tenure

  delegate :first_name, :last_name, to: :employee, prefix: true
  delegate :start_date, to: :tenure, prefix: true

  before_validation :ensure_start_date

  default_scope { order('salaries.start_date') }

  def self.ordered_dates
    select('salaries.start_date').order('salaries.start_date').map(&:start_date).uniq
  end

  def self.ordered_dates_with_previous_dates
    ordered_dates.map { |date| [date - 1, date] }.flatten.tap(&:shift)
  end

  def self.all_dates
    (Salary.history_dates << Time.zone.today).sort.uniq
  end

  def self.history_dates
    (Salary.ordered_dates_with_previous_dates + Tenure.ordered_start_dates\
       + Tenure.ordered_end_dates_with_next_dates).sort.uniq
  end

  private

  def no_salaries_outside_tenure_dates
    unless tenure.employed_on?(start_date)
      errors.add(:start_date, 'must be between employee start and end dates')
    end
  end

  def ensure_start_date
    # first salary is entered as part of employee form so get start date from first tenure
    #  this depends on employee nested_attributes_for :tenures getting called first
    if start_date.blank? && employee&.salaries&.count == 0
      self.start_date = employee.start_date
    end
  end
end