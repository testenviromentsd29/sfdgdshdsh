const doc = document;
let inPopUp = false;
let isLoggedIn;
let postCooldown = false;

AppendNewMessage = data => {
    if(!$('#messages-page').is(':visible')) return console.log('Not visible');
    if(!$("#messages-page .profile-info").is(':visible')) return console.log('Not visible 2');

    console.log($('#messages-page .profile-info .name').text(), data.username, data.receiver)
    if ($('#messages-page .profile-info .name').text() != data.username && data.receiver != $('#messages-page .profile-info .name').text()) return console.log('Not same user');
    const isMine = data.username != $('#messages-page .profile-info .name').text();
    const message = data.message;

    $('.messages-list').append(`
    <div class="message ${isMine ? 'mine' : ''}">
        <div class="profile-img" style = "background:url(${data.profilePhoto})"></div>
        <div class="message-text">
            ${message}
        </div>
    </div>
    `)
}

OnMessage = (e) => {
    switch (e.data.action) {
        case 'open':
            HidePopUps();
            isLoggedIn = e.data.isLoggedIn;
            SetUpPage(e.data.isLoggedIn, e.data.userData);
            $('#body').fadeIn();
            break;
        case 'new-message':
            AppendNewMessage(e.data.messageData);
            break;
        case 'notification':
            OnInstagramNotification(e.data.title, e.data.text, e.data.duration);
            break;
        case 'logged-in':
            HidePopUps();
            isLoggedIn = e.data.isLoggedIn;
            SetUpPage(e.data.isLoggedIn, e.data.userData);
            break;
        case 'close':
            HidePopUps();
            $('#body').fadeOut();
            break;
        case 'take-photo':
            $('#body').fadeIn();
            $('#post-img').css('background', `url(${e.data.image})`);
            OpenPage('#post-page');
            break;
        case 'game-notification':
            OnGameNotification(e.data.notificationData)
            break;
        case 'new-like':
            $('#' + e.data.id + '.post .content .post-image .post-likes').html(Object.keys(e.data.likes).length + ' <i class="fas fa-heart"></i>');
            if (e.data.liked) {
                $('#' + e.data.id + '.post .content .post-image .post-likes').attr('id', 'liked');
            } else {
                $('#' + e.data.id + '.post .content .post-image .post-likes').attr('id', '');
            }
            break;
        case 'new-post':
            let html = `
             <div class="post" id = '${e.data.postData.id}'>
           <div class='header'>
             <div class="profile-img" style = "background:url(${e.data.postData.profilePhoto})"></div>
             <div class="profile-name">${e.data.postData.username}</div>
           </div>
           <div class="content">
             <div class="center">
               <div class="post-image" style = "background:url(${e.data.postData.url})">
                 <div class="post-likes" onclick = "OnLike('${e.data.postData.id}')">${Object.keys(e.data.postData.likes).length} <i class="fas fa-heart"></i></div>
               </div>
             </div>
             <div class="post-text">${e.data.postData.comment}</div>
             <div class="center">
               <div class="post-comment" onclick = "GetComments('${e.data.postData.id}')">LEAVE A COMMENT <i class="fal fa-comment"></i></div>
             </div>
           </div>
         </div>
             `
            $("#posts").prepend(html);
            break;
        case 'refresh':
            $("#posts").html('');
            for (const id in e.data.posts) {
                let targetPost = e.data.posts[id];
                let idd = '';
                if (targetPost.likes[e.data.userData.username]) {
                    idd = 'liked';
                }

                $('#posts').prepend(`
                <div class="post" id = '${id}'>
                <div class='header'>
                  <div class="profile-img" style = "background:url(${targetPost.profilePhoto})"></div>
                  <div class="profile-name">${targetPost.username}</div>
                </div>
                <div class="content">
                  <div class="center">
                    <div class="post-image" style = "background:url(${targetPost.url})">
                      <div class="post-likes id = ${idd}" onclick = "OnLike('${targetPost.id}')">${Object.keys(targetPost.likes).length} <i class="fas fa-heart"></i></div>
                    </div>
                  </div>
                  <div class="post-text">${targetPost.comment}</div>
                  <div class="center">
                    <div class="post-comment" onclick = "GetComments('${id}')">LEAVE A COMMENT <i class="fal fa-comment"></i></div>
                  </div>
                </div>
              </div>`)
            }
            console.log('Posts Loaded')
            break;
    }
}

