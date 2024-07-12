FactoryBot.define do
  factory :wheel do
    title { "Ruby on Rails" }
    association :user, factory: :user
  end
end
