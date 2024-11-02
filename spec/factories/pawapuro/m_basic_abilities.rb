FactoryBot.define do
  factory :pawapuro_m_basic_ability, class: 'Pawapuro::MBasicAbility' do
    name { "MyString" }
    good_bad_division { 1 }
    pitcher_fielder_division { 1 }
  end
end
