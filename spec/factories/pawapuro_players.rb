FactoryBot.define do
  factory :pawapuro_player do
    last_name { "大谷" }
    first_name { "翔平" }
    player_name { "大谷翔平" }
    back_name { "OTANI" }
    birthday { Date.new(1993, 7, 15) }
    main_position { 11 }
    p11_proper { 3 }
    p12_proper { 0 }
    p13_proper { 0 }
    p2_proper { 0 }
    p3_proper { 0 }
    p4_proper { 0 }
    p5_proper { 0 }
    p6_proper { 0 }
    p7_proper { 1 }
    throws { "right" }
    bats { "left" }
    kaifuku { 3 }
    kegasinikusa { 2 }
    other_special_abilities { "人気者,強振多用,積極打法,積極走塁" }
    note { "めっちゃ野球うまい。" }
    created_by { "master" }
    updated_by { "master" }
  end
end
