class SlotsController < ApplicationController
  def show
    @slot = Slot.find(params[:id])
    @user = current_user
    @participation = Participation.find_by(user: @user, slot: @slot)
  end
end
