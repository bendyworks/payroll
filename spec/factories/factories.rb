FactoryGirl.define do
  factory :employee do
    sequence(:first_name) { |n| "##{n}"}
    last_name 'Bendyworker'
    start_date Date.parse('2013-1-1')
    starting_salary 500
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
