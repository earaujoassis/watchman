Hanami::Model.migration do
  up do
    execute 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp"'

    alter_table :users do
      add_column :uuid, String, null: false, unique: true, default: Hanami::Model::Sql.function(:uuid_generate_v4)

      add_index :uuid, unique: true
    end
  end

  down do
    alter_table :users do
      drop_index :uuid
      drop_column :uuid
    end
    execute 'DROP EXTENSION IF EXISTS "uuid-ossp"'
  end
end
