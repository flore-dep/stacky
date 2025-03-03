class Software < ApplicationRecord
  belongs_to :users
  has_one_attached :logo
end
