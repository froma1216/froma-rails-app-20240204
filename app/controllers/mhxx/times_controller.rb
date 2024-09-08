class Mhxx::TimesController < ApplicationController
  before_action :ensure_currect_user, { only: [:edit, :update, :destroy] }

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  # 権限確認
  def ensure_currect_user
    @time = Mhxx::Time.find(params[:id])
    redirect_to mhxx_quests_path, notice: "権限がありません" if @time.user != current_user
  end
end
