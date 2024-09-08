class AddUserIdToMhxxBookmarkQuests < ActiveRecord::Migration[7.1]
  def change
    add_reference :mhxx_bookmark_quests, :user, foreign_key: true, comment: "ユーザーID"
  end
end
