class ReviewsController < ApplicationController
  before_action :set_license
  def new
    @review = Review.new
  end
  def create
    @review = Review.new(review_params)
    @review.license = @license
    @review.user = current_user

    if current_user.license.valid?
      @review.save
    else
      render :new, status: "You have to get a license to comment this software"
    end

    if @review.valid?
      redirect_to software_path(@software)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def set_license
    @license = License.find(params[:license_id])
  end
end
