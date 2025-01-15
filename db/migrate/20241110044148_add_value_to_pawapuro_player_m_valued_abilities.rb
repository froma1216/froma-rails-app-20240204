class AddValueToPawapuroPlayerMValuedAbilities < ActiveRecord::Migration[7.1]
  def change
    add_column :pawapuro_player_m_valued_abilities, :value, :integer, comment: "値"
  end
end
