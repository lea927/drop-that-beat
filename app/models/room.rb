class Room < ApplicationRecord
  has_many :tracks, through: :room_track
  validates :name, presence: true
end
