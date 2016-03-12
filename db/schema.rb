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

ActiveRecord::Schema.define(version: 20160312163506) do

  create_table "calls", force: :cascade do |t|
    t.string   "uuid",              null: false
    t.string   "caller_id"
    t.string   "caller_name"
    t.integer  "company_number_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "answer_time"
    t.integer  "duration"
    t.string   "status"
    t.string   "hangup_cause"
  end

  add_index "calls", ["company_number_id"], name: "index_calls_on_company_number_id"
  add_index "calls", ["uuid"], name: "index_calls_on_uuid"

  create_table "company_numbers", force: :cascade do |t|
    t.string   "sip_endpoint"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "company_numbers_users", id: false, force: :cascade do |t|
    t.integer "company_number_id"
    t.integer "user_id"
  end

  add_index "company_numbers_users", ["company_number_id"], name: "index_company_numbers_users_on_company_number_id"
  add_index "company_numbers_users", ["user_id"], name: "index_company_numbers_users_on_user_id"

  create_table "user_numbers", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "sip_endpoint"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "user_numbers", ["user_id"], name: "index_user_numbers_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
