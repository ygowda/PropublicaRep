module ChambersHelper
    # for logic in your view
    def renderPartyColor(party)
        if party == "R"
            "party rep"
        else
            "party dem"
        end
    end
end
