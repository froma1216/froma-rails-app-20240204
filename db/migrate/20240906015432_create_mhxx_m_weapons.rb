class CreateMhxxMWeapons < ActiveRecord::Migration[7.1]
  def change
    create_table :mhxx_m_weapons, comment: "武器マスタ" do |t|
      t.references :m_weapon_type, null: false, foreign_key: { to_table: :mhxx_m_weapon_types }, comment: "武器種ID"
      t.string :name, comment: "武器名"
      t.integer :attack, comment: "攻撃力"
      t.integer :element, comment: "属性"
      t.string :rarity, comment: "レア度"

      t.timestamps
    end
  end
end
