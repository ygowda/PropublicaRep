class BillsController < ApplicationController
    
    def index
        
        b = Bills.new
        
        bill_types = ['introduced', 'updated', 'active', 'passed', 'enacted', 'vetoed']
        bill_types.each do |bill_type|
            b.setUrl("https://api.propublica.org/congress/v1/115/senate/bills/" + bill_type + ".json")
            b.getRecentBills
        end
        
        @bills = Bill.all
    end
    
    def show
    end
    
    
end
