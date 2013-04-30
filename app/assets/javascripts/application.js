// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

	$( "#location" ).autocomplete({
		source: function(request, response){	
			$.ajax({
                type: "GET",
                url: "http://dev.betterjobs.com:7777/OrionWeb/doSuggestLocations",
                data: {
                    term: request.term,
                    country: $('#country-options').val()
                },                dataType: "jsonp",
                crossDomain: true,
                cache: false,
				success: function(data){
					response( data.suggestions );
				}
			});
		},
		delay:0,
		autoFocus:true
	});

/*$(document).ready(function(){
    $("#result").html( "starting "+new Date() );

    $.ajax({
        type: "GET",
        url: "http://dev.betterjobs.com:7777/OrionWeb/doSuggestLocations",
        data: { term: "Mia", country: "US" },
        dataType: "jsonp",
        crossDomain: true,
        cache: false,
        before: function(){
            $("#result").html( "processing" );
        },
        success: function(data){
            console.log("lalal")
            $("#result").append("Mia >>"+ data.suggestions[0].label );
        },
        error: function(xhr, ajaxOptions, thrownError){
            $("#result").html( "error: " + xhr.status + "<br>" + thrownError );
        }
    });
})
*/