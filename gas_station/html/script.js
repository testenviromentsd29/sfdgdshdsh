let $Maxquantity = 100;
let MaxRepairKits = 50;

let GasolinePrice = 0
let RepairKitPrice = 0
let CanisterPrice = 0

/*GASOLINE PRICE*/
$(document).ready(function () {
    $("#gasoline-input").on("input", "#quantity-liter", function () {
        
        var price = +$("#station-price-litre").data("liter-price");
        $(this).val(parseInt(+$(this).val()));
        var quantity = +$(this).val();
        if (quantity > $Maxquantity){
            quantity = $Maxquantity;
            $(this).val($Maxquantity);
        }
        if (quantity < 0){
            quantity = 0;
            $(this).val(0);
        }
        GasolinePrice = price * quantity
        $("#gasoline-price").text("$" + GasolinePrice.toFixed(2));
        UpdateTotalPrice()
    })


    var $buttonPlus = $('#increase-btn-liter');
    var $buttonMin = $('#decrease-btn-liter');
    var $quantity = $('#quantity-liter');
    var $buttonMax = $('#max-btn-liter');

    /*For plus and minus buttons*/
    $buttonPlus.click(function () {
        $quantity.val(parseInt($quantity.val()) + 1).trigger('input');
    });

    $buttonMin.click(function () {
        $quantity.val(Math.max(parseInt($quantity.val()) - 1, 0)).trigger('input');
    });

    $buttonMax.click(function () {
        $quantity.val(parseInt($Maxquantity)).trigger('input');
    });
})


/*REPAIR KIT PRICE*/
$(document).ready(function () {
    $("#repair-input").on("input", "#quantity-repair", function () {
        var price = +$("#station-price-repair").data("repair-price");
        $(this).val(parseInt(+$(this).val()));
        var quantity = +$(this).val();
        if (quantity > MaxRepairKits){
            quantity = MaxRepairKits;
            $(this).val(MaxRepairKits);
        }
        if (quantity < 0){
            quantity = 0;
            $(this).val(0);
        }
        RepairKitPrice = price * quantity
        $("#repair-price").text("$" + RepairKitPrice);
        UpdateTotalPrice()
    })

    var $buttonPlus = $('#increase-btn-repair');
    var $buttonMin = $('#decrease-btn-repair');
    var $quantity = $('#quantity-repair');

    /*For plus and minus buttons*/
    $buttonPlus.click(function () {
        $quantity.val(parseInt($quantity.val()) + 1).trigger('input');
    });

    $buttonMin.click(function () {
        $quantity.val(Math.max(parseInt($quantity.val()) - 1, 0)).trigger('input');
    });
})

/*CANISTER PRICE*/
$(document).ready(function () {
    $("#canister-input").on("input", "#quantity-canister", function () {
        var price = +$("#station-price-canister").data("canister-price");
        $(this).val(parseInt(+$(this).val()));
        var quantity = +$(this).val();
        if (quantity > 1){
            quantity = 1;
            $(this).val(1);
        }
        if (quantity < 0){
            quantity = 0;
            $(this).val(0);
        }
        CanisterPrice = price * quantity;
        $("#canister-price").text("$" + CanisterPrice);
        UpdateTotalPrice()
    })

    var $buttonPlus = $('#increase-btn-canister');
    var $buttonMin = $('#decrease-btn-canister');
    var $quantity = $('#quantity-canister');

    /*For plus and minus buttons*/
    $buttonPlus.click(function () {
        $quantity.val(parseInt($quantity.val()) + 1).trigger('input');
    });

    $buttonMin.click(function () {
        $quantity.val(Math.max(parseInt($quantity.val()) - 1, 0)).trigger('input');
    });
})

/*SET OWNER PRICES*/
$(document).ready(function () {
    $("#owner-gasoline-price").on("input", function () {
        var price = +$(this).val();
        $(this).val(+price.toFixed(2));
        if (price <= 0){
            price = 0;
            $(this).val(0);
        }
    })
    $("#owner-canister-price").on("input", function () {
        var price = +$(this).val();
        $(this).val(parseInt(price));
        if (price <= 0){
            price = 0;
            $(this).val(0);
        }
    })
    $("#owner-repair-kit-price").on("input", function () {
        var price = +$(this).val();
        $(this).val(parseInt(price));
        if (price <= 0){
            price = 0;
            $(this).val(0);
        }
    })
})

