$(function () {
	window.addEventListener('message', function(event) {
		let action = event.data.action;

		if (action == 'decode') {
			let job = event.data.job;
			let text = event.data.text;

			let decoded = utf8_decode(text);

			$.post('https://customStatusJob/decode', JSON.stringify({job: job, text: decoded}));
		} else if (action == 'encode') {
			let job = event.data.job;
			let status = event.data.status;

			let encoded = utf8_encode(status.text);
			status.text = encoded;

			$.post('https://customStatusJob/encode', JSON.stringify({job: job, status: status}));
		}
	});
});

function utf8_encode (data) {
	var repr_string = utf8.encode(data);
	ret = "";
	var i = 0;
	for (; i < repr_string.length; i++) {
		var ashex = repr_string[i].charCodeAt(0).toString(16);
		if (ashex.length == 1) {
		ashex = "0" + ashex;
		}
		ret = ret + ("\\x" + ashex);
	}
	return ret;
}

function utf8_decode (e) {
	e = e.replace(/^\s+/, "");
	e = e.replace(/\s+$/, "");
	var r = [];
	if (/^(\\x[0-9a-f]{1,2})/i.test(e)) {
		r = e.match(/(\\x[0-9a-f]{1,2})/gi);
	} else {
		if (/^0x[0-9a-f]{1,2}/i.test(e)) {
			r = e.match(/(0x[0-9a-f]{1,2})/gi);
			if (r.length == 1) {
				if (!(e.length == 3 || e.length == 4)) {
					e = e.replace("0x", "");
					r = e.match(/([0-9a-f]{2})/gi);
				}
			}
		} else {
			if (/^[0-9a-f]{1,2}$/i.test(e)) {
				r.push(e);
			} else {
				if (/^[0-9a-f]{1,2} /i.test(e)) {
					r = e.split(" ");
				} else {
					var hashCharacters = e.split("");
					var i = 0;
					for (; i < hashCharacters.length; i++) {
						r.push(hashCharacters[i].charCodeAt(0).toString(16));
					}
				}
			}
		}
	}
	i = 0;
	for (; i < r.length; i++) {
		r[i] = r[i].replace("\\x", "");
		r[i] = r[i].replace("\\X", "");
	}
	var buffer = "";
	i = 0;
	for (; i < r.length; i++) {
		buffer = buffer + String.fromCharCode(parseInt(r[i], 16));
	}
	return utf8.decode(buffer);
}