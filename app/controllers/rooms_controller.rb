class RoomsController < ApplicationController
  before_action :set_room, only: %i[edit update destroy answer]
  before_action :set_room_with_tracks, only: %i[show]

  def index
    if params[:search].present? && Room.search(params[:search]).any?
      @rooms = Room.search(params[:search]) # if artist exists in a room
    elsif params[:search].present? && Room.search(params[:search]).empty?
      flash.now[:notice] = 'Cannot find rooms with associated artist'
      @rooms = nil # if artist does not exist in a room
    else # if rooms_path or blank search
      @rooms = Room.playable(current_user.id).has_tracks
      flash.now[:notice] = 'Please enter an artist to search' if params[:search] == ''
    end
  end

  def show
    @tracks = @room.tracks.to_a.shuffle! if @room
    @tracks_url = @tracks.map(&:preview_url) if @tracks
    return if @room.users.where(email: current_user.email).empty?

    flash[:notice] = "Access denied. You can't play your own room."
    redirect_to rooms_path
  end

  def new
    @room = Room.new(name: params[:room][:name])
  end

  def edit; end

  def create
    @room = Room.new(room_params)
    if @room.save
      current_user.rooms << @room
      redirect_to home_path, notice: 'Game was created successfully'
    else
      render :new
    end
  end

  def update
    if @room.update(room_params)
      redirect_to home_path, notice: 'Game was updated successfully'
    else
      render :edit
    end
  end

  def destroy
    @room.destroy
    redirect_to home_path, notice: 'Room was successfully deleted.'
  end

  def answer
    @track = @room.tracks.find(params[:track_id])

    current_user.increment(:points).save if @track.name == params[:name] && @track.artist == params[:artist]
    render json: @track.name == params[:name], status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Track not found' }, status: :unprocessable_entity
  end

  private

  def set_room
    @room = Room.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "Room doesn't exist."
    render :index
  end

  def set_room_with_tracks
    @room = Room.joins(:tracks).distinct.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "Room doesn't exist."
    render :index
  end

  def room_params
    params.require(:room).permit(:name, :rounds, track_ids: [])
  end
end
