class CreateMhxxBookmarkQuests < ActiveRecord::Migration[7.1]
  def change
    create_table :mhxx_bookmark_quests, comment: "お気に入りクエスト" do |t|
      t.references :m_quest, null: false, foreign_key: { to_table: :mhxx_m_quests }, comment: "クエストID"
      t.integer :display_order, comment: "表示順"

      t.timestamps
    end
  end
end
