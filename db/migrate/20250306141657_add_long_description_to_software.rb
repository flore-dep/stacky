class AddLongDescriptionToSoftware < ActiveRecord::Migration[7.1]
  def change
    add_column :softwares, :long_description, :text
  end
end
