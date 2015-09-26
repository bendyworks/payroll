FactoryGirl.define do
  factory :employee do
    sequence(:first_name) { |n| "##{n}"}
    last_name 'Bendyworker'
    start_date Date.parse('2013-1-1')
    starting_salary 500

    trait :current do
      end_date Date.today + 1
      first_name 'Current'
    end

    trait :past do
      end_date Date.today - 1
      first_name 'Past'
    end

    trait :future do
      start_date Date.today + 10
      first_name 'Future'
    end

    trait :billable do
      billable true
    end

    trait :support do
      billable false
    end
  end
end
