class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users, id: :uuid do |t|
      t.serial :sequence_id
      t.string :public_id

      t.timestamps

      t.boolean :active
    end

    add_index :users, :sequence_id, unique: true
    add_index :users, :public_id, unique: true
  end
end
