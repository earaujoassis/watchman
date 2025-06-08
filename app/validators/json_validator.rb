class JsonValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    JSON.parse(value)
  rescue JSON::ParserError
    record.errors.add(attribute, "must be valid JSON")
  end
end
