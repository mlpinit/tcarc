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

ActiveRecord::Schema.define(version: 20160327043905) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "game_players", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.integer  "next_game_player_id"
    t.integer  "score"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "remaining_meeples",   default: 0
    t.string   "color"
    t.integer  "invite",              default: 0
  end

  create_table "games", force: :cascade do |t|
    t.string   "name"
    t.integer  "owner_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "current_game_player_id"
    t.boolean  "started",                default: false
    t.string   "tile_order"
  end

  create_table "meeples", force: :cascade do |t|
    t.integer  "game_player_id"
    t.integer  "game_id"
    t.integer  "tile_id"
    t.string   "direction"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "archived",       default: false
  end

  create_table "tiles", force: :cascade do |t|
    t.integer  "x"
    t.integer  "y"
    t.string   "north"
    t.string   "south"
    t.string   "west"
    t.string   "east"
    t.boolean  "monastery",        default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "start",            default: false
    t.integer  "game_player_id"
    t.integer  "game_id"
    t.boolean  "connected_castle", default: false
    t.boolean  "connected_road",   default: false
    t.string   "barricade"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
