class Bills<Api_Access
    def initialize(url)
       @url = url 
    end

    
    def getRecentBills
        @bills = makeAPICall(@url)
        @bills['results'][0]['bills']
        # puts @bills['results'][0]['bills']
    end
    
end