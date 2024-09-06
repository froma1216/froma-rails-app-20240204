require 'csv'

file_path = 'db/seeds/csv/m_weapon_types.csv'
CSV.foreach(file_path, headers: true) do |row|
  item = Mhxx::MWeaponType.find_or_initialize_by(id: row['id'])
  item.update(
    weapon_type_division: row['weapon_type_division'],
    name: row['name'],
    name_romanized: row['name_romanized']
  )
end