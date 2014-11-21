FactoryGirl.define do
  factory :employee do
    sequence(:first_name) { |n| "##{n}"}
    last_name 'Bendyworker'
    start_date 1.year.ago
  end

  factory :salary do
    start_date 1.year.ago
    annual_amount 700
    employee
  end

  factory :user do
    sequence(:email) { |n| "user#{n}@bendyworks.com" }
    password 'password'
  end
end
