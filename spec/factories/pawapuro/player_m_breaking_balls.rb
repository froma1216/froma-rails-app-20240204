FactoryBot.define do
  factory :pawapuro_player_m_breaking_ball, class: 'Pawapuro::PlayerMBreakingBall' do
    player { nil }
    ball_type_order { 1 }
    m_breaking_ball_id { nil }
    movement { 1 }
  end
end
