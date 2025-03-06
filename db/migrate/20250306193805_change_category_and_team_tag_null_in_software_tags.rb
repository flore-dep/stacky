class ChangeCategoryAndTeamTagNullInSoftwareTags < ActiveRecord::Migration[7.1]
  def change
    change_column_null :software_tags, :category_tag_id, true
    change_column_null :software_tags, :team_tag_id, true
  end
end
