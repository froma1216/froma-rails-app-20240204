class CreateMhxxMSubQuestRanks < ActiveRecord::Migration[7.1]
  def change
    create_table :mhxx_m_sub_quest_ranks, comment: "サブクエストランクマスタ" do |t|
      t.references :m_quest_rank, null: false, foreign_key: { to_table: :mhxx_m_quest_ranks }, comment: "クエストランクID"
      t.string :name, comment: "サブクエストランク名"

      t.timestamps
    end
  end
end
