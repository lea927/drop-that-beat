module ApplicationHelper
  require 'dotenv'
  require 'httparty'
  include HTTParty

  def search_track(term)
    HTTParty.get(ENV['BASE_URL'] + "term=#{term}&media=music&limit=5")
  end
end
