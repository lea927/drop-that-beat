class AddIndexToRoomTracks < ActiveRecord::Migration[6.0]
  def change
    add_index :room_tracks, %i[track_id room_id], unique: true
  end
end
