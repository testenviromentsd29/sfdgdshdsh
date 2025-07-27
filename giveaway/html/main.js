window.addEventListener('message', function(event) {
  if (event.data.action == "show"){
   $("#myentries").val(event.data.myentries);
   $("#nextentry").val(event.data.nextentry);
   $("#wrap").show();
  }
  document.onkeyup = function (data) {
    if (data.which == 8) {
      hideAll();
      $.post('http://giveaway/close', JSON.stringify({}));
    }
  };
});

function hideAll() {
  $("#wrap").show();
}