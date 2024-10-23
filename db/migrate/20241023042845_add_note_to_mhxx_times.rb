class AddNoteToMhxxTimes < ActiveRecord::Migration[7.1]
  def change
    add_column :mhxx_times, :note, :string, comment: "備考"
  end
end