function UpdateTotalPrice(){
    var totalPrice = GasolinePrice + CanisterPrice + RepairKitPrice
    document.getElementById("total-price").innerHTML = '$'+totalPrice.toFixed(1);
}

function PlaceOrder(){
    var orderdata = {};
    orderdata.gasoline = $("#quantity-liter").val();
    orderdata.repairkits = $("#quantity-repair").val();
    orderdata.gascanister = $("#quantity-canister").val();
    $.post('https://gas_station/placeOrder', JSON.stringify({order: orderdata}));
}

function BuyPremium(){
    $.post('https://gas_station/buyPremium', JSON.stringify({}));
}

function SellPremium(){
    $.post('https://gas_station/sellPremium', JSON.stringify({}));
}

function RefillStation(){
    $.post('https://gas_station/refillStation', JSON.stringify({}));
}

function SetPriceGasoline(){
    var price = $("#owner-gasoline-price").val();
    $.post('https://gas_station/setPrice', JSON.stringify({priceType:'gasoline', price: price}));
    document.getElementById("confirm-gasoline").disabled = true;
    setTimeout(function(){document.getElementById("confirm-gasoline").disabled = false;},2000);
}

function SetPriceCanister(){
    var price = $("#owner-canister-price").val();
    $.post('https://gas_station/setPrice', JSON.stringify({priceType:'canister', price: price}));
    document.getElementById("confirm-canister").disabled = true;
    setTimeout(function(){document.getElementById("confirm-canister").disabled = false;},2000);
}

function SetPriceRepairKit(){
    var price = $("#owner-repair-kit-price").val();
    $.post('https://gas_station/setPrice', JSON.stringify({priceType:'repair-kit', price: price}));
    document.getElementById("confirm-repair-kit").disabled = true;
    setTimeout(function(){document.getElementById("confirm-repair-kit").disabled = false;},2000);
}


$(function () {

    window.addEventListener('message', function (event) {
        var action = event.data.action;
        var data = event.data.data
        if (action == "show") {
            // Set UI elements, prices, etc and then open it
            $('#station-price-litre').data('liter-price',data.fuelPricePerLiter);
            document.getElementById("station-price-litre").innerHTML = '$' + data.fuelPricePerLiter;
            $('#station-price-repair').data('repair-price',data.repairKitPrice);
            document.getElementById("station-price-repair").innerHTML = '$' + data.repairKitPrice;
            $('#station-price-canister').data('canister-price',data.gasCanisterPrice);
            document.getElementById("station-price-canister").innerHTML = '$' + data.gasCanisterPrice;

            document.getElementById("station-owner").innerHTML = data.owner;
            document.getElementById("station-name").innerHTML = data.name;
            document.getElementById("station-controlled").innerHTML = data.controlled;

            if (!data.dontRemoveInput){
                $("#quantity-repair").val(0);
            }
            $("#quantity-repair").trigger('input');
            if (!data.dontRemoveInput){
                $("#quantity-canister").val(0);
            }
            $("#quantity-canister").trigger('input');
            if (!data.dontRemoveInput){
                $("#quantity-liter").val(0);
            }
            if (data.inVehicle) {
                $Maxquantity = data.vehicleFuelMissing
                $('#gasoline-block').show();
                $("#quantity-liter").val(data.vehicleFuelMissing);
                document.getElementById("owner-panel-block").style.marginTop = '-189px';
            }else {
                $Maxquantity = 0.0
                $('#gasoline-block').hide();
                document.getElementById("owner-panel-block").style.marginTop = '-30px';
            }
            $("#quantity-liter").trigger('input');

            if (data.showOwnerPanel){
                $('#owner-panel-block').show();
                document.getElementById("tanker-capacity-amount").innerHTML = data.fuelQuantity + ' / ' + data.fuelMaxCapacity + ' lt';
                $("#owner-gasoline-price").val(data.fuelPricePerLiter);
                $("#owner-canister-price").val(data.gasCanisterPrice);
                $("#owner-repair-kit-price").val(data.repairKitPrice);
            }else {
                $('#owner-panel-block').hide();
            }

            $('#wrap').fadeIn();
        }else if (action == "onCloseMenu") {
            $('#wrap').fadeOut();
        }else if (action == "updatePrices") {
            $('#wrap').fadeOut();
        }
    });

    document.onkeyup = function (event) {
        if (event.key == 'Escape') {
            $('#wrap').fadeOut();
            $.post('https://gas_station/onCloseMenu', JSON.stringify({}));
        }
    };
});