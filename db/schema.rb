# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170210151945) do

  create_table "activities", force: :cascade do |t|
    t.string   "trackable_type"
    t.integer  "trackable_id"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.string   "key"
    t.text     "parameters"
    t.string   "recipient_type"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
  end

  create_table "authorizations", force: :cascade do |t|
    t.string "name"
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.datetime "date_event"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "cover"
  end

  create_table "media", force: :cascade do |t|
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "event_id"
    t.integer  "type_id"
    t.string   "thumbnail_url"
    t.string   "file"
    t.integer  "upload_id"
    t.boolean  "visible",       default: true
  end

  create_table "reports", force: :cascade do |t|
    t.string   "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "medium_id"
    t.index ["medium_id"], name: "index_reports_on_medium_id"
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "mime_types"
    t.string   "cover"
  end

  create_table "uploads", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "event_id"
    t.integer  "type_id"
    t.integer  "user_id"
    t.index ["user_id"], name: "index_uploads_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "last_name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "email"
    t.string   "first_name"
    t.string   "nickname"
    t.string   "picture"
    t.integer  "authorization_id"
    t.string   "id_token"
    t.boolean  "ban",              default: false
    t.string   "avatar"
  end

end
