module ActionPayloadConcern
  extend ActiveSupport::Concern

  class_methods do
    def validates_json_schema(attribute, schema:)
      validates attribute, presence: true, json_schema: { schema: schema }
    end
  end

  included do
    validates_json_schema :payload, schema: :action_payload
  end
end
