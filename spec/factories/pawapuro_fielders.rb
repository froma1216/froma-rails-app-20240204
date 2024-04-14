FactoryBot.define do
  factory :pawapuro_fielder do
    trajectory { 4 }
    meat { 57 }
    power { 90 }
    running { 78 }
    arm_strength { 85 }
    defense { 42 }
    catching { 52 }
    chance { 2 }
    taihidaritousyu { 0 }
    catcher { 0 }
    tourui { -1 }
    sourui { 2 }
    soukyuu { 1 }
    other_special_abilities { "パワーヒッター,初球○,満塁男,レーザービーム,三振" }
    created_by { "master" }
    updated_by { "master" }
    association :pawapuro_player
  end
end
