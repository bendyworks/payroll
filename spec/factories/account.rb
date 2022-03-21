FactoryBot.define do
    factory :account, class: Account do
        name { Faker::Lorem.characters(number: 20, min_alpha: 3) }
        account_type_id { 3 }
    end
end