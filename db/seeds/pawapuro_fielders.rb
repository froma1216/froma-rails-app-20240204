require 'csv'

file_path = 'db/seeds/csv/pawapuro_fielders.csv'
CSV.foreach(file_path, headers: true) do |row|
  fielder = PawapuroFielder.ind_or_initialize_by(id: row['id'])
  fielder.update(
    trajectory: row['trajectory'],
    meat: row['meat'],
    power: row['power'],
    running: row['running'],
    arm_strength: row['arm_strength'],
    defense: row['defense'],
    catching: row['catching'],
    chance: row['chance'],
    taihidaritousyu: row['taihidaritousyu'],
    catcher: row['catcher'],
    tourui: row['tourui'],
    sourui: row['sourui'],
    soukyuu: row['soukyuu'],
    other_special_abilities: row['other_special_abilities'],
    created_by: row['created_by'],
    updated_by: row['updated_by'],
    pawapuro_player_id: row['pawapuro_player_id']
  )
end
