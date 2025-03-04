class Software < ApplicationRecord
  belongs_to :user
  has_one_attached :logo
  has_many :licenses
  has_many :reviews, through: :licenses
end
