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

ActiveRecord::Schema[7.1].define(version: 2024_11_10_044148) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.string "name", comment: "クエスト名"
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

  create_table "mhxx_m_skills", comment: "スキルマスタ", force: :cascade do |t|
    t.string "name", comment: "スキル名"
    t.string "skill_division", comment: "スキル区分"
    t.string "weapon_type_division", comment: "武器種区分"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "mhxx_time_skills", comment: "タイムスキル関連", force: :cascade do |t|
    t.bigint "time_id", null: false, comment: "タイムID"
    t.bigint "m_skill_id", null: false, comment: "スキルID"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["m_skill_id"], name: "index_mhxx_time_skills_on_m_skill_id"
    t.index ["time_id"], name: "index_mhxx_time_skills_on_time_id"
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
    t.string "note", comment: "備考"
    t.index ["m_hunter_art1_id"], name: "index_mhxx_times_on_m_hunter_art1_id"
    t.index ["m_hunter_art2_id"], name: "index_mhxx_times_on_m_hunter_art2_id"
    t.index ["m_hunter_art3_id"], name: "index_mhxx_times_on_m_hunter_art3_id"
    t.index ["m_hunting_style_id"], name: "index_mhxx_times_on_m_hunting_style_id"
    t.index ["m_quest_id"], name: "index_mhxx_times_on_m_quest_id"
    t.index ["m_weapon_id"], name: "index_mhxx_times_on_m_weapon_id"
    t.index ["user_id"], name: "index_mhxx_times_on_user_id"
  end

  create_table "pawapuro_m_basic_abilities", comment: "値なし特殊能力マスタ", force: :cascade do |t|
    t.string "name", comment: "特殊能力名"
    t.integer "good_bad_division", comment: "青赤区分"
    t.integer "pitcher_fielder_division", comment: "投手野手区分"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pawapuro_m_breaking_balls", comment: "変化球マスタ", force: :cascade do |t|
    t.string "name", comment: "変化球名"
    t.integer "breaking_ball_division", comment: "変化方向区分"
    t.boolean "is_original", comment: "オリジナルフラグ"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pawapuro_m_positions", comment: "ポジションマスタ", force: :cascade do |t|
    t.string "name", comment: "ポジション名"
    t.string "abbreviation", comment: "略称"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pawapuro_m_valued_abilities", comment: "値あり特殊能力マスタ", force: :cascade do |t|
    t.string "name", comment: "特殊能力名"
    t.integer "min_level", comment: "最小レベル"
    t.integer "max_level", comment: "最大レベル"
    t.string "level_display_name", comment: "表示名"
    t.integer "pitcher_fielder_division", comment: "投手野手区分"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pawapuro_player_m_basic_abilities", comment: "選手・値なし特殊能力マスタ関連", force: :cascade do |t|
    t.bigint "player_id", null: false, comment: "選手ID"
    t.bigint "m_basic_ability_id", null: false, comment: "値なし特殊能力マスタID"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["m_basic_ability_id"], name: "index_pawapuro_player_m_basic_abilities_on_m_basic_ability_id"
    t.index ["player_id"], name: "index_pawapuro_player_m_basic_abilities_on_player_id"
  end

  create_table "pawapuro_player_m_breaking_balls", comment: "選手・変化球マスタ関連", force: :cascade do |t|
    t.bigint "player_id", null: false, comment: "選手ID"
    t.integer "ball_type_order", comment: "球種順序"
    t.bigint "m_breaking_ball_id", null: false, comment: "変化球マスタID"
    t.integer "movement", comment: "変化量"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["m_breaking_ball_id"], name: "index_pawapuro_player_m_breaking_balls_on_m_breaking_ball_id"
    t.index ["player_id"], name: "index_pawapuro_player_m_breaking_balls_on_player_id"
  end

  create_table "pawapuro_player_m_positions", comment: "選手・ポジションマスタ関連", force: :cascade do |t|
    t.bigint "player_id", null: false, comment: "選手ID"
    t.bigint "m_position_id", null: false, comment: "ポジションID"
    t.integer "proficiency", comment: "適正レベル"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["m_position_id"], name: "index_pawapuro_player_m_positions_on_m_position_id"
    t.index ["player_id"], name: "index_pawapuro_player_m_positions_on_player_id"
  end

  create_table "pawapuro_player_m_valued_abilities", comment: "選手・値あり特殊能力マスタ関連", force: :cascade do |t|
    t.bigint "player_id", null: false, comment: "選手ID"
    t.bigint "m_valued_ability_id", null: false, comment: "値あり特殊能力マスタID"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "value", comment: "値"
    t.index ["m_valued_ability_id"], name: "idx_on_m_valued_ability_id_69ca68d18d"
    t.index ["player_id"], name: "index_pawapuro_player_m_valued_abilities_on_player_id"
  end

  create_table "pawapuro_players", comment: "選手", force: :cascade do |t|
    t.string "last_name", limit: 5, comment: "名字"
    t.string "first_name", limit: 5, comment: "名前"
    t.string "player_name", limit: 10, null: false, comment: "登録名"
    t.string "back_name", limit: 13, comment: "背ネーム"
    t.date "birthday", comment: "生年月日"
    t.bigint "main_position_id", null: false, comment: "メインポジション"
    t.integer "throwing", comment: "利き投げ"
    t.integer "batting", comment: "利き打ち"
    t.integer "pace", comment: "球速"
    t.integer "control", comment: "コントロール"
    t.integer "stamina", comment: "スタミナ"
    t.string "original_breaking_ball_name", comment: "オリジナル球種名"
    t.integer "trajectory", comment: "弾道"
    t.integer "meat", comment: "ミート"
    t.integer "power", comment: "パワー"
    t.integer "running", comment: "走力"
    t.integer "arm", comment: "肩力"
    t.integer "fielding", comment: "守備力"
    t.integer "catching", comment: "捕球"
    t.string "note", limit: 100, comment: "備考"
    t.bigint "user_id", null: false, comment: "ユーザID"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["main_position_id"], name: "index_pawapuro_players_on_main_position_id"
    t.index ["user_id"], name: "index_pawapuro_players_on_user_id"
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
    t.string "role"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

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
  add_foreign_key "mhxx_time_skills", "mhxx_m_skills", column: "m_skill_id"
  add_foreign_key "mhxx_time_skills", "mhxx_times", column: "time_id"
  add_foreign_key "mhxx_times", "mhxx_m_hunter_arts", column: "m_hunter_art1_id"
  add_foreign_key "mhxx_times", "mhxx_m_hunter_arts", column: "m_hunter_art2_id"
  add_foreign_key "mhxx_times", "mhxx_m_hunter_arts", column: "m_hunter_art3_id"
  add_foreign_key "mhxx_times", "mhxx_m_hunting_styles", column: "m_hunting_style_id"
  add_foreign_key "mhxx_times", "mhxx_m_quests", column: "m_quest_id"
  add_foreign_key "mhxx_times", "mhxx_m_weapons", column: "m_weapon_id"
  add_foreign_key "mhxx_times", "users"
  add_foreign_key "pawapuro_player_m_basic_abilities", "pawapuro_m_basic_abilities", column: "m_basic_ability_id"
  add_foreign_key "pawapuro_player_m_basic_abilities", "pawapuro_players", column: "player_id"
  add_foreign_key "pawapuro_player_m_breaking_balls", "pawapuro_m_breaking_balls", column: "m_breaking_ball_id"
  add_foreign_key "pawapuro_player_m_breaking_balls", "pawapuro_players", column: "player_id"
  add_foreign_key "pawapuro_player_m_positions", "pawapuro_m_positions", column: "m_position_id"
  add_foreign_key "pawapuro_player_m_positions", "pawapuro_players", column: "player_id"
  add_foreign_key "pawapuro_player_m_valued_abilities", "pawapuro_m_valued_abilities", column: "m_valued_ability_id"
  add_foreign_key "pawapuro_player_m_valued_abilities", "pawapuro_players", column: "player_id"
  add_foreign_key "pawapuro_players", "pawapuro_m_positions", column: "main_position_id"
  add_foreign_key "pawapuro_players", "users"
end
