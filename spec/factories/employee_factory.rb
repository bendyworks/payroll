# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    sequence(:first_name) { |n| "##{n}" }
    last_name { 'Bendyworker' }
    transient do
      starting_salary { 40_000 }
      sequence(:start_date) { |n| 1.year.ago + n.day }
      end_date { nil }
    end
    after :create do |employee, evaluator|
      create :tenure, employee: employee, start_date: evaluator.start_date, end_date: evaluator.end_date
      create :salary, tenure: employee.tenures.first, start_date: employee.tenures.first.start_date, annual_amount: evaluator.starting_salary
    end

    trait :current do
      transient do
        end_date { Time.zone.today + 1 }
        starting_salary { 40_000 }
      end
      first_name { 'Current' }
      after(:create) do |employee, evaluator|
        employee.tenures = [FactoryBot.create(:tenure, end_date: evaluator.end_date)]
        create :salary, tenure: employee.tenures.first, start_date: employee.tenures.first.start_date, annual_amount: evaluator.starting_salary
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
