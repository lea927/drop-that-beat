class RoomsController < ApplicationController
  before_action :set_room, only: %i[edit update destroy]

  def index
    if params[:search].present? && Room.search(params[:search]).any?
      @rooms = Room.search(params[:search]) # if artist exists in a room
    elsif params[:search].present? && Room.search(params[:search]).empty?
      flash.now[:notice] = 'Cannot find rooms with associated artist'
      @rooms = nil # if artist does not exist in a room
    else
      @rooms = Room.all # if rooms_path or blank search
      flash.now[:notice] = 'Please enter an artist to search' if params[:search] == ''
    end
  end

  def new; end

  def edit; end

  def create
    @room = Room.new(room_params)
    if @room.save
      current_user.rooms << @room
      redirect_to edit_room_path(@room)
    else
      @rooms = current_user.rooms
      render 'home_page/index'
    end
  end

  def update
    if @room.update(room_params)
      redirect_to home_path, notice: 'Game was setup successfully'
    else
      render :edit
    end
  end

  def show; end

  def destroy
    @room.destroy
    redirect_to home_path, notice: 'Room was successfully deleted.'
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :rounds, track_ids: [])
  end
end
