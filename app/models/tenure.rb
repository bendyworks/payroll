# frozen_string_literal: true

class Tenure < ActiveRecord::Base
  belongs_to :employee
  validates :start_date, presence: true, uniqueness: { scope: :employee_id }
  validates :employee, presence: true

  def self.ordered_start_dates
    select('distinct start_date').unscoped.order('start_date').map(&:start_date)
  end
end