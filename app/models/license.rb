class License < ApplicationRecord
  belongs_to :software
  belongs_to :user
  has_many :reviews
  scope :active_license_per_user, -> (user_id) {where("end_at >= ? AND user_id = ?", Time.current, user_id)}
  scope :past_license_per_user, -> (user_id) {where("end_at < ? AND user_id = ?", Time.current, user_id)}


end
