window.onload = function(e) {
    window.addEventListener('message', function(event) {
        if (event.data.action == true){
            $("#craft-container").show();
        }else{
            $("#craft-container").hide();
            $.post('http://esx_ligmajobs_addons/close');
        }

    });
} 

$("html").on("keyup", function (key) {
    // use e.which
    if (key.which == 27){
        $.post('http://esx_ligmajobs_addons/close');
        $("#craft-container").hide();
    }
});

