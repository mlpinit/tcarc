class AddArchivedToMeeples < ActiveRecord::Migration[5.0]
  def change
    add_column :meeples, :archived, :boolean, default: false
  end
end
