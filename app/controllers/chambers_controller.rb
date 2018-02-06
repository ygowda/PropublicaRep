class ChambersController < ApplicationController
    #***Can probably do some kind of before action for index after you have combined both house and senate calls into one
    
    
    #need to be able to view individual senators and congressman
    #also need to be able to compare two congressman by each other. 
    #need to be able to view voting positions for bills that they have signed in common. 
    
    def senate
        #getting data from the api
        #should combine this into 1 but can fix this later...
        getMembersInfo("Senate")
        # getMembersInfo("House")
        @govtOfficials = GovtOfficial.all.order("votes_with_party DESC")
        
        # govtOfficial = GovtOfficial.new
        # puts "the search value returns... " + (govtOfficial.get_search).first!

    end
    
    def getMembersInfo(chamber)
        require 'rubygems'
        require 'open-uri'
        require 'net/http'

        headers = {"X-API-Key" =>"7mzlBEbqun6gjkmVmGMHK9ScX0z4O2NTQk066Zmc"}

        uri = URI('https://api.propublica.org/congress/v1/115/'+chamber+'/members.json')
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        request = Net::HTTP::Get.new(uri.request_uri, headers)
        @result = JSON.parse(http.request(request).body)
        
        chamber= @result['results'][0]['chamber']
        @result = @result['results'][0]['members']
        
        
        #going through the database each time to check if the member exists might take a lot of time...
        
        @result.each do |member|
            #doesn't seem like this is taking too much time but there has got to be a better way to do this....
            unless GovtOfficial.exists?(member_id: member['id'], first_name: member['first_name'], last_name: member['last_name'])
                
                govtOfficial = GovtOfficial.new
                
                govtOfficial.initialize_by_api_data(member, chamber)
                image_url = getImage(member['first_name'] + "_" + member['last_name'])
                govtOfficial.add_image_url(image_url)
                govtOfficial.save  
            end
        
        end
    end
    
    # def senate
    #     @govtOfficials = GovtOfficial.all.order("votesWithParty DESC")
    # end
    
    def house
        @govtOfficials = GovtOfficial.all.order("votesWithParty DESC")
    end
    
    def viewMember
        # @govtOfficials = GovtOfficial.all.order("votesWithParty DESC")
        @member = GovtOfficial.all.find(params[:member_id])
    end
    
    def getImage(name)
        
        require 'rubygems'
        require 'nokogiri'
        require 'open-uri'
        
        image_url = ""
        wiki_base_url = "https://en.wikipedia.org/wiki/"
        wiki_final_url = wiki_base_url + name
        
        begin 

            # may end up missing some members. There might be a better way to do this...
            web_page = Nokogiri::HTML(open(wiki_final_url))
            infobox = web_page.at_css('table.infobox')
            td = infobox.css('td')
                
            td.each do |node|
                if node.at_css('img')
                    image_url = node.css('img').attr('src')
                    break
                end

            end

        rescue
            puts "did not find a web page"
        end
        
        return image_url.to_s
    end
    
    
end
