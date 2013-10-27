$(function() {
	$("#menu").click(function() {
		$("#nav").width($("body").width() - 4).toggle();
	});
});