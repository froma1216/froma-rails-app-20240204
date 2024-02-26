class PokemonEmeraldFactoryParticipantsController < ApplicationController
  before_action :set_q, only: [:index, :search]

  # 一覧画面
  def index
    # 検索結果
    @results = @q.result
  end

  private

  # 検索条件
  # NOTE: https://plog.kobacchi.com/rails7-ransack-instant-search/
  def set_q
    @q = PokemonEmeraldFactoryParticipant.ransack(params[:q])
  end
end
