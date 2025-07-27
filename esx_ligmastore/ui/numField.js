var currentCode = "";
var audioPlayer = null;
var data = null;
var active = false;

$(document).ready(function(){  

    if (audioPlayer != null) {
        audioPlayer.pause();
    }

    audioPlayer = new Howl({src: ["numField.mp3"]});
    audioPlayer.volume(50.0);
    
    $("#key1").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "1";
    }); 
    $("#key2").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "2";
    }); 
    $("#key3").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "3";
    }); 
    $("#key4").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "4";
    }); 
    $("#key5").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "5";
    }); 
    $("#key6").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "6";
    }); 
    $("#key7").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "7";
    }); 
    $("#key8").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "8";
    }); 
    $("#key9").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "9";
    }); 
    $("#key0").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "0";
    }); 

    $("#keyCancel").click(function(){
        audioPlayer.play();
        active = false;
        $('body').css('display', "none")
        $.post('http://esx_ligmastore/escape', JSON.stringify({}));
    }); 

    $("#keyClear").click(function(){
        audioPlayer.play();
        currentCode = "";
    });

    $("#keyEnter").click(function(){
        audioPlayer.play();
        $.post('http://esx_ligmastore/try', JSON.stringify({
            code: currentCode,
            action: data.action
        }));
        active = false;
        currentCode = "";       
    });

    window.addEventListener('message', function(event) {
        data = event.data;
        currentCode = "";
        
        if (event.data.type == "enableui") {
            $('body').css('display', event.data.enable ? "block" : "none")
        }
        if (event.data.enable == true){
            active = true;
        }
    });

    $(document).on("keypress", function (e) {
        // use e.which
        if (active && e.which >= 48 && e.which <= 57){
            currentCode = currentCode + String(e.which-48);
            audioPlayer.play();
        }
        if (active && e.which == 13){
            audioPlayer.play();
            $.post('http://esx_ligmastore/try', JSON.stringify({
                code: currentCode,
                action: data.action
            }));
            active = false;
            currentCode = ""; 
        }
        
    });
});