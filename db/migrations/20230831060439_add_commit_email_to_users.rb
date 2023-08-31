Hanami::Model.migration do
  change do
    alter_table :users do
      add_column :git_commit_email, String, null: true
    end
  end
end
