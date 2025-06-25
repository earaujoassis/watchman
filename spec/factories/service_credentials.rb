FactoryBot.define do
  factory :service_credential do
    sequence_id { 1 }
    association :user
    active { true }
    url { Faker::Internet.url }
    client_key { Faker::Alphanumeric.alphanumeric(number: 32) }
    client_secret { Faker::Alphanumeric.alphanumeric(number: 64) }
  end
end
