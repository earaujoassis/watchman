# == Schema Information
#
# Table name: git_credentials
#
#  id                       :uuid             not null, primary key
#  sequence_id              :integer          not null
#  user_id                  :uuid             not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  active                   :boolean          default(TRUE), not null
#  identification           :string           not null
#  committer_identification :string           not null
#  username                 :string           not null
#  password                 :string           not null
#
# Indexes
#
#  index_git_credentials_on_identification  (identification) UNIQUE
#  index_git_credentials_on_sequence_id     (sequence_id) UNIQUE
#  index_git_credentials_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class GitCredential < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :identification, presence: true, uniqueness: true
  validates :committer_identification, presence: true, uniqueness: false
  validates :username, presence: true, uniqueness: false
  validates :password, presence: true, uniqueness: false
end
