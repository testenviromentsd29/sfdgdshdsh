/* shops below */


var prices = {}
var maxes = {}
var zone = null
var objects = {}
var currentShop = null;

// Partial Functions
function closeMain() {
    $("body").css("display", "none");
    $(".full-screen").css("display", "none");
    $(".shop-container").css("display", "none");
}
function openMain() {
    $("body").css("display", "block");
    $(".full-screen").css("display", "block");
    $(".shop-container").css("display", "block");
    
}
function closeAll() {
    $("body").css("display", "none");
    $(".full-screen").css("display", "none");
    $(".shop-container").css("display", "none");
}
$(".close").click(function(){
    $.post('http://agora/quit', JSON.stringify({}));
    $(".full-screen").css("display", "none");
    $(".shop-container").css("display", "none");
});

// Listen for NUI Events
window.addEventListener('message', function (event) {

    var item = event.data;
   

	// Open & Close main window
	if (item.message == "dd") {
        $( ".home" ).empty();
        prices = {}
        maxes = {}
    }
	if (item.message == "show") {
		if (item.clear == true){
			$( ".home" ).empty();
			prices = {}
			maxes = {}
			zone = null
		}
		openMain();
	}

	if (item.message == "hide") {
		closeMain();
	}
	
	currentShop = item.message;
	
	if (item.message == "sell"){
        var appendstr = '<div class="card card-sell">' +
            '<div class="image-holder">' +
                '<img src="nui://esx_inventoryhud_matza/html/img/items/' + item.item + '.png" onerror="this.src = \'img/default.png\'" alt="' + item.label + '">' + 
            '</div>' +
            '<div class="container">' + 
                '<div class="item-name item-name-sell">' + item.label + '</div>';
                if (item.useBlack == true){
                    appendstr = appendstr+'<div class="price-black">' + parseInt(item.price) * parseInt(item.quantity) + '$' + '</div>'
                }else{
                    appendstr = appendstr+'<div class="price">' + parseInt(item.price) * parseInt(item.quantity) + '$' + '</div>'
                }
                
                appendstr = appendstr+'<div class="quantity">' + 
                '<div class="minus-btn btnquantity" name="' + item.item + '" id="minus">' + 
                    '<i class="fas fa-minus"></i>' + 
                '</div>' +
                `<input type="number" class="control-button" id="count" value="`+parseInt(item.quantity)+`" min="0"></input>` + 
                '<div class="plus-btn btnquantity" name="' + item.item + '" id="plus">' + 
                    '<i class="fas fa-plus"></i>' + 
                '</div>' +
            '</div>' +
            '<div class="purchase">' + 
				
                '<div class="buy sell" name="' + item.item + '">Sell</div>' + 
            '</div>' +
        '</div>' +
        '</div>';
		document.getElementById('inventory-title').html = 'SELL ITEMS';
		$( ".home" ).append(appendstr);
        prices[item.item] = item.price;
        if (item.max == undefined){
            maxes[item.item] = 1000;
        }else{
            maxes[item.item] = item.max;
        }
       
        objects[item.item] = item.itemsObject;
		zone = item.loc;
	}
	else if(item.message == "buy"){
		var appendstr = '<div class="card">' +
            '<div class="image-holder">' +
                '<img src="nui://esx_inventoryhud_matza/html/img/items/' + item.item + '.png" onerror="this.src = \'img/default.png\'" alt="' + item.label + '">' + 
            '</div>' +
            '<div class="container">' + 
                '<div class="item-name">' + item.label + '</div>';
                if (item.useBlack == true){
                    appendstr = appendstr+'<div class="price-black">' + parseInt(item.price) * parseInt(item.quantity) + '$' + '</div>'
                }else{
                    appendstr = appendstr+'<div class="price">' + parseInt(item.price) * parseInt(item.quantity) + '$' + '</div>'
                }
                
                appendstr = appendstr+'<div class="quantity">' + 
                '<div class="minus-btn btnquantity" name="' + item.item + '" id="minus">' + 
                    '<i class="fas fa-minus"></i>' + 
                '</div>' +
                
                `<input type="number" class="control-button" id="count" value="0" min="0"></input>` + 
                '<div class="plus-btn btnquantity" name="' + item.item + '" id="plus">' + 
                    '<i class="fas fa-plus"></i>' + 
                '</div>' +
            '</div>' +
            '<div class="purchase">' + 
				
                '<div class="buy" name="' + item.item + '">Buy</div>' + 
            '</div>' +
        '</div>' +
        '</div>';
		document.getElementById('inventory-title').html = 'BUY ITEMS';
		$( ".home" ).append(appendstr);
        prices[item.item] = item.price;
        if (item.max == undefined){
            maxes[item.item] = 1000;
        }else{
            maxes[item.item] = item.max;
        }
       
        objects[item.item] = item.itemsObject;
		zone = item.loc;
		openMain();
	}
	
	document.onkeyup = function(event) {
		if (event.key == 'Escape') {
			$.post('http://agora/quit', JSON.stringify({}));
			$(".shop-container").css("display", "none");
		}
	};
});



$(".home").on("click", ".btnquantity", function() {
	var $button = $(this);
	var $name = $button.attr('name');
    var oldValue = $button.parent().find(".control-button").val();

	if ($button.get(0).id == "plus") {
		if (oldValue <  maxes[$name]){
			var newVal = parseFloat(oldValue) + 1;
		}else{
			var newVal = parseFloat(oldValue);
		}
	} else {
	// Don't allow decrementing below zero
		if (oldValue > 1) {
			var newVal = parseFloat(oldValue) - 1;
		} else {
			newVal = 1;
		}
	}
    $button.parent().parent().find(".price").text((prices[$name] * newVal) + "$");
    $button.parent().parent().find(".price-black").text((prices[$name] * newVal) + "$");

	$button.parent().find(".control-button").val(newVal);

});


$(".home").on("click", ".buy", function() {
	var $button = $(this);
	var $name = $button.attr('name')
    var $count = parseFloat($button.parent().parent().find(".control-button").val());
    var myobject = objects[$name];
    var myprice = prices[$name];
	$.post('http://agora/'+currentShop+'Item', JSON.stringify({
		item: $name,
        count: $count,
        price: myprice,
        zone: zone,
        object: myobject,
	}));
});









$(".home").on("click", "#toquantityax", function() {
    var $button = $(this);
	var $name = $button.attr('name');
    var $count = parseFloat($button.parent().parent().find(".number").text());
    var myobject = objects[$name];
    var myprice = prices[$name];

	$.post('http://agora/addQuantityBuy', JSON.stringify({
		item: $name,
        count: $count,
        price: myprice,
        setjob: zone,
        object: myobject,
	}));
});