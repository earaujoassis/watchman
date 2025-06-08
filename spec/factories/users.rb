# == Schema Information
#
# Table name: users
#
#  id          :uuid             not null, primary key
#  sequence_id :integer          not null
#  public_id   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  active      :boolean
#
# Indexes
#
#  index_users_on_public_id    (public_id) UNIQUE
#  index_users_on_sequence_id  (sequence_id) UNIQUE
#

FactoryBot.define do
  factory :user do
    sequence_id { 1 }
    public_id { Faker::Alphanumeric.alphanumeric(number: 32) }
    active { true }
  end
end
