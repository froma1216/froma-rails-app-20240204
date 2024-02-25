class CreatePokemonEmeraldFactoryParticipants < ActiveRecord::Migration[7.1]
  def change
    create_table :pokemon_emerald_factory_participants do |t|
      t.integer :no
      t.string :name
      t.string :type1
      t.string :type2
      t.string :move1
      t.string :move2
      t.string :move3
      t.string :move4
      t.string :item
      t.string :effort_values
      t.string :character
      t.integer :lap1_show
      t.integer :lap2_show
      t.integer :lap3_show
      t.integer :lap4_show
      t.integer :lap5_show
      t.integer :lap6_show
      t.integer :lap7_show
      t.integer :lap8_show

      t.timestamps
    end
  end
end
