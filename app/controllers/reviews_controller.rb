class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
