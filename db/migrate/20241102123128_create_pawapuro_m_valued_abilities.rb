class CreatePawapuroMValuedAbilities < ActiveRecord::Migration[7.1]
  def change
    create_table :pawapuro_m_valued_abilities, comment: "値あり特殊能力マスタ" do |t|
      t.string :name, comment: "特殊能力名"
      t.integer :min_level, comment: "最小レベル"
      t.integer :max_level, comment: "最大レベル"
      t.string :level_display_name, comment: "表示名"
      t.integer :pitcher_fielder_division, comment: "投手野手区分"

      t.timestamps
    end
  end
end
