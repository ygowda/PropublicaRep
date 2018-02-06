class Votes<Api_Access
    def initialize()
    end
    
    def setUrl(url)
        @url = url
    end

    def getRecentVotes
        @statements = makeAPICall(@url)
        @statements['results']
    end
    
    def getVoteByRollCall(roll_call_num, vote_model)
        @results = makeAPICall("https://api.propublica.org/congress/v1/115/senate/sessions/2/votes/" + roll_call_num.to_s + ".json")
        if @results == nil?
            #in case it is an odd numbered year
            @results = makeAPICall("https://api.propublica.org/congress/v1/115/senate/sessions/1/votes/" + roll_call_num.to_s + ".json")
        end
        
        # should be querying like this somehow
        # v = Vote.where(roll_call: roll_call)

        unless @results["status"] == "ERROR"
            @results = @results['results']['votes']['vote']
            # v = Vote.where(roll_call: roll_call_num)
            # v.add_party_votes(@results)
            vote_model.add_party_votes(@results)
        end

        
    end
end