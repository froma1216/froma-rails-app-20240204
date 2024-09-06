class CreateMhxxMHuntingStyles < ActiveRecord::Migration[7.1]
  def change
    create_table :mhxx_m_hunting_styles, comment: "狩猟スタイルマスタ" do |t|
      t.string :name, comment: "スタイル名"
      t.integer :hunter_arts_quantity, comment: "狩技数"

      t.timestamps
    end
  end
end
