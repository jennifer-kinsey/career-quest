ActiveRecord::Base.connection.execute('create extension if not exists "pgcrypto"')

class CreateUserCredentials < ActiveRecord::Migration[5.1]
  def change
    create_table :user_credentials, id: :uuid do |u|
      u.string :email
      u.string :password

      u.timestamps
    end
  end
end
