# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_06_06_005545) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  create_table "action_executions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.serial "sequence_id", null: false
    t.uuid "action_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "identification"
    t.string "type", null: false
    t.string "description"
    t.string "payload", null: false
    t.string "current_status", default: "pending", null: false
    t.string "status_reason", default: "created on database", null: false
    t.text "logs"
    t.index ["action_id"], name: "index_action_executions_on_action_id"
    t.index ["identification"], name: "index_action_executions_on_identification", unique: true
    t.index ["sequence_id"], name: "index_action_executions_on_sequence_id", unique: true
  end

  create_table "actions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.serial "sequence_id", null: false
    t.uuid "artifact_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.string "identification", null: false
    t.string "type", null: false
    t.string "description"
    t.string "payload", null: false
    t.index ["artifact_id"], name: "index_actions_on_artifact_id"
    t.index ["identification"], name: "index_actions_on_identification", unique: true
    t.index ["sequence_id"], name: "index_actions_on_sequence_id", unique: true
  end

  create_table "artifacts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.serial "sequence_id", null: false
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.string "full_name", null: false
    t.string "description"
    t.index ["full_name"], name: "index_artifacts_on_full_name", unique: true
    t.index ["sequence_id"], name: "index_artifacts_on_sequence_id", unique: true
    t.index ["user_id"], name: "index_artifacts_on_user_id"
  end

  create_table "git_credentials", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.serial "sequence_id", null: false
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.string "identification", null: false
    t.string "committer_identification", null: false
    t.string "username", null: false
    t.string "password", null: false
    t.index ["identification"], name: "index_git_credentials_on_identification", unique: true
    t.index ["sequence_id"], name: "index_git_credentials_on_sequence_id", unique: true
    t.index ["user_id"], name: "index_git_credentials_on_user_id"
  end

  create_table "service_credentials", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.serial "sequence_id", null: false
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.string "url", null: false
    t.string "client_key", null: false
    t.string "client_secret", null: false
    t.index ["client_key"], name: "index_service_credentials_on_client_key", unique: true
    t.index ["sequence_id"], name: "index_service_credentials_on_sequence_id", unique: true
    t.index ["user_id"], name: "index_service_credentials_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.serial "sequence_id", null: false
    t.string "public_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active"
    t.index ["public_id"], name: "index_users_on_public_id", unique: true
    t.index ["sequence_id"], name: "index_users_on_sequence_id", unique: true
  end

  add_foreign_key "action_executions", "actions"
  add_foreign_key "actions", "artifacts"
  add_foreign_key "artifacts", "users"
  add_foreign_key "git_credentials", "users"
  add_foreign_key "service_credentials", "users"
end
