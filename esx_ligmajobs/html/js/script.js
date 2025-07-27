$('document').ready(function() {

   
    ligmaProgBar = {};

    ligmaProgBar.Progress = function(data) {
        $("body").css("display", "block");
        $(".progress-container").css({"display":"block"});
        $("#progress-label").text(data.label);
        var colour;
        if (data.colour != undefined){
            colour = data.colour
        }else{
            colour = "#6cda13";
        }
        $("#progress-bar").stop().css({"width": 0, "background-color": colour}).animate({
          width: '100%'
        }, {
          duration: parseInt(data.duration),
          complete: function() {
            $(".progress-container").css({"display":"none"});
            $("#progress-bar").css("width", 0);
            $.post('http://esx_ligmajobs/actionFinish', JSON.stringify({
                })
            );
            $("body").css("display", "none");
          }
        });
    };

    ligmaProgBar.ProgressCancel = function() {
        $(".progress-container").css({"display":"block"});
        $("#progress-label").text("CANCELLED");
        $("#progress-bar").stop().css( {"width": "100%", "background-color": "#ff0000"});

        setTimeout(function () {
            $(".progress-container").css({"display":"none"});
            $("#progress-bar").css("width", 0);
            $.post('http://esx_ligmajobs/actionCancel', JSON.stringify({
                })
            );
            $("body").css("display", "none");
        }, 1000);
    };

    ligmaProgBar.CloseUI = function() {
        $('.main-container').css({"display":"none"});
        $(".character-box").removeClass('active-char');
        $(".character-box").attr("data-ischar", "false")
        $("#delete").css({"display":"none"});
    };

    window.addEventListener('message', function(event) {
        switch(event.data.action) {
            case 'ligma_progress':
                ligmaProgBar.Progress(event.data);
                break;
            case 'ligma_progress_cancel':
                ligmaProgBar.ProgressCancel();
                break;
        }
    })
    
    
});
$(function() {

	document.onkeyup = function(event) {
        console.log(event.key);
        if (event.key == 'Escape') {
            $.post('http://esx_ligmajobs/quit', JSON.stringify({}));
			$(".full-screen").css("display", "none");
            $(".shop-container").css("display", "none");
			
        }
    };
});


/* shops below */



var prices = {}
var maxes = {}
var zone = null
var objects = {}

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
    $(".body").css("display", "none");
	$(".full-screen").css("display", "none");
    $(".shop-container").css("display", "none");
}
$(".close").click(function(){
    $.post('http://esx_ligmajobs/quit', JSON.stringify({}));
	$(".full-screen").css("display", "none");
    $(".shop-container").css("display", "none");
});
// Listen for NUI Events
window.addEventListener('message', function (event) {

    var item = event.data;
   

	// Open & Close main window
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
	
	if (item.message == "add"){
	/* 	$( ".home" ).append(`
			<div class="card">
				<div class="image-holder"><img src="nui://esx_inventoryhud_matza/html/img/items/`+ GetImageName(item.item) +`.png"/></div>
				<div class="container">
					<div class="item-name">`+ item.label +`</div>
					<div class="price">`+ item.price +`$</div>
					<div class="quantity">
						<div class="minus-btn btnquantity" name="`+ item.item +`" id="minus"><i class="far fa-minus"></i></div>
						<div class="number" name="name">1</div>
						<div class="plus-btn btnquantity" name="`+ item.item +`" id="plus"><i class="far fa-plus"></i></div>
					</div>
					<div class="price-money">`+ item.price*100 +`$</div>
					<div class="quantity-money">
						<div class="minus-btn btnquantity" name="`+ item.item +`" id="minus"><i class="far fa-minus"></i></div>
						<div class="number" name="name">1</div>
						<div class="plus-btn btnquantity" name="`+ item.item +`" id="plus"><i class="far fa-plus"></i></div>
					</div>
					<div class="purchase">
						<div class="buy" name="`+ item.item +`" >Purchase</div>
					</div>
				</div>
			</div>`
		); */
        $( ".home" ).append(`
			<div class="card">
				<div class="image-holder"><img src="nui://esx_inventoryhud_matza/html/img/items/`+ GetImageName(item.item) +`.png"/></div>
				<div class="container">
					<div class="item-name">`+ item.label +`</div>
					<div class="price-money">`+ item.price +`$</div>
					<div class="quantity-money">
						<div class="minus-btn btnquantity" name="`+ item.item +`" id="minus"><i class="far fa-minus"></i></div>
						<div class="number control-button" name="name">1</div>
						<div class="plus-btn btnquantity" name="`+ item.item +`" id="plus"><i class="far fa-plus"></i></div>
					</div>
					<div class="purchase">
						<div class="buy" name="`+ item.item +`" >Purchase</div>
					</div>
				</div>
			</div>`
		);
		
        /*var appendstr = '<div class="card">' +
            '<div class="image-holder">' +
                '<img src="nui://esx_inventoryhud_matza/html/img/items/' + GetImageName(item.item) + '.png" onerror="this.src = \'img/default.png\'" alt="' + item.label + '">' + 
            '</div>' +
            '<div class="container">' + 
                '<div class="item-name">' + item.label + '</div>';
        if (item.itemsObject.useBlack == true){
            appendstr = appendstr+'<div class="price-black">' + item.price + ' GM Coins' + '</div>'
        }else{
            appendstr = appendstr+'<div class="price">' + item.price + ' GM Coins' + '</div>'
        }
        appendstr = appendstr+'<div class="quantity">' + 
                '<div class="minus-btn btnquantity" name="' + item.item + '" id="minus">' + 
                    '<i class="fas fa-minus"></i>' + 
                '</div>' +
                '<div class="number" name="name">1</div>' + 
                '<div class="plus-btn btnquantity" name="' + item.item + '" id="plus">' + 
                    '<i class="fas fa-plus"></i>' + 
                '</div>' +
            '</div>' +
            '<div class="purchase">' + 
                '<div class="buy" name="' + item.item + '">Buy</div>' + 
            '</div>' +
        '</div>' +
        '</div>';
		$( ".home" ).append(appendstr);*/
		
        prices[item.item] = item.price;
        if (item.max == undefined){
            maxes[item.item] = 1000;
        }else{
            maxes[item.item] = item.max;
        }
       
        objects[item.item] = item.itemsObject;
		zone = item.loc;
	}
	
	
});

