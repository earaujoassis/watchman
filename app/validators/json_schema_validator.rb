class JsonSchemaValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    begin
      parsed_json = JSON.parse(value)
      schema = get_schema(options[:schema])

      errors = validate_schema(parsed_json, schema)
      errors.each { |error| record.errors.add(attribute, error) }
    rescue JSON::ParserError
      record.errors.add(attribute, "must be valid JSON")
    end
  end

  private

  def get_schema(schema_name)
    schema_path = Rails.root.join("app", "schemas", "#{schema_name}.json")
    JSON.parse(File.read(schema_path))
  end

  def validate_schema(data, schema)
    errors = []

    schema["required"]&.each do |field|
      errors << "missing required field: #{field}" unless data.key?(field)
    end

    schema["properties"]&.each do |field, rules|
      next unless data.key?(field)

      if rules["type"] && !valid_type?(data[field], rules["type"])
        errors << "#{field} must be of type #{rules['type']}"
      end
    end

    errors
  end

  def valid_type?(value, expected_type)
    case expected_type
    when "string" then value.is_a?(String)
    when "integer" then value.is_a?(Integer)
    when "boolean" then [ true, false ].include?(value)
    when "array" then value.is_a?(Array)
    when "object" then value.is_a?(Hash)
    else true
    end
  end
end
