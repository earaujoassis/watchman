class CreateServiceCredentials < ActiveRecord::Migration[8.0]
  def change
    create_table :service_credentials, id: :uuid do |t|
      t.serial :sequence_id
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps

      t.boolean :active, default: true, null: false
      t.string :url, null: false
      t.string :client_key, null: false
      t.string :client_secret, null: false
    end

    add_index :service_credentials, :sequence_id, unique: true
    add_index :service_credentials, :client_key, unique: true
  end
end
