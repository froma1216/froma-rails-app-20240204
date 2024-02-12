class CreatePawapuroFielders < ActiveRecord::Migration[7.1]
  def change
    create_table :pawapuro_fielders do |t|
      t.integer :trajectory
      t.integer :meat
      t.integer :power
      t.integer :running
      t.integer :arm_strength
      t.integer :defense
      t.integer :catching
      t.integer :chance
      t.integer :taihidaritousyu
      t.integer :catcher
      t.integer :tourui
      t.integer :sourui
      t.integer :soukyuu
      t.string :other_special_abilities
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
