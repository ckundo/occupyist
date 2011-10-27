class Community < ActiveRecord::Base
  has_many :events
  geocoded_by :address

  validates_uniqueness_of :meetup_id
  validates_uniqueness_of :zip_code  

  def address
    [latitude, longitude].compact.join(', ')
  end
end
