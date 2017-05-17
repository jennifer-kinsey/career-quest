class AddUuidsToAllTables < ActiveRecord::Migration[5.1]
  def change
    drop_table :correspondences
    create_table :correspondences, id: :uuid do |t|
      t.string :action
      t.string :mode
      t.date :date
      t.string :result
      t.string :notes
      t.uuid :contact_id
      t.uuid :position_id
      t.uuid :user_detail_id
      t.uuid :company_id

      t.timestamps
    end
  end
end
