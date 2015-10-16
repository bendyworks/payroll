FactoryGirl.define do
  factory :account do
    sequence(:name) { |n| "Account ##{n}"}
    account_type
  end
end
