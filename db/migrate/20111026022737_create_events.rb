class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :meetup_id
      t.string :description
      t.datetime :start_time, :required => true
      t.datetime :end_time, :required => true
      t.string :meetup_url
      t.string :facebook_url
      t.string :twitter_hashtag
      t.string :twitter_account
      t.integer :community_id, :required => true
      t.timestamps
    end
  end
end
