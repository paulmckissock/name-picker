FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Test User #{n}" }
    password { "password" }
    password_confirmation { "password" }
  end
end
