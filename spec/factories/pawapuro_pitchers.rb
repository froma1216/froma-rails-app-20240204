FactoryBot.define do
  factory :pawapuro_pitcher do
    pace { 163 }
    control { 58 }
    stamina { 80 }
    fastball_type { "ストレート" }
    second_fastball_type { "" }
    slider_type_pitch { "スライダー" }
    slider_type_movement { 5 }
    second_slider_type_pitch { "カットボール" }
    second_slider_type_movement { 2 }
    curveball_type_pitch { "スローカーブ" }
    curveball_type_movement { 1 }
    second_curveball_type_pitch { "" }
    second_curveball_type_movement { 0 }
    shootball_type_pitch { "" }
    shootball_type_movement { 0 }
    second_shootball_type_pitch { "" }
    second_shootball_type_movement { 0 }
    sinker_type_pitch { "Hシンカー" }
    sinker_type_movement { 3 }
    second_sinker_type_pitch { "" }
    second_sinker_type_movement { 0 }
    forkball_type_pitch { "フォーク" }
    forkball_type_movement { 4 }
    second_forkball_type_pitch { "" }
    second_forkball_type_movement { 0 }
    original_pitch { "" }
    taipinch { 2 }
    taihidaridasya { -2 }
    utarezuyosa { 0 }
    nobi { -1 }
    quick { 1 }
    other_special_abilities { "キレ◯,奪三振,球速安定,投打躍動" }
    created_by { "master" }
    updated_by { "master" }
    association :pawapuro_player
  end
end
