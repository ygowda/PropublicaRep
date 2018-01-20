class Bills<Api_Access
    def initialize
    #   @url = url 
    end

    def setUrl(url)
        @url = url
    end
    
    def getRecentBills
        @bills = makeAPICall(@url)
        @bills['results'][0]['bills']
        # puts @bills['results'][0]['bills']
    end
    
    
    def getSpecificBillInfo(bill_ids)
        
        actions = []
        votes = []
        bill_info = []
        bill_ids.each do |bill_id|
            results = makeAPICall("https://api.propublica.org/congress/v1/115/bills/" + bill_id +".json")
            results = results['results'][0]
            bill_info.push(results)
            # puts results
            #need to store bill information at this point
            actions.push(results['actions'])
            #need to store actions here
            votes.push(results['votes'])
        end
        
        output = Hash.new
        output['bill_info'] = bill_info
        output['actions'] = actions
        output['votes'] = votes
        
        return output
    end
end