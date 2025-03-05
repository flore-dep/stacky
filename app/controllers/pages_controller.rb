class PagesController < ApplicationController
  def home
    @softwares = Software.all
  end

  def profile
    @user = current_user
  end
end
