class AddUserId < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :user_detail_id, :uuid
    add_column :contacts, :user_detail_id, :uuid
  end
end
