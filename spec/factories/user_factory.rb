FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@bendyworks.com" }
    password 'password'

    trait :accepted_invitation do
      invitation_accepted_at Time.zone.now - 1.day
    end

    trait :has_logged_in do
      last_sign_in_at Time.zone.now - 1.hour
    end
  end
end
