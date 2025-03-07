class SoftwareTag < ApplicationRecord
  belongs_to :software
  belongs_to :category_tag, optional: true
  belongs_to :team_tag, optional: true

  validates :software_id, presence: true
  validates :software_id, uniqueness: {
    scope: :category_tag_id,
    message: "You already have this tag for this software.",
  }, if: -> { category_tag_id.present? }

  validates :software_id, uniqueness: {
    scope: :team_tag_id,
    message: "You already have this tag for this software.",
  }, if: -> { team_tag_id.present? }

  validate :category_tag_occurences, if: -> { category_tag_id.present? }
  validate :team_tag_occurences, if: -> { team_tag_id.present? }

  private

  def category_tag_occurences
    occurrences = SoftwareTag.where(software_id: software_id)
                             .where.not(category_tag_id: nil)
                             .count
    if occurrences >= 2
      errors.add(:category_tag_id, "A software can only have 1 category tag.")
    end
  end

  def team_tag_occurences
    occurrences = SoftwareTag.where(software_id: software_id)
                             .where.not(team_tag_id: nil)
                             .count
    if occurrences >= 4
      errors.add(:team_tag_id, "A software can have at most 3 team tags.")
    end
  end

end
