module ApplicationHelper
  require 'dotenv'
  require 'httparty'
  include HTTParty

  def search_track(term)
    term.gsub(/ /, '+')
    response = HTTParty.get(ENV['BASE_URL'] + "term=#{term}&media=music&limit=5")
    JSON.parse(response)
  end
end
