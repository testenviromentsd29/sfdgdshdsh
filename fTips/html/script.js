const sleep = (milliseconds) => {
    return new Promise(resolve => setTimeout(resolve, milliseconds))
}

AddTip = async (text, duration) => {
    let html = '<div class="tip"><img src="https://cdn.discordapp.com/attachments/997482194278809645/1068190598038835340/Symbol.png" alt=""> <span> ' + text + '</span></div>';
    let tips = $('.tip').length;
    html = $(html).addClass('tip-' + tips);

    $('.container').append(html);
    await sleep(duration);

    //animate the tip going away
    $('.tip-' + tips).animate({
        opacity: 0,
        marginRight: '-10vw',
    }, 500);
    await sleep(500);
    $('.tip-' + tips).remove();
}

OnMessage = e => {
    if (e.data.action == "add-tip") {
        AddTip(e.data.message, e.data.duration);
    }
}

window.addEventListener("message", OnMessage);