window.addEventListener('message', function(event) {
	if (event.data.action == "showTime") {
		$('#event-timer-wrap').show();
		this.document.getElementById('time-left-text').innerHTML = event.data.time;
	} else if (event.data.action == "hideTime") {
		$('#event-timer-wrap').hide();
	} else if (event.data.action == "openScoreboard") {
		SetScoreBoard(event.data.data);
        $('#wrap-gang-ranking').fadeIn(100);
	} else if (event.data.action == "closeScoreboard") {
		$('#wrap-gang-ranking').fadeOut(100);
	}
});

function SetScoreBoard(data) {
    $("#killsandbounty").html(`<font style="color:#fff">Your Event Kills:</font> <span id="notwanted">`+data.mypoints+`</span>`)
    var table1 = data.scoreboard;
    table1.sort(function(a, b) {
        return b.points - a.points;
    });
    let tableBody = this.document.getElementById("scoreTable");
    tableBody.innerHTML = "<tr><th  class=\"position\">No</th><th class=\"name\">Name</th><th  class=\"points\">Points</th></tr>";
    var itemsShowed = 0;
    var i;
    var substract = 0;
    for (i = 0; i < table1.length; i++) {
        if (table1[i] != undefined){
            itemsShowed++;
            if ((i+1-substract) == 1){
                $("#scoreTable").append(`<tr class="first"><th class="position first">1</th><th class="name first">`+table1[i].label+`</th><th class="points first">`+table1[i].points+`</th></tr>`);
            } else if ((i+1-substract) == 2){
                $("#scoreTable").append(`<tr class="second"><th class="position second">2</th><th class="name second">`+table1[i].label+`</th><th class="points second">`+table1[i].points+`</th></tr>`);
            }else if ((i+1-substract) == 3){
                $("#scoreTable").append(`<tr class="third"><th class="position third">3</th><th class="name third">`+table1[i].label+`</th><th class="points third">`+table1[i].points+`</th></tr>`);
            }else{
                $("#scoreTable").append(`<tr><th class="position">`+(i+1-substract)+`</th><th class="name">`+table1[i].label+`</th><th class="points">`+table1[i].points+`</th></tr>`);
            }
            
            if ((i+1-substract) == 10){
                break;
            } 					
        }
    }
}