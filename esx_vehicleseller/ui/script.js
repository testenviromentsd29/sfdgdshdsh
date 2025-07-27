var bar = null;
$(function () {
  window.addEventListener("message", function (event) {
    if (event.data.action == "show") {
      $("#dollar-block").hide();
      $("#black-block").hide();
      $("#donation-block").hide();
      $("#vehicle-model").html(event.data.label);
      $("#plate").html(event.data.plate);
      $("#vehicle-owner").html(event.data.owner);
      $("#tank-capacity").html(event.data.fuel + " LITERS");
      $("#turbo-block").html(event.data.turbo);
      $("#engine-level").html(event.data.engineKit);
      $("#brakes-level").html(event.data.brakeKit);
      $("#transmission-level").html(event.data.transmissionKit);
      $("#suspension-level").html(event.data.suspensionKit);

      if (bar == null) {
        bar = new ProgressBar.Circle(levelbar, {
          strokeWidth: 8,
          color: "rgba(255,255,255,0.1)",
          trailColor: "rgba(255,255,255,0.2)",
          trailWidth: 1,
          easing: "easeInOut",
          duration: 2000,
          svgStyle: null,
          text: {
            value: "",
            alignToBottom: false,
          },

          // Set default step function for all animate calls
          step: (state, bar) => {
            bar.path.setAttribute("stroke", state.color);
            var value = Math.round(bar.value() * 100);
            bar.setText("<div id='level'>" + value + "%</div>");
            bar.text.style.color = state.color;
          },
        });
      }

      bar.animate(event.data.engine / 100);

      if (event.data.price_type == "clean") {
        $("#dollar-price").html("$" + event.data.price);
        $("#dollar-block").show();
      } else if (event.data.price_type == "black") {
        $("#black-price").html("$" + event.data.price);
        $("#black-block").show();
      } else if (event.data.price_type == "dc") {
        $("#donation-price").html(
          '<i class="fas fa-coins"></i>' + event.data.price
        );
        $("#donation-block").show();
      }
      $("#wrap").fadeIn();
      $("body").show();
    } else if (event.data.action == "hide") {
      $("#dollar-block").hide();
      $("#black-block").hide();
      $("#donation-block").hide();
      $("#wrap").fadeOut();
      $("body").hide();
      $.post("http://esx_vehicleseller/quit");
    }
  });

  document.onkeyup = function (event) {
    if (event.key == "Escape") {
      $("#dollar-block").hide();
      $("#black-block").hide();
      $("#donation-block").hide();
      $("#wrap").fadeOut();
      $("body").hide();
      $.post("http://esx_vehicleseller/quit");
    }
  };
});

function quit() {
  $("#dollar-block").hide();
  $("#black-block").hide();
  $("#donation-block").hide();
  $("#wrap").fadeOut();
  $("body").fadeOut();
  $.post("http://esx_vehicleseller/quit");
}

function buyvehicle() {
  $("#dollar-block").hide();
  $("#black-block").hide();
  $("#donation-block").hide();
  $("#wrap").fadeOut();
  $("body").fadeOut();
  $.post("http://esx_vehicleseller/buy");
}

function testdrive() {
  $("#dollar-block").hide();
  $("#black-block").hide();
  $("#donation-block").hide();
  $("#wrap").fadeOut();
  $("body").fadeOut();
  $.post("http://esx_vehicleseller/testdrive");
}