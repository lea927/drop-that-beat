class Track < ApplicationRecord
  validates :adam_id,:preview_url uniqueness: true
end
