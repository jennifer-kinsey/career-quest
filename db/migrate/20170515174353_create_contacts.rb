ActiveRecord::Base.connection.execute('create extension if not exists "pgcrypto"')


class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts, id: :uuid do |c|
      c.string :name
      c.string :job_title
      c.string :phone
      c.string :email
      c.string :linkedin
      c.string :notes

      c.timestamps
    end
  end
end
