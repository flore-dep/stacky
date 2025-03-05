class ReviewsController < ApplicationController
  before_action :set_license

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.license = @license

    if @review.save
      redirect_to software_path(@license.software)
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
