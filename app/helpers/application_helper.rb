module ApplicationHelper
    def renderPartyColor(party)
        if party == "R"
            "party rep"
        elsif party == "D"
            "party dem"
        else 
            "party ind"
        end
    end
end
