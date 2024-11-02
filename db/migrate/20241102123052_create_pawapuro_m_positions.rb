class CreatePawapuroMPositions < ActiveRecord::Migration[7.1]
  def change
    create_table :pawapuro_m_positions, comment: "ポジションマスタ" do |t|
      t.string :name, comment: "ポジション名"
      t.string :abbreviation, comment: "略称"

      t.timestamps
    end
  end
end
