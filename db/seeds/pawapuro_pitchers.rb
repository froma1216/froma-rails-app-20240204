require 'csv'

file_path = 'db/seeds/csv/pawapuro_pitchers.csv'
CSV.foreach(file_path, headers: true) do |row|
  pitcher = PawapuroPitcher.find_or_initialize_by(id: row['id'])
  pitcher.update(
    pace: row['pace'],
    control: row['control'],
    stamina: row['stamina'],
    fastball_type: row['fastball_type'],
    second_fastball_type: row['second_fastball_type'],
    slider_type_pitch: row['slider_type_pitch'],
    slider_type_movement: row['slider_type_movement'],
    second_slider_type_pitch: row['second_slider_type_pitch'],
    second_slider_type_movement: row['second_slider_type_movement'],
    curveball_type_pitch: row['curveball_type_pitch'],
    curveball_type_movement: row['curveball_type_movement'],
    second_curveball_type_pitch: row['second_curveball_type_pitch'],
    second_curveball_type_movement: row['second_curveball_type_movement'],
    shootball_type_pitch: row['shootball_type_pitch'],
    shootball_type_movement: row['shootball_type_movement'],
    second_shootball_type_pitch: row['second_shootball_type_pitch'],
    second_shootball_type_movement: row['second_shootball_type_movement'],
    sinker_type_pitch: row['sinker_type_pitch'],
    sinker_type_movement: row['sinker_type_movement'],
    second_sinker_type_pitch: row['second_sinker_type_pitch'],
    second_sinker_type_movement: row['second_sinker_type_movement'],
    forkball_type_pitch: row['forkball_type_pitch'],
    forkball_type_movement: row['forkball_type_movement'],
    second_forkball_type_pitch: row['second_forkball_type_pitch'],
    second_forkball_type_movement: row['second_forkball_type_movement'],
    original_pitch: row['original_pitch'],
    taipinch: row['taipinch'],
    taihidaridasya: row['taihidaridasya'],
    utarezuyosa: row['utarezuyosa'],
    nobi: row['nobi'],
    quick: row['quick'],
    other_special_abilities: row['other_special_abilities'],
    created_by: row['created_by'],
    updated_by: row['updated_by'],
    pawapuro_player_id: row['pawapuro_player_id']
  )
end