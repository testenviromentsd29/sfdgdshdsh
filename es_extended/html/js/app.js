(() => {

	ESX = {};
	ESX.HUDElements = [];

	ESX.setHUDDisplay = function (opacity) {
		$('#hud').css('opacity', opacity);
	};

	ESX.insertHUDElement = function (name, index, priority, html, data) {
		ESX.HUDElements.push({
			name: name,
			index: index,
			priority: priority,
			html: html,
			data: data
		});

		ESX.HUDElements.sort((a, b) => {
			return a.index - b.index || b.priority - a.priority;
		});
	};

	ESX.updateHUDElement = function (name, data) {
		for (let i = 0; i < ESX.HUDElements.length; i++) {
			if (ESX.HUDElements[i].name == name) {
				ESX.HUDElements[i].data = data;
			}
		}

		ESX.refreshHUD();
	};

	ESX.deleteHUDElement = function (name) {
		for (let i = 0; i < ESX.HUDElements.length; i++) {
			if (ESX.HUDElements[i].name == name) {
				ESX.HUDElements.splice(i, 1);
			}
		}

		ESX.refreshHUD();
	};

	ESX.refreshHUD = function () {
		$('#hud').html('');

		for (let i = 0; i < ESX.HUDElements.length; i++) {
			let html = Mustache.render(ESX.HUDElements[i].html, ESX.HUDElements[i].data);
			$('#hud').append(html);
		}
	};

	ESX.inventoryNotification = function (add, label, count) {
		let notif = '';

		if (add) {
			notif += '+';
		} else {
			notif += '-';
		}

		if (count) {
			notif += count + ' ' + label;
		} else {
			notif += ' ' + label;
		}

		let elem = $('<div>' + notif + '</div>');
		$('#inventory_notifications').append(elem);

		$(elem).delay(3000).fadeOut(1000, function () {
			elem.remove();
		});
	};

	ESX.iso2ToFlag = function (iso2) {
		const iso2FlagEmoji = function(iso){
			if (iso != undefined)
				return String.fromCodePoint(...[...iso.toUpperCase()].map(char => char.charCodeAt(0) + 127397));
			else
				return ''
				
		}
		var flag = iso2FlagEmoji(iso2);
		$.post('http://es_extended/getflag', JSON.stringify({
			flag :flag
		}));
	};


	window.onData = (data) => {
		switch (data.action) {
			case 'setHUDDisplay': {
				ESX.setHUDDisplay(data.opacity);
				break;
			}

			case 'insertHUDElement': {
				ESX.insertHUDElement(data.name, data.index, data.priority, data.html, data.data);
				break;
			}

			case 'updateHUDElement': {
				ESX.updateHUDElement(data.name, data.data);
				break;
			}

			case 'deleteHUDElement': {
				ESX.deleteHUDElement(data.name);
				break;
			}

			case 'inventoryNotification': {
				ESX.inventoryNotification(data.add, data.item, data.count);
			}

			case 'getflag': {
				ESX.iso2ToFlag(data.iso2);
			}
		}
	};

	window.onload = function (e) {
		window.addEventListener('message', (event) => {
			onData(event.data);
		});
	};

})();
