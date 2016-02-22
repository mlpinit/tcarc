class ChangeEndRoadToConnectedRoad < ActiveRecord::Migration[5.0]
  def change
    remove_column :tiles, :end_road, :boolean
    add_column :tiles, :connected_road, :boolean, default: false
  end
end
