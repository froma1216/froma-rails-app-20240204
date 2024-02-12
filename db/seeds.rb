Conference.create(
  name:'The 1st Conference',
  description:'これは最初のイベントです',
  start_date:'2020-07-01',
  duration:1)
c=Conference.create(
  name:'The 2nd Conference',
  description:'これは次のイベントです',
  start_date:'2020-08-15',
  duration:2)
d1=Day.create(
  title:'第1日',
  description:'初日です',
  seq_no:0)
c.days << d1
d2=Day.create(
  title:'第2日',
  description:'二日目です',
  seq_no:1)
c.days << d2
t1=Track.create(
  title:'Aトラック',
  description:'初日、最初のトラックです',
  seq_no:0)
d1.tracks << t1
t2=Track.create(
  title:'Bトラック',
  description:'初日、2つめのトラックです',
  seq_no:1)
d1.tracks << t2
s=Slot.create(
  title:'第1セッション',
  organizer:'Antonio Banderas',
  chair:'Cynthia Erivo',
  lecturer:'Scarlett Johansson',
  room:'A-1',description:'第1セッションです',
  audience:'第1セッションを聞きたい人',
  level:'初心者',
  start_time:'2020-08-15 10:00:00',
  end_time:'2020-08-15 12:00:00')
t1.slots << s
s=Slot.create(
  title:'第2セッション',
  organizer:'Jonathan Pryce',
  chair:'Florence Pugh',
  lecturer:'Yalitza Aparicio',
  room:'A-2',
  description:'第2セッションです',
  audience:'第2セッションを聞きたい人',
  level:'初心者',
  start_time:'2020-08-15 13:00:00',
  end_time:'2020-08-15 15:00:00')
t1.slots << s
s=Slot.create(
  title:'第3セッション',
  organizer:'OliviaColman',
  chair:'MarinadeTavira',
  lecturer:'AdamDriver',
  room:'A-3',
  description:'第3セッションです',
  audience:'第3セッションを聞きたい人',
  level:'初心者',
  start_time:'2020-08-15 15:00:00',
  end_time:'2020-08-15 17:00:00')
t1.slots << s
s=Slot.create(
  title:'第4セッション',
  organizer:'SamElliott',
  chair:'LadyGaga',
  lecturer:'RichardE.Grant',
  room:'B-1',
  description:'第4セッションです',
  audience:'第4セッションを聞きたい人',
  level:'初心者',
  start_time:'2020-08-15 10:00:00',
  end_time:'2020-08-15 12:00:00')
t2.slots << s
s=Slot.create(
  title:'第5セッション',
  organizer:'ReginaKing',
  chair:'RamiMalek',
  lecturer:'MaryJ.Blige',
  room:'B-2',
  description:'第5セッションです',
  audience:'第5セッションを聞きたい人',
  level:'初心者',
  start_time:'2020-08-15 13:00:00',
  end_time:'2020-08-15 15:00:00')
t2.slots << s
s=Slot.create(
  title:'第6セッション',
  organizer:'TimotheeChalamet',
  chair:'AllisonJanney',
  lecturer:'DanielKaluuya',
  room:'B-3',
  description:'第6セッションです',
  audience:'第6セッションを聞きたい人',
  level:'初心者',
  start_time:'2020-08-15 15:00:00',
  end_time:'2020-08-15 17:00:00')
t2.slots << s

# パワプロ：投手能力
pawapuro_pitcher = PawapuroPitcher.create(
  pace: 163,
  control: 58,
  stamina: 80,
  fastball_type: "ストレート",
  slider_type_pitch: "スライダー",
  slider_type_movement: 5,
  second_slider_type_pitch: "カットボール",
  second_slider_type_movement: 2,
  curveball_type_pitch: "スローカーブ",
  curveball_type_movement: 1,
  sinker_type_pitch: "Hシンカー",
  sinker_type_movement: 3,
  forkball_type_pitch: "フォーク",
  forkball_type_movement: 4,
  taipinch: 2,
  taihidaridasya: -2,
  utarezuyosa: 0,
  nobi: -1,
  quick: 1,
  other_special_abilities: "キレ○,奪三振,球速安定,投打躍動",
  created_by: "master",
  updated_by: "master"
)

# パワプロ：野手能力
pawapuro_fielder = PawapuroFielder.create(
  trajectory: 4,
  meat: 57,
  power: 90,
  running: 78,
  arm_strength: 85,
  defense: 42,
  catching: 52,
  chance: 2,
  taihidaritousyu: 0,
  catcher: 0,
  tourui: -1,
  sourui: 2,
  soukyuu: 1,
  other_special_abilities: "パワーヒッター,初球○,満塁男,レーザービーム,三振",
  created_by: "master",
  updated_by: "master"
)

# パワプロ：選手情報
PawapuroPlayer.create(
  last_name: "大谷",
  first_name: "翔平",
  player_name: "大谷翔平",
  back_name: "OTANI",
  birthday: Date.new(1993, 7, 15),
  main_position: 11,
  p11_proper: 3,
  p12_proper: 0,
  p13_proper: 0,
  p2_proper: 0,
  p3_proper: 0,
  p4_proper: 0,
  p5_proper: 0,
  p6_proper: 0,
  p7_proper: 1,
  throws: "right",
  bats: "left",
  pawapuro_pitcher: pawapuro_pitcher,
  pawapuro_fielder: pawapuro_fielder,
  kaifuku: 3,
  kegasinikusa: 2,
  other_special_abilities: "人気者,強振多用,積極打法,積極走塁",
  note: "めっちゃ野球うまい。",
  created_by: "master",
  updated_by: "master"
)