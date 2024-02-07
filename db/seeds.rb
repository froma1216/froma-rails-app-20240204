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
