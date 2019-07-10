Hanami::Model.migration do
  change do
    alter_table :users do
      add_column :client_key, String, null: true
      add_column :client_secret, String, null: true

      add_index :client_key
    end
  end
end
