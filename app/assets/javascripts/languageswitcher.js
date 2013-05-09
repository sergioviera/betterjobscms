$(document).ready(function() {
	// --- language dropdown --- //
	createDropDown();
	
	var $dropTrigger = $("#csbox .arrow");
	var $languageList = $(".dropdown dd ul");
	
	// open and close list when button is clicked
	$dropTrigger.click(function() {
		$languageList.slideToggle(200);
	});
	
	// close list when anywhere else on the screen is clicked
	$(document).bind('click', function(e) {
		var $clicked = $(e.target);
		if (!$clicked.parents().hasClass("dropdown") && !$clicked.hasClass("arrow") ){
			$languageList.slideUp(200);
		}
	});

	// when a language is clicked, make the selection and then hide the list
	$(".dropdown dd ul li div, #countrymodal ul li div").click(function() {
		var clickedValue = $(this).parent().attr("class");
		if(clickedValue!="more"){
			$('#country-options').val(clickedValue);
			var clickedTitle = $(this).find("em").html();
			$("#target dt").removeClass().addClass(clickedValue);
			$("#target dt em").html(clickedTitle);
			$languageList.hide();
			$("#location").val("");
		}
	});
});

// actual function to transform select to definition list
function createDropDown(){
	var source = $("#country-options");
	var ctry;
	if(typeof searchParams != 'undefined'){
		ctry = searchParams.country;
		if(ctry==null || ctry==''){ ctry = 'us'; }
	}else{
		if( window.location.hash!=null && window.location.hash!='' ){
			ctry = window.location.hash.substring(1, 3);
		}else{
			ctry = 'us';
		}
	}
	
	source.val( ctry );
	$("#target dt").removeClass().addClass( ctry );
	$("#target dt em").html( ctry.toUpperCase() );
	$(".dropdown dd ul").hide();
}
