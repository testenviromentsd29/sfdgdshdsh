let LastCalled = {};

ShowTimer = data => {
    const { text, time } = data;

    $('.header span').text(text);
    $('.time-left').text(time);
    
    if(!$('#timer').is(':visible')){
        $('#timer').fadeIn();
    }

    if(LastCalled.Timer){
        clearTimeout(LastCalled.Timer);
    }

    LastCalled.Timer = setTimeout(() => {
        $('#timer').fadeOut();
    }, 500);
}

ShowCommand = data => {
    const { command, description } = data;
    const customId = `custom-command-${command}`;

    LastCalled.Commands = LastCalled.Commands || {};
    if(LastCalled.Commands[customId]){
        clearTimeout(LastCalled.Commands[customId]);
    }

    LastCalled.Commands[customId] = setTimeout(() => {
        $(`#${customId}`).css('animation', 'fadeOutLeft 1s').fadeOut(1000, () => {
            $(`#${customId}`).remove();
        });
    }, 500);

    if($(`#${customId}`).length){
        return;
    }

    const newCommand = $(`
    <div class="command" id="${customId}">
      <i class="fas fa-terminal"></i>
      <div class="command-info">
        <div class="command-name">${command}</div>
        <div class="command-description">${description}</div>
      </div>
    </div>
    `);

    newCommand.hide();
    $('#commands').append(newCommand);
    newCommand.fadeIn();
}

ShowKey = data => {
    const { key, description } = data;
    let formatedDescription = description.replace(/[^a-zA-Z0-9]/g, '');
    formatedDescription = formatedDescription.replace(/\s/g, '');
    const customId = `custom-key-${formatedDescription}`;

    LastCalled.Keys = LastCalled.Keys || {};
    if(LastCalled.Keys[customId]){
        clearTimeout(LastCalled.Keys[customId]);
    }

    LastCalled.Keys[customId] = setTimeout(() => {
        $(`#${customId}`).css('animation', 'fadeOutRight 1s').fadeOut(1000, () => {
            $(`#${customId}`).remove();
        });
    }, 500);

    if($(`#${customId}`).length){
        return;
    }

    const newKey = $(`
    <div class="key-container" id="${customId}">
      <div class="key-decor"></div>
      <div class="key-text">
        <div class="key">${key}</div>
        <span>${description}</span>
      </div>
    </div>
    `);

    newKey.hide();
    $('#keys').append(newKey);
    newKey.fadeIn();
}

OnMessage = e => {
    switch(e.data.action){
        case 'showTimer':
            ShowTimer(e.data);
            break;
        case 'showCommand':
            ShowCommand(e.data);
            break;  
        case 'showKey':
            ShowKey(e.data);
            break;
    }
}

window.addEventListener('message', OnMessage);