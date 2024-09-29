class User < ApplicationRecord
  has_many :bookmark_quests
  # メールを使わないため、:recoverable を削除
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  #  emailがなくても適切に動作させる
  def email_required?
    false
  end
end
