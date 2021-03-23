# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    sequence(:first_name) { |n| "##{n}" }
    last_name { 'Bendyworker' }
    after :create do |employee|
      create_list :tenure, 1, employee: employee
    end

    trait :current do
      transient do
        end_date { Time.zone.today + 1 }
      end
      first_name { 'Current' }
      after(:create) do |employee, evaluator|
        employee.tenures = [FactoryBot.create(:tenure, end_date: evaluator.end_date)]
      end
    end

    trait :past do
      transient do
        start_date { Time.zone.today - 2}
        end_date { Time.zone.today - 1 }
      end
      first_name { 'Past' }
      after(:create) do |employee, evaluator|
        employee.tenures = [FactoryBot.create(:tenure, start_date: evaluator.start_date, end_date: evaluator.end_date)]
      end
    end

    trait :future do
      transient do
        start_date { Time.zone.today + 10 }
      end
      first_name { 'Future' }
      after(:create) do |employee, evaluator|
        employee.tenures = [FactoryBot.create(:tenure, start_date: evaluator.start_date)]
      end
    end

    trait :billable do
      billable { true }
    end

    trait :support do
      billable { false }
    end
  end
end
