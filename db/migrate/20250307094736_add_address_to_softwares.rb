class AddAddressToSoftwares < ActiveRecord::Migration[7.1]
  def change
    add_column :softwares, :address, :string
  end
end
