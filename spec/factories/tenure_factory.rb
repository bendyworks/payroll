# frozen_string_literal: true

FactoryBot.define do
  factory :tenure do
    sequence(:start_date) { |n| 1.year.ago + n.day }
    employee
  end
end