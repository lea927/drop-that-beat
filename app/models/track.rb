class Track < ApplicationRecord
  validates :adam_id, :preview_url, uniqueness: true
  has_many :room_tracks
  has_many :rooms, through: :room_tracks
end
