class CreateMhxxMSkills < ActiveRecord::Migration[7.1]
  def change
    create_table :mhxx_m_skills, comment: "スキルマスタ" do |t|
      t.string :name, comment: "スキル名"
      t.string :skill_division, comment: "スキル区分"
      t.string :weapon_type_division, comment: "武器種区分"

      t.timestamps
    end
  end
end
