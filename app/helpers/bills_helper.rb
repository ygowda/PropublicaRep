module BillsHelper
    
    def renderName(bill)
        if bill.govt_official != nil 
            return bill.govt_official.firstName + " " + bill.govt_official.lastName
        else
            return "Not available"
        end
        
    end
end
