module Mhxx::QuestsHelper
  # 送られてきた6桁の文字列を「MM'SS"FF」形式に変換する
  def formatted_clear_time(clear_time)
    time_value = clear_time.to_i
    minutes = time_value / 10000
    seconds = (time_value % 10000) / 100
    fraction = time_value % 100
    format("%02d'%02d\"%02d", minutes, seconds, fraction)
  end

  # 送られてきた合計秒数を「MM'SS"FF」形式に変換する
  def total_seconds_to_formatted_time(total_seconds)
    minutes = (total_seconds / 60).floor
    remaining_seconds = total_seconds % 60
    seconds = remaining_seconds.floor
    fraction = ((remaining_seconds - seconds) * 100).round
    format("%02d'%02d\"%02d", minutes, seconds, fraction)
  end
end
