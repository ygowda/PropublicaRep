class Votes<Api_Access
    def initialize(url)
       @url = url 
    end

    
    def getRecentVotes
        @statements = makeAPICall(@url)
        @statements['results']
    end
end