class GovtOfficial < ActiveRecord::Base
    # attr_accessor :first_name, :last_name
    
    has_many :bills, foreign_key: "sponsor_id"
    
    include PgSearch
    multisearchable :against => [:first_name, :last_name]
    
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
        self.first_name = data['first_name']
        self.last_name = data['last_name']
        self.DOB = data['date_of_birth']
        self.twitter = data['twitter_url'] 
                
        add_chamber(chamber_name)
        # govtOfficial.chamber = chamber
        self.title = data['title']
        self.state = data['state']
        self.party = data['party']
        self.next_election = data['next_election']
        self.votes_with_party = data['votes_with_party_pct']
        self.missed_votes = data['missed_votes_pct']
        self.bills_sponsored = data['bills_sponsored']
        self.bills_cosponsored = data['bills_cosponsored']
    end
    
    def add_image_url(image_url)
        self.image_string = image_url
    end
    
    def get_search
        return PgSearch.multisearch("Kirsten")
    end
end
