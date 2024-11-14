class Pawapuro::PlayersController < ApplicationController
  before_action :ensure_currect_user, { only: [:edit, :update, :destroy] }

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
      # 自分で作成した選手のみ表示する
      @player = Pawapuro::Player.find(params[:id])

      # 所持している全変化球を取得
      filtered_balls = @player.filtered_breaking_balls([100, 210..250], [1, 2])
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
      redirect_to pawapuro_index_path,
                  notice: "権限がありません"
    end
  end

  def new; end

  def create; end

  def edit; end

  def update; end

  def destroy; end

  private

  # 権限確認
  def ensure_currect_user
    @player = Pawapuro::Player.find(params[:id])
    redirect_to pawapuro_index_path, notice: "権限がありません" if @player.user != current_user
  end
end
