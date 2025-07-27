let weapons = null;
let gunshop = null;
let isBusy = false;
let employee = false;

$(function() {
	const leftScrollButton = document.getElementById("side-prev");
	const rightScrollButton = document.getElementById("side-next");
	const scrollableArea = document.getElementById("side");

	function scrollLeft() {
		scrollableArea.scrollBy(600, 0);
	}

	function scrollRight() {
		scrollableArea.scrollBy(-600, 0);
	}

	leftScrollButton.addEventListener("click", scrollRight);
	rightScrollButton.addEventListener("click", scrollLeft);
	
	window.addEventListener('message', function(event) {
		if (event.data.action == 'show') {
			weapons = event.data.weapons;
			gunshop = event.data.gunshop;
			employee = event.data.employee;
			
			$('.nav-item').hide();
			
			let found = {};
			
			$.each(weapons, function(type, _) {
				$(`#nav-${type}`).show();
				found[type] = true;
			});
			
			$('#navigation button').each(function(_, element) {
				let type = $(element).attr('name');
				
				if (found[type]) {
					CreateSide(type);
					return false;
				}
			});
			
			$('#wrap').fadeIn(250);
			$('body').fadeIn(250);
		}
    });
	
	$('#navigation').on('click', '.nav-item', function() {
		if (!isBusy) {
			let type = $(this).attr('name');
			CreateSide(type);
		}
	});
	
	$('#side').on('click', '.side-item', function() {
		if (!isBusy) {
			let wid = $(this).attr('wid');
			let wtype = $(this).attr('wtype');
			
			SelectItem(wtype, Number(wid));
		}
	});
	
	$('#btn-buy').click(function() {
		if (!isBusy) {
			let count = $('#main-quantity').val();

			if (count < 1 || count > 100) {
				return;
			}

			let wid = $(this).children().attr('wid');
			let wtype = $(this).children().attr('wtype');
			let wname = $(this).children().attr('wname');

			if (wname.includes('WEAPON_')) {
				$('body').hide();
				$('#wrap').hide();
			}

			$.post('https://gunshop_night/buy', JSON.stringify({id: Number(wid) + 1, type: wtype, gunshop: gunshop, count: count, name: wname}));
		}
	});
	
	$('.nav-item-exit').click(function() {
		if (!isBusy) {
			$('body').hide();
			$('#wrap').hide();
			
			$.post('https://gunshop_night/quit', JSON.stringify({}));
		}
	});
	
	document.onkeyup = function(event) {
		if (event.key == 'Escape') {
			if (!isBusy) {
				$('body').hide();
				$('#wrap').hide();
				
				$.post('https://gunshop_night/quit', JSON.stringify({}));
			}
		}
	};
});

function CreateSide(type) {
	$('.nav-item').removeClass('nav-active');
	$("#navigation button[name='"+ type +"']").addClass('nav-active');
	
	$('#side').html(``);
	
	for (let i = 0; i < weapons[type].length; i++) {
		let price = (employee === true) ? Math.ceil(weapons[type][i].price*0.5) : weapons[type][i].price;

		let id_and_class = (weapons[type][i].name.includes('WEAPON_')) ? 'id="side-item-img"' : 'id="side-item-img" class="is-item"';
		
		$('#side').append(`
			<div wid="${i}" wtype="${type}" class="side-item">
				<div id="side-item-name">${weapons[type][i].label}</div>
				<div id="side-item-price">$${price}</div>
				<div ${id_and_class}><img src="nui://esx_inventoryhud_matza/html/img/items/${GetImageName(weapons[type][i].name)}.png"/></div>
				<!--<div id="side-item-type">${type}</div>-->
				<div id="side-item-weight"><i class="fas fa-weight-hanging"></i> ${weapons[type][i].weight} Kg</div>
			</div>`
		);
	}
	
	SelectItem(type, 0);
}

