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

ActiveRecord::Schema[7.1].define(version: 2024_02_12_112308) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conferences", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.date "start_date"
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "days", force: :cascade do |t|
    t.bigint "conference_id", null: false
    t.string "title"
    t.text "description"
    t.string "seq_no"
    t.string "integer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conference_id"], name: "index_days_on_conference_id"
  end

  create_table "participations", force: :cascade do |t|
    t.bigint "conference_id", null: false
    t.bigint "user_id", null: false
    t.bigint "slot_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conference_id"], name: "index_participations_on_conference_id"
    t.index ["slot_id"], name: "index_participations_on_slot_id"
    t.index ["user_id"], name: "index_participations_on_user_id"
  end

  create_table "pawapuro_fielders", force: :cascade do |t|
    t.integer "trajectory"
    t.integer "meat"
    t.integer "power"
    t.integer "running"
    t.integer "arm_strength"
    t.integer "defense"
    t.integer "catching"
    t.integer "chance"
    t.integer "taihidaritousyu"
    t.integer "catcher"
    t.integer "tourui"
    t.integer "sourui"
    t.integer "soukyuu"
    t.string "other_special_abilities"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pawapuro_pitchers", force: :cascade do |t|
    t.integer "pace"
    t.integer "control"
    t.integer "stamina"
    t.string "fastball_type"
    t.string "second_fastball_type"
    t.string "slider_type_pitch"
    t.integer "slider_type_movement"
    t.string "second_slider_type_pitch"
    t.integer "second_slider_type_movement"
    t.string "curveball_type_pitch"
    t.integer "curveball_type_movement"
    t.string "second_curveball_type_pitch"
    t.integer "second_curveball_type_movement"
    t.string "shootball_type_pitch"
    t.integer "shootball_type_movement"
    t.string "second_shootball_type_pitch"
    t.integer "second_shootball_type_movement"
    t.string "sinker_type_pitch"
    t.integer "sinker_type_movement"
    t.string "second_sinker_type_pitch"
    t.integer "second_sinker_type_movement"
    t.string "forkball_type_pitch"
    t.integer "forkball_type_movement"
    t.string "second_forkball_type_pitch"
    t.integer "second_forkball_type_movement"
    t.string "original_pitch"
    t.integer "taipinch"
    t.integer "taihidaridasya"
    t.integer "utarezuyosa"
    t.integer "nobi"
    t.integer "quick"
    t.string "other_special_abilities"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pawapuro_players", force: :cascade do |t|
    t.string "last_name"
    t.string "first_name"
    t.string "player_name"
    t.string "back_name"
    t.date "birthday"
    t.integer "main_position"
    t.integer "p11_proper"
    t.integer "p12_proper"
    t.integer "p13_proper"
    t.integer "p2_proper"
    t.integer "p3_proper"
    t.integer "p4_proper"
    t.integer "p5_proper"
    t.integer "p6_proper"
    t.integer "p7_proper"
    t.string "throws"
    t.string "bats"
    t.bigint "pawapuro_pitcher_id", null: false
    t.bigint "pawapuro_fielder_id", null: false
    t.integer "kaifuku"
    t.integer "kegasinikusa"
    t.string "other_special_abilities"
    t.text "note"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pawapuro_fielder_id"], name: "index_pawapuro_players_on_pawapuro_fielder_id"
    t.index ["pawapuro_pitcher_id"], name: "index_pawapuro_players_on_pawapuro_pitcher_id"
  end

  create_table "presentations", force: :cascade do |t|
    t.bigint "slot_id", null: false
    t.string "title"
    t.string "presenter"
    t.string "authors"
    t.text "description"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slot_id"], name: "index_presentations_on_slot_id"
  end

  create_table "slots", force: :cascade do |t|
    t.bigint "track_id", null: false
    t.string "title"
    t.string "organizer"
    t.string "chair"
    t.string "lecturer"
    t.string "room"
    t.text "description"
    t.string "url"
    t.string "audience"
    t.string "level"
    t.string "background"
    t.string "category"
    t.string "material"
    t.string "mlinkurl"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["track_id"], name: "index_slots_on_track_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.bigint "day_id", null: false
    t.string "title"
    t.text "description"
    t.integer "seq_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day_id"], name: "index_tracks_on_day_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "fullname"
    t.bigint "conference_id"
    t.index ["conference_id"], name: "index_users_on_conference_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "days", "conferences"
  add_foreign_key "participations", "conferences"
  add_foreign_key "participations", "slots"
  add_foreign_key "participations", "users"
  add_foreign_key "pawapuro_players", "pawapuro_fielders"
  add_foreign_key "pawapuro_players", "pawapuro_pitchers"
  add_foreign_key "presentations", "slots"
  add_foreign_key "slots", "tracks"
  add_foreign_key "tracks", "days"
  add_foreign_key "users", "conferences"
end
