module GovtOfficialHelper
    def renderElectionYearColor(year)
        if year == 2018
            "currentYear"
        else
            "laterYear"
        end
    end
end
