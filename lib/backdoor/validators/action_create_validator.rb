class ActionCreateValidator
  json do
    required(:type).value(Types::StrippedString)
    optional(:description).value(Types::StrippedString)
    required(:payload).json do
      required(:managed_realm).value(Types::StrippedString)
      required(:managed_project).value(Types::StrippedString)
    end
  end
end
