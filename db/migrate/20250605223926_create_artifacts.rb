class CreateArtifacts < ActiveRecord::Migration[8.0]
  def change
    create_table :artifacts, id: :uuid do |t|
      t.serial :sequence_id
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps

      t.boolean :active, default: true, null: false
      t.string :full_name, null: false
      t.string :description
    end

    add_index :artifacts, :sequence_id, unique: true
    add_index :artifacts, :full_name, unique: true
  end
end
