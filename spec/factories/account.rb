FactoryBot.define do
    factory :account, class: Account do
        name {Faker::String.random(length: 3..30)}
        account_type_id { 3 }
    end
end