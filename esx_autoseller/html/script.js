let isBusy = false;
let activeJob = null;
let jobData = null;
let payments = null;
let autosellers = null;
let items = null;

$(window).ready(function() {
	window.addEventListener('message', function(event) {
		if (event.data.action == 'show') {
			jobData = event.data.jobData;
			payments = event.data.payments;
			autosellers = event.data.autosellers;

			$('.bazzars-list').html(``);
			$('.items-list').html(``);
			
			for (let i = 0; i < autosellers.length; i++) {
				$('.bazzars-list').append(`
					<div id="${autosellers[i].job}" class="bazzar">
						<div class="bazzar-name">${autosellers[i].job}</div>
						<div onclick="SelectShop('${autosellers[i].job}')" class="btn-open"> OPEN <i class="fas fa-chevron-right"></i> </div>
					</div>`
				);
			}
			
			$('.btn.restock').hide();
			$('.bazzars-list').show();
			$('#body').show();
		}
		else if (event.data.action == 'update_shop') {
			isBusy = false;
			SelectShop(event.data.job, 0);
		}
	});

	$('.btn.restock').click(function() {
		if (activeJob) {
			$.post(`https://${GetParentResourceName()}/restock`, JSON.stringify({job: activeJob}));
			HideAll();
		}
	});

	$('.search-bazzar').on('input', function() {
		activeJob = null;
		items = null;

		let inputValue = $(this).val();

		$('.bazzars-list').html(``);
		$('.items-list').html(``);
		
		for (let i = 0; i < autosellers.length; i++) {
			if (autosellers[i].job.toLowerCase().includes(inputValue.toLowerCase())) {
				$('.bazzars-list').append(`
					<div id="${autosellers[i].job}" class="bazzar">
						<div class="bazzar-name">${autosellers[i].job}</div>
						<div onclick="SelectShop('${autosellers[i].job}')" class="btn-open"> OPEN <i class="fas fa-chevron-right"></i> </div>
					</div>`
				);
			}
		}
	});

	$('.search-item').on('input', function() {
		if (items && activeJob) {
			let inputValue = $(this).val();

			$('.items-list').html(``);

			let changePriceHtml = ``;

			if (jobData.name == activeJob && jobData.grade_name == 'boss') {
				$('.btn.restock').show();
				changePriceHtml = `<div class="btn remove-item">CHANGE PRICE</div>`;
			}
			else {
				$('.btn.restock').hide();
			}
			
			for (let i = 0; i < items.length; i++) {
				if (items[i].label.toLowerCase().includes(inputValue.toLowerCase())) {
					$('.items-list').append(`
						<div itemid="${i}" itemname="${items[i].name}" class="item">
							<div class="item-label">${items[i].label}</div>
							<div class="item-count">x${items[i].count}</div>
							<div class="item-image" style="background:url(nui://esx_inventoryhud_matza/html/img/items/${GetImageName(items[i].name)}.png)"></div>
							<div class="item-price">${items[i].price.toLocaleString()} ${payments[items[i].priceType]}</div>
							<div class="controls"> <i class="fas fa-minus"></i><input type="number" value="1" min="1" max="${items[i].count}" /> <i class="fas fa-plus"></i> </div>
							<div class="btn purchase">PURCHASE</div>
							${changePriceHtml}
						</div>`
					);
				}
			}
		}
	});

	$('.items-list').on('click', '.fas.fa-minus', function() {
		let input = $(this).siblings('input[type="number"]');
		let currentValue = parseInt(input.val(), 10);
		
		if (currentValue > 1) {
			input.val(currentValue - 1);

			let itemContainer = $(this).closest('.item');
			let itemId = itemContainer.attr('itemid');

			itemContainer.find('.item-price').text(`${(items[itemId].price * input.val()).toLocaleString()} ${payments[items[itemId].priceType]}`);
		}
	});
	
	$('.items-list').on('click', '.fas.fa-plus', function() {
		let input = $(this).siblings('input[type="number"]');
		let currentValue = parseInt(input.val(), 10);

		let maxValue = parseInt(input.attr('max'), 10);

		if (!isNaN(maxValue) && currentValue < maxValue) {
			input.val(currentValue + 1);

			let itemContainer = $(this).closest('.item');
			let itemId = itemContainer.attr('itemid');

			itemContainer.find('.item-price').text(`${(items[itemId].price * input.val()).toLocaleString()} ${payments[items[itemId].priceType]}`);
		}
	});

	$('.items-list').on('input', 'input[type="number"]', function() {
		let sanitizedValue = $(this).val().replace(/[^\d]|^0+(?=\d)/g, '');
		$(this).val(sanitizedValue);

		let inputValue = parseInt($(this).val(), 10);

		if (isNaN(inputValue) || inputValue < 1) {
			$(this).val(1);
		}

		let maxValue = parseInt($(this).attr('max'), 10);

		if (!isNaN(maxValue) && inputValue > maxValue) {
			$(this).val(maxValue);
		}
		
		let itemContainer = $(this).closest('.item');
		let itemId = itemContainer.attr('itemid');

		itemContainer.find('.item-price').text(`${(items[itemId].price * $(this).val()).toLocaleString()} ${payments[items[itemId].priceType]}`);
	});

	$('.items-list').on('click', '.btn.purchase', function() {
		let itemContainer = $(this).closest('.item');
		let name = itemContainer.attr('itemname');
		let count = parseInt(itemContainer.find('input[type="number"]').val(), 10);

		if (count > 0 && !isBusy) {
			isBusy = true;
			$.post(`https://${GetParentResourceName()}/buy`, JSON.stringify({name: name, count: count, job: activeJob}));
		}
	});

	$('.items-list').on('click', '.btn.remove-item', function() {
		let itemContainer = $(this).closest('.item');
		let name = itemContainer.attr('itemname');

		$.post(`https://${GetParentResourceName()}/change_price`, JSON.stringify({name: name, job: activeJob}));
		HideAll();
	});
	
	document.onkeyup = function(event) {
		if (event.key == 'Escape') {
			$.post(`https://${GetParentResourceName()}/quit`, JSON.stringify({}));
			HideAll();
		}
	};
});

