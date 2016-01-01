FactoryGirl.define do
  factory :balance do
    account
    date Time.zone.today
    amount 109.71
  end
end