OnComment = (id) => {
    if (!isLoggedIn) return OnInstagramNotification('ERROR', 'You have to sign in first', 3000);
    let comment = $('.my-comment').val();
    if (!comment || comment == '') return OnInstagramNotification('ERROR', 'Please type a comment', 3000);
    if (isCommentInvalid(comment)) return OnInstagramNotification('ERROR', 'You can not use these chars', 3000);
    $('.my-comment').val('');
    $('.my-comment').html('');
    $.post(`https://fGram/comment`, JSON.stringify({ id, comment }), (posted) => {
        if (posted) {
            GetComments(id, true);
        } else {
            OnInstagramNotification('ERROR', 'There was an error posting your comment', 3000);
        }
    })
}

GetComments = (id, dont) => {
    $.post(`https://fGram/getcomments`, JSON.stringify({ id }), (comments) => {
        let commentsHtml = '';
        for (let i = 0; i < comments.length; i++) {
            commentsHtml += `<div class="comment">
            <div class="profile-image" style = 'background:url(${comments[i].profilePhoto})'></div>
            <div class="profile-name">${comments[i].username} <span>${comments[i].hour}</span></div>
            <div class="profile-comment">${comments[i].comment}</div>
          </div>`
        }

        $('#comment-btn').attr('onclick', `OnComment('${id}')`);
        $('.comment-container .comments').html(commentsHtml);
        if (dont) return;
        OpenPage('#comment-page', true);
    })
}

OnLike = (id) => {
    OnPost('like', { id });
}

OpenMessages = async (userName, photoProfile) => {
    const messages = await $.post(`https://fGram/getconvo`, JSON.stringify({ userName }));
    console.log('OpenMessages ', messages)  

    if (!messages) return console.log('No messages found');
    $('.messages-container header').hide();
    $('.messages-container main').hide();

    console.log('photoProfile ', photoProfile)
    $('.messages-container .profile-info .img').css('background', photoProfile);
    $('.messages-container .profile-info .name').text(userName);

    $('.message-input').show();
    $('.messages-list').show();
    $('.messages-container .profile-info').show();
    $('.messages-list').empty();

    $('#close-messages').off('click').on('click', () => {
        $('.message-input').hide();
        $('.messages-list').hide();
        $('.messages-container .profile-info').hide();

        $('.messages-container header').show();
        $('.messages-container main').show();
    })
    
    console.log(JSON.stringify(messages, null, 2));
    for (let i = 0; i < messages.length; i++) {
        const isMine = messages[i].username != userName;
        const message = messages[i].message;

        $('.messages-list').append(`
        <div class="message ${isMine ? 'mine' : ''}">
          <div class="profile-img" style = "background:url(${messages[i].profilePhoto})"></div>
          <div class="message-text">
            ${message}
          </div>
        </div>
        `)
    }

    $('.message-input input').focus();
    $('.message-input input').off('keyup').on('keyup', (e) => {
        if (e.key == 'Enter') {
            const message = $('.message-input input').val();
            if (!message || message == '') return;
            if(isCommentInvalid(message)) return OnInstagramNotification('ERROR', 'You can not use these chars', 3000);

            $('.message-input input').val('');
            $.post(`https://fGram/sendmessage`, JSON.stringify({ userName, message }));
        }
    });
}

