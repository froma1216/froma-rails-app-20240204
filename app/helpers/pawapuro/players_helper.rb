module Pawapuro::PlayersHelper
  # TODO: 切り出す（画面毎？機能毎？）
  # TODO: 使っていないメソッドがないか確認
  # 選手名ボックスの背景色、ボーダー色のクラスを返す
  def player_name_box_color_class(player)
    positions = player.formatted_position_abbreviations.map { |pos| pos[:id] }

    is_starter = positions.include?(10)
    is_relief = positions.include?(11) || positions.include?(12)
    is_catcher = positions.include?(2)
    # TODO: 以下のモデル内で、定数で管理
    # app/models/pawapuro/m_position.rb
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

  # TODO: アルファベットはenumで
  # 能力値（弾道以外）をアルファベットに変換＋文字色変更
  def display_alphabet(val)
    text, text_color = case val
                       when 1..19
                         ["G", "pawa-text-g"]
                       when 20..39
                         ["F", "pawa-text-f"]
                       when 40..49
                         ["E", "pawa-text-e"]
                       when 50..59
                         ["D", "pawa-text-d"]
                       when 60..69
                         ["C", "pawa-text-c"]
                       when 70..79
                         ["B", "pawa-text-b"]
                       when 80..89
                         ["A", "pawa-text-a"]
                       when 90..100
                         ["S", "pawa-text-s"]
                       else
                         ["", ""]
                       end
    content_tag(:span, "#{text} ", class: text_color)
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

  # 変化球タイプ（PC）
  def breaking_ball_types_pc
    [
      { division: 100, rotation: 180, label: "ストレート系" },
      { division: 230, rotation: 90, label: "シュート系" },
      { division: 240, rotation: 45, label: "シンカー系" },
      { division: 250, rotation: 0, label: "フォーク系" },
      { division: 220, rotation: -45, label: "カーブ系" },
      { division: 210, rotation: -90, label: "スライダー系" }
    ]
  end

  # 変化球タイプ（PC）
  def breaking_ball_types_mobile
    [
      { division: 230, rotation: 90, label: "シュート系" },
      { division: 100, rotation: 180, label: "ストレート系" },
      { division: 210, rotation: -90, label: "スライダー系" },
      { division: 240, rotation: 45, label: "シンカー系" },
      { division: 250, rotation: 0, label: "フォーク系" },
      { division: 220, rotation: -45, label: "カーブ系" }
    ]
  end

  # 一覧BOXの値（変化球）
  def ability_value_movements(value, value2)
    content_tag(:div, class: "d-flex justify-content-between") do
      content_tag(:span, value) +
        content_tag(:span, value2.presence || "")
    end
  end

  # 一覧BOXの値（球速）
  def index_ability_value_pace(value)
    content_tag(:span, value) +
      content_tag(:span) do
        content_tag(:small, "km/h")
      end
  end

  # 一覧BOXの値（弾道）
  def index_ability_value_trajectory(value)
    content_tag(:span) do
      concat display_trajectory(value)
    end +
      content_tag(:span, value)
  end

  # 一覧BOXの値（アルファベット＋数値）
  def index_ability_value_basic(value)
    content_tag(:span) do
      concat display_alphabet(value)
    end +
      content_tag(:span, value)
  end

  # 詳細BOXの値（球速）
  def details_ability_value_pace(value)
    content_tag(:div, class: "d-flex flex-column flex-sm-row align-items-center") do
      content_tag(:span, value, class: "fs-5 fw-bold me-1") +
        content_tag(:span, "km/h", class: "mt-sm-1")
    end
  end

  # 詳細BOXの値（弾道）
  def details_ability_value_trajectory(value)
    content_tag(:span, class: "pawa-text-a fs-5 fw-bold me-1 me-sm-2") do
      concat display_trajectory(value)
    end +
      content_tag(:span, value, class: "fs-5 fw-bold")
  end

  # 詳細BOXの値（アルファベット＋数値）
  def details_ability_value_basic(value)
    content_tag(:span, class: "pawa-text-a fs-5 fw-bold me-1 me-sm-2") do
      concat display_alphabet(value)
    end +
      content_tag(:span, value, class: "fs-5 fw-bold")
  end

  # 変化球ブロック
  # 渡された数字分、色付きのブロックを表示する。
  def breaking_ball_blocks(block_count)
    Array.new(7) do |i|
      class_name = i < block_count ? "pawa-breaking-block-exist" : "pawa-breaking-block-nil"
      content_tag(:div, "", class: "col-1 #{class_name}")
    end.join.html_safe
  end

  # 特殊能力ボックスのクラスをまとめて返す
  def special_ability_box_styles(ability_name, ability_good_bad_division)
    # 外側のコンテナクラスを決定
    bg_class_1, bg_class_2, text_class = special_ability_box_color_styles(ability_good_bad_division)
    text_adjust_class = adjust_text_style(ability_name)

    {
      container_class: bg_class_1,
      inner_class: "#{bg_class_2} #{text_class} #{text_adjust_class}"
    }
  end

  # 特殊能力ボックスの背景色、文字色クラスを返す
  def special_ability_box_color_styles(ability_good_bad_division)
    case ability_good_bad_division
    when "good"
      ["pawa-bg-sa-good1", "pawa-bg-sa-good2", "pawa-text-good"]
    when "bad"
      ["pawa-bg-sa-bad1", "pawa-bg-sa-bad2", "pawa-text-bad"]
    when "good_and_bad"
      ["pawa-bg-sa-good_and_bad1", "pawa-bg-sa-good_and_bad2", "pawa-text-good"]
    when "special"
      ["pawa-bg-sa-special1", "pawa-bg-sa-special2", "pawa-text-special"]
    when "sub"
      ["pawa-bg-sa-sub1", "pawa-bg-sa-sub2", "pawa-text-sub"]
    else
      ["pawa-bg-sa-neutral1 d-none d-sm-block", "pawa-bg-sa-neutral2", "pawa-text-neutral"]
    end
  end

  # 特殊能力ボックスのフォント、文字感覚クラスを返す
  def adjust_text_style(ability_name)
    case ability_name&.length
    # フォントサイズを小さくし、文字間隔も狭くする
    when 8.. then "small-font tighter-letter-spacing"
    # 文字間隔のみ狭くする
    when 7 then "tighter-letter-spacing"
    else ""
    end
  end

  # 特殊能力（値あり）の数値をアルファベットに変換
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
    abilities[val] || "D"
  end

  # 特殊能力（値あり）の金特、超赤特の名前を返す
  def gold_or_very_red_ability_name(ability_name, ability_value)
    PAWAPURO_GOLD_OR_VERY_RED_ABILITIES.dig(ability_name, ability_value) || ability_name
  end

  # 特殊能力（値あり）の青赤区分を返す
  def valued_ability_good_bad_division(ability_value)
    case ability_value
    when ..-2
      "bad"
    when 2..3
      "good"
    when 4
      "special"
    else
      "neutral" # 想定外の値が渡された場合のデフォルト値
    end
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
end
