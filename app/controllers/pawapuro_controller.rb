class PawapuroController < ApplicationController
  # 選手一覧画面
  def index
    @players = PawapuroPlayer.all
  end

  # 選手詳細モーダル
  def details
    @player = PawapuroPlayer.find(params[:id])
    # respond_to(&:js)
  end

  # 選手作成入力画面
  def new
    @player = PawapuroPlayer.new
    @player.build_pawapuro_pitcher
    @player.build_pawapuro_fielder
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
    if params[:pawapuro_player][:pawapuro_pitcher_attributes].present? && params[:pawapuro_player][:pawapuro_pitcher_attributes][:other_special_abilities].present?
      pitcher_other_special_abilities = params[:pawapuro_player][:pawapuro_pitcher_attributes][:other_special_abilities].join(",")
      @player.pawapuro_pitcher[:other_special_abilities] = pitcher_other_special_abilities
    end

    # 野手特殊能力のチェックを連結して格納
    if params[:pawapuro_player][:pawapuro_fielder_attributes].present? && params[:pawapuro_player][:pawapuro_fielder_attributes][:other_special_abilities].present?
      fielder_other_special_abilities = params[:pawapuro_player][:pawapuro_fielder_attributes][:other_special_abilities].join(",")
      @player.pawapuro_fielder[:other_special_abilities] = fielder_other_special_abilities
    end

    if @player.save
      # 成功時の処理（例：リダイレクト）
      # redirect_to some_path, notice: 'Player was successfully created.'
      redirect_to pawapuro_index_path, notice: "Player was successfully created."
    else
      # 失敗時の処理
      render :new
    end
  end

  def edit; end

  def update; end

  def destroy
    @player = PawapuroPlayer.find(params[:id])
    @player.destroy
    redirect_to pawapuro_index_path, notice: "「選手名：#{@player.player_name}」は削除されました"
  end

  private

  # 選手作成時のパラメータ
  def player_params
    params.require(:pawapuro_player).permit(
      :last_name, :first_name, :player_name, :back_name, :birthday, :main_position, :p11_proper, :p12_proper, :p13_proper, :p2_proper, :p3_proper, :p4_proper, :p5_proper, :p6_proper, :p7_proper, :throws, :bats, :kaifuku, :kegasinikusa, :other_special_abilities, :note, :created_by, :updated_by,
      pawapuro_pitcher_attributes: [:pace, :control, :stamina, :fastball_type, :second_fastball_type, :slider_type_pitch, :slider_type_movement, :second_slider_type_pitch, :second_slider_type_movement, :curveball_type_pitch, :curveball_type_movement, :second_curveball_type_pitch, :second_curveball_type_movement, :shootball_type_pitch, :shootball_type_movement, :second_shootball_type_pitch, :second_shootball_type_movement, :sinker_type_pitch, :sinker_type_movement, :second_sinker_type_pitch, :second_sinker_type_movement, :forkball_type_pitch, :forkball_type_movement, :second_forkball_type_pitch, :second_forkball_type_movement, :original_pitch, :taipinch, :taihidaridasya, :utarezuyosa, :nobi, :quick, :other_special_abilities, :created_by, :updated_by],
      pawapuro_fielder_attributes: [:trajectory, :meat, :power, :running, :arm_strength, :defense, :catching, :chance, :taihidaritousyu, :catcher, :tourui, :sourui, :soukyuu, :other_special_abilities, :created_by, :updated_by]
    )
    # params.require(:pawapuro_player).permit(
    #   :last_name, :first_name, :player_name, :back_name, :birthday, :main_position, :p11_proper, :p12_proper, :p13_proper, :p2_proper, :p3_proper, :p4_proper, :p5_proper, :p6_proper, :p7_proper, :throws, :bats, :kaifuku, :kegasinikusa, :other_special_abilities, :note, :created_by, :updated_by,
    #   pawapuro_pitcher_attributes: [:id, :pace, :control, :stamina, :fastball_type, :second_fastball_type, :slider_type_pitch, :slider_type_movement, :second_slider_type_pitch, :second_slider_type_movement, :curveball_type_pitch, :curveball_type_movement, :second_curveball_type_pitch, :second_curveball_type_movement, :shootball_type_pitch, :shootball_type_movement, :second_shootball_type_pitch, :second_shootball_type_movement, :sinker_type_pitch, :sinker_type_movement, :second_sinker_type_pitch, :second_sinker_type_movement, :forkball_type_pitch, :forkball_type_movement, :second_forkball_type_pitch, :second_forkball_type_movement, :original_pitch, :taipinch, :taihidaridasya, :utarezuyosa, :nobi, :quick, :other_special_abilities, :created_by, :updated_by],
    #   pawapuro_fielder_attributes: [:id, :trajectory, :meat, :power, :running, :arm_strength, :defense, :catching, :chance, :taihidaritousyu, :catcher, :tourui, :sourui, :soukyuu, :other_special_abilities, :created_by, :updated_by]
    # )
  end
end
