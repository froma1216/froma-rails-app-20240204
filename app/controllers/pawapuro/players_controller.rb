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
      #  自分で作成した選手のみ表示する
      @player = Pawapuro::Player.where(user: current_user).find(params[:id])
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
    # TODO: 以下の一行はそれぞれのメソッドで書く
    @player = Pawapuro::Player.find(params[:id])
    redirect_to pawapuro_index_path, notice: "権限がありません" if @player.user != current_user
  end
end
