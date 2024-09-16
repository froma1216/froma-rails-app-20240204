class Mhxx::TimesController < ApplicationController
  before_action :ensure_currect_user, only: [:edit, :update, :destroy]
  before_action :set_weapon_and_hunter_art_data, only: [:new, :edit, :create, :update]

  def new
    if current_user.present?
      @quest = Mhxx::MQuest.find(params[:quest_id])
      @time = Mhxx::Time.new
    else
      redirect_to new_user_session_path
    end
  end

  def edit
    @time = Mhxx::Time.find(params[:id])
    @quest = @time.m_quest # 既存のタイムから関連するクエストを取得
  end

  def create
    @quest = Mhxx::MQuest.find(params[:mhxx_time][:m_quest_id]) # フォームから渡されたクエストIDを利用
    @time = Mhxx::Time.new(time_params)
    @time.user = current_user

    if @time.save
      redirect_to mhxx_quests_path, notice: "タイムが作成されました"
    else
      render :new
    end
  end

  def update
    @time = Mhxx::Time.find(params[:id])
    @quest = @time.m_quest # 更新対象のタイムからクエストを取得

    if @time.update(time_params)
      redirect_to mhxx_quests_path, notice: "タイムが更新されました"
    else
      render :edit
    end
  end

  def destroy
    @time = Mhxx::Time.find(params[:id])
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

  # 武器種と狩技のデータを取得
  def set_weapon_and_hunter_art_data
    weapon_types = Mhxx::MWeaponType.all

    @grouped_weapon_types = Enums.weapon_type_division.each_with_object({}) do |(key, division), grouped|
      next if division == 200 # 「共通」は除く
      grouped[I18n.t("enums.mhxx.weapon_type_division.#{key}")] = weapon_types.where(weapon_type_division: division).pluck(:name, :id)
    end

    common_weapon_types, other_weapon_types = weapon_types.partition { |wt| wt.weapon_type_division == 200 }
    @grouped_hunter_arts = (common_weapon_types + other_weapon_types).map do |weapon_type|
      [
        weapon_type.name, # グループ名（武器タイプ名）
        weapon_type.m_hunter_art.map { |art| [art.name, art.id] } # 各グループのオプション（狩技名とID）
      ]
    end
    @grouped_hunter_arts.unshift(["なし", [["なし", ""]]])
  end
end
