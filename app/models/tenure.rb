# frozen_string_literal: true

class Tenure < ActiveRecord::Base
  belongs_to :employee
  has_many :salaries

  validates :start_date, presence: true, uniqueness: { scope: :employee_id }
  validates :employee, presence: true
  validate :tenures_are_sequential, if: :employee
  validate :start_date_is_before_end_date

  default_scope { order :start_date }

  def self.ordered_start_dates
    select('distinct start_date').unscoped.order('start_date').map(&:start_date).uniq
  end

  def self.ordered_end_dates_with_next_dates
    end_dates = select('distinct end_date').unscoped.order('end_date').map(&:end_date).compact
    end_dates.map { |date| [date, date + 1] }.flatten.uniq
  end

  def previous_tenure
    employee.tenures.where("id < ?", id).last
  end

  def next_tenure
    employee.tenures.where("id > ?", id).first
  end

  def employed_on?(date)
    return nil if date.nil?
    date >= start_date && (end_date.nil? || date <= end_date)
  end

  private

  def start_date_is_before_end_date
    unless !end_date || start_date < end_date
      errors.add(:end_date, 'must be after start date')
    end
  end

  def tenures_are_sequential
    unless !previous_tenure || previous_tenure.end_date < start_date
      errors.add(:start_date, 'must be after the previous end date')
    end
    unless !next_tenure || next_tenure.start_date > end_date
      errors.add(:end_date, 'must be before the next start date')
    end
  end
end
