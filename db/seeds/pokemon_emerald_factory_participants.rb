require 'csv'

file_path = 'db/seeds/csv/pokemon_emerald_factory_participants.csv'
CSV.foreach(file_path, headers: true) do |row|
  pokemon = PokemonEmeraldFactoryParticipant.find_or_initialize_by(id: row['id'])
  pokemon.update(
    no: row['no'],
    name: row['name'],
    type1: row['type1'],
    type2: row['type2'],
    move1: row['move1'],
    move2: row['move2'],
    move3: row['move3'],
    move4: row['move4'],
    item: row['item'],
    effort_values: row['effort_values'],
    character: row['character'],
    lap1_show: row['lap1_show'],
    lap2_show: row['lap2_show'],
    lap3_show: row['lap3_show'],
    lap4_show: row['lap4_show'],
    lap5_show: row['lap5_show'],
    lap6_show: row['lap6_show'],
    lap7_show: row['lap7_show'],
    lap8_show: row['lap8_show']
  )
end
