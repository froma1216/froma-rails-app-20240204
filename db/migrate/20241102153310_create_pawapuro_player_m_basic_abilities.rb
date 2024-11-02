class CreatePawapuroPlayerMBasicAbilities < ActiveRecord::Migration[7.1]
  def change
    create_table :pawapuro_player_m_basic_abilities, comment: "選手・値なし特殊能力マスタ関連" do |t|
      t.references :player, null: false, foreign_key: { to_table: :pawapuro_players }, comment: "選手ID"
      t.references :m_basic_ability, null: false, foreign_key: { to_table: :pawapuro_m_basic_abilities }, comment: "値なし特殊能力マスタID"

      t.timestamps
    end
  end
end
