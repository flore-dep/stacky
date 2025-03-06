class PagesController < ApplicationController
  before_action :authenticate_user!, except: :home

  def home
    session[:mode] = "user"
    @mode = session[:mode]
    @softwares = Software.all
  end

  def profile
    @user = current_user
  end
end
