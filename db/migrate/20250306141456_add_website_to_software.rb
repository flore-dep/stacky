class AddWebsiteToSoftware < ActiveRecord::Migration[7.1]
  def change
    add_column :softwares, :website, :string
  end
end
