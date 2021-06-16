# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table :users do
      add_column :passphrase, String, null: true
    end
  end
end
