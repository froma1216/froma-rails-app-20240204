class PawapuroController < ApplicationController
  def index
    @players = PawapuroPlayer.all
  end

  def new; end

  def create; end

  def edit; end

  def update; end

  def destroy; end
end
