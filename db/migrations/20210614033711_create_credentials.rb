Hanami::Model.migration do
  change do
    alter_table :users do
      drop_column :client_key
      drop_column :client_secret
    end

    create_table :credentials do
      primary_key :id

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
      foreign_key :user_id, :users, null: false
      column :uuid, String, null: false, unique: true, default: Hanami::Model::Sql.function(:uuid_generate_v4)
      column :client_key, String, null: false, unique: true
      column :client_secret, String, null: false, unique: true
      column :description, String, null: true
      column :is_active, TrueClass, null: false, default: true

      index :uuid, unique: true
      index :client_key, unique: true
    end
  end
end
