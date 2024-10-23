class Mhxx::Time < ApplicationRecord
  belongs_to :user
  belongs_to :m_quest
  belongs_to :m_hunting_style, optional: true
  belongs_to :m_hunter_art1, class_name: "Mhxx::MHunterArt", foreign_key: "m_hunter_art1_id", optional: true
  belongs_to :m_hunter_art2, class_name: "Mhxx::MHunterArt", foreign_key: "m_hunter_art2_id", optional: true
  belongs_to :m_hunter_art3, class_name: "Mhxx::MHunterArt", foreign_key: "m_hunter_art3_id", optional: true
  belongs_to :m_weapon, optional: true

  has_many :time_skills, dependent: :destroy
  has_many :m_skills, through: :time_skills, class_name: "Mhxx::MSkill"

  validates :clear_time, presence: true, numericality: { only_integer: true },
                         format: { with: /\A\d{6}\z/, message: :clear_time_invalid }
  #  TODO: 備考の文字数バリデーション
end
