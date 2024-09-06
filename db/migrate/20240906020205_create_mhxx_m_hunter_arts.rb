class CreateMhxxMHunterArts < ActiveRecord::Migration[7.1]
  def change
    create_table :mhxx_m_hunter_arts, comment: "狩技マスタ" do |t|
      t.string :name, comment: "狩技名"
      t.references :m_weapon_type, null: false, foreign_key: { to_table: :mhxx_m_weapon_types }, comment: "武器種ID"

      t.timestamps
    end
  end
end
