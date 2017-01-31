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

ActiveRecord::Schema.define(version: 20170130224215) do

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

  create_table "likes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "medium_id"
    t.index ["medium_id"], name: "index_likes_on_medium_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
    t.index [nil, nil], name: "index_likes_on_user_and_medium", unique: true
  end

  create_table "media", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "event_id"
    t.integer  "type_id"
    t.string   "thumbnail_url"
    t.string   "file"
    t.integer  "upload_id"
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
  end

end
