module Api
    module V1
        class GovtOfficialController < ApplicationController
            def show

                getMemberRecentStatments
                getMemberRecentVotes
                # puts @roll_call_ids
                getMemberRecentBills
                getSpecificBillInfo(@bill_ids)
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

            def getMemberRecentStatments
                s = Statement.new('https://api.propublica.org/congress/v1/members/' + params[:id] + '/statements/115.json')
                @statements = s.getRecentStatments
            end
            
            def getMemberRecentVotes
                v = Votes.new('https://api.propublica.org/congress/v1/members/' + params[:id] + '/votes.json')
                @votes = v.getRecentVotes
                
                @roll_call_ids = []
                @votes.each do |vote|
                    @roll_call_ids.push(vote['roll_call'])
                end
            end
            
            def getMemberRecentBills
                @b = Bills.new
                @b.setUrl('https://api.propublica.org/congress/v1/members/' + params[:id] + '/bills/introduced.json')
                @bills = @b.getRecentBills
                
                @bill_ids = []
                @bills.each do |bill|
                    @bill_ids.push(bill['bill_id'].split('-')[0])
                end
            end
            
            # Api is not returning votes for any of the bills....
            def getSpecificBillInfo(bill_ids)
                output = @b.getSpecificBillInfo(bill_ids)
            end
            
            def getSpecificRollCallVote(roll_call_ids)
                #may need to make call twice for odd and even number of years
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