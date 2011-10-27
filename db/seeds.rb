# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
  communities = Community.create([
                                 { name: 'Chicago', city: 'Chicago', state: 'IL', zip_code: '60666', country: 'US'}, 
                                 { name: 'Denver', city: 'Denver', state: 'CO', zip_code: '80210', country: 'US'}
  ])
  
  communities.each do |community|
    community.events.create!([
                             {description: "A gathering of friends over coffee to connect around a movement in #{community.city}.", start_time: 6.hours.advance, end_time: 8.hours.advance, community_id: community.id}, 
                             {description: "Camping out at #{community.city} city hall to protest.", start_time: 2.days.advance, end_time:3.days.advance, community_id: community.id }
    ])
  end
