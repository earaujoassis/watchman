FactoryBot.define do
  factory :artifact do
    sequence_id { 1 }
    association :user
    active { true }
    full_name { Faker::Internet.slug }
  end
end
