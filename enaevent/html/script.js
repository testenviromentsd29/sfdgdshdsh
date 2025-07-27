$(function() {
	window.addEventListener('message', function(event) {
		if (event.data.action == 'show') {
			$('#wrap').hide();
			SetupScoreboard(event.data.type, event.data.scoreboard, event.data.kills, event.data.runningperiod);
			$('#wrap').fadeIn();
		}
	});
	
	document.onkeyup = function(event) {
		if (event.key == 'Escape') {
			$('#wrap').hide();
			$.post('https://enaevent/quit', JSON.stringify({}));
		}
	};
});

function SetupScoreboard(type, data, kills, runningperiod) {
	$('#kills').html(`Your Kills: <span>`+ kills +`</span>`);
	
	let scoreboardHtml = `<tr><th class="position">No.</th><th class="name">Name</th><th class="points">Kills</th></tr>`;
	
	for (let i = 0; i < 10; i++) {
		if (data[i] != undefined) {
			switch(i) {
				case 0: {
					scoreboardHtml += `<tr class="first"><th class="position first"><i class="fal fa-trophy-alt"></i> 1.</th><th class="name first">`+ data[i].name +`</th><th class="points first">`+ data[i].kills +`</th></tr>`
					break;
				}
				case 1: {
					scoreboardHtml += `<tr class="second"><th class="position second"><i class="fal fa-trophy-alt"></i> 2.</th><th class="name second">`+ data[i].name +`</th><th class="points second">`+ data[i].kills +`</th></tr>`
					break;
				}
				case 2: {
					scoreboardHtml += `<tr class="third"><th class="position third"><i class="fal fa-trophy-alt"></i> 3.</th><th class="name third">`+ data[i].name +`</th><th class="points third">`+ data[i].kills +`</th></tr>`
					break;
				}
				default: {
					scoreboardHtml += `<tr><th class="position">`+ (i+1) +`</th><th class="name">`+ data[i].name +`</th><th class="points">`+ data[i].kills +`</th></tr>`
				}
			}
		}
	}
	
	if (type == 'daily') {
		$('#title-large').html(`<span>DAILY LEGEND</span> SHOOTER`);

		$('#running-period').hide();
		
		$('#title-large span').css('color', 'rgba(255, 90, 50, 1)');
		$('#title-large span').css('text-shadow', '0 0 2vw rgba(255, 50, 50, 0.7)');
		
		$('#kills span').css('color', 'rgba(255, 120, 70, 1)');
		$('#kills span').css('text-shadow', '0 0 0.6vw rgba(255, 60, 30, 1)');
	}
	else if (type == 'weekly') {
		$('#title-large').html(`<span>WEEKLY EPIC</span> SHOOTER`);
		
		$('#running-period').hide();

		$('#title-large span').css('color', 'rgba(255, 210, 70, 1');
		$('#title-large span').css('text-shadow', '0 0 2vw rgba(255, 180, 50, 0.7)');
		
		$('#kills span').css('color', 'rgba(255, 210, 70, 1)');
		$('#kills span').css('text-shadow', '0 0 0.6vw rgba(255, 120, 30, 1)');
	} else if (type == 'leaderboard') {
		$('#title-large').html(`<span>BEST GM EVENT</span> SHOOTER`);

		$('#running-period').html(runningperiod);
		$('#running-period').show();

		$('#title-large span').css('color', 'rgba(255, 210, 70, 1');
		$('#title-large span').css('text-shadow', '0 0 2vw rgba(255, 180, 50, 0.7)');
		
		$('#kills span').css('color', 'rgba(255, 210, 70, 1)');
		$('#kills span').css('text-shadow', '0 0 0.6vw rgba(255, 120, 30, 1)');
	}
	
	$('#wrap').css('background-image', `url('../html/images/background_`+ type +`.png')`);
	
	$('#scoreTable').html(scoreboardHtml);
}