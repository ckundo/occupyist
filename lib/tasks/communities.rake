namespace :community do
  desc 'interact with remote events'

  task :update_events => :environment do
    Meetup::Community.fetch_all
  end
end
