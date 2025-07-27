Date.getUtcEpochTimestamp = () => Math.round(new Date().getTime() / 1000)

let showing = null;

$(function() {
	window.addEventListener('message', function(event) {
		if (event.data.action == 'show') {
			let job = event.data.job;
			let name = event.data.name;
			let label = event.data.label;
			let mugshot = event.data.mugshot;
			console.log(job)
			console.log("1")
			if (job.search('dikigoros') != -1) {
				job = 'dikigoros';
			}
			if (showing != null) {
				$(showing).hide();
			}
			
			showing = `#`+ job + `-badge`;
			
			$(showing).html(`
				<img class="face" src="https://nui-img/` + mugshot +`/` + mugshot +`?t=` + Date.getUtcEpochTimestamp() + `"/>
				<div class="name">` + name +`</div>
				<div class="job">` + label +`</div>`
			);
			console.log(job)
			$(showing).css('background', `url('images/`+ job +`.png')`);
			$(showing).css('background-repeat', `no-repeat`);
			$(showing).css('background-size', `cover`);
			
			$(showing).show();
			$('#wrap').show();
		}
		else if (event.data.action == 'hide') {
			$(showing).hide();
			$('#wrap').hide();
			
			showing = null;
		}
	});
});