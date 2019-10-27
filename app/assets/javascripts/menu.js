$(document).ready(function(){
	$(document).on('click','#nav-icon4', function(){
		$(this).toggleClass('open');
		$('#sideTrayWrapper').toggleClass('nav-open');
	});
});

function openNewsletter() {
  document.getElementById("myOverlay").style.display = "block";
}

function closeNewsletter() {
  document.getElementById("myOverlay").style.display = "none";
}

function openSearch() {
  document.getElementById("mySearch").style.display = "block";
}

function closeSearch() {
  document.getElementById("mySearch").style.display = "none";
}