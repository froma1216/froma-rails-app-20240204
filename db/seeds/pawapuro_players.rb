require 'csv'

file_path = 'db/seeds/csv/pawapuro_players.csv'
CSV.foreach(file_path, headers: true) do |row|
  player = PawapuroPlayer.find_or_initialize_by(id: row['id'])
  player.update(
    last_name: row['last_name'],
    first_name: row['first_name'],
    player_name: row['player_name'],
    back_name: row['back_name'],
    birthday: row['birthday'],
    main_position: row['main_position'],
    p11_proper: row['p11_proper'],
    p12_proper: row['p12_proper'],
    p13_proper: row['p13_proper'],
    p2_proper: row['p2_proper'],
    p3_proper: row['p3_proper'],
    p4_proper: row['p4_proper'],
    p5_proper: row['p5_proper'],
    p6_proper: row['p6_proper'],
    p7_proper: row['p7_proper'],
    throws: row['throws'],
    bats: row['bats'],
    kaifuku: row['kaifuku'],
    kegasinikusa: row['kegasinikusa'],
    other_special_abilities: row['other_special_abilities'],
    note: row['note'],
    created_by: row['created_by'],
    updated_by: row['updated_by']
  )
end