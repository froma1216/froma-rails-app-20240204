class Mhxx::QuestsController < ApplicationController
  def index
    @quests = if params[:rank_number].present? && params[:rank_number].to_i != 0
                Mhxx::MQuest.where(m_sub_quest_rank_id: params[:rank_number]).order(:id)
              else
                Mhxx::MQuest.all.order(:id)
              end

    @times = Mhxx::Time.where(m_quest_id: @quests.pluck(:id)).group_by(&:m_quest_id)
  end

  def show
    @quest = Mhxx::MQuest.find_by(id: params[:id])
    @quest_times = Mhxx::Time.where(m_quest_id: @quest.id).order(:clear_time)
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
