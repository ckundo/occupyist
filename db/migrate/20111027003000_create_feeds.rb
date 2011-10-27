class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :twitter_hashtag
      t.string :twitter_account

      t.timestamps
    end
  end
end
