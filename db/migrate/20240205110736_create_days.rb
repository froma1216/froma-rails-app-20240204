class CreateDays < ActiveRecord::Migration[7.1]
  def change
    create_table :days do |t|
      t.references :conference, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :seq_no
      t.string :integer

      t.timestamps
    end
  end
end
