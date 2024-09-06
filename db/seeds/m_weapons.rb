require 'csv'

file_path = 'db/seeds/csv/m_weapons.csv'
CSV.foreach(file_path, headers: true) do |row|
  item = Mhxx::MWeapon.find_or_initialize_by(id: row['id'])
  item.update(
    m_weapon_type_id: row['m_weapon_type_id'],
    name: row['name'],
    attack: row['attack'],
    element: row['element'],
    rarity: row['rarity']
  )
end