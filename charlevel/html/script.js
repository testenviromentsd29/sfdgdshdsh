$(function() {
	window.addEventListener('message', function(event) {
		if (event.data.action == 'show') {
			$('#current-player-level').html(`${event.data.level}`);
			$('.experience').html(` <span id="current-experience"> ${event.data.xp} </span> / ${event.data.level*1000} `);
			$('.progress-bar-fill').css(`width`, `${event.data.xp/(event.data.level*1000)*100}%`);
			
			if (event.data.next_rw != undefined) {
				$('.next-reward-info').html(`
					<div class="next"> NEXT REWARD </div>
					<div class="next-level"> LVL ${event.data.next_rw.level} </div>
				`);
				
				$('.next-reward-img').css('background-image', `url(nui://esx_inventoryhud_matza/html/img/items/${GetImageName(event.data.next_rw.item)}.png)`);
			}
			else {
				$('.next-reward-info').html(``);
			}
			
			$('.challenges').html(``);
			
			for (let i = 0; i < event.data.tasks.length; i++) {
				const percent = event.data.tasks[i].have/event.data.tasks[i].need*100;
				
				$('.challenges').append(`
					<div class="challenge">
						<div class="info">
							<div class="title"> ${event.data.tasks[i].label} </div>
							<div class="progbar-info">
								<div class="progbar">
									<div class="progbar-fill" style="width: ${percent}%;"></div>
								</div>
								<div class="value"> ${event.data.tasks[i].have}/${event.data.tasks[i].need} </div>
							</div>
						</div>
						<div class="reward">
							<div class="amount"> ${event.data.tasks[i].xp} </div>
						</div>
					</div>
				`);
			}
			
			$('#body').show();
		}
    });
	
	document.onkeyup = function(event) {
		if (event.key == 'Escape') {
			$('#body').hide();
			$('.challenges').html(``);
			
			$.post('https://charlevel/quit', JSON.stringify({}));
		}
	};
});

function GetImageName(item) {
    let imageName = item
	
    if (imageName.includes('blueprint_') && !imageName.includes('blueprint_yellow_') && !imageName.includes('_vest')) {
        imageName = imageName.replace('blueprint_', 'WEAPON_')
    }
	else if (imageName.includes('blueprint_yellow_') && !imageName.includes('_vest')) {
        imageName = imageName.replace('blueprint_yellow_', 'WEAPON_')
	}
	
    return imageName
}