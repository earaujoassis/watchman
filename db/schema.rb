ActiveRecord::Schema[8.0].define(version: 2025_06_05_181400) do
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.serial "sequence_id", null: false
    t.string "public_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active"
    t.index ["public_id"], name: "index_users_on_public_id", unique: true
    t.index ["sequence_id"], name: "index_users_on_sequence_id", unique: true
  end
end
