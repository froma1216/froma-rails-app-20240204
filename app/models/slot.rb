class Slot < ApplicationRecord
  has_many :presentations, dependent: :destroy
  belongs_to :track

  # 日時をフォーマットして表示
  def pdatetime
    start_time.strftime("%Y年%m月%d日") + " " + ptime
  end

  # 時間をフォーマットして表示
  def ptime
    start_time.strftime("%H:%M") + " - " + end_time.strftime("%H:%M")
  end
end
