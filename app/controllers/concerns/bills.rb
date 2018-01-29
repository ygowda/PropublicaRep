class Bills<Api_Access
    
    def initialize
        @bill_types = ['introduced', 'updated', 'active', 'passed', 'enacted', 'vetoed']
    end

    def setUrl(url)
        @url = url
    end
    
    def initializeBill(results)
        unless Bill.exists?(bill_id: results["bill_id"], title: results["title"])
            bill = Bill.new 
            bill.initialize_bill(results)
            bill.save
        end
    end
    
    
    
    def getRecentBills
        @bills = makeAPICall(@url)
        @bills = @bills['results'][0]['bills']
        @bills.each do |bill|
            initializeBill(bill)
        end
    end
    
    
    def getSpecificBillInfo(bill_ids)
        
        actions = []
        votes = []
        bill_info = []
        bill_ids.each do |bill_id|
            results = makeAPICall("https://api.propublica.org/congress/v1/115/bills/" + bill_id +".json")
            results = results['results'][0]
            bill_info.push(results)
            
            #initialize bill information
            initializeBill(results)

            unless results['actions'].length == 0 
                results['actions'].each do |bill_action|
                    unless Action.exists?(action_id: bill_action['id'])
                        action = Action.new
                        action.initialize_action(bill_action, results['bill_id'])
                        action.save
                    end
                end
            end
            
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
    
    
    def getMemberRecentBillIds
        bills_info = Hash.new
        bills_info['bills'] = Array.new
        bill_ids = []
        
        @bill_types.each do |type|
            @bills = makeAPICall("https://api.propublica.org/congress/v1/115/senate/bills/" + type + ".json")
            @bills = @bills['results'][0]['bills']
            bills_info['bills'].push(@bills)

            if @bills.length != 0 
                @bills.each do |bill|
                    
                    ##should not be checking like this. should be iterating through the actions of the bills to see if there is a match
                    unless Bill.exists?(bill_id: bill['bill_id'], latest_major_action: bill['last_major_action'])
                        b = Bill.new
                        b.initialize_bill(bill)
                        b.save
                        bill_ids.push(bill['bill_id'].split('-')[0])
                    end
                end
            end
        end
        
        bills_info['bills'] = bills_info['bills'].flatten
        bills_info['bill_ids'] = bill_ids
        
        return bills_info
    end
end