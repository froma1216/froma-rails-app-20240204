class CreatePawapuroMBasicAbilities < ActiveRecord::Migration[7.1]
  def change
    create_table :pawapuro_m_basic_abilities, comment: "値なし特殊能力マスタ" do |t|
      t.string :name, comment: "特殊能力名"
      t.integer :good_bad_division, comment: "青赤区分"
      t.integer :pitcher_fielder_division, comment: "投手野手区分"

      t.timestamps
    end
  end
end