async function SelectItem(type, id) {
	isBusy = true;
	
	let data = await GetWeaponData(weapons[type][id].name);
	let id_and_class = (weapons[type][id].name.includes('WEAPON_')) ? 'class="main-img"' : 'class="main-img is-item"';
	
	if (data != undefined) {
		$('#main').html(`
			<div id="main-name">${weapons[type][id].label}</div>
			<div id="main-type">${data.type}</div>
			
			<img class="main-img-circle1" src="./images/weapon-circle1.png"/>
			<img class="main-img-circle2" src="./images/weapon-circle2.png"/>
			<img class="main-img-circle3" src="./images/weapon-circle3.png"/>
			
			<img ${id_and_class} src="nui://esx_inventoryhud_matza/html/img/items/${GetImageName(weapons[type][id].name)}.png"/>
			
			<div id="main-info">
				<i class="far fa-dot-circle"></i> ${data.ammo} <br/>
				<i class="far fa-stream"></i> ${data.rounds} ROUND(S) <br/>
				<i class="fas fa-weight-hanging"></i> ${weapons[type][id].weight} KG <br/>
			</div>`
		);
	}
	else {
		$('#main').html(`
			<div id="main-name">${weapons[type][id].label}</div>
			<div id="main-type">Item</div>
			
			<img class="main-img-circle1" src="./images/weapon-circle1.png"/>
			<img class="main-img-circle2" src="./images/weapon-circle2.png"/>
			<img class="main-img-circle3" src="./images/weapon-circle3.png"/>
			
			<img ${id_and_class} src="nui://esx_inventoryhud_matza/html/img/items/${GetImageName(weapons[type][id].name)}.png"/>`
		);
	}
	
	if (weapons[type][id].stats != undefined) {
		$('#main').append(`
			<div id="main-stats">
				<div id="weapon-stat">
					Damage <span id="stat-value">${weapons[type][id].stats.damage}</span><br/>
					<div class="w3-border"><div class="w3-yellow" style="width:${weapons[type][id].stats.damage}%"></div></div>
				</div>
				<div id="weapon-stat">
					Recoil <span id="stat-value">${weapons[type][id].stats.recoil}</span><br/>
					<div class="w3-border"><div class="w3-yellow" style="width:${weapons[type][id].stats.recoil}%"></div></div>
				</div>
				<div id="weapon-stat">
					Range <span id="stat-value">${weapons[type][id].stats.range}</span><br/>
					<div class="w3-border"><div class="w3-yellow" style="width:${weapons[type][id].stats.range}%"></div></div>
				</div>
			</div>`
		);
	}
	else {
		//$('#main').append(`<div id="main-stats">`);
	}
	
	if (weapons[type][id].itemsNeeded != undefined) {
		$('#main').append(`
			<div id="main-items-needed">
				<div id="main-items-scrollable">
				</div>
			</div>`
		);
		
		let itemsNeeded = await GetItemsNeeded(weapons[type][id].itemsNeeded);
		
		$.each(itemsNeeded, function(itemName, data) {
			$('#main-items-scrollable').append(`
				<div id="item-needed">
					<div class="item-needed-img"><img src="nui://esx_inventoryhud_matza/html/img/items/${GetImageName(itemName)}.png"/></div>
					<span>${data.label} x${data.count}</span>
				</div>`
			);
		});
	}
	else {
		//$('#main').append(`<div id="main-items-needed">`);
	}
	
	let price = (employee === true) ? Math.ceil(weapons[type][id].price*0.5) : weapons[type][id].price;
	
	$('#main-price').html(FormatPrice(price, weapons[type][id].account));
	$('#main-quantity').val(1);
	$('#btn-buy').html(`<i class="fal fa-shopping-bag" wid="${id}" wtype="${type}" wname="${weapons[type][id].name}"></i> Buy`);
	
	isBusy = false;
}

function FormatPrice(price, type) {
	let color = '';
	
	switch(type) {
		case 'bank': {
			color = '#2ee16d';
			break;
		}
		case 'money': {
			color = '#2ee16d';
			break;
		}
		case 'black_money': {
			color = '#ff5050';
			break;
		}
		default: {
			color = '#2ee16d';
		}
	}
	
	return `<font color='${color}'>$${price}</font>`
}

async function GetWeaponData(name) {
	const response = await fetch('https://gunshop_night/get_weapon_data', {
		method: 'POST',
		body: JSON.stringify({name: name})
	});
	
	let data = await response.json();
	
	return data
}

async function GetItemsNeeded(itemsNeeded) {
	const response = await fetch('https://gunshop_night/get_items_needed', {
		method: 'POST',
		body: JSON.stringify({itemsNeeded: itemsNeeded})
	});
	
	let data = await response.json();
	
	return data
}

function GetImageName(item) {
    let imageName = item
	
    if (imageName.includes('blueprint_') && !imageName.includes('blueprint_yellow_') && !imageName.includes('_vest')) {
        imageName = imageName.replace('blueprint_', 'WEAPON_')
    }
	else if (imageName.includes('blueprint_yellow_') && !imageName.includes('_vest')) {
        imageName = imageName.replace('blueprint_yellow_', 'WEAPON_')
	}
	
    return imageName
}