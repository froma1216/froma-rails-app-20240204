class CreatePawapuroPlayerMPositions < ActiveRecord::Migration[7.1]
  def change
    create_table :pawapuro_player_m_positions, comment: "選手・ポジションマスタ関連" do |t|
      t.references :player, null: false, foreign_key: { to_table: :pawapuro_players }, comment: "選手ID"
      t.references :m_position, null: false, foreign_key: { to_table: :pawapuro_m_positions }, comment: "ポジションID"
      t.integer :proficiency, comment: "適正レベル"

      t.timestamps
    end
  end
end
