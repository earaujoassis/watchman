Hanami::Model.migration do
  change do
    alter_table :actions do
      add_foreign_key :credential_id, :credentials, null: false
    end
  end
end
