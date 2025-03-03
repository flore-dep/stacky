class Software < ApplicationRecord
  belongs_to :user
  has_one_attached :logo
end
