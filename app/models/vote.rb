class Vote < ActiveRecord::Base
    belongs_to :bill
    
    def initialize_vote(result, bill_id)
        self.date = result['date']
        self.roll_call = result['roll_call']
        self.question = result['question']
        self.result = result['result']
        self.total_yes = result['total_yes']
        self.total_no = result['total_no']
        self.total_not_voting = result['total_not_voting']
        self.created_at = result['time']
        self.bill_id = bill_id
    end
    
    def add_party_votes(results)
        self.democratic[0] = results['democratic']['yes'].to_i
        self.democratic[1] = results['democratic']['no'].to_i
        self.republican[0] = results['republican']['yes'].to_i
        self.republican[1] = results['republican']['no'].to_i
        self.independent[0] = results['independent']['yes'].to_i
        self.independent[1] = results['independent']['no'].to_i
    end
    
end
