module PawapuroHelper
  # TODO: ymlに移動
  # 数値をポジション名に変換
  # def display_position_name(val)
  #   positions = {
  #     11 => "先",
  #     12 => "中",
  #     13 => "抑",
  #     2 => "捕",
  #     3 => "一",
  #     4 => "二",
  #     5 => "三",
  #     6 => "遊",
  #     7 => "外"
  #   }
  #   content_tag(:span, positions[val] || "ERR")
  # end

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

  # # 能力値（弾道）によって文字色、→の角度を変更
  # def display_trajectory(trajectory)
  #   text_color, angle = case trajectory
  #                       when 2
  #                         ["pawa-text-c", "-10deg"]
  #                       when 3
  #                         ["pawa-text-b", "-30deg"]
  #                       when 4
  #                         ["pawa-text-a", "-45deg"]
  #                       else
  #                         ["pawa-text-d", "-0deg"]
  #                       end
  #   content_tag(:i, "", class: "fa fa-solid fa-arrow-right #{text_color}", style: "transform: rotate(#{angle});")
  # end

  # # 能力値（弾道以外）をアルファベットに変換＋文字色変更
  # def display_alphabet(val)
  #   case val
  #   when 1..19
  #     content_tag(:span, "G ", class: "pawa-text-g")
  #   when 20..39
  #     content_tag(:span, "F ", class: "pawa-text-f")
  #   when 40..49
  #     content_tag(:span, "E ", class: "pawa-text-e")
  #   when 50..59
  #     content_tag(:span, "D ", class: "pawa-text-d")
  #   when 60..69
  #     content_tag(:span, "C ", class: "pawa-text-c")
  #   when 70..79
  #     content_tag(:span, "B ", class: "pawa-text-b")
  #   when 80..89
  #     content_tag(:span, "A ", class: "pawa-text-a")
  #   when 90..100
  #     content_tag(:span, "S ", class: "pawa-text-s")
  #   else
  #     # エラーケース
  #     content_tag(:span, "", class: "")
  #   end
  # end

  # ポジション表示
  # 2 から 7 までの数値をループ。
  # 各ループで、動的に p2_proper, p3_proper, ..., p7_proper の値を取得。
  # p#{num}_proper が0ではなく、かつその数値が main_position と異なる場合にのみ、そのポジションを表示用の配列に追加。
  # メインポジションは、太字で確定表示。
  # 最終的に、配列内の要素を「・」で結合して返却。
  # def display_positions(player)
  #   positions = ["<strong>#{display_position_name(player.main_position)}</strong>"]

  #   (11..13).each do |num|
  #     proper = player.send("p#{num}_proper")
  #     positions << display_position_name(num) if proper.to_i.nonzero? && num != player.main_position
  #   end

  #   (2..7).each do |num|
  #     proper = player.send("p#{num}_proper")
  #     positions << display_position_name(num) if proper.to_i.nonzero? && num != player.main_position
  #   end

  #   positions.join("・").html_safe
  # end

  # 属性名から位置番号を抽出（上記のdisplay_sub_positionsで使用）
  def position_number(attribute)
    attribute[-1].to_i
  end

  # 変化球ブロック
  # 渡された数字分、色付きのブロックを表示する。
  def breaking_ball_blocks(block_count)
    Array.new(7) do |i|
      class_name = i < block_count ? "pawa-breaking-block-exist" : "pawa-breaking-block-nil"
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

  # # ポジションボックスの背景色、ボーダー色のクラスを返す
  # def main_position_box_color_class(main_position)
  #   case main_position
  #   when 11
  #     "pawa-position-box--s"
  #   when 12..13
  #     "pawa-position-box--r"
  #   when 2
  #     "pawa-position-box--c"
  #   when 3..6
  #     "pawa-position-box--i"
  #   else
  #     "pawa-position-box--o"
  #   end
  # end

  # # 選手名ボックスの背景色、ボーダー色のクラスを返す
  # def player_name_box_color_class(main_position, p11_proper, p12_proper, p13_proper, p2_proper, p3_proper, p4_proper,
  #                                 p5_proper, p6_proper, p7_proper)
  #   is_starter = p11_proper.positive?
  #   is_relief = p12_proper.positive? || p13_proper.positive?
  #   is_catcher = p2_proper.positive?
  #   is_infielder = p3_proper.positive? || p4_proper.positive? || p5_proper.positive? || p6_proper.positive?
  #   is_outfielder = p7_proper.positive?
  #   case main_position
  #   when 11
  #     if is_relief
  #       if is_catcher
  #         "pawa-player-name-box-src"
  #       elsif is_infielder
  #         "pawa-player-name-box-sri"
  #       elsif is_outfielder
  #         "pawa-player-name-box-sro"
  #       else
  #         "pawa-player-name-box-sr"
  #       end
  #     elsif is_catcher
  #       if is_infielder
  #         "pawa-player-name-box-sci"
  #       elsif is_outfielder
  #         "pawa-player-name-box-sco"
  #       else
  #         "pawa-player-name-box-sc"
  #       end
  #     elsif is_infielder
  #       if is_outfielder
  #         "pawa-player-name-box-sio"
  #       else
  #         "pawa-player-name-box-si"
  #       end
  #     elsif is_outfielder
  #       "pawa-player-name-box-so"
  #     else
  #       "pawa-player-name-box-s"
  #     end
  #   when 12..13
  #     if is_starter
  #       if is_catcher
  #         "pawa-player-name-box-rsc"
  #       elsif is_infielder
  #         "pawa-player-name-box-rsi"
  #       elsif is_outfielder
  #         "pawa-player-name-box-rso"
  #       else
  #         "pawa-player-name-box-rs"
  #       end
  #     elsif is_catcher
  #       if is_infielder
  #         "pawa-player-name-box-rci"
  #       elsif is_outfielder
  #         "pawa-player-name-box-rco"
  #       else
  #         "pawa-player-name-box-rc"
  #       end
  #     elsif is_infielder
  #       if is_outfielder
  #         "pawa-player-name-box-rio"
  #       else
  #         "pawa-player-name-box-ri"
  #       end
  #     elsif is_outfielder
  #       "pawa-player-name-box-ro"
  #     else
  #       "pawa-player-name-box-r"
  #     end
  #   when 2
  #     if is_infielder
  #       if is_outfielder
  #         "pawa-player-name-box-cio"
  #       else
  #         "pawa-player-name-box-ci"
  #       end
  #     elsif is_outfielder
  #       "pawa-player-name-box-co"
  #     else
  #       "pawa-player-name-box-c"
  #     end
  #   when 3..6
  #     if is_catcher
  #       if is_outfielder
  #         "pawa-player-name-box-ico"
  #       else
  #         "pawa-player-name-box-ic"
  #       end
  #     elsif is_outfielder
  #       "pawa-player-name-box-io"
  #     else
  #       "pawa-player-name-box-i"
  #     end
  #   else
  #     if is_catcher
  #       if is_infielder
  #         "pawa-player-name-box-oci"
  #       else
  #         "pawa-player-name-box-oc"
  #       end
  #     elsif is_infielder
  #       "pawa-player-name-box-oi"
  #     else
  #       "pawa-player-name-box-o"
  #     end
  #   end
  # end

  # 特殊能力（値なし）ボックスのフォント、文字感覚クラスを返す
  def ability_text_classes(ability)
    if ability.length >= 8
      # フォントサイズを小さくし、文字間隔も狭くする
      "small-font tighter-letter-spacing"
    elsif ability.length >= 7
      # 文字間隔のみ狭くする
      "tighter-letter-spacing"
    else
      ""
    end
  end

  # 特殊能力（値なし）ボックスの背景色、文字色クラスを返す
  def ability_no_value_color_classes(ability)
    abilities = PAWAPURO_ABILITIES
    if abilities["good"].include?(ability)
      ["pawa-bg-sa-g1", "pawa-bg-sa-g2", "pawa-text-good"]
    elsif abilities["bad"].include?(ability)
      ["pawa-bg-sa-b1", "pawa-bg-sa-b2", "pawa-text-bad"]
    elsif abilities["good_and_bad"].include?(ability)
      ["pawa-bg-sa-gb1", "pawa-bg-sa-gb2", "pawa-text-good"]
    elsif abilities["special"].include?(ability)
      ["pawa-bg-sa-sp1", "pawa-bg-sa-sp2", "pawa-text-special"]
    elsif abilities["sub"].include?(ability)
      ["pawa-bg-sa-sb1", "pawa-bg-sa-sb2", "pawa-text-sub"]
    else
      ["pawa-bg-sa-n1 d-none d-sm-block", "pawa-bg-sa-n2", "pawa-text-neutral"]
    end
  end

  # 特殊能力（値あり）ボックスの背景色、文字色クラスを返す
  def ability_value_color_classes(ability_value)
    case ability_value
    when 2..3
      ["pawa-bg-sa-g1", "pawa-bg-sa-g2", "pawa-text-good"]
    when -4..-2
      ["pawa-bg-sa-b1", "pawa-bg-sa-b2", "pawa-text-bad"]
    when 4
      ["pawa-bg-sa-sp1", "pawa-bg-sa-sp2", "pawa-text-special"]
    else
      ["pawa-bg-sa-n1", "pawa-bg-sa-n2", "pawa-text-neutral"]
    end
  end

  # 特殊能力（値あり）の金特、超赤特の名前を返す
  def gold_or_very_red_ability_name(ability_name, ability_value)
    PAWAPURO_GOLD_OR_VERY_RED_ABILITIES.dig(ability_name, ability_value) || ability_name
  end
end
