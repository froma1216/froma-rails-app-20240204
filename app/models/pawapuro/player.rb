class Pawapuro::Player < ApplicationRecord
  belongs_to :user
  belongs_to :main_position, class_name: "Pawapuro::MPosition", foreign_key: "main_position_id", optional: true
  # ポジション適正
  has_many :player_m_positions, dependent: :destroy
  has_many :m_positions, through: :player_m_positions
  # 変化球
  has_many :player_m_breaking_balls, dependent: :destroy
  has_many :m_breaking_balls, through: :player_m_breaking_balls
  # 値あり特殊能力
  has_many :player_m_valued_abilities, dependent: :destroy
  has_many :m_valued_abilities, through: :player_m_valued_abilities
  # 値なし特殊能力
  has_many :player_m_basic_abilities, dependent: :destroy
  has_many :m_basic_abilities, through: :player_m_basic_abilities

  # ネストされた属性の許可
  accepts_nested_attributes_for :player_m_positions, allow_destroy: true
  accepts_nested_attributes_for :player_m_valued_abilities, allow_destroy: true
  accepts_nested_attributes_for :player_m_basic_abilities, allow_destroy: true

  extend Enumerize
  enumerize :throwing, in: Enums.dominant_hand
  enumerize :batting, in: Enums.dominant_hand
  enumerize :breaking_ball_division, in: Enums.breaking_ball_division

  validates :last_name, presence: true, length: { maximum: 10 }
  validates :first_name, presence: true, length: { maximum: 10 }
  validates :player_name, presence: true, length: { maximum: 10 }
  validates :main_position, presence: true

  # 守備適正を持つポジションを全て取得し、メインポジションを先頭にする
  def formatted_position_abbreviations
    positions = player_m_positions.map do |pm_position|
      {
        id: pm_position.m_position.id,
        abbreviation: pm_position.m_position.abbreviation,
        proficiency: pm_position.proficiency
      }
    end

    # main_positionが存在する場合、それを先頭に並べ替え
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

  # 値あり特殊能力の値を取得するメソッド
  def m_valued_ability_value(ability_id)
    player_m_valued_abilities.find_by(m_valued_ability_id: ability_id)&.value
  end

  # 値なし特殊能力名を取得するメソッド
  def other_special_ability_names(divisions)
    player_m_basic_abilities
      .joins(:m_basic_ability)
      .where(pawapuro_m_basic_abilities: { pitcher_fielder_division: divisions })
      .pluck(:name)
  end

  # 所持している全変化球を取得するメソッド
  def filtered_breaking_balls(divisions, orders)
    player_m_breaking_balls
      .joins(:m_breaking_ball)
      .where(pawapuro_m_breaking_balls: { breaking_ball_division: divisions })
      .where(ball_type_order: orders)
      .group_by { |ball| ball.m_breaking_ball.breaking_ball_division }
      .transform_values { |balls| balls.index_by(&:ball_type_order) }
  end
end
