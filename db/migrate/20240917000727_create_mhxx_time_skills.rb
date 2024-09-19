class CreateMhxxTimeSkills < ActiveRecord::Migration[7.1]
  def change
    create_table :mhxx_time_skills, comment: "タイムスキル関連" do |t|
      t.references :time, foreign_key: { to_table: :mhxx_times }, null: false, comment: "タイムID"
      t.references :m_skill, foreign_key: { to_table: :mhxx_m_skills }, null: false, comment: "スキルID"

      t.timestamps
    end
  end
end
