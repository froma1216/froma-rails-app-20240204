class Mhxx::BookmarkQuestsController < ApplicationController
  before_action :set_quest, only: [:create]
  # TODO: 権限確認

  def create
    Mhxx::BookmarkQuest.create(user: current_user, m_quest_id: @quest.id)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    bookmark = Mhxx::BookmarkQuest.find(params[:id])
    if bookmark
      bookmark.destroy
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path, alert: "お気に入りが存在しません。")
    end
  end

  private

  def set_quest
    @quest = Mhxx::MQuest.find(params[:quest_id])
  end
end
