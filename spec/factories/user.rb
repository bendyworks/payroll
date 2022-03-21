FactoryBot.define do
    factory :user, class: User do
        email { Faker::Internet.email }
        encrypted_password { Faker::Internet.password }
        password { Faker::Internet.password }
        admin { false }

        trait :accepted_invitation do
            invitation_accepted_at { DateTime.now - 2 }
        end
        trait :has_logged_in do
            last_sign_in_at { DateTime.now - 1 }
        end
        
        factory :admin, class: User do
            admin { true }
        end
    end
end