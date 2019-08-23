Hanami::Model.migration do
  change do
    alter_table :applications do
      add_foreign_key :server_id, :servers, null: false
      add_column :process_name, String, null: true
      add_column :configuration_file_name, String, null: true
      add_column :configuration_file, File, null: true
    end
  end
end
