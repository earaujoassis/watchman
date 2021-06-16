class ApplicationCreateValidator < Hanami::Validator
  json do
    required(:full_name).value(Types::StrippedString)
    optional(:description).value(Types::StrippedString)
    required(:managed_realm).value(Types::StrippedString)
    optional(:managed_projects).value(Types::StrippedString)
  end
end
