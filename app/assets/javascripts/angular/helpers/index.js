$(window).load(function() {
	var dimensions = getScreenSize();
	console.log(dimensions.height_in_inches + "x" + dimensions.width_in_inches);
	console.log(dimensions.height_in_pixels + "x" + dimensions.width_in_pixels);
	if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
	    $(".btn-launch").each(function(){
	    	$(this).text("Launch App");
	    });
	    $(".program-list .card-header").css("font-size", ".53rem");
	    $(".program-course-guide-search").css("width","100%");
	    $(".program-list .card").css("height", $(".program-list .card").css("min-height"));
	}
}); 
function getScreenSize() {    
    var $temp =  $('<div style="overflow:hidden;visibility:hidden;width:10in"/>').appendTo('body'),
       dpi = $temp[0].offsetWidth / 10;
    return {
    	    "width_in_pixels": screen.width,
            "width_in_inches": screen.width / dpi, 
            "height_in_pixels": screen.height,
            "height_in_inches": screen.height / dpi
    };
}     
jQuery.fn.shake = function(intShakes, intDistance, intDuration) {
	this.each(function() {
		$(this).css("position","relative"); 
		for (var x=1; x<=intShakes; x++) {
			$(this).animate({left:(intDistance*-1)}, (((intDuration/intShakes)/4)))
    		.animate({left:intDistance}, ((intDuration/intShakes)/2))
    		.animate({left:0}, (((intDuration/intShakes)/4)));
   		}
  	});
	return this;
};
var encodeQueryString = function encodeRFC5987ValueChars (str) {
    return encodeURIComponent(str).
        // Note that although RFC3986 reserves "!", RFC5987 does not,
        // so we do not need to escape it
        replace(/['()]/g, escape). // i.e., %27 %28 %29
        replace(/\*/g, '%2A').
            // The following are not required for percent-encoding per RFC5987, 
            // so we can allow for a little better readability over the wire: |`^
            replace(/%(?:7C|60|5E)/g, unescape);
}
var getCookies = function(){
  var pairs = document.cookie.split(";");
  var cookies = {};
  for (var i=0; i<pairs.length; i++){
    var pair = pairs[i].split("=");
    cookies[pair[0]] = unescape(pair[1]);
  }
  return cookies;
}
function createCookie(name,value,days) {
    if (days) {
        var date = new Date();
        date.setTime(date.getTime()+(days*24*60*60*1000));
        var expires = "; expires="+date.toGMTString();
    }
    else var expires = "";
    document.cookie = name+"="+value+expires+"; path=/";
}

function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
}

function eraseCookie(name) {
    createCookie(name,"",-1);
}

function getBaseUrl() {
    var re = new RegExp(/^.*\//);
    return re.exec(window.location.href);
}

function randomNumberGenerator(min, max){
	return Math.floor((Math.random() * max) + min);
}

function numberInflection(number){
	var numbers = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen", "twenty", "twenty-one", "twenty-two", "twenty-three", "twenty-four", "twenty-five", "twenty-six", "twenty-seven", "twenty-eight", "twenty-nine", "thirty", "thirty-one", "thirty-two", "thirty-three", "thirty-four", "thirty-five", "thirty-six", "thirty-seven", "thirty-eight", "thirty-nine", "forty", "forty-one", "forty-two", "forty-three", "forty-four", "forty-five", "forty-six", "forty-seven", "forty-eight", "forty-nine", "fifty", "fifty-one", "fifty-two", "fifty-three", "fifty-four", "fifty-five", "fifty-six", "fifty-seven", "fifty-eight", "fifty-nine", "sixty", "sixty-one", "sixty-two", "sixty-three", "sixty-four", "sixty-five", "sixty-six", "sixty-seven", "sixty-eight", "sixty-nine", "seventy", "seventy-one", "seventy-two", "seventy-three", "seventy-four", "seventy-five", "seventy-six", "seventy-seven", "seventy-eight", "seventy-nine", "eighty", "eighty-one", "eighty-two", "eighty-three", "eighty-four", "eighty-five", "eighty-six", "eighty-seven", "eighty-eight", "eighty-nine", "ninety", "ninety-one", "ninety-two", "ninety-three", "ninety-four", "ninety-five", "ninety-six", "ninety-seven", "ninety-eight", "ninety-nine"];
    if (number > 99){
    	return 100;
    }
    else if (number < 0){
    	return -1;
    }
    
    return numbers[number].charAt(0).toUpperCase() + numbers[number].slice(1);
}
