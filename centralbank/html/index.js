$(function () {
	window.addEventListener('message', function (event) {
		if (event.data.action == 'show') {
            $("#event-description").html(`The Event in Central Bank will begin at ${event.data.hours}:${event.data.minute} and the reward is ${event.data.money} white money.`);
			document.getElementById("wrap").style.overflow = 'visible';
		}
		else if (event.data.action == 'hide') {
			document.getElementById("wrap").style.overflow = 'hidden';
		}
		else if (event.data.action == 'showScore') {
			MyScore(event.data.info, event.data.kills)
			$('#wrap-central-ranking').fadeIn();
		}
		else if (event.data.action == 'hideScore') {
			$('#wrap-central-ranking').fadeOut();
		}
		else if (event.data.action == 'showTab') {
			$('#bottom-left-wrap').fadeIn();
		}
		else if (event.data.action == 'hideTab') {
			$('#bottom-left-wrap').fadeOut();
		}
	}, false);
});

function MyScore(data, kills) {
    $("#killsandbounty").html(`<font style="color:#fff">Your Team's Kills:</font> <span id="notwanted">`+kills+`</span>`);
    var table1 = data;
    
	table1.sort(function(a, b) {
        return b.points - a.points;
    });
	
    let tableBody = this.document.getElementById("scoreTable");
	
    tableBody.innerHTML = "<tr><th  class=\"position\">No</th><th class=\"name\">Name</th><th  class=\"points\">Kills</th></tr>";
    var itemsShowed = 0;
    var i;
    var substract = 0;
	
    for (i = 0; i < table1.length; i++) {
        if (table1[i] != undefined){
            itemsShowed++;
            if ((i+1-substract) == 1){
                $("#scoreTable").append(`<tr class="first"><th class="position first">1</th><th class="name first">`+table1[i].label+`</th><th class="points first">`+table1[i].points+`</th></tr>`);
            }
			else if ((i+1-substract) == 2){
                $("#scoreTable").append(`<tr class="second"><th class="position second">2</th><th class="name second">`+table1[i].label+`</th><th class="points second">`+table1[i].points+`</th></tr>`);
            }
			else if ((i+1-substract) == 3){
                $("#scoreTable").append(`<tr class="third"><th class="position third">3</th><th class="name third">`+table1[i].label+`</th><th class="points third">`+table1[i].points+`</th></tr>`);
            }
			else{
                $("#scoreTable").append(`<tr><th class="position">`+(i+1-substract)+`</th><th class="name">`+table1[i].label+`</th><th class="points">`+table1[i].points+`</th></tr>`);
            }
            
            if ((i+1-substract) == 10){
                break;
            } 					
        }
    }
}