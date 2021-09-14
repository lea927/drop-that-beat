class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_many :room_tracks, dependent: :destroy
  has_many :tracks, through: :room_tracks
  has_many :user_rooms, dependent: :destroy
  has_many :rooms, through: :user_rooms
end
