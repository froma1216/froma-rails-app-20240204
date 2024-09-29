class DropConferencesTable < ActiveRecord::Migration[7.1]
  def up
    drop_table :conferences, if_exists: true
  end

  def down
    create_table :conferences do |t|
      t.timestamps
    end
  end
end
