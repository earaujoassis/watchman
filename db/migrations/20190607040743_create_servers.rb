Hanami::Model.migration do
  change do
    create_table :servers do
      primary_key :id

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
      column :uuid, String, null: false, unique: true, default: Hanami::Model::Sql.function(:uuid_generate_v4)
      column :hostname, String, null: false, unique: true
      column :ip, String, null: false

      index :uuid, unique: true
      index :hostname, unique: true
    end
  end
end
