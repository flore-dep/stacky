class SoftwaresController < ApplicationController
  before_action :set_software, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    session[:mode] = "user"
    @softwares = Software.all
    if params[:query].present?
      @softwares = Software.where("name ILIKE ?", "%#{params[:query]}%")
    end
    @softwares_by_tag = @softwares.group_by(&:tag)
  end

  def show
    @reviews = @software.reviews
    @license = License.new
    @existing_license = License.where(software_id: @software.id, user_id: current_user.id)
    if @existing_license.present?
      @end_date_validity = License.find(@existing_license).end_at > Date.today
    end
  end

  def new
    @software = Software.new
  end

  def create
    @software = Software.new(software_params)
    @software.user = current_user
    if @software.save
      redirect_to software_path(@software)
    else
      Rails.logger.debug @software.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @software.update(software_params)
      redirect_to software_path(@software)
    else
      render :edit, status: :unprocessable_entity
    end
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
