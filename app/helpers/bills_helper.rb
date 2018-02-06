module BillsHelper
    def calculate_width(vote, arg, party)
        
        total = vote.democratic[arg] + vote.republican[arg] + vote.independent[arg] 
        
        if total == 0
            return 0
        end
        
        if party == "dem"
            return number_to_percentage(vote.democratic[arg]/total)* 0.95
        elsif party == "repub"
            return number_to_percentage(vote.republican[arg]/total) * 0.95
        elsif party == "ind"
            return number_to_percentage(vote.independent[arg]/total) * 0.95
        end
        
    end
end
