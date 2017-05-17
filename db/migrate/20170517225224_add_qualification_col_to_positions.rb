class AddQualificationColToPositions < ActiveRecord::Migration[5.1]
  def change
    add_column :positions, :qualifications, :string
  end
end
