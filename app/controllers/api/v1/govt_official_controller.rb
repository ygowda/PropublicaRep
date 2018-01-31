module Api
    module V1
        class GovtOfficialController < ApplicationController
            def show

                #logic for showing whether or not filter buttons have been clicked and rendering information accordingly...
                case params[:filter]
                when "statements"
                    getMemberRecentStatments
                    render json: { data: ["statements", @statements]}
                    
                when "bills"
                    getMemberRecentBillIds

                    render json: { data: ["bills", @bills_info['bills']]}
                    
                when "votes"
                    getMemberRecentVotes
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
            
            def getMemberRecentBillIds
                @b = Bills.new
                @b.setUrl('https://api.propublica.org/congress/v1/members/' + params[:id] + '/bills/introduced.json')
                @bills_info = @b.getMemberRecentBillIds
            end
            
            # only a select few of the bills are returning votes....
            def getSpecificBillInfo(bill_ids)
                #maynot actually be needing to return anything here...
                @b.getSpecificBillInfo(bill_ids)
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