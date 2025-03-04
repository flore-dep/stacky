class Software < ApplicationRecord
  has_one_attached :logo

  belongs_to :user
  has_many :licenses
  has_many :reviews, through: :licenses
end
