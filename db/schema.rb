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

ActiveRecord::Schema.define(version: 20140130002004) do

  create_table "bets", force: true do |t|
    t.integer  "user_id"
    t.integer  "poker_round_id"
    t.string   "round_status"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "poker_rounds", force: true do |t|
    t.integer  "poker_table_id"
    t.string   "current_status"
    t.integer  "current_player_id"
    t.integer  "last_raiser"
    t.integer  "dealer"
    t.string   "card_deck_serialized"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "poker_tables", force: true do |t|
    t.string   "name"
    t.integer  "big_blind"
    t.integer  "small_blind"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "password"
    t.string   "email"
    t.string   "cpf"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "poker_table_id"
    t.integer  "money"
  end

  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["poker_table_id"], name: "index_users_on_poker_table_id"

end
