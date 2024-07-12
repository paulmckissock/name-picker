FactoryBot.define do
  factory :result do
    association :wheel, factory: :wheel
    association :participant, factory: :participant
    association :user, factory: :user
  end
end
