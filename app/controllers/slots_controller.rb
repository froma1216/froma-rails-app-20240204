class SlotsController < ApplicationController
  def show
    @slot = Slot.find(params[:id])
  end
end
