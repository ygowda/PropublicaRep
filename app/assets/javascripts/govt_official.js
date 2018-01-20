$(document).ready(function(){
    var base_url = 'https://tracking-congress-ygowda.c9users.io/api/v1/govt_official/'
    var memberId = $(".horizontalList.plus").data("id");
    var memberTitle = $("#memberName").text();
    
    var titleSegments = memberTitle.split('(');
    var memberName = titleSegments[0].trim();
    
    console.log(memberId);
    
    var state = {
        statements: true,
        bills: true,
        votes: true,
        twitter: true
    };
    
    // creating an ajax call will enable you to render data on to the browser immediately
    // you cannot access global variables within the ajax call but you can call other functions within the success function call
    var makeAjaxCall = function(filterName){

        $.ajax({
            url: base_url + memberId + "?filter=" + filterName,
            success: function(response){
                
                response = response['data'][1]
                // console.log(response)
                populateBasedOnFilter(response, filterName)
                
            },
            failure: function(err){
                console.warn(err);
            }
        });
    }
    
    
    function populateBasedOnFilter(response, arg){
            console.log(response)

            switch(arg) {
                case "statements":
                    var i = 0;
                    for(i = 0; i < response.length; i++){
                        $('.activityList').append("<li id='statements'><div class='listChildren'><aside><p class='date'>" + new Date(response[i]['date']).toDateString() + "</p><p>" + memberName + " released a <a href=" + response[i]['url'] + " target='_blank'>statement</a> </p><p class='description'>" + response[i]['title'] + "</p></aside></div></li>") 
                    }  
                break;
                case "bills":
                    var i = 0;
                    for(i = 0; i < response.length; i++){
                        $('.activityList').append("<li id='bills'><div class='listChildren'><aside><p class='date'>" + new Date(response[i]['latest_major_action_date']).toDateString() + "</p><p><a href= " + response[i]['congressdotgov_url'] + " target='_blank'><strong>" + response[i]['title'] + "</strong></a></p><p class='description'>" +response[i]['latest_major_action']+ "</p></aside></div></li>") 
                    }
                break;
                case "votes":
                    response = response[0]['votes']
                    
                    var i = 0;
                    for(i = 0; i < response.length; i++){
                        
                        var motionResult = response[i]['result'].toLowerCase();
                        var resText = "Failed"

                        if(motionResult.includes('agreed')){
                            resText = "Passed"
                        }   
                        
                        $('.activityList').append("<li id='votes'><div class='listChildren'><aside><p class='date'>" + new Date(response[i]['date']).toDateString() + "</p><p>" + memberName + " voted <span class=" + response[i]['position'].toLowerCase() + ">" + response[i]['position'].toLowerCase() + "</span> on " + response[i]['chamber'] + " Vote " + response[i]['roll_call'] + "</p><p class='description'>" + response[i]['description'] + "</p><p>" +response[i]['question']+ ": <span class= " + resText.toLowerCase() + ">" + resText + "</span></p></aside></div></li>") 
                    }
                break;
                case "twitter":
                    
                break;
                default:
        }    
        
        
    }
    

    $("#statements").on("click", function(event){
        // console.log(state.statements)

        if(state.statements){
            makeAjaxCall("statements")   
        }
        else{
            console.log("here")
            ('#statements').empty()
        }
        makeAjaxCall("statements") 
        console.log(state.statements)
        state.statements = !state.statements

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