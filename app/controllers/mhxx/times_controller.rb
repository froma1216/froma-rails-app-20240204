class Mhxx::TimesController < ApplicationController
  # TODO: editではなくcreate?パワプロも
  before_action :ensure_currect_user, { only: [:edit, :update, :destroy] }

  def new
    if current_user.present?
      # クエスト情報の取得
      @quest = Mhxx::MQuest.find(params[:quest_id])
      # 新しいタイムの初期化
      @time = Mhxx::Time.new
      weapon_types = Mhxx::MWeaponType.all
      # 武器種のセレクトボックス用データ
      @grouped_weapon_types = Enums.weapon_type_division.each_with_object({}) do |(key, division), grouped|
        next if division == 200 # 「共通」は除く
        grouped[I18n.t("enums.mhxx.weapon_type_division.#{key}")] = weapon_types.where(weapon_type_division: division).pluck(:name, :id)
      end
      # 狩技のセレクトボックス用データ
      common_weapon_types, other_weapon_types = weapon_types.partition { |wt| wt.weapon_type_division == 200 }
      @grouped_hunter_arts = (common_weapon_types + other_weapon_types).map do |weapon_type|
        [
          weapon_type.name, # グループ名（武器タイプ名）
          weapon_type.m_hunter_art.map { |art| [art.name, art.id] } # 各グループのオプション（ハンターアーツ名とID）
        ]
      end
      # 初期表示用の「選択なし」を追加
      @grouped_hunter_arts.unshift(["なし", [["なし", ""]]])
    else
      redirect_to new_user_session_path
    end
  end

  def edit
  end

  def create
    # クエスト情報の取得
    @time = Mhxx::Time.new(time_params)
    @time.user = current_user
    @quest = Mhxx::MQuest.find(params[:quest_id])

    # 武器種のセレクトボックス用データ
    weapon_types = Mhxx::MWeaponType.all
    @grouped_weapon_types = Enums.weapon_type_division.each_with_object({}) do |(key, division), grouped|
      next if division == 200 # 「共通」は除く
      grouped[I18n.t("enums.mhxx.weapon_type_division.#{key}")] = weapon_types.where(weapon_type_division: division).pluck(:name, :id)
    end

    # 狩技のセレクトボックス用データ
    common_weapon_types, other_weapon_types = weapon_types.partition { |wt| wt.weapon_type_division == 200 }
    @grouped_hunter_arts = (common_weapon_types + other_weapon_types).map do |weapon_type|
      [
        weapon_type.name, # グループ名（武器タイプ名）
        weapon_type.m_hunter_art.map { |art| [art.name, art.id] } # 各グループのオプション（ハンターアーツ名とID）
      ]
    end

    if @time.save
      # 成功時の処理（例：リダイレクト）
      redirect_to mhxx_quests_path, notice: "タイムが作成されました"
    else
      # 失敗時の処理
      Rails.logger.info @time.errors.full_messages.inspect
      render :new
    end
  end

  def update
  end

  def destroy
    @time.destroy
    redirect_to mhxx_quests_path, notice: "タイムが削除されました"
  end

  private

  # タイム作成時のパラメータ
  def time_params
    params.require(:mhxx_time).permit(
      :m_quest_id, :clear_time, :m_weapon_id, :m_hunting_style_id,
      :m_hunter_art1_id, :m_hunter_art2_id, :m_hunter_art3_id
    )
  end

  # 権限確認
  def ensure_currect_user
    @time = Mhxx::Time.find(params[:id])
    redirect_to mhxx_quests_path, notice: "権限がありません" if @time.user != current_user
  end
end
