# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :sessions do
      primary_key :id

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
      foreign_key :user_id, :users, null: false
      column :uuid, String, null: false, unique: true, default: Hanami::Model::Sql.function(:uuid_generate_v4)
      column :access_token, String, null: false, unique: true
      column :refresh_token, String, null: false, unique: true
      column :is_active, TrueClass, null: false, default: true

      index :uuid, unique: true
      index :access_token, unique: true
      index :refresh_token, unique: true
    end
  end
end
