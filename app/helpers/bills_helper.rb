module BillsHelper
    def calculate_width(vote, arg, party)
        
        total = vote.democratic[arg] + vote.republican[arg] + vote.independent[arg] 
        
        if total == 0
            return 0
        end
        
        total = total.to_f
        if party == "dem"
            calculate_percentage(vote.democratic[arg], total)
        elsif party == "repub"
            calculate_percentage(vote.republican[arg], total) 
        elsif party == "ind"
            calculate_percentage(vote.independent[arg], total) 
        end
    end
    
    def calculate_percentage(votes, total)
        number_to_percentage(votes/total * 95)
    end
end
