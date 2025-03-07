class AddCoordinatesToSoftwares < ActiveRecord::Migration[7.1]
  def change
    add_column :softwares, :latitude, :float
    add_column :softwares, :longitude, :float
  end
end
