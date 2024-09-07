class Mhxx::MQuestRank < ApplicationRecord
  has_many :m_sub_quest_rank

  # ラジオボタンの要素
  def self.with_all_option
    [["すべて", 0]] + Mhxx::MQuestRank.all.map { |rank| [rank.name, rank.id] }
  end
end
