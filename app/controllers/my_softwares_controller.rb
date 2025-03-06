class MySoftwaresController < ApplicationController
  before_action :authenticate_user!

  def index
    @my_softwares = Software.where(user_id: current_user.id)
    session[:mode] = "owner"
  end
end
