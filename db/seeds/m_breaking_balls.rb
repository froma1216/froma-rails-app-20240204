require 'csv'

file_path = 'db/seeds/csv/m_breaking_balls.csv'
CSV.foreach(file_path, headers: true) do |row|
  pitcher = Pawapuro::MBreakingBall.find_or_initialize_by(id: row['id'])
  pitcher.update(
    name: row['name'],
    breaking_ball_division: row['breaking_ball_division'],
    is_original: row['is_original']
  )
end