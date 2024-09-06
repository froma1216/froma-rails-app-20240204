class Mhxx::Time < ApplicationRecord
  belongs_to :m_quest
  belongs_to :m_hunting_style
  belongs_to :m_hunter_art1, class_name: 'Mhxx::MHunterArt', foreign_key: 'm_hunter_art1_id', optional: true
  belongs_to :m_hunter_art2, class_name: 'Mhxx::MHunterArt', foreign_key: 'm_hunter_art2_id', optional: true
  belongs_to :m_hunter_art3, class_name: 'Mhxx::MHunterArt', foreign_key: 'm_hunter_art3_id', optional: true
  belongs_to :m_weapon
end
