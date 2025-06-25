FactoryBot.define do
  factory :git_credential do
    sequence_id { 1 }
    association :user
    active { true }
    identification { Faker::Internet.slug }
    committer_identification { Faker::Internet.slug }
    username { Faker::Internet.username }
    password { Faker::Internet.password }
  end
end
