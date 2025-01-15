class Pawapuro::PlayerMBreakingBall < ApplicationRecord
  belongs_to :player
  belongs_to :m_breaking_ball, optional: true # 新規でIDが空の場合も許可するためoptional: trueを追加

  validates :movement, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 7 },
                       allow_nil: true
end
