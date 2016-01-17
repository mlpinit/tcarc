class AddUserIdToTiles < ActiveRecord::Migration
  def change
    add_column :tiles, :user_id, :integer
  end
end
