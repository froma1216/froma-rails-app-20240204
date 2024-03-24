module PawapuroHelper
  # 数値をポジション名に変換
  def display_position_name(val)
    positions = {
      11 => "投（先）",
      12 => "投（中）",
      13 => "投（抑）",
      2 => "捕",
      3 => "一",
      4 => "二",
      5 => "三",
      6 => "遊",
      7 => "外"
    }
    content_tag(:span, positions[val] || "ERR")
  end

  # 特能数値をアルファベットに変換
  def display_special_ability_alphabet(val)
    abilities = {
      -3 => "G",
      -2 => "F",
      -1 => "E",
      0 => "D",
      1 => "C",
      2 => "B",
      3 => "A"
    }
    content_tag(:span, abilities[val] || "")
  end

  # 投打の値を右・左・両に変換
  def display_left_and_right(val)
    throws_bats = {
      "right" => "右",
      "left" => "左",
      "both" => "両"
    }
    content_tag(:span, throws_bats[val] || "")
  end

  # 能力値（弾道）によって文字色、→の角度を変更
  def display_trajectory(trajectory)
    text_color, angle = case trajectory
                        when 2
                          ["pawa-text-c", "-20deg"]
                        when 3
                          ["pawa-text-b", "-30deg"]
                        when 4
                          ["pawa-text-a", "-45deg"]
                        else
                          ["pawa-text-d", "-10deg"]
                        end
    content_tag(:i, "", class: "fa fa-solid fa-arrow-right #{text_color}", style: "transform: rotate(#{angle});")
  end

  # 能力値（弾道以外）をアルファベットに変換＋文字色変更
  def display_alphabet(val)
    case val
    when 1..29
      content_tag(:span, "G ", class: "pawa-text-g")
    when 30..39
      content_tag(:span, "F ", class: "pawa-text-f")
    when 40..49
      content_tag(:span, "E ", class: "pawa-text-e")
    when 50..59
      content_tag(:span, "D ", class: "pawa-text-d")
    when 60..69
      content_tag(:span, "C ", class: "pawa-text-c")
    when 70..79
      content_tag(:span, "B ", class: "pawa-text-b")
    when 80..89
      content_tag(:span, "A ", class: "pawa-text-a")
    when 90..100
      content_tag(:span, "S ", class: "pawa-text-s")
    else
      # エラーケース
      content_tag(:span, "", class: "")
    end
  end

  # ポジション表示
  # 2 から 7 までの数値をループ。
  # 各ループで、動的に p2_proper, p3_proper, ..., p7_proper の値を取得。
  # p#{num}_proper が0ではなく、かつその数値が main_position と異なる場合にのみ、そのポジションを表示用の配列に追加。
  # メインポジションは、太字で確定表示。
  # 最終的に、配列内の要素を「・」で結合して返却。
  def display_positions(player)
    positions = ["<strong>#{display_position_name(player.main_position)}</strong>"]

    (2..7).each do |num|
      proper = player.send("p#{num}_proper")
      positions << display_position_name(num) if proper.to_i.nonzero? && num != player.main_position
    end
    positions.join("・").html_safe
  end

  # 属性名から位置番号を抽出（上記のdisplay_sub_positionsで使用）
  def position_number(attribute)
    attribute[-1].to_i
  end

  # 変化球ブロック
  # 変化量によって、色付きのブロックを表示する。
  def breaking_ball_blocks(pitcher, ball_type)
    Array.new(7) do |i|
      class_name = i < pitcher.send("#{ball_type}_type_movement") ? "pawa-breaking-block-exist" : "pawa-breaking-block-nil"
      content_tag(:div, "", class: "col-1 #{class_name}")
    end.join.html_safe
  end

  # 年齢計算
  def calculate_age(birthday)
    now = Time.zone.today
    if birthday.present?
      age = now.year - birthday.year
      age -= 1 if now.yday < birthday.yday
      age
    end
  end

  # other_special_abilitiesに引数の値が入っているかを確認（編集画面でチェックボックスに初期値を入れるため）
  # return: true or false
  def ability_checked?(player, ability)
    player.other_special_abilities.to_s.split(",").include?(ability)
  end

  # 選手名ボックスの背景色、ボーダー色のクラスを返す
  def main_position_box_color_class(main_position)
    case main_position
    when 11..13
      "pawa-bg-sa-pitcher pawa-border-pitcher"
    when 2
      "pawa-bg-sa-catcher pawa-border-catcher"
    when 3..6
      "pawa-bg-sa-infielder pawa-border-infielder"
    else
      "pawa-bg-sa-outfielder pawa-border-outfielder"
    end
  end
end
