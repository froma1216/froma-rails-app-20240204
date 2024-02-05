class CreateSlots < ActiveRecord::Migration[7.1]
  def change
    create_table :slots do |t|
      t.references :track, null: false, foreign_key: true
      t.string :title
      t.string :organizer
      t.string :chair
      t.string :lecturer
      t.string :room
      t.text :description
      t.string :url
      t.string :audience
      t.string :level
      t.string :background
      t.string :category
      t.string :material
      t.string :mlinkurl
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
