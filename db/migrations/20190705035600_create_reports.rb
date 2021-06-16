# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :reports do
      primary_key :id

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
      foreign_key :server_id, :servers, null: false
      column :uuid, String, null: false, unique: true, default: Hanami::Model::Sql.function(:uuid_generate_v4)
      column :subject, String, null: false
      column :body, File, null: true
    end
  end
end
