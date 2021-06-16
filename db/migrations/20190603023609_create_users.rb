# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :users do
      primary_key :id

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
      column :email, String, null: false, unique: true
      column :github_token, String, null: false
      column :category, String, null: false, unique: true

      index :email, unique: true
      index :category, unique: true
    end
  end
end
