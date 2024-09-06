require 'csv'

file_path = 'db/seeds/csv/m_sub_quest_ranks.csv'
CSV.foreach(file_path, headers: true) do |row|
  item = Mhxx::MSubQuestRank.find_or_initialize_by(id: row['id'])
  item.update(
    m_quest_rank_id: row['m_quest_rank_id'],
    name: row['name']
  )
end