class Pawapuro::MPosition < ApplicationRecord
  has_many :player_m_positions
  has_many :players, through: :player_m_positions

  PAWAPURO_PITCHER_IDS = [10, 11, 12].freeze # 投手
  PAWAPURO_FIELDER_IDS = [2, 3, 4, 5, 6, 13].freeze # 野手
end
