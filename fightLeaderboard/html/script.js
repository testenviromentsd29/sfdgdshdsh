$(function() {
	let players
	let teams

	window.addEventListener('message', function(event) {
		let action = event.data.action;
		if(action == 'show') {
			document.getElementById('searchtext').value = "";
			
			players = event.data.leaderboardPlayers;
			teams = event.data.leaderboardTeams;

			SetupSoloScoreboard();
			SetupTeamsScoreboard();

			$("#wrap").show();
		}
    });
	
	function SetupSoloScoreboard(search) {
		let tableBody = this.document.getElementById("scoreTableSolo");
		tableBody.innerHTML = `
		<tr>
			<th class="position">No.</th>
			<th class="name">Name</th>
			<th class="v1">1 vs 1</th>
			<th class="v2">2 vs 2</th>
			<th class="v3">3 vs 3</th>
			<th class="v4">4 vs 4</th>
			<th class="v5">5 vs 5</th>
			<th class="points">Total Points</th>
		</tr>`;
	
		for (i = 0; i < players.length; i++) {
			if (search == undefined || (players[i].label != undefined && players[i].label.toLowerCase().includes(search))) {
				if ((i+1) == 1) {
					$("#scoreTableSolo").append(`
					<tr class="first">
						<td class="position first"><i class="fal fa-trophy-alt"></i> 1.</td>
						<td class="name first">${players[i].label}</td>
						<td class="v1 first">${players[i].points['1v1'] ?? 0}</td>
						<td class="v2 first">${players[i].points['2v2'] ?? 0}</td>
						<td class="v3 first">${players[i].points['3v3'] ?? 0}</td>
						<td class="v4 first">${players[i].points['4v4'] ?? 0}</td>
						<td class="v5 first">${players[i].points['5v5'] ?? 0}</td>
						<td class="points first">${players[i].total}</td>
					</tr>`);
				}
				else if ((i+1) == 2) {
					$("#scoreTableSolo").append(`
					<tr class="second">
						<td class="position second"><i class="fal fa-trophy-alt"></i> 2.</td>
						<td class="name second">${players[i].label}</td>
						<td class="v1 second">${players[i].points['1v1'] ?? 0}</td>
						<td class="v2 second">${players[i].points['2v2'] ?? 0}</td>
						<td class="v3 second">${players[i].points['3v3'] ?? 0}</td>
						<td class="v4 second">${players[i].points['4v4'] ?? 0}</td>
						<td class="v5 second">${players[i].points['5v5'] ?? 0}</td>
						<td class="points second">${players[i].total}</td>
					</tr>`);
				}
				else if ((i+1) == 3) {
					$("#scoreTableSolo").append(`
					<tr class="third">
						<td class="position third"><i class="fal fa-trophy-alt"></i> 3.</td>
						<td class="name third">${players[i].label}</td>
						<td class="v1 third">${players[i].points['1v1'] ?? 0}</td>
						<td class="v2 third">${players[i].points['2v2'] ?? 0}</td>
						<td class="v3 third">${players[i].points['3v3'] ?? 0}</td>
						<td class="v4 third">${players[i].points['4v4'] ?? 0}</td>
						<td class="v5 third">${players[i].points['5v5'] ?? 0}</td>
						<td class="points third">${players[i].total}</td>
					</tr>`);
				} else {
					$("#scoreTableSolo").append(`
					<tr>
						<td class="position"> ${i+1}.</td>
						<td class="name">${players[i].label}</td>
						<td class="v1">${players[i].points['1v1'] ?? 0}</td>
						<td class="v2">${players[i].points['2v2'] ?? 0}</td>
						<td class="v3">${players[i].points['3v3'] ?? 0}</td>
						<td class="v4">${players[i].points['4v4'] ?? 0}</td>
						<td class="v5">${players[i].points['5v5'] ?? 0}</td>
						<td class="points">${players[i].total}</td>
					</tr>`);
				}
			}
		}
	};
	
	function SetupTeamsScoreboard(search) {
		let tableBody = this.document.getElementById("scoreTable");
		tableBody.innerHTML = `
		<tr>
			<th class="position">No.</th>
			<th class="name">Criminal Team</th>
			<th class="wins">Overall Wins</th>
		</tr>`;
	
		for (i = 0; i < teams.length; i++) {
			if (search == undefined || (teams[i].label != undefined && teams[i].label.toLowerCase().includes(search))) {
				if ((i+1) == 1) {
					$("#scoreTable").append(`
					<tr class="first">
						<td class="position first"><i class="fal fa-trophy-alt"></i> 1.</td>
						<td class="name first">${teams[i].label}</td>
						<td class="wins first">${teams[i].points ?? 0}</td>
					</tr>`);
				}
				else if ((i+1) == 2) {
					$("#scoreTable").append(`
					<tr class="second">
						<td class="position second"><i class="fal fa-trophy-alt"></i> 2.</td>
						<td class="name second">${teams[i].label}</td>
						<td class="wins second">${teams[i].points ?? 0}</td>
					</tr>`);
				}
				else if ((i+1) == 3) {
					$("#scoreTable").append(`
					<tr class="third">
						<td class="position third"><i class="fal fa-trophy-alt"></i> 3.</td>
						<td class="name third">${teams[i].label}</td>
						<td class="wins third">${teams[i].points ?? 0}</td>
					</tr>`);
				} else {
					$("#scoreTable").append(`
					<tr>
						<td class="position"> ${i+1}.</td>
						<td class="name">${teams[i].label}</td>
						<td class="wins">${teams[i].points ?? 0}</td>
					</tr>`);
				}
			}
		}
	};

	$("#searchtext").keyup(function(event) {
        var searchlabel = document.getElementById('searchtext').value;
		searchlabel=searchlabel.toLowerCase();

		SetupSoloScoreboard(searchlabel);
		SetupTeamsScoreboard(searchlabel);
    });

    document.onkeyup = function(event) {
        if (event.key == 'Escape') {
			$("#wrap").hide(); 
			
            $.post('https://fightLeaderboard/quit', JSON.stringify({}));
        }
    };
});

$(document).ready(function () {
	$(".btn-team").click(function () {
		$("#team-leaderboard").show();
		$("#solo-leaderboard").hide(); 
	});
});
		
$(document).ready(function () {
	$(".btn-solo").click(function () {
		$("#solo-leaderboard").show();
		$("#team-leaderboard").hide(); 
	});
});