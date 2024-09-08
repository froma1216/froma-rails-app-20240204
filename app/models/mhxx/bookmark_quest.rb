class Mhxx::BookmarkQuest < ApplicationRecord
  belongs_to :m_quest

  before_create :set_creator
  before_update :set_updater

  private

  def set_creator
    self.created_by = current_user.id if current_user
  end

  def set_updater
    self.updated_by = current_user.id if current_user
end
