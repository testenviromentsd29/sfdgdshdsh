let notify = null;
var currentType = undefined;
$(function () {
	window.addEventListener('message', function (event) {
		if (event.data.action == 'showNotification') {
			$("#bottom-left-wrap").show();
			$("#highlight").html(event.data.text);

			if (event.data.type != 'firefighter') {
				var audio = new Audio('notify.mp3');
				audio.play();
			}

			notify = setTimeout(function() {
				$('#bottom-left-wrap').fadeOut();
			}, 4*1000); 
		}else if (event.data.action == "show"){
			currentType = event.data.job;
			showEmergency(currentType);
		}else if (event.data.action == "add"){
			currentType = event.data.job;
			var buttonText = "";
			if (currentType == "ambulance"){
				buttonText = "I need medical attention!";
			}else if(currentType == "police"){
				buttonText = "Help please!";
			}else if(currentType == "mechanic"){
				buttonText = "My car broke down!";
			}else if(currentType == "taxi"){
				buttonText = "PICK UP PASSENGER";
			} else if (currentType == "firefighter") {
				buttonText = "EXTINGUISH FIRE";
			}
			AddEmergency(event.data.job,event.data.name,event.data.distance,buttonText,"clickedEmergency",event.data.msg);
			
		}else if (event.data.action == "clear"){
			clearEmergencies();
		}else if (event.data.action == "remove"){
			currentType = event.data.job;
			deleteEmergencyByNumber(event.data.number);
		} else if (event.data.action == "coords") {
			$.each(event.data.coords, function (index, distance) {
				$("#firefighter-scrollable tr").eq(index + 1).find("td:eq(1)").html(`<div id="ems-hotcall-distance">` + Math.floor(distance) + ` meters</div>`);
			});
		}
	}, false);

	window.onkeyup = function(event) {
		if (event.key == 'Escape' || event.key == 'Backspace') {
			closeUI();
		}
	};
	
});

function clickedEmergency(obj){
	var pos = $(obj).parent().parent().index();
	$.post(`https://${GetParentResourceName()}/remove`,JSON.stringify({
		number :pos
	}));
}

function showEmergency(type){
	if (type == "ambulance"){
		$("#wrap-ems").show();
	}else if(type == "police"){
		$("#wrap-"+type).show();
	}else if(type == "mechanic"){
		$("#wrap-"+type).show();
	}else if(type == "taxi"){
		$("#wrap-"+type).show();
	} else if (type == "firefighter") {
		$("#wrap-" + type).show();
	}else{
		closeUI();
	}
}

function AddEmergency(type,Name,Distance,ButtonText,callback,Message){
	if (type == "ambulance"){
		$("#ems-scrollable").children().eq(0).append(`
		<tr>
			<td><div id="ems-hotcall-name">`+Name+`</div></td>
			<td><div id="ems-hotcall-distance">`+Distance+`</div></td>
			<td><div id="ems-hotcall-comment">I need medical attention, help!</div></td>
			<td><button id="ems-route" onclick = "`+callback+`(this)">`+ButtonText+`</button></td>
		</tr>`)
	}else if(type == "police"){
		$("#police-scrollable").children().eq(0).append(`
		<tr>
			<td><div id="ems-hotcall-name">`+Name+`</div></td>
			<td><div id="ems-hotcall-distance">`+Distance+`</div></td>
			<td><div id="ems-hotcall-comment">Help please!, help!</div></td>
			<td><button id="ems-route" onclick = "`+callback+`(this)">`+ButtonText+`</button></td>
		</tr>`)
	}else if(type == "mechanic"){
		$("#mechanic-scrollable").children().eq(0).append(`
		<tr>
			<td><div id="ems-hotcall-name">`+Name+`</div></td>
			<td><div id="ems-hotcall-distance">`+Distance+`</div></td>
			<td><div id="ems-hotcall-comment">My car broke down!</div></td>
			<td><button id="ems-route" onclick = "`+callback+`(this)">`+ButtonText+`</button></td>
		</tr>`)
	}else if(type == "taxi"){
		$("#taxi-scrollable").children().eq(0).append(`
		<tr>
			<td><div id="ems-hotcall-name">`+Name+`</div></td>
			<td><div id="ems-hotcall-distance">`+Distance+`</div></td>
			<td><div id="ems-hotcall-comment">I need a taxi!</div></td>
			<td><button id="ems-route" onclick = "`+callback+`(this)">`+ButtonText+`</button></td>
		</tr>`)
	} else if (type == "firefighter") {
		$("#firefighter-scrollable").children().eq(0).append(`
		<tr>
			<td><div id="ems-hotcall-name">`+ Name + `</div></td>
			<td><div id="ems-hotcall-distance">`+ Distance + `</div></td>
			<td><div id="ems-hotcall-comment">${Message ?? 'ON GOING FIRE'}</div></td>
			<td><button id="ems-route" onclick = "`+ callback + `(this)">` + ButtonText + `</button></td>
		</tr>`)
	}
	
}

function deleteEmergencyByNumber(number){
	//de xreiazetai metatropi apo lua se js metrisi gt to prwto stoixeio stin html einai ta onomata twn stilwn
	if (currentType){
		if (currentType == "ambulance"){
			$("#ems-scrollable").children().eq(0).children().eq(number).remove();
		}else if(currentType == "police"){
			$("#police-scrollable").children().eq(0).children().eq(number).html();
			$("#police-scrollable").children().eq(0).children().eq(number).remove();
		}else if(currentType == "mechanic"){
			$("#mechanic-scrollable").children().eq(0).children().eq(number).remove();
		}else if(currentType == "taxi"){
			$("#taxi-scrollable").children().eq(0).children().eq(number).remove();
		}else if (currentType == "firefighter") {
			$("#firefighter-scrollable").children().eq(0).children().eq(number).remove();
		}
	}
}

function clearEmergencies(){
	
	$("#ems-scrollable").html(`
	<table>
		<tr>
			<th>Name</th>
			<th>Distance</th>
			<th>Comment</th>
			<th></th>
		</tr>
		</table>`)
	$("#police-scrollable").html(`
	<table>
		<tr>
			<th>Name</th>
			<th>Distance</th>
			<th>Comment</th>
			<th></th>
		</tr>
		</table>`)
	$("#mechanic-scrollable").html(`
	<table>
		<tr>
			<th>Name</th>
			<th>Distance</th>
			<th>Comment</th>
			<th></th>
		</tr>
		</table>`)
	$("#taxi-scrollable").html(`
	<table>
		<tr>
			<th>Name</th>
			<th>Distance</th>
			<th>Comment</th>
			<th></th>
		</tr>
		</table>`)
	$("#firefighter-scrollable").html(`
	<table>
		<tr>
			<th>Name</th>
			<th>Distance</th>
			<th>Comment</th>
			<th></th>
		</tr>
		</table>`)

}

function closeUI(){
	$("#wrap-ems").hide();
	$("#wrap-police").hide();
	$("#wrap-mechanic").hide();
	$("#wrap-taxi").hide();
	$("#wrap-firefighter").hide();
	
	$.post(`https://${GetParentResourceName()}/close`);
}