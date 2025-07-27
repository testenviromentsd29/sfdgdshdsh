const monthNames = ["January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December"
];
const dayOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

var CurrentGang

$(function () {
    window.addEventListener('message', function (event) {
        var action = event.data.action;
        var data = event.data.data
        if (action == "show") {
            // Set UI elements and open it
            //   document.getElementById("station-price-litre").innerHTML = '$' + data.fuelPricePerLiter;
            CurrentGang = data.gang;
            let background = CurrentGang.replace('official', '')

            document.getElementById("wrap").className = background + "-bg";
            document.getElementById("side-img").className = background;

            document.getElementById("hood-owner").className = data.gang + "-name";
            document.getElementById("hood-owner").innerHTML = data.owner.toUpperCase();

            document.getElementById("gang-name").innerHTML = 'Gang War <span class="' + data.gang + '-name">' + data.owner + '</span>';

            document.getElementById("controlled-by-name").innerHTML = data.controlledBy;

            document.getElementById("cashout-money").innerHTML = '$ '+data.money;
            if (data.CanTakeMoney){
                $('#btn-cashout').show();
                $('#btn-weapons').show();
            }else{
                $('#btn-cashout').hide();
                $('#btn-weapons').hide();
            }
            if (data.CanRespawnCar){
                $('#btn-respawn').show();
            }else{
                $('#btn-respawn').hide();
            }

            var date = getNextDay(data.date.day);
            if (data.date.minute<10) {
                data.date.minute = '0'+data.date.minute
            }
            document.getElementById("next-gang-war").innerHTML = 'Next Gang War will take place on <span>' + dayOfWeek[data.date.day] + ' ' + date.getDate() + ' ' + monthNames[date.getMonth()] + ' at ' + data.date.hour + ':' + data.date.minute + '</span>';

            var defenders = data.defenders;
            var attackers = data.attackers;

            let attackerHTML = '';
            attackerHTML += `<div id="strain-scrollable"><table><tr><th class="no">No</th><th class="name">Attacker</th><th>Members</th></tr>`;
            let i = 1;
            attackers.forEach(element => {
                attackerHTML += `<tr><td>`+i+`.</td><td>`+element.name+`</td><td>`+element.memberCount+`</td></tr>`;
                i = i+1;
            });	
            attackerHTML += `</table></div><button id="btn-register-attacker" onclick='RegisterAttacker("`+data.gang+`")'><i class="fas fa-swords"></i> REGISTER AS ATTACKER</button>`;
        
            $("#list-attackers").empty().append(attackerHTML);

            let defenderHTML = '';
            defenderHTML += `<div id="strain-scrollable"><table><tr><th class="no">No</th><th class="name">Defender</th><th>Members</th></tr>`;
            i = 1;
            defenders.forEach(element => {
                defenderHTML += `<tr><td>`+i+`.</td><td>`+element.name+`</td><td>`+element.memberCount+`</td></tr>`;
                i = i+1;
            });	
            defenderHTML += `</table></div><button id="btn-register-defender" onclick='RegisterDefender("`+data.gang+`")'><i class="far fa-shield-alt"></i> REGISTER AS DEFENDER</button>`;
            $("#list-defenders").empty().append(defenderHTML);


            $('#wrap').fadeIn();
        } else if (action == "onCloseMenu") {
            $('#wrap').fadeOut();
        } else if (action == "notify") {
            document.getElementById("event-wrap").className = data.gang ;
            document.getElementById("event-description").innerHTML = data.owner + " Raid will take place tonight at "+data.time.hour+":"+data.time.minute.toLocaleString('en-US', {
                minimumIntegerDigits: 2,useGrouping: false})+", get your team and register now and fight for the "+data.owner+" Hood.";
            document.getElementById("event-title").innerHTML = data.owner.toUpperCase() + " RAID";
            $('#event-wrap').fadeIn();
        } else if (action == "notifyClose") {
            $('#event-wrap').fadeOut();
        } else if (action == "showTabMessage") {
            $('#bottom-left-wrap').fadeIn();
        } else if (action == "closeTabMessage") {
            $('#bottom-left-wrap').fadeOut();
        } else if (action == "openScoreboard") {
            SetScoreBoard(data);
            $('#wrap-gang-ranking').fadeIn(100);
        } else if (action == "closeScoreboard") {
            $('#wrap-gang-ranking').fadeOut(100);
        }
    });

    document.onkeyup = function (event) {
        if (event.key == 'Escape') {
            $('#wrap').fadeOut();
            // $('#wrap-gang-ranking').fadeOut();
            $.post('https://gang_wars/onCloseMenu', JSON.stringify({}));
        }
    };
});

function RegisterAttacker(gang) {
    $.post('https://gang_wars/registerAttacker', JSON.stringify({gang: gang}));
}

function RegisterDefender(gang) {
    $.post('https://gang_wars/registerDefender', JSON.stringify({gang: gang}));
}

function Cashout() {
    $.post('https://gang_wars/cashout', JSON.stringify({gang: CurrentGang}));
}

function Weapons() {
    $.post('https://gang_wars/weapons', JSON.stringify({gang: CurrentGang}));
}

function RespawnCars() {
    $.post('https://gang_wars/respawnCars', JSON.stringify({gang: CurrentGang}));
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
    $("#killsandbounty").html(`Your Gang War Points: <span>`+data.mypoints+`</span>`)
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