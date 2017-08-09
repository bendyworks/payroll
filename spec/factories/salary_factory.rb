# frozen_string_literal: true

FactoryGirl.define do
  factory :salary do
    start_date Date.parse('2013-2-1')
    annual_amount 700
    employee
  end
end
