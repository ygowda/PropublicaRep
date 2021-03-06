class Bill < ActiveRecord::Base 
    self.primary_key = :bill_id
    
    has_many :actions
    has_many :votes
    belongs_to :govt_official, foreign_key: "sponsor_id"
    
    def initialize_bill(data)
        self.bill_id = data["bill_id"].split('-')[0]
        self.bill_slug = data["bill_slug"] 
        self.title = data["title"]
        self.short_title = data["short_title"]
        self.sponsor_id = data["sponsor_id"]
        self.sponsor_party = data["sponsor_party"] 
        self.sponsor_state = data["sponsor_state"]
        self.introduced_date = data["introduced_date"]
        self.summary = data["summary"]
        self.short_summary = data["short_summary"]
        self.created_at = data["created_at"]
        self.updated_at = data["updated_at"]
        self.latest_major_action = data["latest_major_action"]
        self.latest_major_action_date = data["latest_major_action_date"]
        self.congressdotgov_url = data["congressdotgov_url"]
        self.govtrack_url = data["govtrack_url"]
    end
    
    def get_title
        self.title
    end
end
