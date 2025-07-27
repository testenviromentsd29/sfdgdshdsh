var quantities = new Object();
var ConfigItems;
var Inventory;
var selectedItem;
var selectedItemID;
var discount;
var ConfigQuantitiesPerCraft = new Object();
var job;

$('#items-craft').on('click', '.btnquantity', function() {
	var $button = $(this);
	var $name = $button.attr('spawnname')
	var oldValue = $button.parent().find('.number').text();
	
	if ($button.get(0).id == 'plus') {
		if (oldValue < 50) {
			var newVal = parseFloat(oldValue) + 1;
		}
		else
		{
			var newVal = parseFloat(oldValue);
		}
	}
	else {
		if (oldValue > 0) {
			var newVal = parseFloat(oldValue) - 1;
		}
		else
		{
			newVal = 0;
		}
	}
	quantities[$name] = newVal;
	selectItem($button.attr('tabID'));
	$button.parent().parent().find('.craft-quantity span').text(ConfigQuantitiesPerCraft[$name]*newVal);
	$button.parent().find('.number').text(newVal);
});

$('#search-job').off('keyup').on('keyup', function() {
	let search = $(this).val().toLowerCase();
	$('.item').each(function() {
		let title = $(this).find('.title').text().toLowerCase();
		if (title.indexOf(search) > -1) {
			$(this).fadeIn();
		}else{
			$(this).fadeOut();
		}
	});
});

$(function() {
	
	window.addEventListener('message', function(event) {
		if (event.data.action == 'show') {
			$('body').show();

			ConfigItems = event.data.items
			Inventory = event.data.inventory
			selectedItem = event.data.items[0].name;
			selectedItemID = 0;
			discount = event.data.discount;
			job = event.data.job;

			let imageUrl = job.includes('veh_factory') ? 'https://i.ibb.co/sJsgnDn/vehicle-photo.png' : 'nui://esx_inventoryhud_matza/html/img/items/' + GetImageName(event.data.items[0].name) + '.png';

			$('#crafting-now').html('');
			$('#crafting-now').append(`
				YOU'RE ABOUT TO CRAFT: <span>` + event.data.items[0].label + `</span>
				<div id="crafting-now-img" style="background:url(`+ imageUrl +`) center center"></div>
				<button onclick="craft()" class="btn-craft"><i class="fas fa-hammer"></i> CRAFT</button>
			`);

			$('#items-need').html('');
			for (let i = 0; i < event.data.items[0].needed.length; i++) {

				var found = false;
				Object.keys(Inventory).forEach(function(key,index) {
					if (key == event.data.items[0].needed[i].name) {
						found = true;
						var neededAmount = event.data.items[0].needed[i].amount - Math.floor(event.data.items[0].needed[i].amount * discount);
						if (Inventory[key].count >= neededAmount){
							$('#items-need').append(`
								<div class="item item-green">
									<div class="image-holder"><img src="nui://esx_inventoryhud_matza/html/img/items/` + GetImageName(event.data.items[0].needed[i].name) + `.png"/></div>
									<div class="container">
										<div class="item-name">` + event.data.items[0].needed[i].label + `</div>
										<div class="in-armory">ITEMS NEEDED<br/> <span class="you-have-green">` + Inventory[key].count + `</span> <span class="you-need">/ ` + neededAmount + `</span></div>
									</div>
								</div>
							`);
						}else{
							$('#items-need').append(`
								<div class="item item-red">
									<div class="image-holder"><img src="nui://esx_inventoryhud_matza/html/img/items/` + GetImageName(event.data.items[0].needed[i].name) + `.png"/></div>
									<div class="container">
										<div class="item-name">` + event.data.items[0].needed[i].label + `</div>
										<div class="in-armory">ITEMS NEEDED<br/> <span class="you-have-red">` + Inventory[key].count + `</span> <span class="you-need">/ ` + neededAmount + `</span></div>
									</div>
								</div>
							`);
						}
					}
					
				});

				if (found == false){
					$('#items-need').append(`
						<div class="item item-red">
							<div class="image-holder"><img src="nui://esx_inventoryhud_matza/html/img/items/` + GetImageName(event.data.items[0].needed[i].name) + `.png"/></div>
							<div class="container">
								<div class="item-name">` + event.data.items[0].needed[i].label + `</div>
								<div class="in-armory">ITEMS NEEDED<br/> <span class="you-have-red">` + 0 + `</span> <span class="you-need">/ ` + (event.data.items[0].needed[i].amount - Math.floor(event.data.items[0].needed[i].amount * discount)) + `</span></div>
							</div>
						</div>
					`);
				}
				
			}



			$('#items-craft').html('');
			for (let i = 0; i < event.data.items.length; i++) {
				quantities[event.data.items[i].name] = 1; 
				ConfigQuantitiesPerCraft[event.data.items[i].name] = event.data.items[i].quantity; 
				
				let imageUrl = job.includes('veh_factory') ? 'https://i.ibb.co/sJsgnDn/vehicle-photo.png' : 'nui://esx_inventoryhud_matza/html/img/items/' + GetImageName(event.data.items[i].name) + '.png';

				$('#items-craft').append(`
					<div onclick="selectItem(`+i+`)" class="item">
						<div class="image-holder"><img src="`+ imageUrl +`"/></div>
						<div class="container">
							<div class="item-name">` + event.data.items[i].label + `</div>
							<div class="craft-quantity">PER CRAFT:<br/> <span>` + event.data.items[i].quantity + `</span></div>
							<div class="quantity">
								<input class="quantity-input" id="quantity-input" tabID = ` + i + ` spawnname="` + event.data.items[i].name + `" type="number" placeholder="1">
							</div>
						</div>
					</div>`);
				
			}
			
			$('.quantity-input').on('input', function() {
				const newValue = $(this).val();
				
				var $button = $(this);
				var $name = $button.attr('spawnname')
				
				quantities[$name] = newValue;
				selectItem($button.attr('tabID'));
				$button.parent().parent().find('.craft-quantity span').text(ConfigQuantitiesPerCraft[$name]*newValue);
			});
        }
    })
	document.onkeyup = function(event) {
		if (event.key == 'Escape') {
			HideEverything();
			$.post('https://craftSystem/quit', JSON.stringify({}));
		}
	};
});

