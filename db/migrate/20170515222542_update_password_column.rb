class UpdatePasswordColumn < ActiveRecord::Migration[5.1]
  def change
    change_table :user_credentials do |t|
      t.rename :password, :password_digest
    end
  end
end
