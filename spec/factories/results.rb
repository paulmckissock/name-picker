FactoryBot.define do
  factory :result do
    association :wheel, factory: :wheel
    association :user, factory: :user
  end
end
