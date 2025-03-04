class PagesController < ApplicationController
  def home
  end

  def profile
    @user = current_user  
  end
end
