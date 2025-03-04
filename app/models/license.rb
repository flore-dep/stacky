class License < ApplicationRecord
  belongs_to :software
  belongs_to :user
  has_many :reviews
end
