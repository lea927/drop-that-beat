class TracksController < ApplicationController
  include ApplicationHelper

  def index
    search_track('new+rules+dua+lipa')
  end
end
