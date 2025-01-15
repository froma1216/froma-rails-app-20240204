class DropPawapuroPlayersTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :pawapuro_players
  end
end
