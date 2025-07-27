

window.addEventListener('message', function(event) {

	if (event.data.action == 'start_capture') {
		$('#top-wrap').html(`
			<div id="capturing-text">CAPTURING</div>
			<div id="capturebar"></div>
			<script>
				captureBar = new ProgressBar.Circle(capturebar, {
					strokeWidth: 8,
					fill: 'rgba(20,20,20,0.5)',
					color: 'rgba(0,0,0,0.3)',
					trailColor: 'rgba(0,0,0,0.3)',
					trailWidth: 16,
					easing: 'easeInOut',
					duration: 500,
					svgStyle: null,
					text: {
						value: '',
						alignToBottom: false
					},
					
					// Set default step function for all animate calls
					step: (state, bar) => {
						bar.path.setAttribute('stroke', state.color);
						var value = Math.round(bar.value() * 100);
						bar.setText("<div id='capture-area'>💀</div>");
						bar.text.style.color = state.color;
					}
				});
				captureBar.animate(0 / 100); 
			</script>`
		);
	}
	else if (event.data.action == 'update_capture') {
		let value = event.data.percent;
		captureBar.animate(value / 100);

		if (value == 100){
			$(`#capturing-text`).css({backgroundColor: 'rgba(253, 89, 13, 0.4)'})
			$('#capturing-text').html(`CAPTURED`)
		}
	}
	else if (event.data.action == 'show_capture') {
		$('#top-wrap').show();
	}
	else if (event.data.action == 'hide_capture') {
		$('#top-wrap').hide();
	}else if (event.data.action == "showKills") {
		$('#event-kills-wrap').show();
		this.document.getElementById('kills-text').innerHTML = event.data.kills
		return;
	} else if (event.data.action == "hideKills") {
		$('#event-kills-wrap').hide();
		return;
	}
});