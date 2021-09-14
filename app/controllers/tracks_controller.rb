class TracksController < ApplicationController
  require 'dotenv'
  require 'httparty'
  include HTTParty

  def index
    get_preview_url
  end

  def get_preview_url
    @term = 'levitating+dua+lipa'
    request = HTTParty.get(ENV['BASE_URL']+'term='+@term+'&media=music&limit=5')
    @request_hash = JSON.parse(request)
  end
end
