ActiveRecord::Base.connection.execute('create extension if not exists "pgcrypto"')

class CreateUserDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :user_details, id: :uuid do |u|
      u.string :name
      u.string :current_job
      u.string :career_objectives
      u.string :webpage
      u.string :resume_template
      u.string :cover_letter_template
      u.string :skills

      u.timestamps
    end
  end
end
