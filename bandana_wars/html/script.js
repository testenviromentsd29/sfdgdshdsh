window.addEventListener('message', function(event) {
	if (event.data.action == 'showScore') {
		$('#killsandbounty').html(`<font style="color:#fff">Your Team Points:</font> <span id="notwanted">${event.data.points}</span>`)
		$('#scoreTable').html(`<tr><th class="position">No.</th><th class="name">Team</th><th class="points">Points</th></tr>`);
		
		for (let i = 0; i < 10; i++) {
			if (event.data.scoreboard[i] == undefined) {
				break;
			}
			
			if (i == 0) {
				$('#scoreTable').append(`<tr class="first"><th class="position first">1</th><th class="name first">${event.data.scoreboard[i].label}</th><th class="points first">${event.data.scoreboard[i].points}</th></tr>`);
			}
			else if (i == 1) {
				$('#scoreTable').append(`<tr class="second"><th class="position second">2</th><th class="name second">${event.data.scoreboard[i].label}</th><th class="points second">${event.data.scoreboard[i].points}</th></tr>`);
			}
			else if (i == 2) {
				$('#scoreTable').append(`<tr class="third"><th class="position third">3</th><th class="name third">${event.data.scoreboard[i].label}</th><th class="points third">${event.data.scoreboard[i].points}</th></tr>`);
			}
			else {
				$('#scoreTable').append(`<tr><th class="position">${i+1}</th><th class="name">${event.data.scoreboard[i].label}</th><th class="points">${event.data.scoreboard[i].points}</th></tr>`);
			}
		}
		
		$('#wrap-gang-ranking').fadeIn(100);
	}
	else if (event.data.action == 'hideScore') {
		$('#wrap-gang-ranking').fadeOut(100);
	}
	else if (event.data.action == 'showHelp') {
		$('#bottom-left-wrap').fadeIn(100);
	}
	else if (event.data.action == 'hideHelp') {
		$('#bottom-left-wrap').fadeOut(100);
	}
});