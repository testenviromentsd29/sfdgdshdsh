$(window).ready(function() {
	listener();
});

function listener() {
	window.addEventListener('message', (event) => {
		let tempData = event.data;
		
		if (tempData.action == 'showCountdown'){
			$('#event-countdown-wrap').show();
			$('#event-countdown-text').html(`STARTS IN<br/> <span>`+ tempData.seconds +`</span>`);
		}
		else if(tempData.action == 'setCountdown'){
			$('#event-countdown-text').html(`STARTS IN<br/> <span>`+ tempData.seconds +`</span>`);
		}
		else if(tempData.action == 'hideCountdown'){
			$('#event-countdown-wrap').hide();
		}
		else if (tempData.action == 'sendInfo'){
			$('#event-timer-text').html(`FIGHT ENDS IN <br/> <span>`+ tempData.timeRemaining +`</span>`);
			$('#teammates-count').html(tempData.count1);
			$('#teammates-text').text(tempData.job1);
			$('#opponents-text').text(tempData.job2);
			$('#opponents-count').text(tempData.count2);
		}
		else if (tempData.action == 'showInfo'){
			$('#event-timer-wrap').show();
			$('#fight-score').show();
		}
		else if(tempData.action == 'hideInfo'){
			$('#event-timer-wrap').hide();
			$('#fight-score').hide();
		}
	});
}