class SoftwaresController < ApplicationController
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
    @software.user = current_user
    if @software.save
      redirect_to software_path(@software)
    else
      raise
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @software = Software.update(software_params)
    redirect_to software_path(@software)
  end

  def destroy
    @software.destroy
    redirect_to softwares_path
  end

  private

  def software_params
    params.require(:software).permit(:name, :price_month, :description, :tag, :logo)
  end

  def set_software
    @software = Software.find(params[:id])
  end
end
