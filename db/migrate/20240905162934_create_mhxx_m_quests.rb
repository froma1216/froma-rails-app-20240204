class CreateMhxxMQuests < ActiveRecord::Migration[7.1]
  def change
    create_table :mhxx_m_quests, comment: "クエストマスタ" do |t|
      t.string :name, comment: "クエスト名"
      t.references :m_sub_quest_rank, null: false, foreign_key: { to_table: :mhxx_m_sub_quest_ranks }, comment: "サブクエストランクID"
      t.integer :quest_division, comment: "クエスト区分"
      t.references :m_monster1, null: false, foreign_key: { to_table: :mhxx_m_monsters }, comment: "モンスターID1"
      t.references :m_monster2, null: true, foreign_key: { to_table: :mhxx_m_monsters }, comment: "モンスターID2"
      t.references :m_monster3, null: true, foreign_key: { to_table: :mhxx_m_monsters }, comment: "モンスターID3"
      t.references :m_monster4, null: true, foreign_key: { to_table: :mhxx_m_monsters }, comment: "モンスターID4"
      t.references :m_monster5, null: true, foreign_key: { to_table: :mhxx_m_monsters }, comment: "モンスターID5"

      t.timestamps
    end
  end
end
