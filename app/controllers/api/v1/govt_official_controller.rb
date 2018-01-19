module Api
    module V1
        class GovtOfficialController < ApplicationController
            def show
                # s Statement.new

                getRecentStatments
                getRecentVotes
                # puts @roll_call_ids
                getRecentBills
                # getSpecificBillInfo(@bill_ids)
                # getSpecificRollCallVote(@roll_call_ids)
                # puts @roll_call_nums
                
                #logic for showing whether or not filter buttons have been clicked and rendering information accordingly...
                case params[:filter]
                when "statements"
                    # render 'govt_official/recent_activity'
                    render json: { data: ["statements", @statements]}
                    
                when "bills"
                    render json: { data: ["bills", @bills]}
                    
                when "votes"
                    render json: { data: ["votes", @votes]}
                    
                when "twitter"
                    render json: { data: ["twitter", "xxxxx"]}
                    
                else
                    render json: { body: "ok" } 
                end
                
            end

            def getRecentStatments
                s = Statement.new('https://api.propublica.org/congress/v1/members/' + params[:id] + '/statements/115.json')
                @statements = s.getRecentStatments
            end
            
            def getRecentVotes
                v = Votes.new('https://api.propublica.org/congress/v1/members/' + params[:id] + '/votes.json')
                @votes = v.getRecentVotes
                
                @roll_call_ids = []
                @votes.each do |vote|
                    @roll_call_ids.push(vote['roll_call'])
                end
            end
            
            def getRecentBills
                b = Bills.new('https://api.propublica.org/congress/v1/members/' + params[:id] + '/bills/introduced.json')
                @bills = b.getRecentBills
                
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