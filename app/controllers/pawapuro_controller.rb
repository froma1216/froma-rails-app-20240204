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

  def new; end

  def create; end

  def edit; end

  def update; end

  def destroy; end
end
