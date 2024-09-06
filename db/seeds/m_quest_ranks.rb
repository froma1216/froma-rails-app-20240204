require 'csv'

file_path = 'db/seeds/csv/m_quest_ranks.csv'
CSV.foreach(file_path, headers: true) do |row|
  item = Mhxx::MQuestRank.find_or_initialize_by(id: row['id'])
  item.update(
    name: row['name']
  )
end