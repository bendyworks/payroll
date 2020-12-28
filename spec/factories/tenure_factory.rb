# frozen_string_literal: true

FactoryBot.define do
  factory :tenure do
    sequence(:start_date) { |n| Date.parse("2013-1-#{n}") }
    employee
  end
end