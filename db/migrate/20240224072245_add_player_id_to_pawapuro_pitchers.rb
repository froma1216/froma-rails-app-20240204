class AddPlayerIdToPawapuroPitchers < ActiveRecord::Migration[7.1]
  def change
    add_reference :pawapuro_pitchers, :pawapuro_player, null: false, foreign_key: true
  end
end
