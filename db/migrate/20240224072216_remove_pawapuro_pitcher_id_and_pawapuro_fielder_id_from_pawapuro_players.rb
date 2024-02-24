class RemovePawapuroPitcherIdAndPawapuroFielderIdFromPawapuroPlayers < ActiveRecord::Migration[7.1]
  def change
    # 外部キー制約を削除
    remove_foreign_key :pawapuro_players, :pawapuro_pitchers
    remove_foreign_key :pawapuro_players, :pawapuro_fielders

    # カラムを削除
    remove_column :pawapuro_players, :pawapuro_pitcher_id
    remove_column :pawapuro_players, :pawapuro_fielder_id
  end
end
