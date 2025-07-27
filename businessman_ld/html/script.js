$(function() {
	window.addEventListener('message', function(event) {
		if (event.data.action == 'show') {
			$('#your-business-points').html(`<i class="far fa-chart-line"></i> YOUR POINTS: <span>${event.data.myPoints}</span>`);
			$('#top_business').html(``);

			for (let i = 0; i < event.data.leaderboard.length; i++) {
				if (i == 24) {
					break;
				}

				if (i == 0) {
					$('#top_business').append(`
						<tr>
							<td class="pos first"><i class="fal fa-trophy-alt"></i> 1.</td>
							<td class="name">${event.data.leaderboard[i].name}</td>
							<td class="bid_win">${event.data.leaderboard[i].data.bid_win}</td>
							<td class="bid_amount">${event.data.leaderboard[i].data.bid_amount}</td>
							<td class="transfers">${event.data.leaderboard[i].data.transfers}</td>
							<td class="points">${event.data.leaderboard[i].sum}</td>
						</tr>`
					);
				}
				else if (i == 1) {
					$('#top_business').append(`
						<tr>
							<td class="pos second"><i class="fal fa-trophy-alt"></i> 2.</td>
							<td class="name">${event.data.leaderboard[i].name}</td>
							<td class="bid_win">${event.data.leaderboard[i].data.bid_win}</td>
							<td class="bid_amount">${event.data.leaderboard[i].data.bid_amount}</td>
							<td class="transfers">${event.data.leaderboard[i].data.transfers}</td>
							<td class="points">${event.data.leaderboard[i].sum}</td>
						</tr>`
					);
				}
				else if (i == 2) {
					$('#top_business').append(`
						<tr>
							<td class="pos third"><i class="fal fa-trophy-alt"></i> 3.</td>
							<td class="name">${event.data.leaderboard[i].name}</td>
							<td class="bid_win">${event.data.leaderboard[i].data.bid_win}</td>
							<td class="bid_amount">${event.data.leaderboard[i].data.bid_amount}</td>
							<td class="transfers">${event.data.leaderboard[i].data.transfers}</td>
							<td class="points">${event.data.leaderboard[i].sum}</td>
						</tr>`
					);
				}
				else {
					$('#top_business').append(`
						<tr>
							<td class="pos">${i+1}.</td>
							<td class="name">${event.data.leaderboard[i].name}</td>
							<td class="bid_win">${event.data.leaderboard[i].data.bid_win}</td>
							<td class="bid_amount">${event.data.leaderboard[i].data.bid_amount}</td>
							<td class="transfers">${event.data.leaderboard[i].data.transfers}</td>
							<td class="points">${event.data.leaderboard[i].sum}</td>
						</tr>`
					);
				}
			}

			$('body').fadeIn();
			$('#wrap').fadeIn();
		}
    });
	
	document.onkeyup = function(event) {
		if (event.key == 'Escape') {
			$('#wrap').fadeOut();
			$('body').fadeOut();

			$('#top_business').html(``);

			$.post('https://businessman_ld/quit', JSON.stringify({}));
		}
	};
});