function selectItem(id){
	selectedItem = ConfigItems[id].name
	selectedItemID = id

	let imageUrl = job.includes('veh_factory') ? 'https://i.ibb.co/sJsgnDn/vehicle-photo.png' : 'nui://esx_inventoryhud_matza/html/img/items/' + GetImageName(ConfigItems[id].name) + '.png';

	$('#crafting-now').html('');
	$('#crafting-now').append(`
		YOU'RE ABOUT TO CRAFT: <span>` + ConfigItems[id].label + `</span>
		<div id="crafting-now-img" style="background:url(`+ imageUrl +`) center center"></div>
		<button onclick="craft()" class="btn-craft"><i class="fas fa-hammer"></i> CRAFT</button>
	`);

	$('#items-need').html('');
	for (let i = 0; i < ConfigItems[id].needed.length; i++) {

		var found = false;
		Object.keys(Inventory).forEach(function(key,index) {
			if (key == ConfigItems[id].needed[i].name) {
				found = true;
				var theamount = (ConfigItems[id].needed[i].amount - Math.floor(ConfigItems[id].needed[i].amount * discount)) * quantities[ConfigItems[id].name];
				if (Inventory[key].count >= theamount){
					$('#items-need').append(`
						<div class="item item-green">
							<div class="image-holder"><img src="nui://esx_inventoryhud_matza/html/img/items/` + GetImageName(ConfigItems[id].needed[i].name) + `.png"/></div>
							<div class="container">
								<div class="item-name">` + ConfigItems[id].needed[i].label + `</div>
								<div class="in-armory">ITEMS NEEDED<br/> <span class="you-have-green">` + Inventory[key].count + `</span> <span class="you-need">/ ` + theamount + `</span></div>
							</div>
						</div>
					`);
				}else{
					$('#items-need').append(`
						<div class="item item-red">
							<div class="image-holder"><img src="nui://esx_inventoryhud_matza/html/img/items/` + GetImageName(ConfigItems[id].needed[i].name) + `.png"/></div>
							<div class="container">
								<div class="item-name">` + ConfigItems[id].needed[i].label + `</div>
								<div class="in-armory">ITEMS NEEDED<br/> <span class="you-have-red">` + Inventory[key].count + `</span> <span class="you-need">/ ` + theamount + `</span></div>
							</div>
						</div>
					`);
				}



				
				
			}

			
		});


		if (found == false){
			$('#items-need').append(`
				<div class="item item-red">
					<div class="image-holder"><img src="nui://esx_inventoryhud_matza/html/img/items/` + GetImageName(ConfigItems[id].needed[i].name) + `.png"/></div>
					<div class="container">
						<div class="item-name">` +  ConfigItems[id].needed[i].label + `</div>
						<div class="in-armory">ITEMS NEEDED<br/> <span class="you-have-red">` + 0 + `</span> <span class="you-need">/ ` + (ConfigItems[id].needed[i].amount - Math.floor(ConfigItems[id].needed[i].amount * discount)) + `</span></div>
					</div>
				</div>
			`);
		}
	}
}

function GetImageName(item){
    let imageName = item
    if (imageName.includes("blueprint_") && !imageName.includes("blueprint_yellow_") && !imageName.includes("_vest")){
        imageName = imageName.replace("blueprint_","WEAPON_")
    }else if (imageName.includes("blueprint_yellow_") && !imageName.includes("_vest")){
        imageName = imageName.replace("blueprint_yellow_","WEAPON_")
	}
    return imageName
}

function craft(){
	HideEverything();
	var quant = quantities[ConfigItems[selectedItemID].name];
	$.post('https://craftSystem/craft', JSON.stringify({selectedItem : selectedItem, quantity : quant}));

}

function HideEverything(){
	$('body').hide();
}
