module ApplicationHelper
  require 'dotenv'
  require 'httparty'
  include HTTParty

  def search_track(term)
    response = HTTParty.get(ENV['BASE_URL'] + "term=#{term}&media=music&limit=5")
    @response_hash = JSON.parse(response)
  end
end
