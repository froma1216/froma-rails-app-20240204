require 'csv'

file_path = 'db/seeds/csv/m_monsters.csv'
CSV.foreach(file_path, headers: true) do |row|
  item = Mhxx::MMonster.find_or_initialize_by(id: row['id'])
  item.update(
    name: row['name'],
    name_romanized: row['name_romanized']
  )
end