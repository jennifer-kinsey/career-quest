class AddPositionDateCol < ActiveRecord::Migration[5.1]
  def change
    add_column :positions, :application_date, :date
    change_column :correspondences, :date, "date using date::date"
  end
end
