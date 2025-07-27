$(function() {
	window.addEventListener('message', function(event) {
		switch(event.data.action) {
			case 'keyguide': {
				event.data.show ? $('#keyguide-wrap').show() : $('#keyguide-wrap').hide();
				break;
			}
		}
	});
});