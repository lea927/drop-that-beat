class Room < ApplicationRecord
  has_many :room_tracks
  has_many :tracks, through: :room_tracks
  has_many :user_rooms
  has_many :users, through: :user_rooms
  validates :name, presence: true
end
