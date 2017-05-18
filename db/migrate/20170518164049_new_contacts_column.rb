class NewContactsColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :contacts, :twitter_handle, :string
  end
end
