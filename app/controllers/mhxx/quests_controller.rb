class Mhxx::QuestsController < ApplicationController
  def index
    if current_user.present?
      if params[:rank_number].present? && params[:rank_number].to_i != 99
        # その他のランクが選択された場合
        @quests = Mhxx::MQuest
          .where(m_sub_quest_rank_id: params[:rank_number])
          .includes(:times, :bookmark_quests)
          .order(:id)
      else
        #  初期表示 もしくは お気に入りが選択された場合
        bookmarked_quests_ids = Mhxx::BookmarkQuest.where(user: current_user).pluck(:m_quest_id)
        @quests = Mhxx::MQuest
          .where(id: bookmarked_quests_ids)
          .includes(:times, :bookmark_quests)
          .order("bookmark_quests.display_order")
      end

      @times = Mhxx::Time
        .where(m_quest_id: @quests.pluck(:id), user: current_user)
        .group_by(&:m_quest_id)
      @bookmarks = Mhxx::BookmarkQuest
        .where(user_id: current_user.id, m_quest_id: @quests.pluck(:id))
        .index_by(&:m_quest_id)
    else
      redirect_to new_user_session_path
    end
  end

  def show
    @quest = Mhxx::MQuest.find_by(id: params[:id])
    @quest_times = Mhxx::Time.where(m_quest_id: @quest.id, user: current_user).order(:clear_time)
    # 平均クリアタイム
    @average_clear_time_in_seconds = average_clear_time_in_seconds(@quest_times)
  end

  # セレクトボックスに標示するサブクエストランクを取得
  def sub_quest_ranks
    @sub_quest_ranks = Mhxx::MSubQuestRank.where(m_quest_rank_id: params[:m_quest_rank_id])
    render json: @sub_quest_ranks
  end

  private

  # 平均を算出する
  def average_clear_time_in_seconds(quest_times)
    if @quest_times.present?
      total_seconds = quest_times.map { |t| clear_time_to_total_seconds(t.clear_time) }.sum
      total_seconds / quest_times.size
    else
      0
    end
  end

  # 受け取った値を合計秒数に変換する
  def clear_time_to_total_seconds(clear_time)
    time_value = clear_time.to_i
    minutes = time_value / 10_000
    seconds = (time_value % 10_000) / 100
    fraction = time_value % 100

    (minutes * 60) + seconds + (fraction / 100.0)
  end
end
