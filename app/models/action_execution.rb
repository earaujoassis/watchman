# == Schema Information
#
# Table name: action_executions
#
#  id             :uuid             not null, primary key
#  sequence_id    :integer          not null
#  action_id      :uuid             not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  identification :string
#  type           :string           not null
#  description    :string
#  payload        :string           not null
#  current_status :string           default("pending"), not null
#  status_reason  :string           default("created on database"), not null
#  logs           :text
#
# Indexes
#
#  index_action_executions_on_action_id       (action_id)
#  index_action_executions_on_identification  (identification) UNIQUE
#  index_action_executions_on_sequence_id     (sequence_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (action_id => actions.id)
#
class ActionExecution < ApplicationRecord
  include ActionTypeConcern
  include ActionPayloadConcern

  belongs_to :action

  enum :current_status,
    { pending: "pending", active: "active", completed: "completed", failed: "failed" },
    default: :pending,
    prefix: true

  validates :action, presence: true
  validates :identification, presence: true, uniqueness: true
  validates :type, presence: true, uniqueness: false
  validates :payload, presence: true, json: true
  validates :current_status, presence: true, uniqueness: false
  validates :status_reason, presence: true, uniqueness: false
end
