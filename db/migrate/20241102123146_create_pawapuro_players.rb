class CreatePawapuroPlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :pawapuro_players, comment: "選手" do |t|
      t.string :last_name, limit: 5, comment: "名字"
      t.string :first_name, limit: 5, comment: "名前"
      t.string :player_name, limit: 10, comment: "登録名", null: false
      t.string :back_name, limit: 13, comment: "背ネーム"
      t.date :birthday, comment: "生年月日"
      t.references :main_position, foreign_key: { to_table: :pawapuro_m_positions }, null: false, comment: "メインポジション"
      t.integer :throwing, comment: "利き投げ"
      t.integer :batting, comment: "利き打ち"
      t.integer :pace, comment: "球速"
      t.integer :control, comment: "コントロール"
      t.integer :stamina, comment: "スタミナ"
      t.string :original_breaking_ball_name, comment: "オリジナル球種名"
      t.integer :trajectory, comment: "弾道"
      t.integer :meat, comment: "ミート"
      t.integer :power, comment: "パワー"
      t.integer :running, comment: "走力"
      t.integer :arm, comment: "肩力"
      t.integer :fielding, comment: "守備力"
      t.integer :catching, comment: "捕球"
      t.string :note, limit: 100, comment: "備考"
      t.references :user, null: false, foreign_key: true, comment: "ユーザID"

      t.timestamps
    end
  end
end
