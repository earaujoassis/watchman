Hanami::Model.migration do
  change do
    alter_table :users do
      set_column_allow_null :github_token
      set_column_allow_null :passphrase
      add_column :external_user_id, String, null: false

      add_index :external_user_id, unique: true
    end
  end
end
