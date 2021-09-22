class Room < ApplicationRecord
  has_many :room_tracks, dependent: :destroy
  has_many :tracks, through: :room_tracks
  has_many :user_rooms, dependent: :destroy
  has_many :users, through: :user_rooms
  validates :name, presence: true
  validates :rounds, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 3 }

  def self.search(search)
    # If the argument search not nil, then a block is run where the track object is found based on params[:search]
    if search.present?
      begin
        track = Track.find_by(artist: search.downcase).rooms.first
      rescue StandardError
        nil
      end
      # then the rooms with the searched track are all returned through the room_track
      room_names_arr = Track.where(artist: search.downcase).map(&:rooms).flatten.pluck(:name).uniq
      Room.where(name: [room_names_arr]) if track
    else
      ''
    end
  end
end
