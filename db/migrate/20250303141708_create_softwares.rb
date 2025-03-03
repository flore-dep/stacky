class CreateSoftwares < ActiveRecord::Migration[7.1]
  def change
    create_table :softwares do |t|
      t.string :name
      t.float :price_month
      t.text :description
      t.string :tag
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
