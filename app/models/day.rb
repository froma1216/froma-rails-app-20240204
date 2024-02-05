class Day < ApplicationRecord
  has_many :tracks, dependent: :destroy
  belongs_to :conference

  # 関連する日付をフォーマットして表示
  def pdate
    (conference.start_date + seq_no).strftime("%Y年%m月%d日")
  end
end