async function SelectShop(job, cooldown = 500) {
	if (isBusy) {
		return;
	}
	
	isBusy = true;

	const response = await fetch(`https://${GetParentResourceName()}/get_items`, {
		method: 'POST',
		body: JSON.stringify({job: job})
	});

	items = await response.json();

	$('.bazzar').removeClass('active');
	$(`#${job}`).addClass('active');

	activeJob = job;
	$('.search-item').val(``);

	$('.items-list').html(``);

	let changePriceHtml = ``;

	if (jobData.name == activeJob && jobData.grade_name == 'boss') {
		$('.btn.restock').show();
		changePriceHtml = `<div class="btn remove-item">CHANGE PRICE</div>`;
	}
	else {
		$('.btn.restock').hide();
	}

	for (let i = 0; i < items.length; i++) {
		$('.items-list').append(`
			<div itemid="${i}" itemname="${items[i].name}" class="item">
				<div class="item-label">${items[i].label}</div>
				<div class="item-count">x${items[i].count}</div>
				<div class="item-image" style="background:url(nui://esx_inventoryhud_matza/html/img/items/${GetImageName(items[i].name)}.png)"></div>
				<div class="item-price">${items[i].price.toLocaleString()} ${payments[items[i].priceType]}</div>
				<div class="controls"> <i class="fas fa-minus"></i><input type="number" value="1" min="1" max="${items[i].count}" /> <i class="fas fa-plus"></i> </div>
				<div class="btn purchase">PURCHASE</div>
				${changePriceHtml}
			</div>`
		);
	}

	setTimeout(function () {
		isBusy = false;
	}, cooldown);
}

function HideAll() {
	$('#body').hide();
	$('.bazzars-list').hide();

	$('.bazzars-list').html(``);
	$('.items-list').html(``);

	isBusy = false;
	activeJob = null;
	jobData = null;
	payments = null;
	autosellers = null;
	items = null;
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