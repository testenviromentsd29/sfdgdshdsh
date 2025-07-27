$(function() {
	window.addEventListener('message', function(event) {
		if (event.data.action == 'show') {
			let components = event.data.components;
			let weapon = event.data.weapon;
			
			$('#attachments').html('');
			
			for (let i = 0; i < components.length; i++) {
				if (components[i].used) {
					$('#attachments').append(`
						<tr id="` + components[i].value + `">
							<td><img class="` + components[i].value + ` equiped" src="./images/` + components[i].value + `.png"/></td>
							<td><button onclick="RemoveComponent(\'` + components[i].value + `\', \'` + weapon + `\')" id="equiped"><i class="fas fa-badge-check"></i> Equiped</button></td>
						</tr>`);
				}
				else {
					$('#attachments').append(`
						<tr id="` + components[i].value + `">
							<td><img class="` + components[i].value + ` not-equiped" src="./images/` + components[i].value + `.png"/></td>
							<td><button onclick="AddComponent(\'` + components[i].value + `\', \'` + weapon + `\')" id="not-equiped"><i class="fal fa-times-square"></i> Not Equiped</button></td>
						</tr>`);
				}
			}
			
			$('#attachments').append(`
			<tr>
				<td><button onclick="AddComponent(\'` + "all" + `\', \'` + weapon + `\')" id="equiped"><i class="fas fa-badge-check"></i> Equip All</button></td>
			</tr>
			<tr>
				<td><button onclick="RemoveComponent(\'` + "all" + `\', \'` + weapon + `\')" id="not-equiped"><i class="fal fa-times-square"></i> Unequip All</button></td>
			</tr>`);
			
			$('#wrap').show();
		}
		else if (event.data.action == 'remove') {
			let item = event.data.item;
			let weapon = event.data.weapon;
			
			$(`#`+ item).html(`
				<td><img class="` + item + ` not-equiped" src="./images/` + item + `.png"/></td>
				<td><button onclick="AddComponent(\'` + item + `\', \'` + weapon + `\')" id="not-equiped"><i class="fal fa-times-square"></i> Not Equiped</button></td>`
			);
		}
		else if (event.data.action == 'add') {
			let item = event.data.item;
			let weapon = event.data.weapon;
			
			$(`#`+ item).html(`
				<td><img class="` + item + ` equiped" src="./images/` + item + `.png"/></td>
				<td><button onclick="RemoveComponent(\'` + item + `\', \'` + weapon + `\')" id="equiped"><i class="fas fa-badge-check"></i> Equiped</button></td>`
			);
		}
	});
	
	document.onkeyup = function(event) {
		if (event.key == 'Escape') {
			$('#wrap').hide();
			$.post('https://esx_attatchments/quit', JSON.stringify({}));
		}
	};
});

function RemoveComponent(item, weapon) {
	$.post('https://esx_attatchments/remove', JSON.stringify({item: item, weapon: weapon}));
}

function AddComponent(item, weapon) {
	$.post('https://esx_attatchments/add', JSON.stringify({item: item, weapon: weapon}));
}