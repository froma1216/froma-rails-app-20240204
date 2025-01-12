class Pawapuro::MPosition < ApplicationRecord
  has_many :player_m_positions
  has_many :players, through: :player_m_positions

  # 先発
  STARTER_ID = 10
  # リリーフ
  RELIEF_IDS = [11, 12].freeze
  # 捕手
  CATCHER_ID = 2
  # 内野手
  INFIELDER_IDS = [3, 4, 5, 6].freeze
  # 外野手
  OUTFIELDER_ID = 13

  # 投手
  PITCHER_IDS = [STARTER_ID, *RELIEF_IDS].freeze
  # 野手
  FIELDER_IDS = [CATCHER_ID, *INFIELDER_IDS, OUTFIELDER_ID].freeze
end
