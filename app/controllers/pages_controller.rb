class PagesController < ApplicationController
  before_action :authenticate_user!, except: :home

  def home
    @softwares = Software.all
  end

  def profile
    @user = current_user
  end
end
