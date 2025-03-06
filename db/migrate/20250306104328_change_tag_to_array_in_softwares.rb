class ChangeTagToArrayInSoftwares < ActiveRecord::Migration[7.0]
  def up
    change_column :softwares, :tag, :string, array: true, default: [], using: 'ARRAY[tag]::varchar[]'
  end

  def down
    change_column :softwares, :tag, :string, array: false, using: 'tag::text'
  end
end
