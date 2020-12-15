# frozen_string_literal: true

class Tenure < ActiveRecord::Base
  belongs_to :employee
  validates :start_date, presence: true, uniqueness: { scope: :employee_id }
  validates :employee_id, presence: true
end