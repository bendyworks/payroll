FactoryBot.define do
    factory :balance, class: Balance do
        account { create :account }
        date { Faker::Time.between(from: DateTime.now - 100, to: DateTime.now) }
        amount { Faker::Number.decimal(l_digits: 6, r_digits: 2) }
    end
end