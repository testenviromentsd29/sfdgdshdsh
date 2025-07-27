var audioBusMusic = null;
let isPlaying = false;

$(window).ready(function() {
	window.addEventListener('message', function(event) {
		if (event.data.action == 'playSound') {
			var audio = new Audio(`sounds/`+ event.data.sound);
			audio.volume = 0.5;
			audio.play();
		}
	});
});