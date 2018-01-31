class Bills<Api_Access
    
    def initialize
        @bill_types = ['introduced', 'updated', 'active', 'passed', 'enacted', 'vetoed']
    end

    def setUrl(url)
        @url = url
    end
    
    #initializer methods to get votes...
    def initializeBill(results)
        unless Bill.exists?(bill_id: results["bill_id"], title: results["title"])
            bill = Bill.new 
            bill.initialize_bill(results)
            bill.save
        end
    end
    
    def initializeActions(results)
        unless results['actions'].length == 0 
            results['actions'].each do |bill_action|
                unless Action.exists?(action_id: bill_action['id'])
                    action = Action.new
                    action.initialize_action(bill_action, results['bill_id'].split('-')[0])
                    action.save
                end
            end
        end
    end
    
    def initializeVotes(results)
        if results['votes'].length != 0
            results['votes'].each do |vote|
                unless Vote.exists?(roll_call: vote['roll_call'])
                    v = Vote.new
                    v.initialize_vote(vote, results['bill_id'].split('-')[0])
                    v.save
                end
            end
        end
        
    end
    
    
    
    def getRecentBills
        @bills = makeAPICall(@url)
        @bills = @bills['results'][0]['bills']
        # seems to be adding twice the number of bills for some reason...
        # unless statement might be failing
        @bills.each do |bill|
            getSpecificBillInfo(bill["bill_id"].split('-')[0])
            initializeBill(bill)
        end
    end
    
    
    def getSpecificBillInfo(bill_id)
        
        results = makeAPICall("https://api.propublica.org/congress/v1/115/bills/" + bill_id +".json")
        results = results['results'][0]

        #initialize bill information
        initializeBill(results)
        initializeActions(results)
        initializeVotes(results)
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
                    getSpecificBillInfo(bill["bill_id"].split('-')[0])
                end
            end
        end
        
        bills_info['bills'] = bills_info['bills'].flatten
        bills_info['bill_ids'] = bill_ids
        
        return bills_info
    end
end