class Mhxx::TimesController < ApplicationController
  before_action :ensure_currect_user, only: [:edit, :update, :destroy]
  before_action :set_weapon_and_hunter_art_data, only: [:new, :edit, :create, :update]

  def new
    if current_user.present?
      @quest = Mhxx::MQuest.find(params[:quest_id])
      @time = Mhxx::Time.new
      session[:previous_url] = request.referer # 遷移元のURLをセッションに保存
    else
      redirect_to new_user_session_path
    end
  end

  def edit
    @time = Mhxx::Time.find(params[:id])
    @quest = @time.m_quest # 既存のタイムから関連するクエストを取得
    session[:previous_url] = request.referer # 遷移元のURLをセッションに保存
  end

  def create
    @quest = Mhxx::MQuest.find(params[:mhxx_time][:m_quest_id]) # フォームから渡されたクエストIDを利用
    @time = Mhxx::Time.new(time_params)
    @time.user = current_user

    if @time.save
      # スキルの関連付けを処理
      if params[:mhxx_time][:skill_ids].present?
        @time.m_skills = Mhxx::MSkill.where(id: params[:mhxx_time][:skill_ids])
      end
      redirect_to session.delete(:previous_url) || mhxx_quests_path, notice: "タイムが作成されました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @time = Mhxx::Time.find(params[:id])
    @quest = @time.m_quest # 更新対象のタイムからクエストを取得

    if @time.update(time_params)
      # スキルの関連付けを処理
      if params[:mhxx_time][:skill_ids].present?
        @time.m_skills = Mhxx::MSkill.where(id: params[:mhxx_time][:skill_ids]).reject(&:blank?)
      else
        # スキルが選択されなかった場合は関連をクリアする
        @time.m_skills.clear
      end
      redirect_to mhxx_quest_path(@quest), notice: "タイムが更新されました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @time = Mhxx::Time.find(params[:id])
    @quest = @time.m_quest
    @time.destroy
    redirect_to mhxx_quest_path(@quest), notice: "タイムが削除されました"
  end

  # 武器種セレクト・属性ボタンから、武器セレクトの内容を作るAPI
  def filtered_weapons
    # パラメータから武器種と属性を取得
    weapon_type_id = params[:m_weapon_type]
    element = params[:element]

    # 武器を絞り込むクエリ
    filtered_weapons = Mhxx::MWeapon.all.order(:m_weapon_type_id, attack: :desc)
    filtered_weapons = filtered_weapons.where(m_weapon_type_id: weapon_type_id) if weapon_type_id.present?
    filtered_weapons = filtered_weapons.where(element: element) if element.present?

    # 結果をJSONで返す
    render json: filtered_weapons.select(:id, :name)
  end

  # 武器種セレクトから、武器セレクトの内容を作るAPI
  def filtered_hunter_arts
    weapon_type_id = params[:m_weapon_type]
    
    if weapon_type_id.present?
      weapon_type = Mhxx::MWeaponType.find(weapon_type_id)
      
      # 各武器種に対応する狩技を取得
      weapon_type_hunter_arts = weapon_type.m_hunter_art.map { |art| { id: art.id, name: art.name } }
      
      # 共通狩技を取得
      common_hunter_arts = Mhxx::MWeaponType.find_by(weapon_type_division: 200).m_hunter_art.map { |art| { id: art.id, name: art.name } }
  
      # グループ化したデータを返す
      grouped_hunter_arts = {
        "共通" => common_hunter_arts,
        weapon_type.name => weapon_type_hunter_arts
      }
  
      render json: grouped_hunter_arts
    else
      render json: { error: 'Weapon type not provided' }, status: :unprocessable_entity
    end
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
