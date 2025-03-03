class AddJobTitleToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :job_title, :string
  end
end
