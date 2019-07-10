Hanami::Model.migration do
  change do
    create_table :actions do
      primary_key :id

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
      column :uuid, String, null: false, unique: true, default: Hanami::Model::Sql.function(:uuid_generate_v4)
      foreign_key :application_id, :applications, null: false
      column :type, String, null: false
      column :description, String, null: true
      column :payload, String, null: false
      column :current_status, String, null: false
      column :status_reason, String, null: true
      column :report, File, null: true
    end
  end
end
