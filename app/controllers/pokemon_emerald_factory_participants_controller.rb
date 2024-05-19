class PokemonEmeraldFactoryParticipantsController < ApplicationController
  include PokemonEmeraldFactoryParticipantsHelper
  before_action :set_q, only: [:index]

  # 一覧画面
  def index
    if params[:q].present? && params[:q].values.any?(&:present?)
      # 検索結果
      @results = Kaminari.paginate_array(@results).page(params[:page])
      # 画像のパスを生成
      create_name_and_type_image_path(params[:q].values[0])

      # 通番の計算用に現在のページ番号を取得（指定がない場合は1とする）
      current_page = params[:page] ? params[:page].to_i : 1
      # ページごとの表示件数
      per_page = @results.limit_value
      # ビューで使用するための基点となる通番を計算
      @starting_number = (current_page - 1) * per_page

      # 検索結果が空の場合にフラッシュメッセージを設定
      flash.now[:alert] = "対象のポケモンが見つかりませんでした。" if @results.empty?
    else
      # 初期状態・ポケモン名未入力で何も表示しない
      @results = PokemonEmeraldFactoryParticipant.none
      # ポケモン名未入力の場合（初期表示を除く）にフラッシュメッセージを設定
      flash.now[:alert] = "ポケモン名を入力してください。" if params[:search]
    end
    # ポケモン名セレクト作成用にポケモンの名前を全て取得
    @pokemon_names = PokemonEmeraldFactoryParticipant.pluck(:name).uniq
  end

  # 画像のパスを生成
  def create_name_and_type_image_path(name)
    types = PokemonEmeraldFactoryParticipant.get_types_by_name(name)
    @type1 = types[0]
    @type2 = types[1]
    @type1_image_path = create_pokemon_image_path(@type1, "types")
    @type2_image_path = create_pokemon_image_path(@type2, "types") if types[1].present?
    @name_image_path = create_pokemon_image_path(name, "pokemons")
  end

  private

  # 検索条件
  # NOTE: https://plog.kobacchi.com/rails7-ransack-instant-search/
  def set_q
    @q = PokemonEmeraldFactoryParticipant.ransack(params[:q])
    @results = params[:lap_number].present? ? @q.result.with_lap_show(params[:lap_number]) : @q.result
  end
end
