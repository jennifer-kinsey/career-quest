class AddTweetsTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :tweets
    create_table :tweets do |t|
      t.text :tweet
      t.string :handle
      t.integer :retweet
      t.uuid :contact_id


      t.timestamps
    end
  end
end
