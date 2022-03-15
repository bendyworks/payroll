FactoryBot.define do
    factory :user, class: User do
        email { Faker::Internet.email }
        encrypted_password { Faker::Internet.password }
        password { Faker::Internet.password }
        invitation_accepted_at { DateTime.now - 1 }
        admin { false }
    end

    factory :admin, class: User do
        email { Faker::Internet.email }
        encrypted_password { Faker::Internet.password }
        password { Faker::Internet.password }
        invitation_accepted_at { DateTime.now - 1 }
        admin { true }
    end
end