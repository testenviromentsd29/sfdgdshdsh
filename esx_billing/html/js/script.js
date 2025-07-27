$(() => {

    let senderPlayer = null
    let playerIdentifier = null 
    let sharedAccountName = null
    let reason = null
    let price = null
    let polCategory = null

    $('#background').hide();
    $('#background_en').hide();
    window.addEventListener('message', function(event) {
        let v = event.data
        if (v.money != null & v.reason != null){
            $('#background').show();
            $('#moneyAmount').text(v.money + '$')
            $('#reasonMsg').html(v.reason)
            $('#headline').text(v.title)
            $('#moneyTitle').text(v.priceTitle)
            $('#reasonTitle').text(v.reasonTitle)
            $('#sign').text(v.signTitle)
            $('#accept').text(v.acceptTitle)

            senderPlayer = v.senderPlayer
            playerIdentifier = v.playerIdentifier
            sharedAccountName = v.sharedAccountName
            reason = v.reason
            price = v.money
            polCategory = v.policeCategory
        }
    });

    $('#accept').click(() => {
        $.post('http://esx_billing/accept', JSON.stringify({
            senderPlayer: senderPlayer,
            playerIdentifier: playerIdentifier,
            sharedAccountName: sharedAccountName, 
            label: reason, 
            amount: price,
            polCat: polCategory
        }));
        $('#background').hide();
    });
    
    $('#denied').click(() => {
        $.post('http://esx_billing/denied', JSON.stringify({
			senderPlayer: senderPlayer,
            playerIdentifier: playerIdentifier,
            sharedAccountName: sharedAccountName, 
            label: reason, 
            amount: price
		}));
        $('#background').hide();
    });
});


