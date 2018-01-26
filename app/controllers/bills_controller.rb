class BillsController < ApplicationController
    
    def index
        @bills = Bill.all
        b = Bills.new
        b.getRecentBills
    end
    
    
end
