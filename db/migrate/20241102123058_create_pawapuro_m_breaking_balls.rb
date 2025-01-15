class CreatePawapuroMBreakingBalls < ActiveRecord::Migration[7.1]
  def change
    create_table :pawapuro_m_breaking_balls, comment: "変化球マスタ" do |t|
      t.string :name, comment: "変化球名"
      t.integer :breaking_ball_division, comment: "変化方向区分"
      t.boolean :is_original, comment: "オリジナルフラグ"

      t.timestamps
    end
  end
end
