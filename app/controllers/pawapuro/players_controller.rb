class Pawapuro::PlayersController < ApplicationController
  # ログイン確認
  before_action :ensure_current_user, only: [:index, :new, :create]
  # プレイヤー確認 + 権限チェック
  before_action :set_player_and_authorize, only: [:details, :edit, :update, :destroy]

  def index
    # 自分で作った選手のみ取得
    @players = Pawapuro::Player.where(user: current_user).order(id: :desc)
  end

  def details
    # ポジション適正
    @position_proficiencies = fetch_position_proficiencies(@player)
    # 変化球
    @breaking_balls = fetch_breaking_balls(@player)
  end

  def new
    @player = Pawapuro::Player.new
    prepare_player_resources
  end

  def create
    @player = Pawapuro::Player.new(player_params)
    @player.user = current_user # 現在ログイン中のユーザーを設定

    if @player.save
      redirect_to pawapuro_players_path, notice: "「選手名：#{@player.player_name}」を作成しました"
    else
      prepare_player_resources
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    prepare_player_resources
  end

  def update
    if @player.update(player_params)
      redirect_to pawapuro_players_path, notice: "「選手名：#{@player.player_name}」を更新しました。"
    else
      prepare_player_resources
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @player.destroy
      redirect_to pawapuro_players_path, notice: "「選手名：#{@player.player_name}」を削除しました。"
    else
      redirect_to pawapuro_players_path, alert: "「選手名：#{@player.player_name}」の削除に失敗しました。"
    end
  end

  private

  # ユーザーがログインしていることを確認
  def ensure_current_user
    redirect_to new_user_session_path unless current_user.present?
  end

  # @playerの設定と権限チェックを行う
  def set_player_and_authorize
    @player = Pawapuro::Player.find(params[:id])
    redirect_to pawapuro_players_path, notice: "権限がありません" unless @player.user == current_user
  end

  # ストロングパラメータ
  def player_params
    params.require(:pawapuro_player).permit(
      :player_name, :last_name, :first_name, :back_name, :birthday,
      :throwing, :batting,
      :main_position_id,
      :pace, :control, :stamina,
      :trajectory, :meat, :power, :running, :arm, :fielding, :catching,
      :note,
      player_m_positions_attributes: [:id, :m_position_id, :proficiency, :_destroy],
      player_m_valued_abilities_attributes: [:id, :m_valued_ability_id, :value, :_destroy],
      m_basic_ability_ids: [], # 値なし特殊能力のIDを配列で受け取る
      player_m_breaking_balls_attributes: [:id, :ball_type_order, :m_breaking_ball_id, :movement, :_destroy]
    ).tap do |whitelisted|
      # 値が0を除外
      whitelisted[:player_m_positions_attributes]&.each_value do |attributes|
        attributes[:_destroy] = "1" if attributes[:proficiency].to_i.zero?
      end
      whitelisted[:player_m_valued_abilities_attributes]&.each_value do |attributes|
        attributes[:_destroy] = "1" if attributes[:value].to_i.zero?
      end
      whitelisted[:player_m_breaking_balls_attributes]&.each_value do |attributes|
        attributes[:_destroy] = "1" if attributes[:movement].to_i.zero? || attributes[:m_breaking_ball_id].blank?
      end
    end
  end

  # ポジション適正を取得
  def fetch_position_proficiencies(player)
    positions = [
      { abbreviation: "投", ids: Pawapuro::MPosition::PAWAPURO_PITCHER_IDS, category: :pitcher },
      { abbreviation: "捕", id: 2, category: :fielder },
      { abbreviation: "一", id: 3, category: :fielder },
      { abbreviation: "二", id: 4, category: :fielder },
      { abbreviation: "三", id: 5, category: :fielder },
      { abbreviation: "遊", id: 6, category: :fielder },
      { abbreviation: "外", id: 13, category: :fielder }
    ]

    positions.map do |position|
      if position[:ids]
        # 投手の場合
        proficiency = player.player_m_positions.where(m_position_id: position[:ids]).maximum(:proficiency)
        { abbreviation: position[:abbreviation], proficiency: proficiency || 0 }
      else
        # 野手の場合
        proficiency = player.player_m_positions.find_by(m_position_id: position[:id])&.proficiency || 0
        { abbreviation: position[:abbreviation], proficiency: }
      end
    end
  end

  # 変化球を取得
  def fetch_breaking_balls(player)
    filtered_balls = player.filtered_breaking_balls(Enums.breaking_ball_division.values, [1, 2])
    {
      fastball: { 1 => filtered_balls.dig("fastball", 1), 2 => filtered_balls.dig("fastball", 2) },
      slider: { 1 => filtered_balls.dig("slider", 1), 2 => filtered_balls.dig("slider", 2) },
      curve: { 1 => filtered_balls.dig("curve", 1), 2 => filtered_balls.dig("curve", 2) },
      shoot: { 1 => filtered_balls.dig("shoot", 1), 2 => filtered_balls.dig("shoot", 2) },
      sinker: { 1 => filtered_balls.dig("sinker", 1), 2 => filtered_balls.dig("sinker", 2) },
      fork: { 1 => filtered_balls.dig("fork", 1), 2 => filtered_balls.dig("fork", 2) }
    }
  end

  # フォームで使用する選手情報の各種データを取得
  def prepare_player_resources
    # ポジション一覧
    @positions = Pawapuro::MPosition.all
    # 値あり特殊能力一覧
    @valued_abilities = Pawapuro::MValuedAbility.all
    # 値なし特殊能力一覧
    @basic_abilities = Pawapuro::MBasicAbility.all
    # 変化球の初期値
    # 構造イメージ:
    # {
    #   "fastball" => { 1 => nil, 2 => nil },
    #   "slider"   => { 1 => nil, 2 => nil },
    #   "curve"    => { 1 => nil, 2 => nil },
    #   "shoot"    => { 1 => nil, 2 => nil },
    #   "sinker"   => { 1 => nil, 2 => nil },
    #   "fork"     => { 1 => nil, 2 => nil }
    # }
    @breaking_balls = Enums.breaking_ball_division.keys.index_with do |_type|
      { 1 => nil, 2 => nil }
    end
    # 変化球セレクトオプション（分類ごとにグループ化）
    @breaking_ball_options = Pawapuro::MBreakingBall
      .where(breaking_ball_division: Enums.breaking_ball_division.values)
      .group_by { |ball| Enums.breaking_ball_division.key(ball.breaking_ball_division) }
  end
end
