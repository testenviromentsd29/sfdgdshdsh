let dealer = null;
let vehicles = null;
let isBusy = false;
let selectedVehicle = null;
let discount = 0;

$(function() {
	window.addEventListener('message', function(event) {
		if (event.data.action == 'show') {
			dealer = event.data.dealer;
			vehicles = event.data.vehicles;
			discount = event.data.discount;

			$('.color-pallete').html('');

			for (let i = 0; i < event.data.colors.length; i++) {
				$('.color-pallete').append(`<div class="color" color_id="${i}" style="background-color: ${event.data.colors[i].hex};"></div>`);
			}

			$('.color-pallete .color').click(function() {
				let color = $(this).attr('color_id');
				$.post('https://esx_cardealer/color', JSON.stringify({color: Number(color) + 1}));
			});

			$('.categories-btns').html('');

			$.each(vehicles, function(index, data) {
				$('.categories-btns').append(`<div id="category-${index.replace(/\s/g, "")}" class="category">${index}</div>`);
			});

			$('.categories-btns .category').click(function() {
				SelectCategory($(this).text());
			});

			$.each(vehicles, function(index, data) {
				SelectCategory(index);
				return false;
			});

			$('#body').show();
		}
		else if (event.data.action == 'test_drive_end') {
			isBusy = false;
			$('#body').show();
		}
    });

	$('.test-drive-btn').click(function() {
		if (isBusy) {
			return;
		}

		isBusy = true;

		$('#body').hide();
		$.post('https://esx_cardealer/test_drive', JSON.stringify({dealer: dealer, name: selectedVehicle}));
	});

	$('.buy-btn').click(function() {
		if (isBusy) {
			return;
		}

		$.post('https://esx_cardealer/buy', JSON.stringify({dealer: dealer, name: selectedVehicle}));

		dealer = null;
		vehicles = null;
		isBusy = false;
		selectedVehicle = null;
		discount = 0;

		$('#body').hide();

		$('.categories-btns .category').off('click');
		$('.color-pallete .color').off('click');
		$('.list-of-cars .car').off('click');

		$('.color-pallete').html('');
		$('.categories-btns').html('');
		$('.list-of-cars').html('');
		$('.tech-specs').html('');
	});

	$('#body').bind('mousewheel', function(e) {
		let target = $(e.target).closest('#item-list');
		let secondTarget = $(e.target).closest('.categories-btns');

		if (target.length > 0 || secondTarget.length > 0) {
			return;
		}
		
		if(e.originalEvent.wheelDelta /120 > 0) {
			$.post('https://esx_cardealer/zoom', JSON.stringify({zoom: true}));
		}
		else {
			$.post('https://esx_cardealer/zoom', JSON.stringify({zoom: false}));
		}
	});
	
	document.onkeyup = function(event) {
		if (event.key == 'Escape') {
			if (isBusy) {
				return;
			}

			dealer = null;
			vehicles = null;
			isBusy = false;
			selectedVehicle = null;
			discount = 0;

			$('#body').hide();

			$('.categories-btns .category').off('click');
			$('.color-pallete .color').off('click');
			$('.list-of-cars .car').off('click');

			$('.color-pallete').html('');
			$('.categories-btns').html('');
			$('.list-of-cars').html('');
			$('.tech-specs').html('');

			$.post('https://esx_cardealer/quit', JSON.stringify({}));
		}
	};
});

function FormatPrice(price, type) {
	switch(type) {
		case 'white':
			price = Math.ceil(price - (price * discount / 100));
			return `<span style="color: lightgreen;">$${price}</span>`;
		case 'black':
			price = Math.ceil(price - (price * discount / 100));
			return `<span style="color: #FF6666;">$${price}</span>`;
		case 'dc':
			return `<span style="color: #FFFFCC;">${price} DC</span>`;
		case 'gm':
			return `<span style="color: #FFCC99;">${price} GM</span>`;
	}
}

function SelectCategory(category) {
	if (isBusy) {
		return;
	}

	$('.category').removeClass('active');
	$('#category-' + category.replace(/\s/g, "")).addClass('active');

	$('.list-of-cars').html('');

	$.each(vehicles[category], function(index, data) {
		$('.list-of-cars').append(`
			<div id="model-${index}" class="car">
				<div class="car-name">${index}</div>
				<div class="car-price">${FormatPrice(data.price, data.money_type)}</div>
			</div>`
		);
	});

	$('.list-of-cars .car').click(function() {
		SelectVehicle($(this).find('.car-name').text());
	});

	$.each(vehicles[category], function(index, data) {
		SelectVehicle(index);
		return false;
	});
}

async function SelectVehicle(name) {
	if (isBusy) {
		return;
	}

	isBusy = true;
	selectedVehicle = name;

	$('.car').removeClass('active');
	$('#model-'+ name).addClass('active');

	const response = await fetch('https://esx_cardealer/preview', {
		method: 'POST',
		body: JSON.stringify({dealer: dealer, name: name})
	});
	
	let stats = await response.json();

	$('.tech-specs').html('');

	for (let i = 0; i < stats.length; i++) {
		$('.tech-specs').append(`
			<div class="info-container">
				<div class="info">
					<div class="label">${stats[i].label}</div>
					<div class="value">${stats[i].value}</div>
				</div>
				<div class="progress-bar">
					<div class="progress" style="width: ${stats[i].percentage}%;"></div>
				</div>
			</div>`
		);
	}

	isBusy = false;
}