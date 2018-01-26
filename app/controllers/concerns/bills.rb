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
            
            unless Bill.exists?(bill_id: results["bill_id"], title: results["title"])
                bill = Bill.new 
                bill.bill_id = results["bill_id"]
                bill.bill_slug = results["bill_slug"] 
                bill.title = results["title"]
                bill.short_title = results["short_title"]
                bill.sponsor_id = results["sponsor_id"]
                bill.sponsor_party = results["sponsor_party"] 
                bill.sponsor_state = results["sponsor_state"]
                bill.introduced_date = results["introduced_date"]
                bill.summary = results["summary"]
                bill.short_summary = results["short_summary"]
                bill.created_at = results["created_at"]
                bill.updated_at = results["updated_at"]
                bill.latest_major_action = results["latest_major_action"]
                bill.latest_major_action_date = results["latest_major_action_date"]
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
end