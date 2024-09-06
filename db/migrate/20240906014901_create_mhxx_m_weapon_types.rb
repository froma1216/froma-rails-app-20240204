class CreateMhxxMWeaponTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :mhxx_m_weapon_types, comment: "武器種マスタ" do |t|
      t.integer :weapon_type_division, comment: "武器種区分"
      t.string :name, comment: "武器種名"
      t.string :name_romanized, comment: "ローマ字"

      t.timestamps
    end
  end
end
