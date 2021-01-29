# frozen_string_literal: true

class Tenure < ActiveRecord::Base
  belongs_to :employee
  validates :start_date, presence: true, uniqueness: { scope: :employee_id }
  validates :employee, presence: true
  validate :tenures_are_sequential, if: :employee

  def self.ordered_start_dates
    select('distinct start_date').unscoped.order('start_date').map(&:start_date)
  end

  def previous_tenure
    employee.tenures.where("id < ?", id).last
  end

  def next_tenure
    employee.tenures.where("id > ?", id).first
  end

  private

  def tenures_are_sequential
    unless !previous_tenure || previous_tenure.end_date < start_date
      errors.add(:start_date, 'must be after the previous end date')
    end
    unless !next_tenure || next_tenure.start_date > end_date
      errors.add(:end_date, 'must be before the next start date')
    end
  end
end