require 'csv'

file_path = 'db/seeds/csv/m_basic_abilities.csv'
CSV.foreach(file_path, headers: true) do |row|
  fielder = Pawapuro::MBasicAbility.find_or_initialize_by(id: row['id'])
  fielder.update(
    name: row['name'],
    good_bad_division: row['good_bad_division'],
    pitcher_fielder_division: row['pitcher_fielder_division']
  )
end
