class SoftwareTag < ApplicationRecord
  belongs_to :software
  belongs_to :category_tag
  belongs_to :team_tag
end
