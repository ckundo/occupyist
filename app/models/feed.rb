class Feed < ActiveRecord::Base
  belongs_to :community
  belongs_to :event
end
