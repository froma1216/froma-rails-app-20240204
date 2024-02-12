class CreatePawapuroPlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :pawapuro_players do |t|
      t.string :last_name
      t.string :first_name
      t.string :player_name
      t.string :back_name
      t.date :birthday
      t.integer :main_position
      t.integer :p11_proper
      t.integer :p12_proper
      t.integer :p13_proper
      t.integer :p2_proper
      t.integer :p3_proper
      t.integer :p4_proper
      t.integer :p5_proper
      t.integer :p6_proper
      t.integer :p7_proper
      t.string :throws
      t.string :bats
      t.references :pawapuro_pitcher, null: false, foreign_key: true
      t.references :pawapuro_fielder, null: false, foreign_key: true
      t.integer :kaifuku
      t.integer :kegasinikusa
      t.string :other_special_abilities
      t.text :note
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
