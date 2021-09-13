class CreateRoomTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :room_tracks do |t|
      t.references :track, null: false, foreign_key: true

      t.timestamps
    end
  end
end
