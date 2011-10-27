require 'iconv'

module Meetup
  CONTAINER_NAME = 'occupytogether'
  
  module Events
    URL = 'https://api.meetup.com/ew/events'
    
    def self.fetch_by_community(zip, id)
      community_ids = id
      zip = zip
      status = "upcoming"
      page = 100
      fields = 'udf_twitter_account,udf_twitter_hashtag'

      response = RestClient.get URL, {:params => {:key => ENV['MEETUP_API_KEY'], :urlname => Meetup::CONTAINER_NAME, :zip => zip, :fields => fields, :status => status, :page => page}, :accept => :json}
      community = Community.find_by_meetup_id(id)

      ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
      response = ic.iconv(response + ' ')[0..-2]
      data = JSON.parse(response)      
      
      data["results"].each do |result|
        if Event.find_by_meetup_id(result['id'])
          break
        else
          event = Event.new
          event.twitter_account = result["udf_twitter_account"]
          event.twitter_hashtag = result["udf_twitter_hashtag"]
          event.community_id = community.id
          event.description = result["description"][0..100]
          event.meetup_url = result["meetup_url"]
          event.meetup_id = result["id"]
          event.start_time = Time.at(result["time"]/1000) if result["time"]

          re1 = /facebook.com\/(event.php\?eid=\d+)/
          re2 = /facebook.com\/(pages\/\S+\/\d+)/
          twitter_hashtag_re = /#([A-Za-z0-9_]+)/
          twitter_account_re = /@([A-Za-z0-9_]+)/

          if event.description
            begin
              link = re1.match(result['description'])
              event.facebook_url = "http://#{link}" if link
              
              hashtag = twitter_hashtag_re.match(result['description'])
              user = twitter_account_re.match(result['description'])
            rescue Exception => e
              puts "regex derped out: #{e.message}"
            end
            
          end

          begin
            if !hashtag.nil? && hashtag[1] != "" && hashtag[1][1] != "!" && event.twitter_hashtag != hashtag[1]
              hashtag = hashtag[1].gsub("#", "")
              puts "found a hashtag: #{hashtag}"
              event.twitter_hashtag = hashtag
              # push_hashtag_feed(event.meetup_id, hashtag)
            end

            if !user.nil? && user[1] != "" && user[1] != "@gmail" && user[1] != "@yahoo" && user[1] != "@hotmail" && event.twitter_account != user[1]
              user = user[1].gsub("@", "")
              puts "found a twitter user: #{user}"
              event.twitter_account = user
              # push_user_feed(event.meetup_id, user)
            end

            event.save!
            puts "New event saved"
          rescue Exception => e
            puts "event save error: " + e.message
          end
        end
      end
    end
  end

  module Communities
    PAGE = "100"
    FIELDS = 'udf_twitter_account,udf_twitter_hashtag'
    URL = "https://api.meetup.com/ew/community/"
    
    def self.fetch_events
      Community.all.each do |community|
        Meetup::Events.fetch_by_community(community.zip_code, community.meetup_id)
      end
    end

    def self.fetch(id)
      response = RestClient.get (URL + id.to_s), {:params => {:key => ENV['MEETUP_API_KEY'], :fields => FIELDS}, :accept => :json}

      data = JSON.parse(response)
   
      community = Community.new
      community.city = data["city"]
      community.zip_code = data["zip"]
      community.state = data["state"]
      community.latitude = data["lat"]
      community.longitude = data["lon"]
      community.meetup_id = id
      # community.twitter_hashtag = data["udf_twitter_hashtag"]
      # community.twitter_account = data["udf_twitter_account"]

      begin
        community.save!
        puts "New community saved: #{community.zip_code}"
      rescue Exception => e
        puts "community save error: " + e.message
      end
    end

    def self.fetch_nearby(zip)
      page = 100;
      url = 'https://api.meetup.com/ew/communities'
      response = RestClient.get url, {:params => {:key => ENV['MEETUP_API_KEY'], :url_name => 'occupytogether', :zip => zip, :page => page}, :accept => :json}
      data = JSON.parse(response)
      
      data['results'].each do |result|
        community = Community.new
        community.city = result["city"]
        community.zip_code = result["zip"]
        community.state = result["state"]
        community.latitude = result["lat"]
        community.longitude = result["lon"]
        community.meetup_id = result["id"]

        begin
          community.save
        rescue Exception => e
          puts "Couldn't save community: #{e.message}"
        end
      end
    end
  end
end
