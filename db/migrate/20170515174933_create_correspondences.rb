ActiveRecord::Base.connection.execute('create extension if not exists "pgcrypto"')

class CreateCorrespondences < ActiveRecord::Migration[5.1]
  def change
    create_table :correspondences do |c|
      c.string :status
      c.string :mode
      c.string :date
      c.string :result
      c.string :notes
      c.uuid :contact_id
      c.uuid :user_id
      c.uuid :position_id

      c.timestamps
    end
  end
end
