FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "Test User #{n}" }
    password { "password" }
    password_confirmation { "password" }
  end
end
