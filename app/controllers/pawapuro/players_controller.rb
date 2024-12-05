class Pawapuro::PlayersController < ApplicationController
  before_action :ensure_current_user, { only: [:edit, :update, :destroy] }

  def index
    if current_user.present?
      # 自分で作った選手のみ取得
      @players = Pawapuro::Player.where(user: current_user).order(id: :desc)
    else
      redirect_to new_user_session_path
    end
  end

  def details
    if current_user.present?
      @player = Pawapuro::Player.find(params[:id])

      # 全てのポジション適正情報を取得
      @position_proficiencies = @player.player_m_positions.map do |pm_position|
        {
          id: pm_position.m_position.id,
          abbreviation: pm_position.m_position.abbreviation,
          proficiency: pm_position.proficiency
        }
      end

      # 所持している全変化球を取得
      # TODO: newやeditと同じようにまとめて取得
      filtered_balls = @player.filtered_breaking_balls(Enums.breaking_ball_division.values, [1, 2])
      # それぞれの変化球を取得
      @breaking_ball_fastball1 = filtered_balls.dig(100, 1)
      @breaking_ball_fastball2 = filtered_balls.dig(100, 2)
      @breaking_ball_slider1 = filtered_balls.dig(210, 1)
      @breaking_ball_slider2 = filtered_balls.dig(210, 2)
      @breaking_ball_curve1 = filtered_balls.dig(220, 1)
      @breaking_ball_curve2 = filtered_balls.dig(220, 2)
      @breaking_ball_shoot1 = filtered_balls.dig(230, 1)
      @breaking_ball_shoot2 = filtered_balls.dig(230, 2)
      @breaking_ball_sinker1 = filtered_balls.dig(240, 1)
      @breaking_ball_sinker2 = filtered_balls.dig(240, 2)
      @breaking_ball_fork1 = filtered_balls.dig(250, 1)
      @breaking_ball_fork2 = filtered_balls.dig(250, 2)
    else
      redirect_to pawapuro_players_path,
                  notice: "権限がありません"
    end
  end

  def new
    if current_user.present?
      @player = Pawapuro::Player.new
      # ポジション適正：投手
      @position_proficiencies_pitcher = Pawapuro::MPosition.where(id: Pawapuro::MPosition::PAWAPURO_PITCHER_IDS).map do |pm_position|
        {
          id: pm_position.id,
          name: pm_position.name,
          abbreviation: pm_position.abbreviation
        }
      end
      # ポジション適正：野手
      @position_proficiencies_fielder = Pawapuro::MPosition.where(id: Pawapuro::MPosition::PAWAPURO_FIELDER_IDS).map do |pm_position|
        {
          id: pm_position.id,
          name: pm_position.name,
          abbreviation: pm_position.abbreviation
        }
      end
      # 値あり特殊能力：共通
      @valued_abilities_options_common = Pawapuro::MValuedAbility.where(pitcher_fielder_division: 110).map do |ability|
        levels = JSON.parse(ability.level_display_name)
        {
          id: ability.id,
          name: ability.name,
          options: levels.map { |key, value| [value, key.to_i] }
        }
      end
      @valued_abilities_options_common.each do |ability|
        @player.player_m_valued_abilities.build(m_valued_ability_id: ability[:id])
      end
      # 値あり特殊能力：投手
      @valued_abilities_options_pitcher = Pawapuro::MValuedAbility.where(pitcher_fielder_division: 120).map do |ability|
        levels = JSON.parse(ability.level_display_name)
        {
          id: ability.id,
          name: ability.name,
          options: levels.map { |key, value| [value, key.to_i] }
        }
      end
      @valued_abilities_options_pitcher.each do |ability|
        @player.player_m_valued_abilities.build(m_valued_ability_id: ability[:id])
      end
      # 値あり特殊能力：野手
      @valued_abilities_options_fielder = Pawapuro::MValuedAbility.where(pitcher_fielder_division: 130).map do |ability|
        levels = JSON.parse(ability.level_display_name)
        {
          id: ability.id,
          name: ability.name,
          options: levels.map { |key, value| [value, key.to_i] }
        }
      end
      @valued_abilities_options_fielder.each do |ability|
        @player.player_m_valued_abilities.build(m_valued_ability_id: ability[:id])
      end
      # 値なし特殊能力：共通
      @basic_abilities_common = Pawapuro::MBasicAbility.where(pitcher_fielder_division: 110).map do |ability|
        {
          id: ability.id,
          name: ability.name,
          check_input_class: "pawa-check-input-#{ability.good_bad_division}", # チェックボックス：ボックスのクラス
          check_label_class: "pawa-text-#{ability.good_bad_division}", # チェックボックス：ラベルのクラス
          selected: false # 新規作成時はすべて未選択
        }
      end
      @basic_abilities_common.each do |ability|
        @player.player_m_basic_abilities.build(m_basic_ability_id: ability[:id])
      end
      # 値なし特殊能力：投手
      @basic_abilities_pitcher = Pawapuro::MBasicAbility.where(pitcher_fielder_division: 120).map do |ability|
        {
          id: ability.id,
          name: ability.name,
          check_input_class: "pawa-check-input-#{ability.good_bad_division}",
          check_label_class: "pawa-text-#{ability.good_bad_division}",
          selected: false
        }
      end
      @basic_abilities_pitcher.each do |ability|
        @player.player_m_basic_abilities.build(m_basic_ability_id: ability[:id])
      end
      # 値なし特殊能力：野手
      @basic_abilities_fielder = Pawapuro::MBasicAbility.where(pitcher_fielder_division: 130).map do |ability|
        {
          id: ability.id,
          name: ability.name,
          check_input_class: "pawa-check-input-#{ability.good_bad_division}",
          check_label_class: "pawa-text-#{ability.good_bad_division}",
          selected: false
        }
      end
      @basic_abilities_fielder.each do |ability|
        @player.player_m_basic_abilities.build(m_basic_ability_id: ability[:id])
      end
      # 値なし特殊能力：起用
      @basic_abilities_sub = Pawapuro::MBasicAbility.where(pitcher_fielder_division: 140).map do |ability|
        {
          id: ability.id,
          name: ability.name,
          check_input_class: "pawa-check-input-#{ability.good_bad_division}",
          check_label_class: "pawa-text-#{ability.good_bad_division}",
          selected: false
        }
      end
      @basic_abilities_sub.each do |ability|
        @player.player_m_basic_abilities.build(m_basic_ability_id: ability[:id])
      end
      # 変化球
      @breaking_balls = {
        fastball: { 1 => nil, 2 => nil },
        slider: { 1 => nil, 2 => nil },
        curve: { 1 => nil, 2 => nil },
        shoot: { 1 => nil, 2 => nil },
        sinker: { 1 => nil, 2 => nil },
        fork: { 1 => nil, 2 => nil }
      }
      # 変化球セレクト
      @breaking_ball_options = Pawapuro::MBreakingBall
        .where(breaking_ball_division: Enums.breaking_ball_division.values)
        .group_by { |ball| Enums.breaking_ball_division.key(ball.breaking_ball_division) }
    else
      redirect_to new_user_session_path
    end
  end

  def create; end

  def edit
    # ポジション適正：投手
    @position_proficiencies_pitcher = Pawapuro::MPosition.where(id: Pawapuro::MPosition::PAWAPURO_PITCHER_IDS).map do |pm_position|
      {
        id: pm_position.id,
        name: pm_position.name,
        abbreviation: pm_position.abbreviation
      }
    end
    # ポジション適正：野手
    @position_proficiencies_fielder = Pawapuro::MPosition.where(id: Pawapuro::MPosition::PAWAPURO_FIELDER_IDS).map do |pm_position|
      {
        id: pm_position.id,
        name: pm_position.name,
        abbreviation: pm_position.abbreviation
      }
    end
    # 値あり特殊能力：共通
    @valued_abilities_options_common = Pawapuro::MValuedAbility.where(pitcher_fielder_division: 110).map do |ability|
      levels = JSON.parse(ability.level_display_name)
      {
        id: ability.id,
        name: ability.name,
        options: levels.map { |key, value| [value, key.to_i] }
      }
    end
    # 値あり特殊能力：投手
    @valued_abilities_options_pitcher = Pawapuro::MValuedAbility.where(pitcher_fielder_division: 120).map do |ability|
      levels = JSON.parse(ability.level_display_name)
      {
        id: ability.id,
        name: ability.name,
        options: levels.map { |key, value| [value, key.to_i] }
      }
    end
    # 値あり特殊能力：投手
    @valued_abilities_options_fielder = Pawapuro::MValuedAbility.where(pitcher_fielder_division: 130).map do |ability|
      levels = JSON.parse(ability.level_display_name)
      {
        id: ability.id,
        name: ability.name,
        options: levels.map { |key, value| [value, key.to_i] }
      }
    end
    # 値なし特殊能力：共通
    @basic_abilities_common = Pawapuro::MBasicAbility.where(pitcher_fielder_division: 110).map do |ability|
      {
        id: ability.id,
        name: ability.name,
        check_input_class: "pawa-check-input-#{ability.good_bad_division}", # チェックボックス：ボックスのクラス
        check_label_class: "pawa-text-#{ability.good_bad_division}", # チェックボックス：ラベルのクラス
        selected: @player.m_basic_abilities.exists?(id: ability.id) # 選択済みかどうか
      }
    end
    # 値なし特殊能力：投手
    @basic_abilities_pitcher = Pawapuro::MBasicAbility.where(pitcher_fielder_division: 120).map do |ability|
      {
        id: ability.id,
        name: ability.name,
        check_input_class: "pawa-check-input-#{ability.good_bad_division}",
        check_label_class: "pawa-text-#{ability.good_bad_division}",
        selected: @player.m_basic_abilities.exists?(id: ability.id)
      }
    end
    # 値なし特殊能力：野手
    @basic_abilities_fielder = Pawapuro::MBasicAbility.where(pitcher_fielder_division: 130).map do |ability|
      {
        id: ability.id,
        name: ability.name,
        check_input_class: "pawa-check-input-#{ability.good_bad_division}",
        check_label_class: "pawa-text-#{ability.good_bad_division}",
        selected: @player.m_basic_abilities.exists?(id: ability.id)
      }
    end
    # 値なし特殊能力：起用
    @basic_abilities_sub = Pawapuro::MBasicAbility.where(pitcher_fielder_division: 140).map do |ability|
      {
        id: ability.id,
        name: ability.name,
        check_input_class: "pawa-check-input-#{ability.good_bad_division}",
        check_label_class: "pawa-text-#{ability.good_bad_division}",
        selected: @player.m_basic_abilities.exists?(id: ability.id)
      }
    end
    # 変化球
    filtered_balls = @player.filtered_breaking_balls(Enums.breaking_ball_division.values, [1, 2])
    @breaking_balls = {
      fastball: { 1 => filtered_balls.dig(100, 1), 2 => filtered_balls.dig(100, 2) },
      slider: { 1 => filtered_balls.dig(210, 1), 2 => filtered_balls.dig(210, 2) },
      curve: { 1 => filtered_balls.dig(220, 1), 2 => filtered_balls.dig(220, 2) },
      shoot: { 1 => filtered_balls.dig(230, 1), 2 => filtered_balls.dig(230, 2) },
      sinker: { 1 => filtered_balls.dig(240, 1), 2 => filtered_balls.dig(240, 2) },
      fork: { 1 => filtered_balls.dig(250, 1), 2 => filtered_balls.dig(250, 2) }
    }
    # 変化球セレクト
    @breaking_ball_options = Pawapuro::MBreakingBall
      .where(breaking_ball_division: Enums.breaking_ball_division.values)
      .group_by { |ball| Enums.breaking_ball_division.key(ball.breaking_ball_division) }
  end

  def update; end

  def destroy; end

  private

  def player_params
    params.require(:player).permit(
      :name,
      player_m_valued_abilities_attributes: [:id, :m_valued_ability_id, :value, :_destroy],
      player_m_basic_abilities_attributes: [:id, :m_basic_ability_id, :_destroy]
    )
  end

  # 権限確認
  def ensure_current_user
    @player = Pawapuro::Player.find(params[:id])
    redirect_to pawapuro_players_path, notice: "権限がありません" if @player.user != current_user
  end
end
