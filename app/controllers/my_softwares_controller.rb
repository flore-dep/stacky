class MySoftwaresController < ApplicationController
  before_action :authenticate_user!

  def index
    @my_softwares = current_user.softwares
  end
end
