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

ActiveRecord::Schema[7.1].define(version: 2024_09_08_070852) do
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

  create_table "mhxx_bookmark_quests", comment: "お気に入りクエスト", force: :cascade do |t|
    t.bigint "m_quest_id", null: false, comment: "クエストID"
    t.integer "display_order", comment: "表示順"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", comment: "ユーザーID"
    t.index ["m_quest_id"], name: "index_mhxx_bookmark_quests_on_m_quest_id"
    t.index ["user_id"], name: "index_mhxx_bookmark_quests_on_user_id"
  end

  create_table "mhxx_m_hunter_arts", comment: "狩技マスタ", force: :cascade do |t|
    t.string "name", comment: "狩技名"
    t.bigint "m_weapon_type_id", null: false, comment: "武器種ID"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["m_weapon_type_id"], name: "index_mhxx_m_hunter_arts_on_m_weapon_type_id"
  end

  create_table "mhxx_m_hunting_styles", comment: "狩猟スタイルマスタ", force: :cascade do |t|
    t.string "name", comment: "スタイル名"
    t.integer "hunter_arts_quantity", comment: "狩技数"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mhxx_m_monsters", comment: "モンスターマスタ", force: :cascade do |t|
    t.string "name", comment: "モンスター名"
    t.string "name_romanized", comment: "ローマ字"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mhxx_m_quest_ranks", comment: "クエストランクマスタ", force: :cascade do |t|
    t.string "name", comment: "クエストランク名"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mhxx_m_quests", comment: "クエストマスタ", force: :cascade do |t|
    t.string "name", limit: 100, comment: "クエスト名"
    t.bigint "m_sub_quest_rank_id", null: false, comment: "サブクエストランクID"
    t.integer "quest_division", comment: "クエスト区分"
    t.bigint "m_monster1_id", null: false, comment: "モンスターID1"
    t.bigint "m_monster2_id", comment: "モンスターID2"
    t.bigint "m_monster3_id", comment: "モンスターID3"
    t.bigint "m_monster4_id", comment: "モンスターID4"
    t.bigint "m_monster5_id", comment: "モンスターID5"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["m_monster1_id"], name: "index_mhxx_m_quests_on_m_monster1_id"
    t.index ["m_monster2_id"], name: "index_mhxx_m_quests_on_m_monster2_id"
    t.index ["m_monster3_id"], name: "index_mhxx_m_quests_on_m_monster3_id"
    t.index ["m_monster4_id"], name: "index_mhxx_m_quests_on_m_monster4_id"
    t.index ["m_monster5_id"], name: "index_mhxx_m_quests_on_m_monster5_id"
    t.index ["m_sub_quest_rank_id"], name: "index_mhxx_m_quests_on_m_sub_quest_rank_id"
  end

  create_table "mhxx_m_sub_quest_ranks", comment: "サブクエストランクマスタ", force: :cascade do |t|
    t.bigint "m_quest_rank_id", null: false, comment: "クエストランクID"
    t.string "name", comment: "サブクエストランク名"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["m_quest_rank_id"], name: "index_mhxx_m_sub_quest_ranks_on_m_quest_rank_id"
  end

  create_table "mhxx_m_weapon_types", comment: "武器種マスタ", force: :cascade do |t|
    t.integer "weapon_type_division", comment: "武器種区分"
    t.string "name", comment: "武器種名"
    t.string "name_romanized", comment: "ローマ字"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mhxx_m_weapons", comment: "武器マスタ", force: :cascade do |t|
    t.bigint "m_weapon_type_id", null: false, comment: "武器種ID"
    t.string "name", comment: "武器名"
    t.integer "attack", comment: "攻撃力"
    t.integer "element", comment: "属性"
    t.string "rarity", comment: "レア度"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["m_weapon_type_id"], name: "index_mhxx_m_weapons_on_m_weapon_type_id"
  end

  create_table "mhxx_times", comment: "タイム", force: :cascade do |t|
    t.bigint "m_quest_id", null: false, comment: "クエストID"
    t.string "clear_time", null: false, comment: "クリアタイム"
    t.bigint "m_hunting_style_id", comment: "狩猟スタイルID"
    t.bigint "m_hunter_art1_id", comment: "狩技ID1"
    t.bigint "m_hunter_art2_id", comment: "狩技ID2"
    t.bigint "m_hunter_art3_id", comment: "狩技ID3"
    t.bigint "m_weapon_id", comment: "武器ID"
    t.boolean "display_flag", default: true, comment: "表示フラグ"
    t.string "skills", comment: "スキル"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", comment: "ユーザーID"
    t.index ["m_hunter_art1_id"], name: "index_mhxx_times_on_m_hunter_art1_id"
    t.index ["m_hunter_art2_id"], name: "index_mhxx_times_on_m_hunter_art2_id"
    t.index ["m_hunter_art3_id"], name: "index_mhxx_times_on_m_hunter_art3_id"
    t.index ["m_hunting_style_id"], name: "index_mhxx_times_on_m_hunting_style_id"
    t.index ["m_quest_id"], name: "index_mhxx_times_on_m_quest_id"
    t.index ["m_weapon_id"], name: "index_mhxx_times_on_m_weapon_id"
    t.index ["user_id"], name: "index_mhxx_times_on_user_id"
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
    t.bigint "pawapuro_player_id", null: false
    t.index ["pawapuro_player_id"], name: "index_pawapuro_fielders_on_pawapuro_player_id"
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
    t.bigint "pawapuro_player_id", null: false
    t.index ["pawapuro_player_id"], name: "index_pawapuro_pitchers_on_pawapuro_player_id"
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
    t.integer "kaifuku"
    t.integer "kegasinikusa"
    t.string "other_special_abilities"
    t.text "note"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pokemon_emerald_factory_participants", force: :cascade do |t|
    t.integer "no"
    t.string "name"
    t.string "type1"
    t.string "type2"
    t.string "move1"
    t.string "move2"
    t.string "move3"
    t.string "move4"
    t.string "item"
    t.string "effort_values"
    t.string "character"
    t.integer "lap1_show"
    t.integer "lap2_show"
    t.integer "lap3_show"
    t.integer "lap4_show"
    t.integer "lap5_show"
    t.integer "lap6_show"
    t.integer "lap7_show"
    t.integer "lap8_show"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "role"
    t.index ["conference_id"], name: "index_users_on_conference_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "days", "conferences"
  add_foreign_key "mhxx_bookmark_quests", "mhxx_m_quests", column: "m_quest_id"
  add_foreign_key "mhxx_bookmark_quests", "users"
  add_foreign_key "mhxx_m_hunter_arts", "mhxx_m_weapon_types", column: "m_weapon_type_id"
  add_foreign_key "mhxx_m_quests", "mhxx_m_monsters", column: "m_monster1_id"
  add_foreign_key "mhxx_m_quests", "mhxx_m_monsters", column: "m_monster2_id"
  add_foreign_key "mhxx_m_quests", "mhxx_m_monsters", column: "m_monster3_id"
  add_foreign_key "mhxx_m_quests", "mhxx_m_monsters", column: "m_monster4_id"
  add_foreign_key "mhxx_m_quests", "mhxx_m_monsters", column: "m_monster5_id"
  add_foreign_key "mhxx_m_quests", "mhxx_m_sub_quest_ranks", column: "m_sub_quest_rank_id"
  add_foreign_key "mhxx_m_sub_quest_ranks", "mhxx_m_quest_ranks", column: "m_quest_rank_id"
  add_foreign_key "mhxx_m_weapons", "mhxx_m_weapon_types", column: "m_weapon_type_id"
  add_foreign_key "mhxx_times", "mhxx_m_hunter_arts", column: "m_hunter_art1_id"
  add_foreign_key "mhxx_times", "mhxx_m_hunter_arts", column: "m_hunter_art2_id"
  add_foreign_key "mhxx_times", "mhxx_m_hunter_arts", column: "m_hunter_art3_id"
  add_foreign_key "mhxx_times", "mhxx_m_hunting_styles", column: "m_hunting_style_id"
  add_foreign_key "mhxx_times", "mhxx_m_quests", column: "m_quest_id"
  add_foreign_key "mhxx_times", "mhxx_m_weapons", column: "m_weapon_id"
  add_foreign_key "mhxx_times", "users"
  add_foreign_key "participations", "conferences"
  add_foreign_key "participations", "slots"
  add_foreign_key "participations", "users"
  add_foreign_key "pawapuro_fielders", "pawapuro_players"
  add_foreign_key "pawapuro_pitchers", "pawapuro_players"
  add_foreign_key "presentations", "slots"
  add_foreign_key "slots", "tracks"
  add_foreign_key "tracks", "days"
  add_foreign_key "users", "conferences"
end
