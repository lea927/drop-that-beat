class TracksController < ApplicationController
  include ApplicationHelper

  def index; end

  def search_track
    search_track('new+rules+dua+lipa')
  end
end
