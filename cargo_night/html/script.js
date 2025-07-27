$(function() {
	window.addEventListener('message', function(event) {
		switch(event.data.action) {
			case 'close':
				window.location.reload();
				break;
			case 'update':
				let data = event.data.data;
				
				$(".phase-text").html(data.stage);
				$('.timer-counter').html(data.time);
				
				$('#body').fadeIn(1000);
				break;
		}
	});
});