class RoomTrack < ApplicationRecord
  belongs_to :track
  belongs_to :room
  validates :track, uniqueness: { scope: :room,
    message: 'should only assign once' }
end
