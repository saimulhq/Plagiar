$(document).ready(function() {
	$('#university').change(function() {
		$.ajax({
			url : 'GetUniversityServlet',
			data : {
				university : $('#university').val()
			},
			success : function(responseText) {
				$('#ajaxGetUniversityServletResponse').text(responseText);
			}
		});
	});
});