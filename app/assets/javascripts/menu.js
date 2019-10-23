$(document).ready(function(){
	$(document).on('click','#nav-icon4', function(){
		$(this).toggleClass('open');
		$('#sideTrayWrapper').toggleClass('nav-open');
	});
});