class DropPawapuroFieldersTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :pawapuro_fielders
  end
end
