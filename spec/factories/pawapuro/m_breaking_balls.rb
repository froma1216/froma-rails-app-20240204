FactoryBot.define do
  factory :pawapuro_m_breaking_ball, class: 'Pawapuro::MBreakingBall' do
    name { "MyString" }
    breaking_ball_division { 1 }
    is_original { false }
  end
end
