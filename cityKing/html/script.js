var CurrentArea

$(function () {
    window.addEventListener('message', function (event) {
        var action = event.data.action;
        var data = event.data.data
        if (action == "show") {
            // Set UI elements and open it
            CurrentArea = data.area;

            document.getElementById("wrap").className = data.area + "-bg";

            document.getElementById("side-zone-name").className = data.area + "-name";
            document.getElementById("side-zone-name").innerHTML = data.area.toUpperCase();

            document.getElementById("zone-name").innerHTML = '<img src="./images/crown.png"/> King of ' + data.area.charAt(0).toUpperCase() + data.area.slice(1) + ' <span class="' + data.area + '-name">' + data.controlledBy + '</span>';

            document.getElementById("controlled-by-name").innerHTML = data.controlledBy;

            document.getElementById("cashout-money").innerHTML = '$ '+data.money + '<br>';
            if (data.CanTakeMoney){
                $('#btn-cashout').show();
            }else{
                $('#btn-cashout').hide();
            }

            //Load event date
            if (data.date.startMinute<10 && data.date.startMinute != 00) {
                data.date.startMinute = '0'+data.date.startMinute;
            }
			if (data.date.startMinute == 0) {
				data.date.startMinute = '00';
			}
            document.getElementById("next-gang-war").innerHTML = 'Next King of the ' + data.area.charAt(0).toUpperCase() + data.area.slice(1) + ' will take place on <span>' + data.date.day + ' at ' + data.date.startHour + ':' + data.date.startMinute + '</span>';

            //Load attackers list
            var attackers = data.attackers;
            let attackerHTML = '';
            attackerHTML += `<div id="strain-scrollable"><table><tr><th class="no">No</th><th class="name">Attackers</th><th>Members</th></tr>`;
            let i = 1;
            attackers.forEach(element => {
                attackerHTML += `<tr><td>`+i+`.</td><td>`+element.name+`</td><td>`+element.memberCount+`</td></tr>`;
                i = i+1;
            });	
            attackerHTML += `</table></div><button id="btn-register-attacker" onclick='RegisterAttacker("`+data.area+`")'><i class="fas fa-swords"></i> REGISTER AS ATTACKER</button>`;
            $("#list-attackers").empty().append(attackerHTML);


            //Load defenders list
            var defenders = data.defenders;
            let defenderHTML = '';
            defenderHTML += `<div id="strain-scrollable"><table><tr><th class="no">No</th><th class="name">Defender</th><th>Members</th></tr>`;
            i = 1;
            defenders.forEach(element => {
                defenderHTML += `<tr><td>`+i+`.</td><td>`+element.name+`</td><td>`+element.memberCount+`</td></tr>`;
                i = i+1;
            });	
            //defenderHTML += `</table></div><button id="btn-register-defender" onclick='RegisterDefender("`+data.area+`")'><i class="far fa-shield-alt"></i> REGISTER AS DEFENDER</button>`;
            $("#list-defenders").empty().append(defenderHTML);


            $('#wrap').fadeIn();
        } else if (action == "onCloseMenu") {
            $('#wrap').fadeOut();
        } else if (action == "notify") {
            document.getElementById("event-wrap").className = data.area ;
            document.getElementById("event-description").innerHTML = "Rule " + data.event + " will take place at "+data.time.hour+":"+data.time.minute.toLocaleString('en-US', {
                minimumIntegerDigits: 2,useGrouping: false})+", get your team ready and fight for the "+data.event+".";
            document.getElementById("event-title").innerHTML = data.event.toUpperCase();
            $('#event-wrap').fadeIn();
        } else if (action == "notifyClose") {
            $('#event-wrap').fadeOut();
        } else if (action == "showTabMessage") {
            $('#bottom-left-wrap').fadeIn();
        } else if (action == "closeTabMessage") {
            $('#bottom-left-wrap').fadeOut();
        } else if (action == "openScoreboard") {
            SetScoreBoard(data);
            $('#wrap-gang-ranking').fadeIn();
        } else if (action == "closeScoreboard") {
            $('#wrap-gang-ranking').fadeOut();
        }else if (action == "showTime") {
            $('#event-timer-wrap').show();
            this.document.getElementById('time-left-text').innerHTML = event.data.time
        } else if (action == "hideTime") {
            $('#event-timer-wrap').hide();
        }
    });

    document.onkeyup = function (event) {
        if (event.key == 'Escape') {
            $('#wrap').fadeOut();
			$('#wrap-gang-ranking').fadeOut();
            $.post('https://cityKing/onCloseMenu', JSON.stringify({}));
        }
    };
});

function RegisterAttacker(area) {
    $.post('https://cityKing/registerAttacker', JSON.stringify({area: area}));
}

function RegisterDefender(area) {
    $.post('https://cityKing/registerDefender', JSON.stringify({area: area}));
}

function Cashout() {
    $.post('https://cityKing/cashout', JSON.stringify({area: CurrentArea}));
}

function getNextDay(day) {
    var dayIndex = day

    var returnDate = new Date();
    var returnDay = returnDate.getDay();
    if (dayIndex !== returnDay) {
        returnDate.setDate(returnDate.getDate() + (dayIndex + (7 - returnDay)) % 7);
    }

    return returnDate;
}

function SetScoreBoard(data) {
    $("#killsandbounty").html(`Your Kills: <span>`+data.mypoints+`</span>`)
    var table1 = data.scoreboard;
    table1.sort(function(a, b) {
        return b.kills - a.kills;
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
                $("#scoreTable").append(`<tr class="first"><th class="position first">1</th><th class="name first">`+table1[i].label+`</th><th class="points first">`+table1[i].kills+`</th></tr>`);
            } else if ((i+1-substract) == 2){
                $("#scoreTable").append(`<tr class="second"><th class="position second">2</th><th class="name second">`+table1[i].label+`</th><th class="points second">`+table1[i].kills+`</th></tr>`);
            }else if ((i+1-substract) == 3){
                $("#scoreTable").append(`<tr class="third"><th class="position third">3</th><th class="name third">`+table1[i].label+`</th><th class="points third">`+table1[i].kills+`</th></tr>`);
            }else{
                $("#scoreTable").append(`<tr><th class="position">`+(i+1-substract)+`</th><th class="name">`+table1[i].label+`</th><th class="points">`+table1[i].kills+`</th></tr>`);
            }
            
            if ((i+1-substract) == 10){
                break;
            } 					
        }
    }
}