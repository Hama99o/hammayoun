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

ActiveRecord::Schema[7.0].define(version: 2024_04_11_154046) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.string "city"
    t.string "country"
    t.integer "postal_code"
    t.string "state"
    t.boolean "is_default"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable"
  end

  create_table "allowlisted_jwts", force: :cascade do |t|
    t.string "jti", null: false
    t.string "aud"
    t.datetime "exp", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_allowlisted_jwts_on_jti", unique: true
    t.index ["user_id"], name: "index_allowlisted_jwts_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.string "favoritable_type"
    t.bigint "favoritable_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["favoritable_type", "favoritable_id"], name: "index_favorites_on_favoritable"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "lock_app_sensitive_infos", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "data_type"
    t.text "data"
    t.string "username"
    t.string "link"
    t.string "email"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_lock_app_sensitive_infos_on_user_id"
  end

  create_table "note_app_notes", force: :cascade do |t|
    t.bigint "owner_id"
    t.integer "status", default: 0, null: false
    t.jsonb "data"
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_note_app_notes_on_owner_id"
  end

  create_table "note_app_reminders", force: :cascade do |t|
    t.bigint "note_id"
    t.bigint "user_id"
    t.datetime "reminder_time"
    t.boolean "is_completed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["note_id"], name: "index_note_app_reminders_on_note_id"
    t.index ["user_id"], name: "index_note_app_reminders_on_user_id"
  end

  create_table "note_app_shares", force: :cascade do |t|
    t.bigint "note_id"
    t.bigint "shared_with_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["note_id"], name: "index_note_app_shares_on_note_id"
    t.index ["shared_with_user_id"], name: "index_note_app_shares_on_shared_with_user_id"
  end

  create_table "notes_tags", id: false, force: :cascade do |t|
    t.bigint "note_id"
    t.bigint "tag_id"
    t.index ["note_id"], name: "index_notes_tags_on_note_id"
    t.index ["tag_id"], name: "index_notes_tags_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.jsonb "tokens"
    t.string "firstname", default: "", null: false
    t.string "lastname", default: "", null: false
    t.date "birth_date"
    t.date "join_date"
    t.string "authentication_token"
    t.string "phone_number", default: "", null: false
    t.string "gender", default: "", null: false
    t.string "job_title", default: "", null: false
    t.string "linkedin", default: "", null: false
    t.integer "access_level", default: 0, null: false
    t.integer "status"
    t.string "timezone", default: "Europe/Paris"
    t.string "lang", default: "en"
    t.datetime "locked_at"
    t.integer "strikes_count", default: 0
    t.boolean "agreed_to_terms"
    t.jsonb "applications"
    t.integer "current_application", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "allowlisted_jwts", "users", on_delete: :cascade
  add_foreign_key "favorites", "users"
  add_foreign_key "lock_app_sensitive_infos", "users"
  add_foreign_key "note_app_notes", "users", column: "owner_id"
  add_foreign_key "note_app_reminders", "note_app_notes", column: "note_id"
  add_foreign_key "note_app_reminders", "users"
  add_foreign_key "note_app_shares", "note_app_notes", column: "note_id"
  add_foreign_key "note_app_shares", "users", column: "shared_with_user_id"
  add_foreign_key "notes_tags", "note_app_notes", column: "note_id"
end
