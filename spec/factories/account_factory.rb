# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    sequence(:name) { |n| "Account ##{n}" }
    account_type { create :account_type }
  end
end
