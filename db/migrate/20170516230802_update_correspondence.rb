class UpdateCorrespondence < ActiveRecord::Migration[5.1]
  def change
    rename_column(:correspondences, :status, :action)
  end
end
