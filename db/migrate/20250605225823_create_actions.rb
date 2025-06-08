class CreateActions < ActiveRecord::Migration[8.0]
  def change
    create_table :actions, id: :uuid do |t|
      t.serial :sequence_id
      t.references :artifact, null: false, foreign_key: true, type: :uuid

      t.timestamps

      t.boolean :active, default: true, null: false
      t.string :identification, null: false
      t.string :type, null: false
      t.string :description
      t.string :payload, null: false
    end

    add_index :actions, :sequence_id, unique: true
    add_index :actions, :identification, unique: true
  end
end
