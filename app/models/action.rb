class Action < ActiveRecord::Base
    belongs_to :bill
    
    def initialize_action(data, bill_id)
        self.action_id = data['id']
        self.chamber = data['chamber']
        self.action_type = data['action_type']
        self.date = data['datetime']
        self.description = data['description']
        self.bill_id = bill_id
    end
end
