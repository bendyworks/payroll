# frozen_string_literal: true

FactoryBot.define do
  factory :balance do
    account { create :account }
    date { Time.zone.today }
    amount { 109.71 }
  end
end
