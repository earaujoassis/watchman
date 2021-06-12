Hanami::Model.migration do
  change do
    alter_table :applications do
      drop_foreign_key :server_id
      drop_column :process_name
      drop_column :configuration_file
      drop_column :configuration_file_name

      add_column :managed_realm, String, null: false
      add_column :managed_projects, String, null: false
    end
  end
end
