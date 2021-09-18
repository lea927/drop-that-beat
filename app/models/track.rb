class Track < ApplicationRecord
  validates :adam_id, :preview_url, uniqueness: true
  has_many :room_tracks, dependent: :destroy
  has_many :rooms, through: :room_tracks

  before_save :set_downcase

  def set_downcase
    name.downcase!
    artist.downcase!
  end
end
