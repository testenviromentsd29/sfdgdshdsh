let validFonts = {
    1: true,
    2: true,
    3: true,
    4: true,
    5: true
};

OnFontType = async () => {
    let val = $('#font-val').val();
    let numVal = parseInt(val);
    if (validFonts[numVal]) {
        await $.post('https://fGrafs/ontype', JSON.stringify({ font: numVal }));
    } else {
        await $('#font-val').val('', '');
    }
}

OnMsgType = async () => {
    let msgVal = $('#msg-val').val();
    await $.post('https://fGrafs/ontype', JSON.stringify({ text: msgVal }));
}

OnColourChange = async () => {
    let colorVal = $('.content input[type=color]').val();
    await $.post('https://fGrafs/ontype', JSON.stringify({ colour: colorVal.toString() }));
}

OnSumbit = () => {
    let fontVal = $('#font-val').val();
    if (!validFonts[fontVal]) return;
    let msgVal = $('#msg-val').val();
    if (!msgVal || msgVal == '') return;
    let colorVal = $('.content input[type=color]').val();
    $('#body').fadeOut();
    $.post('https://fGrafs/onspray', JSON.stringify({ message: msgVal, color: hexToRgb(colorVal) }));
}

OnMessage = async e => {
    switch (e.data.action) {
        case 'open':
            await $("#body").fadeIn();
            break;
        case 'close':
            $('#body').fadeOut();
            $.post('https://fGrafs/close', JSON.stringify({}));
            break;
    }

    $('header').mousedown(function () {
        ToggleDrag(true);
    })

    $('header').mouseup(function () {
        ToggleDrag();
    })
}

OnKeyUp = async e => {
    switch (e.key) {
        case 'Escape':
            $('#body').fadeOut();
            await $.post('https://fGrafs/close', JSON.stringify({}));
            break;
    }
}

ToggleDrag = async toggle => {
    $('.content').draggable();
    if (toggle) {
        await $('.content').draggable("enable");
    } else {
        await $(".content").draggable({ disabled: true });
    }
}

function hexToRgb(hex) { //stack overflow of the godz
    var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
    return result ? {
        r: parseInt(result[1], 16),
        g: parseInt(result[2], 16),
        b: parseInt(result[3], 16)
    } : null;
}

window.addEventListener('keyup', OnKeyUp);
window.addEventListener('message', OnMessage);
