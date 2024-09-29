class DropDaysParticipationPresentationSlotTrackTables < ActiveRecord::Migration[7.1]
  def up
    remove_foreign_key :presentations, :slots, if_exists: true
    remove_foreign_key :participations, :slots, if_exists: true
    drop_table :slots, if_exists: true, cascade: true
    drop_table :tracks, if_exists: true, cascade: true
    drop_table :days, if_exists: true, cascade: true
    drop_table :participations, if_exists: true, cascade: true
    drop_table :presentations, if_exists: true, cascade: true
  end
end