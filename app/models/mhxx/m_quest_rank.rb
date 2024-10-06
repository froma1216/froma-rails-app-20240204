class Mhxx::MQuestRank < ApplicationRecord
  has_many :m_sub_quest_rank

  # ラジオボタンの要素
  def self.with_all_option
    all_option = [["すべて", 0]]
    favorite_option = [["お気に入り", 99]]
    ranks = Mhxx::MQuestRank.pluck(:name, :id)
    all_option + ranks + favorite_option
  end
end
