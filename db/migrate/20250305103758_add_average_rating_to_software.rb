class AddAverageRatingToSoftware < ActiveRecord::Migration[7.1]
  def change
    add_column :softwares, :average_rating, :float
  end
end
