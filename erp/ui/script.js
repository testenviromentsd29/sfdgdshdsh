$(function() {
	$("#sex").click(function(){
		$('#wrap').fadeOut();
		$.post('http://erp/sex', JSON.stringify({}));
	});
	$("#blowjob1").click(function(){
		$('#wrap').fadeOut();
		$.post('http://erp/blowjob1', JSON.stringify({}));
	});
	$("#blowjob2").click(function(){
		$('#wrap').fadeOut();
		$.post('http://erp/blowjob2', JSON.stringify({}));
	});
	$("#cancel-emote").click(function(){
		$('#wrap').fadeOut();
		$.post('http://erp/cancel-emote', JSON.stringify({}));
	});
	$("#start-emote").click(function(){
		$('#wrap').fadeOut();
		$.post('http://erp/start-emote', JSON.stringify({}));
	});
	
	window.addEventListener('message', function(event) {
		
		if(event.data.action == "show") {
			$('#wrap').fadeIn();
		}
	});
	
	document.onkeyup = function(event) {
		if (event.key == 'Escape') {
			$('#wrap').fadeOut();
			$.post('http://erp/quit', JSON.stringify({}));
		}
	};
});