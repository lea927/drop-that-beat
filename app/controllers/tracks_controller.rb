class TracksController < ApplicationController
  include ApplicationHelper

  def index
    @tracks = Track.all
  end

  def search
    if params[:term].blank?
      flash.now[:notice] = 'Please enter valid track'
    else
      @tracks = new_track(search_track(params[:term]))
      respond_to do |format|
        format.js
      end
    end
  end

  def create
    @track = Track.search_db(params[:adam_id]) || Track.new(track_params)
    @track.save
  end

  private

  def track_params
    params.permit(:room_id, :name, :artist, :adam_id, :preview_url)
  end
end
