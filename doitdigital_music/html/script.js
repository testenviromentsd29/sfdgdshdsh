let ytID = null;
let isResizing = false;
let isDragging = false;

$(window).ready(function() {
	$.post(`https://${GetParentResourceName()}/ready`, JSON.stringify({}));
	
	window.addEventListener('message', function(event) {
		if (event.data.show) {
			$(`#wrap-`+event.data.type).show();
			$(`#reset-size-`+event.data.type).show();
		}
		else if (event.data.hide) {
			$('#wrap-boombox').hide();
			$('#wrap-radiocar').hide();
			$('#reset-size-boombox').hide();
			$('#reset-size-radiocar').hide();
		}
		else if (event.data.action == 'preferences') {
			$(`#wrap-`+event.data.type).height(event.data.preferences.height);
			$(`#wrap-`+event.data.type).width(event.data.preferences.width);
			$(`#wrap-`+event.data.type).css('inset', event.data.preferences.inset);
		}
	});
	
	$('#submit-btn-boombox').click(function(event) {
		ytID = YouTubeGetID($('#youtube-url-boombox').val());
		$('#youtube-thumbnail-boombox').attr('src', 'https://img.youtube.com/vi/'+ ytID +'/0.jpg');
		
		event.preventDefault();
	});
	
	$('#submit-btn-radiocar').click(function(event) {
		ytID = YouTubeGetID($('#youtube-url-radiocar').val());
		$('#youtube-thumbnail-radiocar').attr('src', 'https://img.youtube.com/vi/'+ ytID +'/0.jpg');
		
		event.preventDefault();
	});
	
	$('#reset-size-boombox').click(function() {
		$('#wrap-boombox').height('19vw');
		$('#wrap-boombox').width('30vw');
		$('#wrap-boombox').css('inset', '');
		
		let inset = $('#wrap-boombox').css('inset');
		let height = $('#wrap-boombox').height();
		let width = $('#wrap-boombox').width();
		
		$.post(`https://${GetParentResourceName()}/save`, JSON.stringify({inset: inset, height: height, width: width, type: 'boombox'}));
	});
	
	$('#reset-size-radiocar').click(function() {
		$('#wrap-radiocar').height('19vw');
		$('#wrap-radiocar').width('30vw');
		$('#wrap-radiocar').css('inset', '');
		
		let inset = $('#wrap-radiocar').css('inset');
		let height = $('#wrap-radiocar').height();
		let width = $('#wrap-radiocar').width();
		
		$.post(`https://${GetParentResourceName()}/save`, JSON.stringify({inset: inset, height: height, width: width, type: 'radiocar'}));
	});
	
	$('#play-btn-boombox').click(function() {
		if (ytID) {
			$('#wrap-boombox').hide();
			$.post(`https://${GetParentResourceName()}/play_boombox`, JSON.stringify({ytid: ytID}));
		}
		else {
			$.post(`https://${GetParentResourceName()}/notify`, JSON.stringify('Invalid YouTube Link'));
		}
	});
	
	$('#stop-btn-boombox').click(function() {
		$.post(`https://${GetParentResourceName()}/stop_boombox`, JSON.stringify({}));
	});
	
	$('#take-btn-boombox').click(function() {
		$('#wrap-boombox').hide();
		$.post(`https://${GetParentResourceName()}/take_boombox`, JSON.stringify({}));
	});
	
	$('#play-btn-radiocar').click(function() {
		if (ytID) {
			$('#wrap-radiocar').hide();
			$.post(`https://${GetParentResourceName()}/play_radiocar`, JSON.stringify({ytid: ytID}));
		}
		else {
			$.post(`https://${GetParentResourceName()}/notify`, JSON.stringify('Invalid YouTube Link'));
		}
	});
	
	$('#stop-btn-radiocar').click(function() {
		$.post(`https://${GetParentResourceName()}/stop_radiocar`, JSON.stringify({}));
	});
	
	$('#volume-up-btn-radiocar').click(function(event) {
		$.post(`https://${GetParentResourceName()}/volume_radiocar`, JSON.stringify({gain: 0.1}));
		event.preventDefault();
	});
	
	$('#volume-down-btn-radiocar').click(function(event) {
		$.post(`https://${GetParentResourceName()}/volume_radiocar`, JSON.stringify({gain: -0.1}));
		event.preventDefault();
	});
	
	$('#wrap-boombox').draggable({
		stop: function() {
			let inset = $('#wrap-boombox').css('inset');
			let height = $('#wrap-boombox').height();
			let width = $('#wrap-boombox').width();
			
			//$.post(`https://${GetParentResourceName()}/save`, JSON.stringify({inset: inset, height: height, width: width, type: 'boombox'}));
		}
	});
	
	$('#wrap-radiocar').draggable({
		stop: function() {
			let inset = $('#wrap-radiocar').css('inset');
			let height = $('#wrap-radiocar').height();
			let width = $('#wrap-radiocar').width();
			
			//$.post(`https://${GetParentResourceName()}/save`, JSON.stringify({inset: inset, height: height, width: width, type: 'radiocar'}));
		}
	});
	
	$('#wrap-boombox').mousedown(function() {
		var relX = event.pageX - $(this).offset().left;
		var relY = event.pageY - $(this).offset().top;
		var relBoxCoords = "(" + relX + "," + relY + ")";
		
		if ($(this).width() - relX < 16 && $(this).height() - relY < 16){
			isResizing = true;
			isDragging = false;
			
			$('#wrap-boombox').draggable('disable');
		}
		else {
			isResizing = false;
			isDragging = true;
			
			$('#wrap-boombox').draggable('enable');
		}
    });
	
	$('#wrap-boombox').mouseup(function() {
		isResizing = false;
		isDragging = false;
		
		let inset = $('#wrap-boombox').css('inset');
		let height = $('#wrap-boombox').height();
		let width = $('#wrap-boombox').width();
		
		$.post(`https://${GetParentResourceName()}/save`, JSON.stringify({inset: inset, height: height, width: width, type: 'boombox'}));
    });
	
	$('#wrap-radiocar').mousedown(function() {
		var relX = event.pageX - $(this).offset().left;
		var relY = event.pageY - $(this).offset().top;
		var relBoxCoords = "(" + relX + "," + relY + ")";
		
		if ($(this).width() - relX < 16 && $(this).height() - relY < 16){
			isResizing = true;
			isDragging = false;
			
			$('#wrap-radiocar').draggable('disable');
		}
		else {
			isResizing = false;
			isDragging = true;
			
			$('#wrap-radiocar').draggable('enable');
		}
    });
	
	$('#wrap-radiocar').mouseup(function() {
		isResizing = false;
		isDragging = false;
		
		let inset = $('#wrap-radiocar').css('inset');
		let height = $('#wrap-radiocar').height();
		let width = $('#wrap-radiocar').width();
		
		$.post(`https://${GetParentResourceName()}/save`, JSON.stringify({inset: inset, height: height, width: width, type: 'radiocar'}));
    });
	
	document.onkeyup = function(event) {
		if (event.key == 'Escape') {
			$('#wrap-boombox').hide();
			$('#wrap-radiocar').hide();
			$('#reset-size-boombox').hide();
			$('#reset-size-radiocar').hide();
			
			$.post(`https://${GetParentResourceName()}/quit`, JSON.stringify({}));
		}
	};
});

function YouTubeGetID(url) {
	url = url.split(/(vi\/|v=|\/v\/|youtu\.be\/|\/embed\/)/);
	return (url[2] !== undefined) ? url[2].split(/[^0-9a-z_\-]/i)[0] : url[0];
}