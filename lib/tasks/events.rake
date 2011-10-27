namespace :events do
  desc 'interact with remote events'

  task :fetch_zip => :environment do
    # Event.fetch_zip(ENV['ZIP_CODE'])
  end

  task :fetch_all => :environment do
    # Event.fetch_all
  end
end

