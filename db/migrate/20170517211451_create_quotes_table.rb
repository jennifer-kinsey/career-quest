class CreateQuotesTable < ActiveRecord::Migration[5.1]
  def change
    create_table :quotes, id: :uuid do |t|
      t.string :tip
    end
  end
end
