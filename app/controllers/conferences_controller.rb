class ConferencesController < ApplicationController
  def index
    @conferences = Conference.all.order("start_date desc")
  end

  def show
    @conference = Conference.find(params[:id])
  end
end
