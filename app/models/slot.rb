class Slot < ApplicationRecord
  belongs_to :track
  has_many :presentations, dependent: :destroy
  has_many :participations
  # participationsモデルを経由して、usersテーブルと多対多の関係
  has_many :users, through: :participations

  # 日時をフォーマットして表示
  def pdatetime
    "#{start_time.strftime("%Y年%m月%d日")} #{start_time.strftime("%H:%M")} - #{end_time.strftime("%H:%M")}"
  end
end
