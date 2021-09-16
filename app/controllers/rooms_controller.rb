class RoomsController < ApplicationController
  def index
    if params[:search].present? && Room.search(params[:search])
      @rooms = Room.search(params[:search]) # if artist exists in a room
    elsif Room.search(params[:search]).nil?
      @rooms = nil # if artist does not exist in a room
      flash.now[:notice] = 'Cannot find rooms with associated artist'
    else
      @rooms = Room.all # if rooms_path or blank search
    end
  end

  def new; end

  def edit; end

  private

  def room_params
    params.require(:room).permit(:search)
  end
end
