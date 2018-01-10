class GovtOfficialController < ApplicationController
    def show
        @member = GovtOfficial.find(params[:id])
        
        # recent votes
        # recent personal explanations
        # tweets 
    end
end
