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

ActiveRecord::Schema.define(version: 20150207002226) do

  create_table "games", force: :cascade do |t|
    t.integer  "game_number"
    t.date     "game_date"
    t.text     "numbers"
    t.integer  "bonus"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "games_tickets", id: false, force: :cascade do |t|
    t.integer "game_id"
    t.integer "ticket_id"
  end

  add_index "games_tickets", ["game_id", "ticket_id"], name: "index_games_tickets_on_game_id_and_ticket_id"
  add_index "games_tickets", ["ticket_id"], name: "index_games_tickets_on_ticket_id"

  create_table "results", force: :cascade do |t|
    t.decimal  "amount"
    t.integer  "game_id"
    t.integer  "ticket_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "results", ["game_id"], name: "index_results_on_game_id"
  add_index "results", ["ticket_id"], name: "index_results_on_ticket_id"

  create_table "tickets", force: :cascade do |t|
    t.text     "numbers"
    t.integer  "bet_amount"
    t.boolean  "bonus"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
