require 'csv'

file_path = 'db/seeds/csv/m_hunting_styles.csv'
CSV.foreach(file_path, headers: true) do |row|
  item = Mhxx::MHuntingStyle.find_or_initialize_by(id: row['id'])
  item.update(
    name: row['name'],
    hunter_arts_quantity: row['hunter_arts_quantity']
  )
end