class SoftwaresController < ApplicationController
  before_action :set_software, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    session[:mode] = "user"
    @softwares = Software.all

    if params[:query].present?
      @softwares = Software.global_search("%#{params[:query]}%")
    end
  end

  def show
    @reviews = @software.reviews
    @license = License.new
    if user_signed_in?
      @existing_license = License.where(software_id: @software.id, user_id: current_user.id)
    end
    if @existing_license.present?
      @end_date_validity = License.find(@existing_license).end_at > Date.today
    end

    @markers = [{
        lat: @software.latitude,
        lng: @software.longitude,
      }]
      # raise
  end

  def new
    @software = Software.new
  end

  def create
    @software = Software.new(software_params)
    @software.user = current_user
    if @software.save
      category_tag_id = software_params[:category]
      category_tag = CategoryTag.find(software_params[:category])
      SoftwareTag.create!(software: @software, category_tag: category_tag)

      team_tag_ids = software_params[:tag]
      team_tag_ids.each do |tag|
        unless tag.empty?
          team_tag = TeamTag.find(tag)
          SoftwareTag.create!(software: @software, team_tag: team_tag)
        end
      end
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
    params.require(:software).permit(:name, :price_month, :description, :logo, :category, tag: [])
  end

  def set_software
    @software = Software.find(params[:id])
  end
end
