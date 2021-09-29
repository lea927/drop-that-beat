module ApplicationHelper
  require 'dotenv'
  Dotenv.load
  require 'httparty'
  include HTTParty

  def search_track(term)
    return nil if term.blank?

    term.gsub(/ /, '+')
    response = HTTParty.get(ENV['BASE_URL'] + "term=#{term}&media=music&limit=5")
    JSON.parse(response)['results']
  end

  def new_track(tracks)
    return if tracks.empty?

    tracks.map do |track|
      Track.new(
        name: track['trackName'],
        artist: track['artistName'],
        adam_id: track['trackId'],
        preview_url: track['previewUrl']
      )
    end
  rescue StandardError
    nil
  end
end
