# == Schema Information
#
# Table name: actions
#
#  id             :uuid             not null, primary key
#  sequence_id    :integer          not null
#  artifact_id    :uuid             not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  active         :boolean          default(TRUE), not null
#  identification :string           not null
#  type           :string           not null
#  description    :string
#  payload        :string           not null
#
# Indexes
#
#  index_actions_on_artifact_id     (artifact_id)
#  index_actions_on_identification  (identification) UNIQUE
#  index_actions_on_sequence_id     (sequence_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (artifact_id => artifacts.id)
#
class Action < ApplicationRecord
  include ActionTypeConcern
  include ActionPayloadConcern

  belongs_to :artifact

  validates :artifact, presence: true
  validates :identification, presence: true, uniqueness: true
  validates :type, presence: true, uniqueness: false
  validates :payload, presence: true, json: true
end
