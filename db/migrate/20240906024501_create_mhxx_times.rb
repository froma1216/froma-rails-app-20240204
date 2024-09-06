class CreateMhxxTimes < ActiveRecord::Migration[7.1]
  def change
    create_table :mhxx_times, comment: "タイム" do |t|
      t.references :m_quest, null: false, foreign_key: { to_table: :mhxx_m_quests }, comment: "クエストID"
      t.string :clear_time, null: false, comment: "クリアタイム"
      t.references :m_hunting_style, foreign_key: { to_table: :mhxx_m_hunting_styles }, comment: "狩猟スタイルID"
      t.references :m_hunter_art1, foreign_key: { to_table: :mhxx_m_hunter_arts }, comment: "狩技ID1"
      t.references :m_hunter_art2, foreign_key: { to_table: :mhxx_m_hunter_arts }, comment: "狩技ID2"
      t.references :m_hunter_art3, foreign_key: { to_table: :mhxx_m_hunter_arts }, comment: "狩技ID3"
      t.references :m_weapon, foreign_key: { to_table: :mhxx_m_weapons }, comment: "武器ID"
      t.boolean :display_flag, default: true, comment: "表示フラグ"
      t.string :skills, comment: "スキル"

      t.timestamps
    end
  end
end
