class GovtOfficialController < ApplicationController
    def show
        @member = GovtOfficial.find(params[:id])
    end
    
end
