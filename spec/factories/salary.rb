FactoryBot.define do
    factory :salary, class: Salary do
        start_date { Faker::Date.between(from: Date.today, to: Date.today + 40) }
        annual_amount { Faker::Number.decimal(l_digits: 5, r_digits: 2) }
        created_at { Faker::Time.backward(days: 10, period: :evening) }
        association :employee, factory: :employee
    end
end