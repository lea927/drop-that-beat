json.extract! room, :id, :name, :rounds
json.tracks do
  json.array! room.tracks, partial: 'tracks/track', as: :track
end
json.url room_url(room, format: :json)
