FactoryBot.define do
  factory :pawapuro_player, class: 'Pawapuro::Player' do
    last_name { "MyString" }
    first_name { "MyString" }
    player_name { "MyString" }
    back_name { "MyString" }
    birthday { "2024-11-02" }
    main_position { nil }
    throwing { 1 }
    batting { 1 }
    pace { 1 }
    control { 1 }
    stamina { 1 }
    original_breaking_ball_name { "MyString" }
    trajectory { 1 }
    meat { 1 }
    power { 1 }
    running { 1 }
    arm { 1 }
    fielding { 1 }
    catching { 1 }
    note { "MyString" }
    user { nil }
  end
end
