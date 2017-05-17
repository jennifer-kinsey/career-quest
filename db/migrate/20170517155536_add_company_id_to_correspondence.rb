class AddCompanyIdToCorrespondence < ActiveRecord::Migration[5.1]
  def change
    add_column :correspondences, :company_id, :uuid 
  end
end
