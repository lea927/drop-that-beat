class TracksController < ApplicationController
  include ApplicationHelper
  before_action :set_room, only: %i[create]

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

  def show
    @track = Track.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "Track doesn't exist."
    render 'rooms/index'
  end

  def create
    @track = Track.search_db(params[:adam_id]) || Track.new(track_params.except(:room_id))
    @track.save
    @room.tracks << @track
    respond_to do |format|
      format.js
    end
  rescue ActiveRecord::RecordInvalid => e
    logger.info e.record.errors.full_messages
    render js: ''
  end

  def destroy
    @room_track = RoomTrack.find_by(room_id: params[:room_id], track_id: params[:id])
    @room_track.destroy
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def track_params
    params.permit(:room_id, :name, :artist, :adam_id, :preview_url)
  end
end
