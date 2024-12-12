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
      prepare_new_player_data(@player)
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @player = Pawapuro::Player.new(player_params)
    @player.user = current_user # 現在ログイン中のユーザーを設定

    if @player.save
      redirect_to pawapuro_players_path, notice: "「選手名：#{@player.player_name}」を作成しました"
    else
      # 新規作成時に必要なデータを再生成
      prepare_new_player_data(@player)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # ポジション適正
    @position_proficiencies = {
      pitcher: fetch_positions(@player, Pawapuro::MPosition::PAWAPURO_PITCHER_IDS),
      fielder: fetch_positions(@player, Pawapuro::MPosition::PAWAPURO_FIELDER_IDS)
    }
    # 値あり特殊能力
    @valued_abilities_options = {
      common: fetch_valued_abilities(@player, 110),
      pitcher: fetch_valued_abilities(@player, 120),
      fielder: fetch_valued_abilities(@player, 130)
    }
    # 値なし特殊能力
    @basic_abilities_options = {
      common: fetch_basic_abilities(@player, 110),
      pitcher: fetch_basic_abilities(@player, 120),
      fielder: fetch_basic_abilities(@player, 130),
      sub: fetch_basic_abilities(@player, 140)
    }
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

  def update
    @player = Pawapuro::Player.find(params[:id])
    ensure_current_user # 権限がなければリダイレクト

    if @player.update(player_params)
      redirect_to pawapuro_players_path, notice: "「選手名：#{@player.player_name}」を更新しました。"
    else
      # 更新時に必要なデータを再生成
      prepare_new_player_data(@player)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @player = Pawapuro::Player.find(params[:id])
    ensure_current_user # 権限がなければリダイレクト

    if @player.destroy
      redirect_to pawapuro_players_path, notice: "「選手名：#{@player.player_name}」を削除しました。"
    else
      redirect_to pawapuro_players_path, alert: "「選手名：#{@player.player_name}」の削除に失敗しました。"
    end
  end

  private

  def player_params
    params.require(:pawapuro_player).permit(
      :player_name,
      :last_name,
      :first_name,
      :back_name,
      :birthday,
      :throwing,
      :batting,
      :main_position_id,
      :pace,
      :control,
      :stamina,
      :trajectory,
      :meat,
      :power,
      :running,
      :arm,
      :fielding,
      :catching,
      :note,
      player_m_positions_attributes: [:id, :m_position_id, :proficiency, :_destroy],
      player_m_valued_abilities_attributes: [:id, :m_valued_ability_id, :value, :_destroy],
      player_m_basic_abilities_attributes: [:id, :m_basic_ability_id, :_destroy],
      player_m_breaking_balls_attributes: [:id, :ball_type_order, :m_breaking_ball_id, :movement, :_destroy]
    ).tap do |whitelisted|
      # 値が0を除外
      whitelisted[:player_m_positions_attributes]&.reject! do |_key, attributes|
        attributes[:proficiency].to_i.zero?
      end
      whitelisted[:player_m_valued_abilities_attributes]&.reject! do |_key, attributes|
        attributes[:value].to_i.zero?
      end
      whitelisted[:player_m_breaking_balls_attributes]&.each_value do |attributes|
        attributes[:_destroy] = "1" if attributes[:movement].to_i.zero? || attributes[:m_breaking_ball_id].blank?
      end
    end
  end

  # 権限確認
  def ensure_current_user
    @player = Pawapuro::Player.find(params[:id])
    redirect_to pawapuro_players_path, notice: "権限がありません" if @player.user != current_user
  end

  # ポジション適正を取得する
  def fetch_positions(player, position_ids)
    positions = Pawapuro::MPosition.where(id: position_ids)
    positions.map do |position|
      # 既存データがある場合はそのまま、ない場合は新規作成
      player_position = player.player_m_positions.find_or_initialize_by(m_position_id: position.id)

      {
        id: position.id,
        name: position.name,
        abbreviation: position.abbreviation,
        player_position: # フォーム用に渡す
      }
    end
  end

  # 値あり特殊能力を取得する
  def fetch_valued_abilities(player, division)
    abilities = Pawapuro::MValuedAbility.where(pitcher_fielder_division: division)
    abilities.map do |ability|
      # 既存データがある場合はそのまま、ない場合は新規作成
      player_ability = player.player_m_valued_abilities.find_or_initialize_by(m_valued_ability_id: ability.id)

      levels = JSON.parse(ability.level_display_name)
      {
        id: ability.id,
        name: ability.name,
        options: levels.map { |key, value| [value, key.to_i] },
        player_ability: # フォーム用に渡す
      }
    end
  end

  # 値なし特殊能力を取得する
  def fetch_basic_abilities(player, division)
    abilities = Pawapuro::MBasicAbility.where(pitcher_fielder_division: division)
    abilities.map do |ability|
      # 既存データがある場合はそのまま、ない場合は新規作成
      player_ability = player.player_m_basic_abilities.find_or_initialize_by(m_basic_ability_id: ability.id)

      {
        id: ability.id,
        name: ability.name,
        check_input_class: "pawa-check-input-#{ability.good_bad_division}",
        check_label_class: "pawa-text-#{ability.good_bad_division}",
        player_ability:, # フォーム用に渡す
        selected: player_ability.persisted? # 編集時：登録済みかどうか、新規時：false
      }
    end
  end

  # 新規作成用のデータをセット
  def prepare_new_player_data(player)
    # ポジション適正
    @position_proficiencies = {
      pitcher: fetch_positions(player, Pawapuro::MPosition::PAWAPURO_PITCHER_IDS),
      fielder: fetch_positions(player, Pawapuro::MPosition::PAWAPURO_FIELDER_IDS)
    }
    # 値あり特殊能力
    @valued_abilities_options = {
      common: fetch_valued_abilities(player, 110),
      pitcher: fetch_valued_abilities(player, 120),
      fielder: fetch_valued_abilities(player, 130)
    }
    # 値なし特殊能力
    @basic_abilities_options = {
      common: fetch_basic_abilities(player, 110),
      pitcher: fetch_basic_abilities(player, 120),
      fielder: fetch_basic_abilities(player, 130),
      sub: fetch_basic_abilities(player, 140)
    }
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
  end
end
