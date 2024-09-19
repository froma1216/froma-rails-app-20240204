require 'csv'

file_path = 'db/seeds/csv/m_skills.csv'
CSV.foreach(file_path, headers: true) do |row|
  item = Mhxx::MSkill.find_or_initialize_by(id: row['id'])
  item.update(
    name: row['name'],
    skill_division: row['skill_division'],
    weapon_type_division: row['weapon_type_division']
  )
end