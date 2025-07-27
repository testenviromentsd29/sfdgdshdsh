let cooldowns = null;

$(function() {
	window.addEventListener('message', function(event) {
		cooldowns = event.data.cooldowns;
		
		let activeButton = $('#side-menu').find('button.side-btn-active');
		
		if (activeButton.length > 0) {
			let kind = activeButton.attr('kind');
			SetupCooldowns(kind);
			$('#wrap').show();
		}
	});
	
	document.onkeyup = function(event) {
		if (event.key == 'Escape') {
			cooldowns = null;
			
			$('#wrap').hide();
			
			$('.available-cooldowns').html(``);
			$('.unavailable-cooldowns').html(``);
			
			$.post('https://cooldowns/quit', JSON.stringify({}));
		}
	};
	
	$('.side-btn').click(function() {
		$('.side-btn').removeClass('side-btn-active');
		$(this).addClass('side-btn-active');
		
		const kind = $(this).attr('kind');
		
		SetupCooldowns(kind);
	});
});

function SetupCooldowns(kind) {
	$('.available-cooldowns').html(``);
	$('.unavailable-cooldowns').html(``);
	
	let timestamp = Math.floor(Date.now() / 1000);
	
	$.each(cooldowns, function(index, data) {
		if (data.type == kind) {
			if (data.expire > timestamp) {
				let timeLeft = data.expire - timestamp;
				
				$('.unavailable-cooldowns').append(`
					<div class="cooldown-item">
						<div class="cooldown-item-img"><img src="./images/`+ data.type +`.png"/></div>
						<div class="cooldown-item-name">
							`+ data.name +`<br/>
							<span class="cooldown">Available in - <span>`+ SecondsToClock(timeLeft) +`</span></span><br/>
							<button onclick="SetWaypoint(\'`+ data.coords +`\')" class="cooldown-item-gps"><i class="fas fa-map-marker-alt"></i> GPS LOCATION</button>
						</div>
					</div>`
				);
			}
			else {
				$('.available-cooldowns').append(`
					<div class="cooldown-item">
						<div class="ribbon">
							  <p>AVAILABLE</p>
							  <span><svg x="0px" y="0px" viewBox="0 0 100 100"><path fill="#324e11" d="M92.5,84.3V98c4.7,0,5.5-2.1,5.5-2.1L92.5,84.3z"></path><path fill="#324e11" d="M3.7,1.7c0,0-2.4,0.4-2.4,5.1H15L3.7,1.7z"></path><polygon fill="#78be28" points="44.1,1.7 98,55.5 98,95.9 3.7,1.7 "></polygon></svg></span>
							</div>
						<div class="cooldown-item-img"><img src="./images/`+ data.type +`.png"/></div>
						<div class="cooldown-item-name">
							`+ data.name +`<br/>
							<span class="cooldown-item-available">Available</span><br/>
							<button onclick="SetWaypoint(\'`+ data.coords +`\')" class="cooldown-item-gps"><i class="fas fa-map-marker-alt"></i> GPS LOCATION</button>
						</div>
					</div>`
				);
			}
		}
	});
}

function SetWaypoint(coords) {
	$.post('https://cooldowns/setwaypoint', JSON.stringify({coords: coords}));
}

function SecondsToClock(seconds) {
	var sec_num = parseInt(seconds, 10); // don't forget the second param
	var hours   = Math.floor(sec_num / 3600);
	var minutes = Math.floor((sec_num - (hours * 3600)) / 60);
	var seconds = sec_num - (hours * 3600) - (minutes * 60);
	
	if (hours   < 10) {hours   = "0"+hours;}
	if (minutes < 10) {minutes = "0"+minutes;}
	if (seconds < 10) {seconds = "0"+seconds;}
	
	return hours+':'+minutes+':'+seconds;
}