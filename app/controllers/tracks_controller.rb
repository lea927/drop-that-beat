class TracksController < ApplicationController
  include ApplicationHelper

  def index
    @tracks = Track.all
    @tracks = @tracks.search(params[:query]) if params[:query].present?
  end

  def search
    @tracks = search_track(params[:term])
    render 'index'
  end
end
