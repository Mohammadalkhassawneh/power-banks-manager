FactoryBot.define do
    factory :user do
      email { "test3@example.com" }
      password { "password3" }
      jti { SecureRandom.uuid }
      role { "user" }

      trait :admin do
        role { "admin" }
      end
    end
  end

