class Mhxx::MQuest < ApplicationRecord
  belongs_to :m_monster1, class_name: 'Mhxx::MMonster', foreign_key: 'm_monster1_id', optional: true
  belongs_to :m_monster2, class_name: 'Mhxx::MMonster', foreign_key: 'm_monster2_id', optional: true
  belongs_to :m_monster3, class_name: 'Mhxx::MMonster', foreign_key: 'm_monster3_id', optional: true
  belongs_to :m_monster4, class_name: 'Mhxx::MMonster', foreign_key: 'm_monster4_id', optional: true
  belongs_to :m_monster5, class_name: 'Mhxx::MMonster', foreign_key: 'm_monster5_id', optional: true
  belongs_to :m_sub_quest_rank

  has_many :bookmark_quest
  has_many :time
end
