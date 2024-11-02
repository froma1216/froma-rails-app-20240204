FactoryBot.define do
  factory :pawapuro_m_valued_ability, class: 'Pawapuro::MValuedAbility' do
    name { "MyString" }
    min_level { 1 }
    max_level { 1 }
    level_display_name { "MyString" }
    pitcher_fielder_division { 1 }
  end
end
