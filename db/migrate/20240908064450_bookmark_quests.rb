class BookmarkQuests < ActiveRecord::Migration[7.1]
  def change
    add_column :mhxx_bookmark_quests, :created_by, :integer, comment: "作成者"
    add_column :mhxx_bookmark_quests, :updated_by, :integer, comment: "更新者"
  end
end
