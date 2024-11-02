class CreatePawapuroPlayerMBreakingBalls < ActiveRecord::Migration[7.1]
  def change
    create_table :pawapuro_player_m_breaking_balls, comment: "選手・変化球マスタ関連" do |t|
      t.references :player, null: false, foreign_key: { to_table: :pawapuro_players }, comment: "選手ID"
      t.integer :ball_type_order, comment: "球種順序"
      t.references :m_breaking_ball, null: false, foreign_key: { to_table: :pawapuro_m_breaking_balls }, comment: "変化球マスタID"
      t.integer :movement, comment: "変化量"

      t.timestamps
    end
  end
end
