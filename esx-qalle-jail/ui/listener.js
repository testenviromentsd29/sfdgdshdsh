
$(function () {
	window.addEventListener('message', function (event) {
		if (event.data.action == 'show') {
			$("#arrest-wrap").fadeIn(2000);
			$("#arrest-title").html('Reason: '+event.data.reason);
			$("#player-name").html(event.data.dateAdded);
		}else if(event.data.action == "time"){
			$("#arrest-timer").html(event.data.time);
		}else if(event.data.action == "hide"){
			$("#arrest-wrap").fadeOut();
		}
	}, false);
});