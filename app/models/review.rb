class Review < ApplicationRecord
  belongs_to :license
  has_one :software, through: :license
  has_one :user, through: :license

  after_commit :update_software_average_rating
  after_destroy :update_software_average_rating

  validates :comment, :rating, presence: true
  validates :rating, inclusion: { in: 0..5 }, numericality: { only_integer: true }

  private

  def update_software_average_rating
    ratings = software.reviews.pluck(:rating)
    average = ratings.sum.fdiv(ratings.count).round(1)
    software.update(average_rating: average)
  end
end
