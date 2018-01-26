class Bills<Api_Access
    
    def initialize
        @bill_types = ['introduced', 'updated', 'active', 'passed', 'enacted', 'vetoed']
    end

    def setUrl(url)
        @url = url
    end
    
    def getMemberRecentBills
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
            
            unless Bill.exists?(bill_id: results["bill_id"], title: results["title"])
                bill = Bill.new 
                bill.initialize_bill(results)
                bill.save
            end
            
            unless results['actions'].length == 0 
                results['actions'].each do |bill_action|
                    unless Action.exists?(action_id: bill_action['id'])
                        action = Action.new
                        action.action_id = bill_action['id']
                        action.chamber = bill_action['chamber']
                        action.action_type = bill_action['action_type']
                        action.date = bill_action['datetime']
                        action.description = bill_action['description']
                        action.bill_id = results['bill_id']
                        
                        action.save
                    end
                end
            end
            
            # puts results
            
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
    
    
    def getRecentBills
        @bill_types.each do |type|
            @bills = makeAPICall("https://api.propublica.org/congress/v1/115/senate/bills/" + type + ".json")
            @bills = @bills['results'][0]['bills']
            
            if @bills.length != 0 
                @bills.each do |bill|
                    #no implicit conversion????
                    ##should not be checking like this. should be iterating through the actions of the bills to see if there is a match
                    unless Bill.exists?(bill_id: bill['bill_id'], latest_major_action: bill['last_major_action'])
                        b = Bill.new
                        b.initialize_bill(bill)
                        b.save
                    end
                end
            end
        end
    end
end