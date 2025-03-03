class AddCompanyToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :company, :string
  end
end
