class PawapuroController < ApplicationController
  before_action :ensure_currect_user, { only: [:edit, :update, :destroy] }

  # 選手一覧画面
  def index
    if current_user.present?
      @players = PawapuroPlayer.all.order(:id)
    else
      redirect_to new_user_session_path
    end
  end

  # 選手詳細モーダル
  def details
    @player = PawapuroPlayer.find(params[:id])
    #  自分で作成した選手と、テストデータのみ表示する
    if @player.created_by != current_user.username && @player.id != 1
      redirect_to pawapuro_index_path,
                  notice: "権限がありません"
    end
  end

  # 選手作成入力画面
  def new
    if current_user.present?
      @player = PawapuroPlayer.new
      # 新規作成時にサブポジションの初期値を設定
      @player.p11_proper = 0
      @player.p12_proper = 0
      @player.p13_proper = 0
      @player.p2_proper = 0
      @player.p3_proper = 0
      @player.p4_proper = 0
      @player.p5_proper = 0
      @player.p6_proper = 0
      @player.p7_proper = 0
      # 投手、野手テーブル用にネストを作成
      @player.build_pawapuro_pitcher(
        pace: 120,
        control: 1,
        stamina: 1,
        slider_type_movement: 0,
        second_slider_type_movement: 0,
        curveball_type_movement: 0,
        second_curveball_type_movement: 0,
        shootball_type_movement: 0,
        second_shootball_type_movement: 0,
        sinker_type_movement: 0,
        second_sinker_type_movement: 0,
        forkball_type_movement: 0,
        second_forkball_type_movement: 0
      )
      @player.build_pawapuro_fielder(
        trajectory: 1,
        meat: 1,
        power: 1,
        running: 1,
        arm_strength: 1,
        defense: 1,
        catching: 1
      )
    else
      redirect_to new_user_session_path
    end
  end

  # 選手作成アクション
  def create
    @player = PawapuroPlayer.new(player_params)

    # 選手特殊能力のチェックを連結して格納
    if params[:pawapuro_player].present? && params[:pawapuro_player][:other_special_abilities].present?
      player_other_special_abilities = params[:pawapuro_player][:other_special_abilities].join(",")
      @player[:other_special_abilities] = player_other_special_abilities
    end

    # 野手特殊能力のチェックを連結して格納
    if params[:pawapuro_player][:pawapuro_pitcher_attributes].present? &&
       params[:pawapuro_player][:pawapuro_pitcher_attributes][:other_special_abilities].present?
      pitcher_other_special_abilities =
        params[:pawapuro_player][:pawapuro_pitcher_attributes][:other_special_abilities].join(",")
      @player.pawapuro_pitcher[:other_special_abilities] = pitcher_other_special_abilities
    end

    # 野手特殊能力のチェックを連結して格納
    if params[:pawapuro_player][:pawapuro_fielder_attributes].present? &&
       params[:pawapuro_player][:pawapuro_fielder_attributes][:other_special_abilities].present?
      fielder_other_special_abilities =
        params[:pawapuro_player][:pawapuro_fielder_attributes][:other_special_abilities].join(",")
      @player.pawapuro_fielder[:other_special_abilities] = fielder_other_special_abilities
    end

    # ログインユーザを created_by に設定
    @player.created_by = current_user&.username || ""
    @player.pawapuro_pitcher.created_by = current_user&.username || ""
    @player.pawapuro_fielder.created_by = current_user&.username || ""

    if @player.save
      # 成功時の処理（例：リダイレクト）
      redirect_to pawapuro_index_path, notice: "「選手名：#{@player.player_name}」が作成されました"
    else
      # 失敗時の処理
      render :new
    end
  end

  def edit; end

  # 選手更新アクション
  def update
    # player_paramsから受け取ったパラメータを@playerオブジェクトに適用
    @player.assign_attributes(player_params)

    # 選手特殊能力のチェックを連結して格納
    if params[:pawapuro_player].present? && params[:pawapuro_player][:other_special_abilities].present?
      player_other_special_abilities = params[:pawapuro_player][:other_special_abilities].join(",")
      @player[:other_special_abilities] = player_other_special_abilities
    end

    # 野手特殊能力のチェックを連結して格納
    if params[:pawapuro_player][:pawapuro_pitcher_attributes].present? &&
       params[:pawapuro_player][:pawapuro_pitcher_attributes][:other_special_abilities].present?
      pitcher_other_special_abilities =
        params[:pawapuro_player][:pawapuro_pitcher_attributes][:other_special_abilities].join(",")
      @player.pawapuro_pitcher[:other_special_abilities] = pitcher_other_special_abilities
    end

    # 野手特殊能力のチェックを連結して格納
    if params[:pawapuro_player][:pawapuro_fielder_attributes].present? &&
       params[:pawapuro_player][:pawapuro_fielder_attributes][:other_special_abilities].present?
      fielder_other_special_abilities =
        params[:pawapuro_player][:pawapuro_fielder_attributes][:other_special_abilities].join(",")
      @player.pawapuro_fielder[:other_special_abilities] = fielder_other_special_abilities
    end

    # ログインユーザを updated_by に設定
    @player.updated_by = current_user&.username || ""
    @player.pawapuro_pitcher.updated_by = current_user&.username
    @player.pawapuro_fielder.updated_by = current_user&.username

    if @player.save
      redirect_to pawapuro_index_path, notice: "「選手名：#{@player.player_name}」が更新されました"
    else
      render :edit
    end
  end

  # 選手削除アクション
  def destroy
    @player.destroy
    redirect_to pawapuro_index_path, notice: "「選手名：#{@player.player_name}」は削除されました"
  end

  private

  # 選手作成時のパラメータ
  def player_params
    params.require(:pawapuro_player).permit(
      :last_name, :first_name, :player_name, :back_name, :birthday, :main_position,
      :p11_proper, :p12_proper, :p13_proper,
      :p2_proper, :p3_proper, :p4_proper, :p5_proper, :p6_proper, :p7_proper,
      :throws, :bats, :kaifuku, :kegasinikusa, :note,
      :created_by, :updated_by,
      :other_special_abilities,
      pawapuro_pitcher_attributes: [
        :id, :pace, :control, :stamina,
        :fastball_type, :second_fastball_type,
        :slider_type_pitch, :slider_type_movement, :second_slider_type_pitch, :second_slider_type_movement,
        :curveball_type_pitch, :curveball_type_movement, :second_curveball_type_pitch, :second_curveball_type_movement,
        :shootball_type_pitch, :shootball_type_movement, :second_shootball_type_pitch, :second_shootball_type_movement,
        :sinker_type_pitch, :sinker_type_movement, :second_sinker_type_pitch, :second_sinker_type_movement,
        :forkball_type_pitch, :forkball_type_movement, :second_forkball_type_pitch, :second_forkball_type_movement,
        :original_pitch,
        :taipinch, :taihidaridasya, :utarezuyosa, :nobi, :quick, :other_special_abilities,
        :created_by, :updated_by
      ],
      pawapuro_fielder_attributes: [
        :id, :trajectory, :meat, :power, :running, :arm_strength, :defense, :catching,
        :chance, :taihidaritousyu, :catcher, :tourui, :sourui, :soukyuu, :other_special_abilities,
        :created_by, :updated_by
      ]
    )
  end

  # 権限確認
  def ensure_currect_user
    @player = PawapuroPlayer.find(params[:id])
    redirect_to pawapuro_index_path, notice: "権限がありません" if @player.created_by != current_user.username
  end
end
