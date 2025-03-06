class License < ApplicationRecord
  belongs_to :software
  belongs_to :user
  has_many :reviews

  validates :end_at, presence: true
  validates :start_at, presence: true
  validate :end_date_must_be_after_start_date
  validates :user_id, uniqueness: {
    scope: :software_id,
    message: "You already have an active license for this software.",
    conditions: -> { where("end_at >= ?", Time.current) }
  }
  validate :cannot_overlap_with_existing_license


  scope :active_license_per_user, -> (user_id) {where("end_at >= ? AND user_id = ?", Time.current, user_id)}
  scope :past_license_per_user, -> (user_id) {where("end_at < ? AND user_id = ?", Time.current, user_id)}

  private

  def end_date_must_be_after_start_date
    if end_at <= start_at
      errors.add(:end_at, "must be after the start date")
    end
  end

  def cannot_overlap_with_existing_license
    max_end_at = License.where(user_id: user_id, software_id: software_id).maximum(:end_at)
    if max_end_at.present? && start_at < max_end_at
      errors.add(:start_at, "must be equal or after the last license dates")
    end
  end
end
