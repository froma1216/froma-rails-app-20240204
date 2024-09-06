class CreateMhxxMMonsters < ActiveRecord::Migration[7.1]
  def change
    create_table :mhxx_m_monsters, comment: "モンスターマスタ" do |t|
      t.string :name, comment: "モンスター名"
      t.string :name_romanized, comment: "ローマ字"

      t.timestamps
    end
  end
end
