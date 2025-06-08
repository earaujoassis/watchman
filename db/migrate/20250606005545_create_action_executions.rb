class CreateActionExecutions < ActiveRecord::Migration[8.0]
  def change
    create_table :action_executions, id: :uuid do |t|
      t.serial :sequence_id
      t.references :action, null: false, foreign_key: true, type: :uuid

      t.timestamps

      t.string :identification
      t.string :type, null: false
      t.string :description
      t.string :payload, null: false
      t.string :current_status, default: 'pending', null: false
      t.string :status_reason, default: 'created on database', null: false
      t.text :logs
    end

    add_index :action_executions, :sequence_id, unique: true
    add_index :action_executions, :identification, unique: true
  end
end
