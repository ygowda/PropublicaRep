module Api
    module V1
        class GovtOfficialController < ApplicationController
            def show
                case params[:filter]
                when "statements"
                    # get statemnet
                    render json: { data: ["statements", "xxxxx"]}
                when "bills"
                    render json: { data: ["bills", "xxxxx"]}
                    
                when "votes"
                    render json: { data: ["votes", "xxxxx"]}
                    
                when "twitter"
                    render json: { data: ["twitter", "xxxxx"]}
                    
                else
                    render json: { body: "ok" } 
                end
            # getRecentStatments
            # getRecentVotes
            # # puts @roll_call_ids
            # getRecentBills
            # getSpecificBillInfo(@bill_ids)
            # getSpecificRollCallVote(@roll_call_ids)
            # # puts @roll_call_nums
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
                
                @roll_call_ids = []
                @votes.each do |vote|
                    @roll_call_ids.push(vote['roll_call'])
                end
            end
            
            def getRecentBills
                @bills = makeAPICall('https://api.propublica.org/congress/v1/members/' + @member.member_id + '/bills/introduced.json')
                @bills = @bills['results'][0]['bills']
                
                @bill_ids = []
                @bills.each do |bill|
                    @bill_ids.push(bill['bill_id'].split('-')[0])
                end
                    
            end
            
            
            
            # Api is not returning votes for any of the bills....
            def getSpecificBillInfo(bill_ids)
                @roll_call_nums = []
                bill_ids.each do |bill_id|
                    results = makeAPICall("https://api.propublica.org/congress/v1/115/bills/" + bill_id +".json")
                    results = results['results'][0]
                    # puts results
                    #need to store bill information at this point
                    
                    actions = results['actions']
                    #need to store actions here
                    votes = results['votes']
                    # puts votes
                    #need to store votes and get the roll call nums at this point
                end
            end
            
            def getSpecificRollCallVote(roll_call_ids)
                #do you need to make this call twice for both odd numbered and even numbered years???
                roll_call_ids.each do |roll_call|
                    @roll_call_votes = makeAPICall("https://api.propublica.org/congress/v1/115/senate/sessions/1/votes/" + roll_call + ".json")
                    @roll_call_votes = @roll_call_votes['results']['votes']
                    positions = @roll_call_votes['vote']['positions']
                    # can compare party's voting position with user's voting position....
                end
            end
        end
    end
end