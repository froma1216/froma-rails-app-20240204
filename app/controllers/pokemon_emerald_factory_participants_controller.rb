class PokemonEmeraldFactoryParticipantsController < ApplicationController
  before_action :set_q, only: [:index]

  # 一覧画面
  def index
    if params[:q].present?
      # 検索結果
      # @results = @q.result
      @results = Kaminari.paginate_array(@results).page(params[:page])

      # 通番の計算用に現在のページ番号を取得（指定がない場合は1とする）
      current_page = params[:page] ? params[:page].to_i : 1
      # ページごとの表示件数
      per_page = @results.limit_value
      # ビューで使用するための基点となる通番を計算
      @starting_number = (current_page - 1) * per_page

      # 検索結果が空の場合にフラッシュメッセージを設定
      flash.now[:alert] = "対象のポケモンが見つかりませんでした。" if @results.empty?
    else
      # 初期状態で何も表示しない
      @results = PokemonEmeraldFactoryParticipant.none
    end
    # PokemonEmeraldFactoryParticipantモデルからポケモンの名前を全て取得
    @pokemon_names = PokemonEmeraldFactoryParticipant.pluck(:name).uniq
  end

  private

  # 検索条件
  # NOTE: https://plog.kobacchi.com/rails7-ransack-instant-search/
  def set_q
    @q = PokemonEmeraldFactoryParticipant.ransack(params[:q])
    # @q.result = @q.result.with_lap_show(params[:lap_number]) if params[:lap_number].present?
    @results = params[:lap_number].present? ? @q.result.with_lap_show(params[:lap_number]) : @q.result
  end
end
