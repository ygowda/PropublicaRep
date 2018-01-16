$(document).ready(function(){
    var base_url = 'https://tracking-congress-ygowda.c9users.io/api/v1/govt_official/'
    var memberId = $(".horizontalList.plus").data("id");
    
    console.log(memberId);
    
    var state = {
        statement: true,
        bills: true,
        votes: true,
        twitter: true
    };
    
    
    var makeAjaxCall = function(filterName){
        $.ajax({
            url: base_url + memberId + "?filter=" + filterName,
            success: function(response){
                console.log(response)
            },
            failure: function(err){
                console.warn(err);
            }
        });
    }
    
    $("#statements").on("click", function(event){
        makeAjaxCall("statements")
        console.log(state)
        state.statement = !state.statement
        console.log(state)
    });
    
    $("#bills").on("click", function(event){
        makeAjaxCall("bills")
        console.log(state)
        state.statement = !state.statement
        console.log(state)
    });
    
    $("#votes").on("click", function(event){
        makeAjaxCall("votes")
        console.log(state)
        state.statement = !state.statement
        console.log(state)
    });
    
    $("#twitter").on("click", function(event){
        makeAjaxCall("twitter")
        console.log(state)
        state.statement = !state.statement
        console.log(state)
    });
});