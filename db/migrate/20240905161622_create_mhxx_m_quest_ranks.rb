class CreateMhxxMQuestRanks < ActiveRecord::Migration[7.1]
  def change
    create_table :mhxx_m_quest_ranks, comment: "クエストランクマスタ" do |t|
      t.string :name, comment: "クエストランク名"

      t.timestamps
    end
  end
end
