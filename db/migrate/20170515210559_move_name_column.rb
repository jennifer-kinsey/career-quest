class MoveNameColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :user_details, :name
    add_column :user_credentials, :name, :string
  end
end
