class CreatePresentations < ActiveRecord::Migration[7.1]
  def change
    create_table :presentations do |t|
      t.references :slot, null: false, foreign_key: true
      t.string :title
      t.string :presenter
      t.string :authors
      t.text :description
      t.string :url

      t.timestamps
    end
  end
end
