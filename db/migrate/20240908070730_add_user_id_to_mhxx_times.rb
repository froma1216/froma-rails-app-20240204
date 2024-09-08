class AddUserIdToMhxxTimes < ActiveRecord::Migration[7.1]
  def change
    add_reference :mhxx_times, :user, foreign_key: true, comment: "ユーザーID"
  end
end
