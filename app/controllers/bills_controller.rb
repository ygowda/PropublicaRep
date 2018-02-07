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
        @votes = Vote.where(question: "On Passage").limit(3).order("date DESC")

        v = Votes.new
        @votes.each do |vote|
           results = v.getVoteByRollCall(vote['roll_call'], vote)
        end
    end
    
    def show
        @bill = Bill.find_by(bill_id: params[:id])
        # why can't you get actions this way??
        # @actions = @bill.actions
        @actions = Action.where(bill_id: params[:id]).order("date DESC")
    end
    
    
end
