# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table :users do
      set_column_not_null :passphrase
    end
  end
end
