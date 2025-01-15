class Pawapuro::MValuedAbility < ApplicationRecord
  has_many :player_m_valued_abilities
  has_many :players, through: :player_m_valued_abilities
end
