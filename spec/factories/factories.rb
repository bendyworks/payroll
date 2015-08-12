FactoryGirl.define do
  factory :employee do
    sequence(:first_name) { |n| "##{n}"}
    last_name 'Bendyworker'
    start_date Date.parse('2013-1-1')
    starting_salary 500

    trait :current do
      end_date Date.today + 1
    end

    trait :past do
      end_date Date.today - 1
    end

    trait :future do
      start_date Date.today + 10
    end

    trait :billable do
      billable true
    end

    trait :support do
      billable false
    end
  end

  factory :salary do
    start_date Date.parse('2013-2-1')
    annual_amount 700
    employee
  end

  factory :user do
    sequence(:email) { |n| "user#{n}@bendyworks.com" }
    password 'password'
  end
end
