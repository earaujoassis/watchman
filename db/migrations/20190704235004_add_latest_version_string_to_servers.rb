Hanami::Model.migration do
  change do
    alter_table :servers do
      add_column :latest_version, String, null: true

      add_index :latest_version
    end
  end
end
