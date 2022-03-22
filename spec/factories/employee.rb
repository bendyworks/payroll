FactoryBot.define do
    factory :employee, class: Employee do
        first_name { Faker::Lorem.characters(number: 20, min_alpha: 3) }
        last_name { Faker::Lorem.characters(number: 20, min_alpha: 3) }
        billable { true }
        direct_experience { Faker::Number.between(from: 1, to: 10) }
        indirect_experience { Faker::Number.between(from: 1, to: 10) }
        starting_salary { Faker::Number.decimal(l_digits: 5, r_digits: 2) }
        planning_raise_date { Faker::Time.between(from: DateTime.now + 365, to: DateTime.now + 700, format: :default) }
        planning_raise_salary { Faker::Number.decimal(l_digits: 6, r_digits: 2) }
        planning_notes { Faker::Lorem.characters(number: 20, min_alpha: 3) }

        factory :past_employee, class: Employee do
            billable { false }
        end
    end
end