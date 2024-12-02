class Pawapuro::MBasicAbility < ApplicationRecord
  has_many :player_m_basic_abilities
  has_many :players, through: :player_m_basic_abilities

  extend Enumerize
  enumerize :good_bad_division, in: Enums.good_bad_division
end
