class RemoveConferenceIdFromDaysUsersParticipations < ActiveRecord::Migration[7.1]
  def change
    remove_column :days, :conference_id
    remove_column :users, :conference_id
    remove_column :participations, :conference_id
  end
end
