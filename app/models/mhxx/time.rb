class Mhxx::Time < ApplicationRecord
  belongs_to :m_quest
  belongs_to :m_hunting_style
  belongs_to :m_hunter_art1, class_name: 'Mhxx::MHunterArt', foreign_key: 'm_hunter_art1_id', optional: true
  belongs_to :m_hunter_art2, class_name: 'Mhxx::MHunterArt', foreign_key: 'm_hunter_art2_id', optional: true
  belongs_to :m_hunter_art3, class_name: 'Mhxx::MHunterArt', foreign_key: 'm_hunter_art3_id', optional: true
  belongs_to :m_weapon

  before_create :set_creator
  before_update :set_updater

  private

  def set_creator
    self.created_by = current_user.id if current_user
  end

  def set_updater
    self.updated_by = current_user.id if current_user
end
