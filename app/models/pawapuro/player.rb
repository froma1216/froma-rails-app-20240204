class Pawapuro::Player < ApplicationRecord
  belongs_to :user
  belongs_to :main_position, class_name: "Pawapuro::MPosition", foreign_key: "main_position_id", optional: true
  has_many :player_m_positions
  has_many :m_positions, through: :player_m_positions
  has_many :player_m_breaking_balls
  has_many :m_breaking_balls, through: :player_m_breaking_balls

  # 守備適正を持つポジションを全て取得し、メインポジションを先頭にする
  def formatted_position_abbreviations
    positions = player_m_positions.includes(:m_position).map do |pm_position|
      {
        id: pm_position.m_position.id,
        abbreviation: pm_position.m_position.abbreviation
      }
    end

    # main_positionが存在する場合、それを先頭にして並び替え
    if main_position
      positions.sort_by! { |pos| pos[:id] == main_position.id ? 0 : 1 }
    end

    positions
  end

  # 変化球の変化量を取得するメソッド
  def breaking_ball_movement(breaking_ball_division, ball_type_order)
    player_m_breaking_balls
      .joins(:m_breaking_ball)
      .merge(Pawapuro::MBreakingBall.where(breaking_ball_division:))
      .where(ball_type_order:)
      .pluck(:movement)
      .first
  end
end
