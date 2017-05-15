class UpdateForeignKeysJoinTables < ActiveRecord::Migration[5.1]
  def change
    remove_column :correspondences, :user_id, :uuid
    add_column :correspondences, :user_detail_id, :uuid

    remove_column :positions, :user_id, :uuid
    add_column :positions, :user_detail_id, :uuid
  end
end
