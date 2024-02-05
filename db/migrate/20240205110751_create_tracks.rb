class CreateTracks < ActiveRecord::Migration[7.1]
  def change
    create_table :tracks do |t|
      t.references :day, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.integer :seq_no

      t.timestamps
    end
  end
end
