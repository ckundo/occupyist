class Community < ActiveRecord::Base
  has_many :events

  validates_uniqueness_of :meetup_id
  validates_uniqueness_of :zip_code  
end
