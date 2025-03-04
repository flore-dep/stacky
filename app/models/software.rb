class Software < ApplicationRecord
  belongs_to :user
  has_one_attached :logo
  has_many :licenses
end
