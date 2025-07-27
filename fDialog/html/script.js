OnMessage = e => {
    switch (e.data.action) {
        case 'open':
            $('.question').html(e.data.question);
            $('#input-box').val(e.data.text);
            $('#body').fadeIn(500);

            $('.sumbit').off('click').on('click', () => {
                let val = $('#input-box').val();
                if (val.length < 1) return;
                $('#body').fadeOut(500);
                $.post('https://fDialog/submit', JSON.stringify({
                    val
                    }));
                });
            break;
    }
}

OnKeyUp = e => {
    switch (e.key) {
        case 'Escape':
            $('#body').fadeOut(500);
            $.post('https://fDialog/submit', JSON.stringify({}));
    }
}

window.addEventListener('keyup', OnKeyUp);
window.addEventListener('message', OnMessage);