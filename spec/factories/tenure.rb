FactoryBot.define do
    factory :tenure, class: Tenure do
        start_date {Faker::Time.between(from: DateTime.now - 1000, to: DateTime.now, format: :default) }
        association :employee, factory: :employee
    end
end