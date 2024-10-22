class Mhxx::MQuestRank < ApplicationRecord
  has_many :m_sub_quest_rank

  # ラジオボタンの要素
  def self.with_favorite_option
    favorite_option = [["お気に入り", 99]]
    ranks = Mhxx::MQuestRank.pluck(:name, :id)
    favorite_option + ranks
  end
end
