class GovtOfficial < ActiveRecord::Base
    #maybe a has_many bill relationship should go here....?
    has_many :bills, foreign_key: "sponsor_id"
    
    self.primary_key = :member_id
    enum chamber: [:house, :senate]
    
    def add_chamber(chamber_name)
        if chamber_name == "House"
            self.chamber = :house
        else
            self.chamber = :senate 
        end
    end
    
    def initialize_by_api_data(data, chamber_name)
        self.member_id = data['id']
        self.firstName = data['first_name']
        self.lastName = data['last_name']
        self.DOB = data['date_of_birth']
        self.twitter = data['twitter_url'] 
                
        add_chamber(chamber_name)
        # govtOfficial.chamber = chamber
        self.title = data['title']
        self.state = data['state']
        self.party = data['party']
        self.nextElection = data['next_election']
        self.votesWithParty = data['votes_with_party_pct']
        self.missed_votes = data['missed_votes_pct']
        self.bills_sponsored = data['bills_sponsored']
        self.bills_cosponsored = data['bills_cosponsored']
    end
    
    def add_image_url(image_url)
        self.image_string = image_url
    end
end
