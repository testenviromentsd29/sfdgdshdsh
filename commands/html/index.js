$('.side-btn').click(function() {
	$('.side-btn').removeClass('side-btn-active');
	$(this).addClass('side-btn-active');
});

$(function() {	
	window.addEventListener('message', function(event) {
		if (event.data.action == 'show') {
			$('#wrap').fadeIn();
		}
		else if (event.data.action == hide) {
			$('#wrap').fadeOut();
		}
	});
	
	document.onkeyup = function(event) {
		if (event.key == 'Escape') {
			$('#wrap').fadeOut();
			$.post('http://commands/quit', JSON.stringify({}));
		}
	};
});

ChangePage = function(page) {
	if (page == 'pvpCommands') {
		$('#gamePlay-commands').hide();
		$('#ui-commands').hide();
		$('#makeIt-commands').hide();
		$('#usefull-commands').hide();
		$('#pvp-commands').show();
	}else if (page == 'usefullCommands') {
		$('#gamePlay-commands').hide();
		$('#ui-commands').hide();
		$('#makeIt-commands').hide();
		$('#pvp-commands').hide();
		$('#usefull-commands').show();
	}else if (page == 'makeItCommands') {
		$('#gamePlay-commands').hide();
		$('#ui-commands').hide();
		$('#pvp-commands').hide();
		$('#usefull-commands').hide();
		$('#makeIt-commands').show();
	}else if (page == 'uiCommands') {
		$('#gamePlay-commands').hide();
		$('#pvp-commands').hide();
		$('#usefull-commands').hide();
		$('#makeIt-commands').hide();
		$('#ui-commands').show();
	}else if (page == 'gameplayCommands') {
		$('#pvp-commands').hide();
		$('#usefull-commands').hide();
		$('#makeIt-commands').hide();
		$('#ui-commands').hide();
		$('#gamePlay-commands').show();
	}
};

function justclick(command) {
	$('#wrap').hide();
	$.post('http://commands/send', JSON.stringify(command));
}