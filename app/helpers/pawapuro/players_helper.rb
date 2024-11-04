module Pawapuro::PlayersHelper
  # 選手名ボックスの背景色、ボーダー色のクラスを返す
  def player_name_box_color_class(player)
    positions = player.formatted_position_abbreviations.map { |pos| pos[:id] }

    is_starter = positions.include?(10)
    is_relief = positions.include?(11) || positions.include?(12)
    is_catcher = positions.include?(2)
    is_infielder = positions.any? { |pos| [3, 4, 5, 6].include?(pos) }
    is_outfielder = positions.include?(13)

    case player.main_position.id
    when 10
      if is_relief
        if is_catcher
          "pawa-player-name-box-src"
        elsif is_infielder
          "pawa-player-name-box-sri"
        elsif is_outfielder
          "pawa-player-name-box-sro"
        else
          "pawa-player-name-box-sr"
        end
      elsif is_catcher
        if is_infielder
          "pawa-player-name-box-sci"
        elsif is_outfielder
          "pawa-player-name-box-sco"
        else
          "pawa-player-name-box-sc"
        end
      elsif is_infielder
        if is_outfielder
          "pawa-player-name-box-sio"
        else
          "pawa-player-name-box-si"
        end
      elsif is_outfielder
        "pawa-player-name-box-so"
      else
        "pawa-player-name-box-s"
      end
    when 12..13
      if is_starter
        if is_catcher
          "pawa-player-name-box-rsc"
        elsif is_infielder
          "pawa-player-name-box-rsi"
        elsif is_outfielder
          "pawa-player-name-box-rso"
        else
          "pawa-player-name-box-rs"
        end
      elsif is_catcher
        if is_infielder
          "pawa-player-name-box-rci"
        elsif is_outfielder
          "pawa-player-name-box-rco"
        else
          "pawa-player-name-box-rc"
        end
      elsif is_infielder
        if is_outfielder
          "pawa-player-name-box-rio"
        else
          "pawa-player-name-box-ri"
        end
      elsif is_outfielder
        "pawa-player-name-box-ro"
      else
        "pawa-player-name-box-r"
      end
    when 2
      if is_infielder
        if is_outfielder
          "pawa-player-name-box-cio"
        else
          "pawa-player-name-box-ci"
        end
      elsif is_outfielder
        "pawa-player-name-box-co"
      else
        "pawa-player-name-box-c"
      end
    when 3..6
      if is_catcher
        if is_outfielder
          "pawa-player-name-box-ico"
        else
          "pawa-player-name-box-ic"
        end
      elsif is_outfielder
        "pawa-player-name-box-io"
      else
        "pawa-player-name-box-i"
      end
    else
      if is_catcher
        if is_infielder
          "pawa-player-name-box-oci"
        else
          "pawa-player-name-box-oc"
        end
      elsif is_infielder
        "pawa-player-name-box-oi"
      else
        "pawa-player-name-box-o"
      end
    end
  end

  # ポジションボックスの背景色、ボーダー色のクラスを返す
  def main_position_box_color_class(main_position)
    case main_position
    when 10, 1
      "pawa-position-box--s"
    when 11..12
      "pawa-position-box--r"
    when 2
      "pawa-position-box--c"
    when 3..6
      "pawa-position-box--i"
    else
      "pawa-position-box--o"
    end
  end

  # 能力値（弾道）によって文字色、→の角度を変更
  def display_trajectory(trajectory)
    text_color, angle = case trajectory
                        when 2
                          ["pawa-text-c", "-10deg"]
                        when 3
                          ["pawa-text-b", "-30deg"]
                        when 4
                          ["pawa-text-a", "-45deg"]
                        else
                          ["pawa-text-d", "-0deg"]
                        end
    content_tag(:i, "", class: "fa fa-solid fa-arrow-right #{text_color}", style: "transform: rotate(#{angle});")
  end

  # 能力値（弾道以外）をアルファベットに変換＋文字色変更
  def display_alphabet(val)
    case val
    when 1..19
      content_tag(:span, "G ", class: "pawa-text-g")
    when 20..39
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

  # ポジション適正を「・」区切りで表示
  def display_position_abbreviations(positions, main_position_id)
    positions.map do |pos|
      if pos[:id] == main_position_id
        content_tag(:strong, pos[:abbreviation])
      else
        pos[:abbreviation]
      end
    end.join("・").html_safe
  end
end