OpenConvos = users => {
    inPopUp = true;
    $('.message-input').hide();
    $('.messages-list').hide();
    $('.messages-container .profile-info').hide();
    let html = '';
    $('.profiles-list').empty();

    for(const userName in users) {
        const user = users[userName];
        html += `
        <div class="profile">
            <div class="profile-image" style = "background-image:url(${user.profilePhoto})"></div>
            <div class="profile-info">
                <div class="profile-name">${userName}</div>
                <div class="profile-status">Online</div>
            </div>
            <div class="dot"></div>
        </div>
        `
    }

    $('.profiles-list').html(html);

    $('.messages-container header').show();
    $('.messages-container main').show();
    $('#messages-page').fadeIn();

    $('.messages-container header input').off('keyup').on('keyup', (e) => {
        console.log('keyup')
        const search = $('.messages-container header input').val();
        if (!search || search == '') {
            $('.profiles-list .profile').show();
            return;
        }

        $('.profiles-list .profile').each((i, profile) => {
            const userName = $(profile).find('.profile-name').text();
            if (userName.includes(search)) {
                $(profile).show();
            } else {
                $(profile).hide();
            }
        });
    })

    $('.profiles-list .profile').click((e) => {
        const userName = $(e.currentTarget).find('.profile-name').text();
        const photoProfile = $(e.currentTarget).find('.profile-image').css('background-image');

        OpenMessages(userName, photoProfile);
    })
}

OpenSms = () => {
    $.post(`https://fGram/getmessages`, JSON.stringify({}), (data) => {
        console.log(JSON.stringify(data))

        let users = data.users;
        let messages = data.messages;
        OpenConvos(users);
    })
}


SetUpPage = (isLoggedIn, userData) => {
    userData = userData ?? {};
    let loggedInText = ((isLoggedIn && `Logged in as ${userData.username}`) ?? '');
    $('.layout .user-data span').html(loggedInText);

    if (isLoggedIn) {
        let profilePhoto = userData.profilePhoto;
        $('.log-status .profile-image').css('background', "url('" + profilePhoto + "')");
        $('.log-status .profile-image').attr('onclick', "OnPost('logout')");
        $('.log-status .profile-image').css('display', "flex");
        $('.log-status i').css('display', "none");
        $('.media-btns button').attr('onclick', "OpenPage('#post-page')")
        $('.log-status .fa-sms').css('display', "inline-block");
        $('.log-status .fa-sms').attr('onclick', "OpenSms()");
    } else {
        $('.log-status .profile-image').css('display', "none");
        $('.log-status i').css('display', "block");
        $(".log-status i").attr("onclick", "OpenPage('#login-page')");
        $('.media-btns button').attr('onclick', "OpenPage('#login-page')")
        $('.log-status .fa-sms').css('display', "none");
    }

    $('.btn-signin').attr("onclick", "OnLogIn()");
    $('.btn-signup').attr("onclick", "OnLogIn(true)");

}

HidePopUps = () => {
    inPopUp = false;
    $('.popup').fadeOut();
};

OpenPage = (page, donthide) => {
    if (donthide) {
        HidePopUps();
    }
    inPopUp = true;
    $(page).fadeIn();
}

OnInstagramNotification = (title, text, duration, inphone) => {
    $('.notification .title').html(title);
    $('.notification .notification-text').html(text);
    $('.notification').fadeIn();
    setTimeout(() => {

        $('.notification').fadeOut();
    }, duration)
}

OnGameNotification = (data) => {
    $('.game-notification .name').html(data.username);
    $('.game-notification .image').css("background", `url(${data.url})`);
    $('.game-notification .text').html(data.comment);
    $('.game-notification .icon').css("background", `url(${data.profilePhoto})`);
    $('.game-notification').fadeIn();
    setTimeout(() => {
        $('.game-notification').fadeOut();
    }, 5000);
}

