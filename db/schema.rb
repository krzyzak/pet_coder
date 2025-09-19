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

ActiveRecord::Schema[8.1].define(version: 2025_09_19_103741) do
  create_table "games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "level_id", null: false
    t.integer "lives", null: false
    t.integer "pet_id", null: false
    t.integer "player_id", null: false
    t.integer "points", default: 0, null: false
    t.integer "target_id", null: false
    t.integer "treat_id", null: false
    t.datetime "updated_at", null: false
    t.index ["level_id"], name: "index_games_on_level_id"
    t.index ["pet_id"], name: "index_games_on_pet_id"
    t.index ["player_id"], name: "index_games_on_player_id"
    t.index ["target_id"], name: "index_games_on_target_id"
    t.index ["treat_id"], name: "index_games_on_treat_id"
  end

  create_table "levels", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.json "holes", default: [], null: false
    t.json "pet", null: false
    t.json "target", null: false
    t.json "treats", default: [], null: false
    t.datetime "updated_at", null: false
    t.json "walls", default: [], null: false
  end

  create_table "pets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "image_name", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["image_name"], name: "index_pets_on_image_name", unique: true
  end

  create_table "players", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.integer "pet_id", null: false
    t.integer "target_id", null: false
    t.integer "treat_id", null: false
    t.datetime "updated_at", null: false
    t.index ["pet_id"], name: "index_players_on_pet_id"
    t.index ["target_id"], name: "index_players_on_target_id"
    t.index ["treat_id"], name: "index_players_on_treat_id"
  end

  create_table "states", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "game_id", null: false
    t.json "pet", null: false
    t.integer "points", default: 0, null: false
    t.json "target", null: false
    t.json "treats", default: [], null: false
    t.datetime "updated_at", null: false
    t.json "walls", default: [], null: false
    t.index ["game_id"], name: "index_states_on_game_id"
  end

  create_table "targets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "image_name", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["image_name"], name: "index_targets_on_image_name", unique: true
  end

  create_table "treats", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "image_name", null: false
    t.string "name", null: false
    t.integer "points", null: false
    t.datetime "updated_at", null: false
    t.index ["image_name"], name: "index_treats_on_image_name", unique: true
  end

  add_foreign_key "games", "levels"
  add_foreign_key "games", "pets"
  add_foreign_key "games", "players"
  add_foreign_key "games", "targets"
  add_foreign_key "games", "treats"
  add_foreign_key "players", "pets"
  add_foreign_key "players", "targets"
  add_foreign_key "players", "treats"
  add_foreign_key "states", "games"
end
