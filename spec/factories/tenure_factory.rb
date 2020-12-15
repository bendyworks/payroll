# frozen_string_literal: true

FactoryBot.define do
  factory :tenure do
    start_date { Date.parse('2013-2-1') }
    employee
  end
end