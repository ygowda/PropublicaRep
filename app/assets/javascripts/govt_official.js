$(document).ready(function(){
    var base_url = 'https://tracking-congress-ygowda.c9users.io/api/v1/govt_official/'
    var memberId = $(".horizontalList.plus").data("id");
    
    console.log(memberId);
    
    var state = {
        statements: true,
        bills: true,
        votes: true,
        twitter: true
    };
    
    // creating an ajax call will enable you to render data on to the browser immediately
    var makeAjaxCall = function(filterName){

        $.ajax({
            url: base_url + memberId + "?filter=" + filterName,
            success: function(response){

                
                response = response['data'][1]
                console.log(response)
                populateBasedOnFilter(response, filterName)

                
            },
            failure: function(err){
                console.warn(err);
            }
        });
    }
    
    
    function populateBasedOnFilter(response, arg){

        switch(arg) {
            case "statements":
                var i = 0;
                for(i = 0; i < response.length; i++){
                    $('#activityList').append("<li id='listChildren'><div class=''><aside><p>" + new Date(response[i]['date']) + "</p><p>" + response[i]['title'] + "</p></aside></div></li>") 
                }
            break;
            case "bills":
                var i = 0;
                for(i = 0; i < response.length; i++){
                    $('#activityList').append("<li id='listChildren'><div class=''><aside><p>" + response[i]['title'] + "</p><p>" + new Date(response[i]['latest_major_action_date']) + "</p><p>" +response[i]['latest_major_action']+ "</p></aside></div></li>") 
                }
            break;
            case "votes":
                response = response[0]['votes']
                var i = 0;
                for(i = 0; i < response.length; i++){
                    $('#activityList').append("<li id='listChildren'><div class=''><aside><p>" + new Date(response[i]['date']) + "</p><p>" + response[i]['description'] + "</p><p>" +response[i]['question']+ "</p><p>" +response[i]['position']+ "</p><p>" +response[i]['latest_major_action']+ "</p></aside></div></li>") 
                }
            break;
            case "twitter":
                
            break;
            default:
        }

        
    }
    

    $("#statements").on("click", function(event){
        makeAjaxCall("statements")
        state.statements = !state.statements
        $("#statments").data("state", state.statements)

    });
    
    $("#bills").on("click", function(event){
        makeAjaxCall("bills")
        state.bills = !state.bills
    });
    
    $("#votes").on("click", function(event){
        makeAjaxCall("votes")
        state.votes = !state.votes
    });
    
    $("#twitter").on("click", function(event){
        makeAjaxCall("twitter")
        state.twitter = !state.twitter
    });
});