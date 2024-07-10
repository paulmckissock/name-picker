FactoryBot.define do
  factory :participant do
    text { "Joe" }
    association :wheel, factory: :wheel
  end
end
