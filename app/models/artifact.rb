# == Schema Information
#
# Table name: artifacts
#
#  id          :uuid             not null, primary key
#  sequence_id :integer          not null
#  user_id     :uuid             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  active      :boolean          default(TRUE), not null
#  full_name   :string           not null
#  description :string
#
# Indexes
#
#  index_artifacts_on_full_name    (full_name) UNIQUE
#  index_artifacts_on_sequence_id  (sequence_id) UNIQUE
#  index_artifacts_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Artifact < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :full_name, presence: true, uniqueness: false
end
