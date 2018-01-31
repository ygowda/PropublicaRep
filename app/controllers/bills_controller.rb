class BillsController < ApplicationController
    
    def index
        
        #getting most recent bills and displaying...
        b = Bills.new
        bill_types = ['introduced', 'updated', 'active', 'passed', 'enacted', 'vetoed']
        bill_types.each do |bill_type|
            b.setUrl("https://api.propublica.org/congress/v1/115/senate/bills/" + bill_type + ".json")
            b.getRecentBills
        end
        
        #models to be accessed in the frontend 
        @bills = Bill.all.order("latest_major_action_date DESC")
        # @votes = Vote.limit(3).order("date DESC").find_by(question: "On Passage")
        @votes = Vote.limit(3).order("date DESC")
    end
    
    def show
        @bill = Bill.find_by(bill_id: params[:id])
        @actions = @bill.actions
        puts "actions****"
        puts @actions
    end
    
    
end
