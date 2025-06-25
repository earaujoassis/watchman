class CreateGitCredentials < ActiveRecord::Migration[8.0]
  def change
    create_table :git_credentials, id: :uuid do |t|
      t.serial :sequence_id
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps

      t.boolean :active, default: true, null: false
      t.string :identification, null: false
      t.string :committer_identification, null: false
      t.string :username, null: false
      t.string :password, null: false
    end

    add_index :git_credentials, :sequence_id, unique: true
    add_index :git_credentials, :identification, unique: true
  end
end
