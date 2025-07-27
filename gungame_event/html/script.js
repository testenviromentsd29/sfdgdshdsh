$(function() {
	window.addEventListener('message', function(event) {
		switch(event.data.action) {
			case 'close':
				window.location.reload();
				break;
			case 'update':
				let gungameData = event.data.data;
				
				// $(".player-counter").html(`${gungameData.players} <span>ALIVE</span>`);
				$(".kills-counter").html(`${gungameData.kills} <span>KILLS</span>`);
				$(".headshots-counter").html(`${gungameData.level} <span>LEVEL</span>`);
				$(".phase-text").html(gungameData.stage);
				$('.timer-counter').html(gungameData.time);
				
				$('#body').fadeIn(1000);
				break;
			case 'lvl_up':
				var audio = new Audio('sounds/smb3_powerup.mp3');
				audio.volume = 0.5;
				audio.play();
				break;
			case 'lvl_down':
				var audio = new Audio('sounds/smb3_powerdown.mp3');
				audio.volume = 0.5;
				audio.play();
				break;
			case 'last_lvl':
				var audio = new Audio('sounds/smb_warning2.mp3');
				audio.volume = 0.5;
				audio.play();
				break;
			case 'leaderboard':
				let solo = event.data.solo;
				let team = event.data.team;
				
				$('#scoreTableSolo').html(`
					<tr>
						<th class="position">No.</th>
						<th class="name">Name</th>
						<th class="wins">Wins</th>
					</tr>`
				);
				
				for (let i = 0; i < solo.length; i++) {
					switch(i) {
						case 0:
							$('#scoreTableSolo').append(`
								<tr class="first">
									<td class="position first"><i class="fal fa-trophy-alt"></i> 1.</td>
									<td class="name first">${solo[i].name}</td>
									<td class="wins first">${solo[i].wins}</td>
								</tr>`
							);
							
							break;
						case 1:
							$('#scoreTableSolo').append(`
								<tr class="second">
									<td class="position second"><i class="fal fa-trophy-alt"></i> 2.</td>
									<td class="name second">${solo[i].name}</td>
									<td class="wins second">${solo[i].wins}</td>
								</tr>`
							);
							
							break;
						case 2:
							$('#scoreTableSolo').append(`
								<tr class="third">
									<td class="position third"><i class="fal fa-trophy-alt"></i> 3.</td>
									<td class="name third">${solo[i].name}</td>
									<td class="wins third">${solo[i].wins}</td>
								</tr>`
							);
							
							break;
						default:
							$('#scoreTableSolo').append(`
								<tr>
									<td class="position">${i+1}.</td>
									<td class="name">${solo[i].name}</td>
									<td class="wins">${solo[i].wins}</td>
								</tr>`
							);
							
							break;
					}
				}
				
				$('#scoreTable').html(`
					<tr>
						<th class="position">No.</th>
						<th class="name">Name</th>
						<th class="wins">Wins</th>
					</tr>`
				);
				
				if (team != undefined) {
					for (let i = 0; i < team.length; i++) {
						switch(i) {
							case 0:
								$('#scoreTable').append(`
									<tr class="first">
										<td class="position first"><i class="fal fa-trophy-alt"></i> 1.</td>
										<td class="name first">${team[i].name}</td>
										<td class="wins first">${team[i].wins}</td>
									</tr>`
								);
								
								break;
							case 1:
								$('#scoreTable').append(`
									<tr class="second">
										<td class="position second"><i class="fal fa-trophy-alt"></i> 2.</td>
										<td class="name second">${team[i].name}</td>
										<td class="wins second">${team[i].wins}</td>
									</tr>`
								);
								
								break;
							case 2:
								$('#scoreTable').append(`
									<tr class="third">
										<td class="position third"><i class="fal fa-trophy-alt"></i> 3.</td>
										<td class="name third">${team[i].name}</td>
										<td class="wins third">${team[i].wins}</td>
									</tr>`
								);
								
								break;
							default:
								$('#scoreTable').append(`
									<tr>
										<td class="position">${i+1}.</td>
										<td class="name">${team[i].name}</td>
										<td class="wins">${team[i].wins}</td>
									</tr>`
								);
								
								break;
						}
					}
				}
				
				$('#wrap').show();
				$('#body').fadeIn(1000);
				break;
		}
	});
	
	document.onkeyup = function(event) {
		if (event.key == 'Escape') {
			$('#scoreTable').html(``);
			$('#scoreTableSolo').html(``);
			
			window.location.reload();
			
			$.post('https://gungame_event/quit', JSON.stringify({}));
		}
	};
	
	$(".btn-team").click(function () {
		$("#team-leaderboard").show();
		$("#solo-leaderboard").hide(); 
	});
	
	$(".btn-solo").click(function () {
		$("#solo-leaderboard").show();
		$("#team-leaderboard").hide(); 
	});
});