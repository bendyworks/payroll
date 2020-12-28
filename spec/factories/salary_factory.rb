# frozen_string_literal: true

FactoryBot.define do
  factory :salary do
    sequence(:start_date) { |n| 6.months.ago + n.day }
    annual_amount { 700 }
    employee
  end
end
