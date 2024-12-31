class Pawapuro::MBreakingBall < ApplicationRecord
  has_many :player_m_breaking_balls
  has_many :players, through: :player_m_breaking_balls

  extend Enumerize
  enumerize :breaking_ball_division, in: Enums.breaking_ball_division
end
