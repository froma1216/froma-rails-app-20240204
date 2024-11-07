class Pawapuro::MBreakingBall < ApplicationRecord
  has_many :player_m_breaking_balls
  has_many :players, through: :player_m_breaking_balls
end
