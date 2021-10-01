class Room < ApplicationRecord
  has_many :room_tracks, dependent: :destroy
  has_many :tracks, through: :room_tracks
  has_many :user_rooms, dependent: :destroy
  has_many :users, through: :user_rooms
  validates :name, presence: true
  validates :rounds, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 3 }
  validates :tracks, length: { minimum: 5 }

  def self.search(search)
    # If the argument search not nil, then a block is run where the track object is found based on params[:search]
    return if search.nil?

    Track.where('artist ILIKE ?', "%#{search}%").map(&:rooms).flatten.uniq
  rescue StandardError
    nil
  end
end
