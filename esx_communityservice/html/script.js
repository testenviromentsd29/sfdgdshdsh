window.addEventListener('message', function(event) {
	if (event.data.action == 'show') {
		if (event.data.type == 'default') {
			$('#message').html("Τσέκαρε το χάρτη σου για να βρεις τις σκούπες. ");
		}
		else {
			$('#message').html("Τσέκαρε το χάρτη σου για να βρεις τις σκούπες.<br> Γράψε /bf4002 για να πάρεις την μηχανή. ");
		}

		$('#message-wrap').show();
	}
	else if (event.data.action == 'hide') {
		$('#message-wrap').hide();
	}
});