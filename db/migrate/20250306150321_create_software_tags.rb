class CreateSoftwareTags < ActiveRecord::Migration[7.1]
  def change
    create_table :software_tags do |t|
      t.references :software, null: false, foreign_key: true
      t.references :category_tag, null: false, foreign_key: true
      t.references :team_tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
