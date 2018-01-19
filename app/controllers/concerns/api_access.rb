require 'rubygems'
require 'open-uri'
require 'net/http'

class Api_Access 
    def initialize
    end
    
    def makeAPICall(url)

                
        headers = {"X-API-Key" =>"7mzlBEbqun6gjkmVmGMHK9ScX0z4O2NTQk066Zmc"}
        
        uri = URI(url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        
        request = Net::HTTP::Get.new(uri.request_uri, headers)
        @results = JSON.parse(http.request(request).body)
                
        return @results
    end
end