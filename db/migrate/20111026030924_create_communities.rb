class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      t.integer :meetup_id, :unique => true
      t.string :name
      t.string :city
      t.string :zip_code
      t.string :state
      t.string :country
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
