class Statement<Api_Access
    def initialize(url)
       @url = url 
    end

    
    def getRecentStatments
        @statements = makeAPICall(@url)
        @statements = @statements['results']

    end
end