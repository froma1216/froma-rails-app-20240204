class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # メールを使わないため、:recoverable を削除
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  #  emailがなくても適切に動作させる
  def email_required?
    false
  end
end
