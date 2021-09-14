class TracksController < ApplicationController
  require 'dotenv'
  require 'httparty'
  include HTTParty

  def index
    search_track
  end

  def search_track
    term = 'levitating+dua+lipa'
    request = HTTParty.get(ENV['BASE_URL'] + "term=#{term}&media=music&limit=5")
    @request_hash = JSON.parse(request)
  end
end
