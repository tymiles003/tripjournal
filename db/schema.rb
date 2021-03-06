# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150828140854) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "instagram_sources", force: :cascade do |t|
    t.string   "user_id"
    t.string   "last_media_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "notes", force: :cascade do |t|
    t.integer  "kind",       default: 0, null: false
    t.string   "title"
    t.string   "text"
    t.string   "image_url"
    t.string   "source_url"
    t.string   "source_id"
    t.string   "author"
    t.point    "latlng"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "points", force: :cascade do |t|
    t.point    "latlng",     null: false
    t.float    "alt"
    t.float    "speed"
    t.float    "hdop"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "points", ["created_at"], name: "index_points_on_created_at", using: :btree

  create_table "tracks", force: :cascade do |t|
    t.text     "json"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
