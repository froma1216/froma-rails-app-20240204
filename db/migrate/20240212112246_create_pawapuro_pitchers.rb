class CreatePawapuroPitchers < ActiveRecord::Migration[7.1]
  def change
    create_table :pawapuro_pitchers do |t|
      t.integer :pace
      t.integer :control
      t.integer :stamina
      t.string :fastball_type
      t.string :second_fastball_type
      t.string :slider_type_pitch
      t.integer :slider_type_movement
      t.string :second_slider_type_pitch
      t.integer :second_slider_type_movement
      t.string :curveball_type_pitch
      t.integer :curveball_type_movement
      t.string :second_curveball_type_pitch
      t.integer :second_curveball_type_movement
      t.string :shootball_type_pitch
      t.integer :shootball_type_movement
      t.string :second_shootball_type_pitch
      t.integer :second_shootball_type_movement
      t.string :sinker_type_pitch
      t.integer :sinker_type_movement
      t.string :second_sinker_type_pitch
      t.integer :second_sinker_type_movement
      t.string :forkball_type_pitch
      t.integer :forkball_type_movement
      t.string :second_forkball_type_pitch
      t.integer :second_forkball_type_movement
      t.string :original_pitch
      t.integer :taipinch
      t.integer :taihidaridasya
      t.integer :utarezuyosa
      t.integer :nobi
      t.integer :quick
      t.string :other_special_abilities
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
