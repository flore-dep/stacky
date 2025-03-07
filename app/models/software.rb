class Software < ApplicationRecord
  include PgSearch::Model

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  has_one_attached :logo

  belongs_to :user
  has_many :licenses
  has_many :reviews, through: :licenses
  has_many :software_tags
  has_many :category_tags, through: :software_tags
  has_many :team_tags, through: :software_tags


  # TAG_LIST = [
  #   "International",
  #   "Produit",
  #   "Administratif & Juridique",
  #   "Business",
  #   "Financements",
  #   "RH",
  #   "Tech",
  #   "Stratégie",
  #   "Autre",
  #   "CSM",
  #   "Marketing & Communication",
  #   "Collaboration & Management"
  # ]

  # CATEGORIES = [
  #   "Communication",
  #   "Project Management",
  #   "Productivity",
  #   "Storage",
  #   "Design",
  #   "Development",
  #   "Cloud",
  #   "Payment",
  #   "CRM",
  #   "Support",
  #   "Marketing",
  #   "Analytics"
  # ]

  validate :maximum_three_tags
  # validate :at_least_one_category_tag
  validates :name, :price_month, presence: true

  pg_search_scope :global_search,
    against: [:name, :description],
    associated_against: {
      user: [:username],
      category_tags: [:name],
      team_tags: [:name]
    },
    using: {
      tsearch: { prefix: true }
    }

  private

  def maximum_three_tags
    if software_tags.size > 3
      errors.add(:software_tags, "Select up to 3 tags")
    end
  end

  def at_least_one_category_tag
    if category_tags.empty?
      errors.add(:category_tags, "Must have at least one category tag")
    end
  end
end
