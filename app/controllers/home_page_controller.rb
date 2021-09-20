class HomePageController < ApplicationController
  skip_before_action :authenticate_user!, only: [:landing]

  def landing
    redirect_to home_path if user_signed_in?
  end

  def index
    @rooms = current_user.rooms
    @room = Room.new
  end
end
