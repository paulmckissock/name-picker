FactoryBot.define do
  factory :participant do
    name { "Joe" }
    association :wheel, factory: :wheel
  end
end
