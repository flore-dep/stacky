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

  TAG_LIST = [
    "International",
    "Produit",
    "Administratif & Juridique",
    "Business",
    "Financements",
    "RH",
    "Tech",
    "Stratégie",
    "Autre",
    "CSM",
    "Marketing & Communication",
    "Collaboration & Management"
  ]

  CATEGORIES = [
    "Communication",
    "Project Management",
    "Productivity",
    "Storage",
    "Design",
    "Development",
    "Cloud",
    "Payment",
    "CRM",
    "Support",
    "Marketing",
    "Analytics"
  ]

  validate :maximum_three_tags
  validates :name, :price_month, :category, presence: true


  pg_search_scope :global_search,
    against: [ :name, :description, :tag, :category ],
    associated_against: {
      user: [ :username ]
    },
    using: {
      tsearch: { prefix: true }
    }

  private

  def maximum_three_tags
    if tag.size > 4
      errors.add(:tag, "Select up to 3 tags")
    end
  end
end
