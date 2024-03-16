class PokemonEmeraldFactoryParticipantsController < ApplicationController
  before_action :set_q, only: [:index]

  # 一覧画面
  def index
    # 検索結果
    @results = @q.result
    # PokemonEmeraldFactoryParticipantモデルからポケモンの名前を全て取得
    @pokemon_names = PokemonEmeraldFactoryParticipant.pluck(:name).uniq

    @results = Kaminari.paginate_array(@results).page(params[:page])

    # 検索結果が空の場合にフラッシュメッセージを設定
    flash.now[:alert] = "対象のポケモンが見つかりませんでした。" if @results.empty?
  end

  private

  # 検索条件
  # NOTE: https://plog.kobacchi.com/rails7-ransack-instant-search/
  def set_q
    @q = PokemonEmeraldFactoryParticipant.ransack(params[:q])
  end
end
