require 'csv'

file_path = 'db/seeds/csv/m_positions.csv'
CSV.foreach(file_path, headers: true) do |row|
  player = Pawapuro::MPosition.find_or_initialize_by(id: row['id'])
  player.update(
    name: row['name'],
    abbreviation: row['abbreviation']
  )
end