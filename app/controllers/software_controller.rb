class SoftwareController < ApplicationController
  before_action :set_software, only: [:show, :edit, :update, :destroy]

  def index
    @softwares = Software.all
  end

  def show
  end

  def new
    @software = Software.new()
  end

  def create
    @software = Software.new(software_params)
    @software.save
    redirect_to software(@software)
  end

  def edit
  end

  def update
    @software = Article.update(software_params)
    redirect_to software(@software)
  end

  def destroy
    @software.destroy
    redirect_to softwares
  end

  private

  def software_params
    params.require(:software).permit(:name, :price_month, :description, :tag, :user, :logo)
  end

  def set_software
    @software = Software.find(params[:id])
  end
end
