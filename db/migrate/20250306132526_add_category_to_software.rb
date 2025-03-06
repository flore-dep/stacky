class AddCategoryToSoftware < ActiveRecord::Migration[7.1]
  def change
    add_column :softwares, :category, :string
  end
end
