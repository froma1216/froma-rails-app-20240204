class CreatePawapuroPlayerMValuedAbilities < ActiveRecord::Migration[7.1]
  def change
    create_table :pawapuro_player_m_valued_abilities, comment: "選手・値あり特殊能力マスタ関連" do |t|
      t.references :player, null: false, foreign_key: { to_table: :pawapuro_players }, comment: "選手ID"
      t.references :m_valued_ability, null: false, foreign_key: { to_table: :pawapuro_m_valued_abilities }, comment: "値あり特殊能力マスタID"

      t.timestamps
    end
  end
end
