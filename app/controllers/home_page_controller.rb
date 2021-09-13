class HomePageController < ApplicationController
  skip_before_action :authenticate_user!, only: [:landing]

  def landing
    if user_signed_in?
      redirect_to home_page_index_path
    end
  end

  def index
  end
end
