class Track < ApplicationRecord
  validates :adam_id, :preview_url, uniqueness: true
  has_many :room_tracks, dependent: :destroy
  has_many :rooms, through: :room_tracks

  def self.search_db(track)
    find_by(adam_id: track)
  end
end
