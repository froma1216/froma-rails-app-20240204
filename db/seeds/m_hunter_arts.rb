require 'csv'

file_path = 'db/seeds/csv/m_hunter_arts.csv'
CSV.foreach(file_path, headers: true) do |row|
  item = Mhxx::MHunterArt.find_or_initialize_by(id: row['id'])
  item.update(
    name: row['name'],
    m_weapon_type_id: row['m_weapon_type_id']
  )
end