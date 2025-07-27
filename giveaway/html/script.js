window.addEventListener('message', function(event) {
  if (event.data.action == "show"){
   $("#myentries").text(event.data.myentries);
   $("#nextentry").text(event.data.nextentry);
   $("#wrap").show();
  }
  document.onkeyup = function(event) {
		if (event.key == 'Escape') {
      $("#wrap").hide();
      $.post('https://giveaway/close', JSON.stringify({}));
		}
	};
  
});

function hideAll() {
}
