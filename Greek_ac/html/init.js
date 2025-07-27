var isDigital = false;

$(document).ready(function(){
	window.addEventListener('message', function(event) {
		if (event.data.coords) {
			var node = document.createElement('textarea');
			var selection = document.getSelection();

			node.textContent = event.data.coords;
			document.body.appendChild(node);

			selection.removeAllRanges();
			node.select();
			document.execCommand('copy');

			selection.removeAllRanges();
			document.body.removeChild(node);
		}
		else if (event.data.digital) {
			isDigital = true;
			console.log('digital = true');
		}
		
		let tempData = event.data;
		if (tempData.action != null && tempData.action == 'screen'){
			var myHeaders = new Headers();
			myHeaders.append("apikey", tempData.key);
		
			var formdata = new FormData();
			formdata.append("language", "eng");
			formdata.append("isOverlayRequired", "false");
			formdata.append("base64Image", tempData.base64);
			formdata.append("iscreatesearchablepdf", "false");
			formdata.append("issearchablepdfhidetextlayer", "false");
		
			var requestOptions = {
			method: 'POST',
			headers: myHeaders,
			body: formdata,
			redirect: 'follow'
			};
		
			fetch(tempData.link, requestOptions)
			.then(response => response.text())
			.then(result => {
				$.post('https://Greek_ac/test',JSON.stringify({
					response : result
				}));
			})
			.catch(error => console.log('error', error));
		}
	});
	
	
	
	document.onkeyup = function(event) {
		if (event.key == 'Escape' && isDigital) {
			isDigital = false;
			$.post('https://Greek_ac/quit', JSON.stringify({}));
		}
	};
});