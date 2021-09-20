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
end
