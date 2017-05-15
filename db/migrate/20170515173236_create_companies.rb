ActiveRecord::Base.connection.execute('create extension if not exists "pgcrypto"')

class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies, id: :uuid do |c|
      c.string :name
      c.string :location
      c.string :website
      c.string :services
      c.string :size
      c.string :specializations
      c.string :pros
      c.string :cons
      c.string :notes
      c.uuid  :contact_id

      c.timestamps
    end
  end
end
