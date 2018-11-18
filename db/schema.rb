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

ActiveRecord::Schema.define(version: 2018_11_18_103413) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "black_lists", force: :cascade do |t|
    t.string "token", null: false
    t.datetime "exp_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_black_lists_on_token"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "fullname"
    t.boolean "show_email", default: false, null: false
    t.string "picture"
    t.text "about"
    t.string "city"
    t.date "birthday"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["about"], name: "index_profiles_on_about"
    t.index ["fullname"], name: "index_profiles_on_fullname"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "tokens", force: :cascade do |t|
    t.json "user_agent"
    t.string "token", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_tokens_on_token"
    t.index ["user_id"], name: "index_tokens_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "username", null: false
    t.string "password_digest", null: false
    t.boolean "is_admin", default: false, null: false
    t.boolean "is_banned", default: false, null: false
    t.datetime "exp_ban"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "fullname"
    t.boolean "show_email", default: false, null: false
    t.string "picture"
    t.text "about"
    t.string "city"
    t.date "birthday"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username"
  end

  add_foreign_key "profiles", "users"
end
