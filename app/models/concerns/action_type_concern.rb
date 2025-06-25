module ActionTypeConcern
  extend ActiveSupport::Concern

  VALID_TYPES = %w[artifact_update].freeze

  included do
    validates :type, presence: true, inclusion: { in: VALID_TYPES }
  end
end
