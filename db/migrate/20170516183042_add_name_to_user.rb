class AddNameToUser < ActiveRecord::Migration[5.1]
  def change
    add_column(:user_details, :name, :string)
  end
end
