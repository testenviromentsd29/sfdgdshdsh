window.addEventListener('message', function(event) {
	if (event.data.action == 'show') {
		$('#killsandbounty').html(`<font style="color:#fff">Your Event Kills:</font> <span id="notwanted">${event.data.kills}</span>`)
		$('#scoreTable').html(`<tr><th class="position">No.</th><th class="name">Name</th><th class="points">Kills</th></tr>`);
		
		for (let i = 0; i < 10; i++) {
			if (event.data.scoreboard[i] == undefined) {
				break;
			}
			
			if (i == 0) {
				$('#scoreTable').append(`<tr class="first"><th class="position first">1</th><th class="name first">${event.data.scoreboard[i].name}</th><th class="points first">${event.data.scoreboard[i].kills}</th></tr>`);
			}
			else if (i == 1) {
				$('#scoreTable').append(`<tr class="second"><th class="position second">2</th><th class="name second">${event.data.scoreboard[i].name}</th><th class="points second">${event.data.scoreboard[i].kills}</th></tr>`);
			}
			else if (i == 2) {
				$('#scoreTable').append(`<tr class="third"><th class="position third">3</th><th class="name third">${event.data.scoreboard[i].name}</th><th class="points third">${event.data.scoreboard[i].kills}</th></tr>`);
			}
			else {
				$('#scoreTable').append(`<tr><th class="position">${i+1}</th><th class="name">${event.data.scoreboard[i].name}</th><th class="points">${event.data.scoreboard[i].kills}</th></tr>`);
			}
		}
		
		$('#wrap-gang-ranking').fadeIn(100);
	}
	else if (event.data.action == 'hide') {
		$('#wrap-gang-ranking').fadeOut(100);
	}
});