module Mhxx::QuestsHelper
  # 送られてきた6桁の文字列を「MM'SS"FF」形式に変換する
  def formatted_clear_time(clear_time)
    time_value = clear_time.to_i
    minutes = time_value / 10_000
    seconds = (time_value % 10_000) / 100
    fraction = time_value % 100
    format("%<minutes>02d'%<seconds>02d\"%<fraction>02d", minutes:, seconds:, fraction:)
  end

  # 送られてきた合計秒数を「MM'SS"FF」形式に変換する
  def total_seconds_to_formatted_time(total_seconds)
    minutes = (total_seconds / 60).floor
    remaining_seconds = total_seconds % 60
    seconds = remaining_seconds.floor
    fraction = ((remaining_seconds - seconds) * 100).round
    format("%<minutes>02d'%<seconds>02d\"%<fraction>02d", minutes:, seconds:, fraction:)
  end

  # クエスト説明文
  def quest_main_target(quest, monsters)
    case quest.quest_division
    when "gathering"
      # 採取
      # 「急募・単行採掘求ム」のみ
      "燃石炭１０個以上納品<br>もしくはネコタクチケットの納品".html_safe
    when "hunt"
      # 狩猟
      generate_hunt_target(monsters)
    when "capture"
      # 捕獲
      "#{monsters[0].name}１頭の捕獲"
    when "multi_monster"
      # 大連続
      "全ての大型モンスターの狩猟"
    when "slay"
      # 討伐
      generate_slay_target(monsters)
    when "special"
      # 特殊
      "#{monsters[0].name}の討伐"
    when "special_permit"
      # 特殊許可
      generate_special_permit_target(quest, monsters)
    # when "prowler"
    #   # ニャンター
    #   "猫です"
    else
      "クエスト区分が存在しません。"
    end
  end

  # モンスターアイコン表示
  def monster_image_tag(monster)
    if Rails.application.assets.find_asset("mhxx/monsters/#{monster&.name_romanized}.png")
      # 通常
      image_tag("mhxx/monsters/#{monster.name_romanized}.png", class: "mhxx-monster-icon__base-image")
    elsif monster.name_romanized.starts_with?("hyper_")
      # 獰猛化
      modified_name = monster.name_romanized.sub(/^hyper_/, "")
      image_tag("mhxx/monsters/#{modified_name}.png", class: "mhxx-monster-icon__base-image") +
        image_tag("mhxx/hyper.png", class: "mhxx-monster-icon__overlay-image")
    else
      # 禁忌（固有アイコン無し）
      image_tag("mhxx/monsters/question.png")
    end
  end

  private

  # クエスト説明文：狩猟の詳細分岐
  def generate_hunt_target(monsters)
    if monsters[1].nil?
      "#{monsters[0].name}１頭の狩猟"
    elsif monsters[0].id == monsters[1].id
      "#{monsters[0].name}２頭の狩猟"
    else
      "#{monsters[0].name}１頭と<br>#{monsters[1].name}１頭の狩猟".html_safe
    end
  end

  # クエスト説明文：討伐の詳細分岐
  def generate_slay_target(monsters)
    elder_dragon_class_ids = [72, 75, 76] + (81..93).to_a
    if elder_dragon_class_ids.include?(monsters[0].id)
      "#{monsters[0].name}の討伐"
    else
      "#{monsters[0].name}１頭の討伐"
    end
  end

  # クエスト説明文：特殊許可の詳細分岐
  def generate_special_permit_target(quest, monsters)
    if quest.name.include?("捕獲")
      "#{monsters[0].name}１頭の捕獲"
    elsif monsters[1].nil?
      "#{monsters[0].name}１頭の狩猟"
    elsif monsters[2].present?
      "全ての大型モンスターの狩猟"
    elsif monsters[0].id == monsters[1].id
      "#{monsters[0].name}連続２頭の狩猟"
    else
      generate_hunt_target(monsters)
    end
  end
end