OnPostPhoto = () => {
    let url = $('#post-img').css('background-image').slice(4, -1).replace(/"/g, "");
    let lastIndexOfJpg = url.lastIndexOf('.jpg');
    if (!lastIndexOfJpg) return OnInstagramNotification('ERROR', 'This is not a supported image!', 2000);
    url = url.substring(0, url.lastIndexOf('.jpg')) + '.jpg';
    if (! /\.(jpg|jpeg|png|gif)$/.test(url)) return OnInstagramNotification('ERROR', 'This is not a supported image!', 2000, true);
    let comment = $('#comment-input').val();
    $('#post-img').css('background', '');
    $('#comment-input').val('');
    $('#comment-input').html('');
    OnPost('uploadPhoto', { url, comment });
}

OnLogIn = (isSignup) => {
    let username = $('#username').val();
    let password = $('#password').val();

    if ((!username || username == '') || (!password || password == '')) {
        ClearInputs();
        return OnInstagramNotification('ERROR', 'Enter your password and username', 3000);
    }

    if (containsSpecialChars(username) || containsSpecialChars(password)) {
        ClearInputs();
        return OnInstagramNotification('ERROR', 'Do not put special characters', 3000);
    }

    if (isSignup) {
        if ((username.length < 3 || username.length > 20) || (password.length < 3 || password.length > 20)) {
            ClearInputs();
            return OnInstagramNotification('ERROR', 'Username and password characters should be between 3 and 20', 3000);
        }
        OnPost('signup', { username, password });
    } else {
        OnPost('login', { username, password });
    }
}

OnPost = (callback, data) => {
    if (postCooldown) return;
    if (callback == 'add') {
        OnPost('close');
    }
    $.post(`https://fGram/${callback}`, JSON.stringify({ data }), (data) => {
        if (callback === 'login' && !data) {
            ClearInputs();
        }
    });
    postCooldown = true;
    setTimeout(() => {
        postCooldown = false;
    }, 1000);
}

OnKeyUp = (e) => {
    switch (e.key) {
        case 'Escape':
            if (inPopUp) {
                HidePopUps();
            } else {
                OnPost('close');
            }
            break;
        case 'Enter':
            let isInFocus = $('#link-input').is(':focus');
            if (!isInFocus) return;
            let url = $('#link-input').val();
            let lastIndexOfJpg = url.lastIndexOf('.jpg');
            if (!lastIndexOfJpg) return OnInstagramNotification('ERROR', 'This is not a supported image!', 2000);
            url = url.substring(0, url.lastIndexOf('.jpg')) + '.jpg';
            if (! /\.(jpg|jpeg|png|gif)$/.test(url)) return OnInstagramNotification('ERROR', 'This is not a supported image!', 2000);
            $('#post-img').css('background', `url(${url})`);
            break;
    }
}

SetAsProfile = () => {
    let url = $('#post-img').css('background-image').slice(4, -1).replace(/"/g, "");
    let lastIndexOfJpg = url.lastIndexOf('.jpg');
    if (!lastIndexOfJpg) return OnInstagramNotification('ERROR', 'This is not a supported image!', 2000);
    url = url.substring(0, url.lastIndexOf('.jpg')) + '.jpg';
    if (! /\.(jpg|jpeg|png|gif)$/.test(url)) return OnInstagramNotification('ERROR', 'This is not a supported image!', 2000);
    $.post(`https://fGram/profile`, JSON.stringify({ url }), (updated) => {
        if (updated) {
            $('.log-status .profile-image').css('background', "url('" + url + "')");
            OnInstagramNotification('SUCESS', 'Sucesfully updated your image', 2000)
        }
    });
}

ClearInputs = () => {
    $('#password').val('');
    $('#password').html('');
}

function containsSpecialChars(str) {
    const specialChars = /[`!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~]/;
    return specialChars.test(str);
}

function isCommentInvalid(str) {
    const specialChars = /[`\-=\[\]{};':"\\|<>\/~]/;
    return specialChars.test(str);
}

window.addEventListener('message', OnMessage);
window.addEventListener("keyup", OnKeyUp);