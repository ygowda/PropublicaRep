class GovtOfficialController < ApplicationController
    def show
        @member = GovtOfficial.find(params[:id])
        
        # recent votes
        # recent personal explanations
        # tweets 
        
        # getRecentStatments
        # getRecentVotes
        getRecentBills
        
    end
    
    def makeAPICall(url)
        require 'rubygems'
        require 'open-uri'
        require 'net/http'
        
        headers = {"X-API-Key" =>"7mzlBEbqun6gjkmVmGMHK9ScX0z4O2NTQk066Zmc"}

        uri = URI(url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        request = Net::HTTP::Get.new(uri.request_uri, headers)
        @results = JSON.parse(http.request(request).body)
        
        return @results
    end
    
    
    def getRecentStatments
        @statements = makeAPICall('https://api.propublica.org/congress/v1/members/' + @member.member_id + '/statements/115.json')
        @statements = @statements['results']
    end
    
    def getRecentVotes
        @votes = makeAPICall('https://api.propublica.org/congress/v1/members/' + @member.member_id + '/votes.json')
        @votes = @votes['results'][0]['votes']
    end
    
    def getRecentBills
        @bills = makeAPICall('https://api.propublica.org/congress/v1/members/' + @member.member_id + '/bills/introduced.json')
        @bills = @bills['results'][0]['bills']
    end
    
    #do you need to create a separate results table here or 
end
