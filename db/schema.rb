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

ActiveRecord::Schema.define(version: 20161205052939) do

  create_table "programs", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "name_shorthand", limit: 255
    t.string   "icon",           limit: 255,   default: "file"
    t.string   "color",          limit: 255,   default: "#970000"
    t.string   "launch_text",    limit: 255,   default: "Launch App"
    t.string   "url",            limit: 255
    t.text     "description",    limit: 65535
    t.boolean  "admin",                        default: false
    t.boolean  "default_status",               default: true
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
  end

  create_table "user_programs", force: :cascade do |t|
    t.integer  "program_id", limit: 4
    t.boolean  "display",                default: true
    t.integer  "order",      limit: 4,   default: 0
    t.integer  "user_id",    limit: 4
    t.string   "token",      limit: 255
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "user_programs", ["program_id"], name: "index_user_programs_on_program_id", using: :btree
  add_index "user_programs", ["user_id"], name: "index_user_programs_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "uid",                    limit: 255,   default: "",        null: false
    t.string   "email",                  limit: 255
    t.string   "provider",               limit: 255,   default: "email",   null: false
    t.boolean  "admin",                                default: false
    t.string   "role",                   limit: 255,   default: "student"
    t.string   "encrypted_password",     limit: 255,   default: "",        null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.text     "tokens",                 limit: 65535
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,         null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

end
