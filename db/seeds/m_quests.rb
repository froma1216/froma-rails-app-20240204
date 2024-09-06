require 'csv'

file_path = 'db/seeds/csv/m_quests.csv'
CSV.foreach(file_path, headers: true) do |row|
  item = Mhxx::MQuest.find_or_initialize_by(id: row['id'])
  item.update(
    name: row['name'],
    m_sub_quest_rank_id: row['m_sub_quest_rank_id'],
    quest_division: row['quest_division'],
    m_monster1_id: row['m_monster1_id'],
    m_monster2_id: row['m_monster2_id'],
    m_monster3_id: row['m_monster3_id'],
    m_monster4_id: row['m_monster4_id'],
    m_monster5_id: row['m_monster5_id']
  )
end