/*$(".home").on("click", ".btnquantity", function() {
	var $button = $(this);
	var $name = $button.attr('name')
    var oldValue = $button.parent().find(".number").text();
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
    $button.parent().parent().find(".price").text((prices[$name] * newVal) + " GM Coins");
	$button.parent().find(".number").text(newVal);

});*/

$(".home").on("click", ".buy", function() {
	var $button = $(this);
	var $name = $button.attr('name')
    var $count = parseFloat($button.parent().parent().find(".number").text());
    var myobject = objects[$name];
    var myprice = prices[$name];
	$.post('http://esx_ligmajobs/purchase', JSON.stringify({
		item: $name,
        count: $count,
        price: myprice,
        setjob: zone,
        object: myobject,
	}));
});


/* youtube */


//YouTube IFrame API player.



var player;
var linkplaying;

//Create DOM elements for the player.
var tag = document.createElement('script');
tag.src = "https://www.youtube.com/iframe_api";

var ytScript = document.getElementsByTagName('script')[0];
ytScript.parentNode.insertBefore(tag, ytScript);



function onYouTubeIframeAPIReady()
{
    player = new YT.Player('player', {
        width: '1',
        height: '',
        playerVars: {
            'autoplay': 0,
            'controls': 0,
            'disablekb': 1,
            'enablejsapi': 1,
        },
        events: {
            'onReady': onPlayerReady,
            /*'onStateChange': onPlayerStateChange,  */
            'onError': onPlayerError
        }
    });
    
   
}

function onPlayerReady(event)
{
    $.post('http://esx_ligmajobs/loaded');
}

/*
function onPlayerStateChange(event)
{
    if(event.data == YT.PlayerState.PLAYING)
    {
        title = event.target.getVideoData().title;
    }

    if (event.data == YT.PlayerState.ENDED)
    {   
        if (musicIndex != undefined){
            musicIndex++;
        }
        
        play();
    }
}
 */
function onPlayerError(event)
{
    switch (event.data)
    {
        case 2:
            console.log("request contains an invalid parameter value" );
            break;
        case 5:
            console.log("The requested content cannot be played in an HTML5 player or another error related to the HTML5 player has occurred.");
        case 100:
            console.log("The video requested was not found. This error occurs when a video has been removed (for any reason) or has been marked as private." );
        case 101:
        case 150:
            console.log("Embedding for ideo id  was not allowed.");
            $.post('http://esx_ligmajobs/wrontytlink');
            break;
        default:
            console.log("An unknown error occured ");
    }

    skip();
}

function skip()
{
    play();
}

function play(id)
{    
    player.loadVideoById(id, 0, "tiny")
    player.playVideo();
    linkplaying = id;
}

function resume()
{
    player.playVideo();
}

function pause()
{
    player.pauseVideo();
}

function stop()
{
    player.stopVideo();
    linkplaying = undefined;
}

function setVolume(volume)
{
    player.setVolume(volume)
}



var ytName;
var item;
window.onload = function(e) {
    window.addEventListener('message', function(event) {
        party(event.data)
    });
} 

function party(data) {
    item = data;
    if (item !== undefined && item.type === 'radio')
    {	
        if (item.youtube){
            stop();
            play(item.radio);
            setVolume(item.volume);
            ytName = item.name;
        }
    }else if (item !== undefined && item.type === 'volume'){
        if (item.youtube){
            setVolume(item.volume);

        }   
        
    }else if (item !== undefined && item.type === 'stop'){
        console.log(item.link);
        console.log(linkplaying);
        if (item.link == linkplaying){
            stop();
        }
        
    }
    
    
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