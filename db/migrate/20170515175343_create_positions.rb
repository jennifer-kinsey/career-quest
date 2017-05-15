class CreatePositions < ActiveRecord::Migration[5.1]
  def change
    create_table :positions do |p|
      p.string :title
      p.string :application_status
      p.string :description
      p.string :offer
      p.string :schedule
      p.string :url
      p.string :est_salary
      p.string :notes
      p.string :resume
      p.string :cover_letter
      p.uuid :company_id
      p.uuid :user_id

      p.timestamps      
    end
  end
end
