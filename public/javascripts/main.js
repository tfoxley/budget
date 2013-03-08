$(function() {
	$("a").each(function() {
		if (this.onclick == null && this.getAttribute("target") != "_blank") {
			$(this).click(function() { 
				window.location = $(this).attr("href");
				return false;
			});
		}
	});
	
	$("#progressbar").progressbar({
	    value: 50
	  });
});