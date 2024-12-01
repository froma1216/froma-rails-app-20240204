class Pawapuro::MPosition < ApplicationRecord
  has_many :players

  PAWAPURO_PITCHER_IDS = [10, 11, 12].freeze # 投手
  PAWAPURO_FIELDER_IDS = [2, 3, 4, 5, 6, 13].freeze # 野手
end
