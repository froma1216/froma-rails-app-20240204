class User < ApplicationRecord
  belongs_to :conference, optional: true
  has_many :participations
  has_many :slots, through: :participations
  has_many :times
  has_many :bookmark_quests
  # メールを使わないため、:recoverable を削除
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  #  emailがなくても適切に動作させる
  def email_required?
    false
  end
end
