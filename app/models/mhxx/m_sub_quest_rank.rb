class Mhxx::MSubQuestRank < ApplicationRecord
  belongs_to :m_quest_rank

  has_many :m_quest
end
