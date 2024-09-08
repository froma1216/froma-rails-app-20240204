class Quests < ActiveRecord::Migration[7.1]
  def change
    add_column :mhxx_times, :created_by, :integer, comment: "作成者"
    add_column :mhxx_times, :updated_by, :integer, comment: "更新者"
  end
end
