# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :applications do
      primary_key :id

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
      foreign_key :user_id, :users, null: false
      column :uuid, String, null: false, unique: true, default: Hanami::Model::Sql.function(:uuid_generate_v4)
      column :full_name, String, null: false, unique: true
      column :description, String, null: true

      index :uuid, unique: true
      index :full_name, unique: true
    end
  end
end
