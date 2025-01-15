require 'csv'

file_path = 'db/seeds/csv/m_valued_abilities.csv'
CSV.foreach(file_path, headers: true) do |row|
  value = Pawapuro::MValuedAbility.find_or_initialize_by(id: row['id'])
  value.update(
    name: row['name'],
    min_level: row['min_level'],
    max_level: row['max_level'],
    level_display_name: JSON.parse(row['level_display_name']),
    pitcher_fielder_division: row['pitcher_fielder_division']
  )
end
