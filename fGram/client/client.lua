local ESX = nil;
local PlayerData = nil;
local mf = math.floor;
local recName = GetCurrentResourceName()..':';
local instagram = {};

local conversations = {};

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerData = ESX.GetPlayerData();
	Wait(5000)

	instagram.userData = json.decode(GetResourceKvpString('masters_fgram')) or {} --Onomaste to kvp me to server name sas h me kati alo please

	if instagram.userData.username then
		local data = instagram.userData;
		instagram.logIn({data = data})
	end
end)

instagram.signOut = function (data,	cb)

	if not instagram.isLoggedIn then
		return;
	end

	local action = exports['dialog']:Decision('SIGN OUT', 'Are you sure you want to log out?', '', 'LOG OUT', 'CANCEL').action;

	if action == 'submit' then

		instagram.userData = {};

		instagram.isLoggedIn = false;

		SetResourceKvp('masters_fgram', json.encode(instagram.userData));

		TriggerServerEvent(recName..'onLogOut');

		ESX.TriggerServerCallback(recName..'getPosts', function (posts)
			instagram.refreshPosts(posts);
		end)

		instagram.Close();
	else
		instagram.Open();
	end
end

instagram.uploadPhoto = function (data,cb)
	if not instagram.isLoggedIn then
		return;
	end
	
	local serverData = data.data;

	ESX.TriggerServerCallback(recName..'uploadPhoto', function (uploaded)
		if uploaded then
			instagram.Close();
			Wait(500);
			instagram.Open();
		end
	end, serverData)
end

instagram.post = function (data,cb)
	SetNuiFocus(false,false);
	CreateMobilePhone(1);
	Citizen.CreateThread(function ()

		CellCamActivate(true, true);
		while true do
			Wait(0)
			DrawScreenText('Press [~g~E~w~] to capture photo',0.05,0.905,1,0.8);
			HideDefaultHud();
			if IsControlJustReleased(0,38) then
				ESX.TriggerServerCallback(recName..'lamao', function(hook)
					exports['screenshot-basic']:requestScreenshotUpload("https://api.fivemanage.com/api/image?apiKey="..hook, "file", function(data)
						local image = json.decode(data);
						DestroyMobilePhone();
						CellCamActivate(false, false);
						instagram.SendNUIMessage({
							action = 'take-photo',
							image =image.url
						},true)
					end)
				end)
			break;
			elseif IsControlJustReleased(0,27) then

				CellFrontCamActivate(false);
			elseif IsControlJustReleased(0,173) then

				CellFrontCamActivate(true);
			end
		end
	end)
end

instagram.signUp = function (data, callback)
	if not data then
		return;
	end

	ESX.TriggerServerCallback(recName..'signUp', function (passed,text,data)

		if not passed then
			instagram.showNotification('ERROR',text);
			callback(false);
			return
		end

		instagram.logIn(data);
		callback(true,nil,data);
	end,data)
end

instagram.logIn = function (data,callback)
	if not data then
		return;
	end

	ESX.TriggerServerCallback(recName..'onLogIn', function(passed,text,data) 

		if not passed then
			instagram.showNotification('ERROR',text);
			--callback(false);
			return
		end
		
		instagram.isLoggedIn = true;

		instagram.userData = data;

		SetResourceKvp('masters_fgram',json.encode(data))

		ESX.TriggerServerCallback(recName..'getPosts', function (posts)
			instagram.refreshPosts(posts)
		end)

		instagram.SendNUIMessage({action = 'logged-in', userData = instagram.userData});
	end, data)
end

instagram.Close = function ()
	instagram.isOpen = false;
	
	instagram.SendNUIMessage({
		action = 'close'
	})

	SetNuiFocus(false,false);
end

instagram.Open = function ()
	if instagram.isOpen then
		return;
	end

	local object = {};

	object.userData = instagram.userData or {};
	object.action = 'open';

	instagram.SendNUIMessage(object,true);
	instagram.isOpen = true;
	
	ExecuteCommand('e phone');

	while instagram.isOpen do
		Wait(500)
	end

	ExecuteCommand('e c');
end

instagram.SendNUIMessage = function (data, focus)
	data.isLoggedIn = instagram.isLoggedIn;
	data.userData = instagram.userData;
	
	SendNUIMessage(data);
	if focus then
		SetNuiFocus(true,true);
	end
end

instagram.showNotification = function (title, text, duration, image)
	instagram.SendNUIMessage({
		action = 'notification',
		title = title,
		text = text,
		duration = duration or 2000
	})
end

instagram.updateProfilePhoto = function (data, cb)
	if not data then
		return;
	end

	if not data.url then
		return;
	end

	ESX.TriggerServerCallback(recName..'updateProfilePhoto', function(updated) 
		if updated then
			instagram.userData.profilePhoto = data.url;
		end
		cb(updated)
	end,data.url)
end

instagram.onPhotoLike = function (data)

	if not instagram.isLoggedIn then
		return;
	end

	local nuiData = data.data

	TriggerServerEvent(recName..'onPhotoLike', nuiData.id);
end

instagram.pushLikesToClient = function (likes, id)
	local isLiked = (instagram.isLoggedIn and likes[instagram.userData.username]) or false;
	
	instagram.SendNUIMessage({
		action = 'new-like',
		likes = likes,
		liked = isLiked,
		id = id
	}, false)
end

instagram.pushPhotoToClient = function (data)
	if not data then
		return
	end

	instagram.SendNUIMessage({
		postData = data,
		action = 'new-post'
	}, false)

	if instagram.isOpen then
		instagram.showNotification('NEW POST', data.username..' has posted a new photo');
	else
		instagram.showGameNotification(data);
	end
end

instagram.showGameNotification = function (data)
	instagram.SendNUIMessage({
		action = 'game-notification',
		notificationData = data;
	})
end

instagram.onComment = function (data, cb)
	if not data then
		return
	end
	
	ESX.TriggerServerCallback(recName..'onComment', function (commented)
		cb(commented)
	end, data)
end

instagram.getPostComments = function (data, cb)
	if not data then
		return;
	end

	if not data.id then
		return;
	end

	ESX.TriggerServerCallback(recName..'getComments',function (comments)
		cb(comments);
	end, data.id)
end

instagram.refreshPosts = function (posts)
	instagram.SendNUIMessage({
		action = 'refresh',
		posts = posts,
	})
end

---NUI CALLBACKS

RegisterNUICallback('logout', instagram.signOut);
RegisterNUICallback('comment', instagram.onComment);
RegisterNUICallback('getcomments', instagram.getPostComments);
RegisterNUICallback('like', instagram.onPhotoLike);
RegisterNUICallback('uploadPhoto', instagram.uploadPhoto);
RegisterNUICallback('profile', instagram.updateProfilePhoto);
RegisterNUICallback('add',instagram.post);
RegisterNUICallback('login', instagram.logIn);
RegisterNUICallback('signup',instagram.signUp);
RegisterNUICallback('close', instagram.Close);
RegisterNUICallback('closeMenu', function ()
	SetNuiFocus(false,false);
end);

---------------

function CellFrontCamActivate(activate)
	return Citizen.InvokeNative(0x2491A93618B7D838, activate)
end

function RequestAnim(anim)
	RequestAnimDict(anim)
	
	while not HasAnimDictLoaded(anim) do
		Wait(10)
	end
end

function CreateNPC(model, coords, heading, freeze)
	local hashMonel = GetHashKey(model)
	RequestModel(hashMonel)

	while not HasModelLoaded(hashMonel) do
		Wait(10)
	end

	RequestAnim('mini@strip_club@idles@bouncer@base')

	local npc = CreatePed(mf(5), hashMonel, coords.x, coords.y, coords.z-1.0, heading, false, true)
	SetEntityHeading(npc, heading)
	FreezeEntityPosition(npc, freeze)
	SetEntityInvincible(npc, true)
	SetBlockingOfNonTemporaryEvents(npc, true)

	TaskPlayAnim(npc, 'mini@strip_club@idles@bouncer@base', 'base', 8.0, 0.0, mf(-1), mf(1), mf(0), mf(0), mf(0), mf(0))

	SetModelAsNoLongerNeeded(hashMonel)

	return npc
end

function DrawScreenText(text,x,y,font,scale)
	SetTextFont(font)
	SetTextProportional(1)
	SetTextScale(0.0,scale)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

function HideDefaultHud()
	HideHudComponentThisFrame(mf(7));
	HideHudComponentThisFrame(mf(8));
	HideHudComponentThisFrame(mf(9));
	HideHudComponentThisFrame(mf(6));
	HideHudComponentThisFrame(mf(19));
	HideHudAndRadarThisFrame();
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

function GetLoggedInUsers()
	local users = nil;

	ESX.TriggerServerCallback(recName..'GetLoggedInAccounts', function(data) 
		users = data;
	end)

	while not users do
		Wait(0)
	end
	
	local mySid = GetPlayerServerId(PlayerId());
	
	for k,v in pairs(users) do
		if v.source == mySid then
			users[k] = nil;
			break;
		end
	end

	return users;
end

function GetMessages(data, cb)
	local userName = instagram.userData.username;
	
	local users = GetLoggedInUsers();
	local convos = conversations[userName] or {};

	cb({
		convos = convos,
		users = users
	});
end

function GetConverstation(data, cb)
	local userName = instagram.userData.username;
	local convos = conversations[userName] or {};

	cb(convos[data.userName] or {});
end

function SendMessage(data)
	local userName = data.userName;
	local message = data.message;

	print('Sending message to '..userName..' with message: '..message);
	TriggerServerEvent(recName..'SendMessage', userName, message);
end

function OnMessage(messageData)
	local receiver = messageData.receiver;
	local sender = messageData.username;

	local targetConvoIndex = receiver == instagram.userData.username and sender or receiver;
	print('Target convo index: '..targetConvoIndex);

	conversations[instagram.userData.username] = conversations[instagram.userData.username] or {};
	conversations[instagram.userData.username][targetConvoIndex] = conversations[instagram.userData.username][targetConvoIndex] or {};
	table.insert(conversations[instagram.userData.username][targetConvoIndex], messageData);

	if instagram.isOpen then
		instagram.SendNUIMessage({
			action = 'new-message',
			messageData = messageData
		}, false)
	end
end

RegisterNUICallback('getconvo', GetConverstation);
RegisterNUICallback('sendmessage', SendMessage);
RegisterNUICallback('getmessages', GetMessages);
RegisterCommand('ins', GetLoggedInUsers);
RegisterNetEvent(recName..'onMessage', OnMessage);
RegisterNetEvent(recName..'pushLikesToClient', instagram.pushLikesToClient)
RegisterNetEvent(recName..'pushPhotoToClient', instagram.pushPhotoToClient);
RegisterNetEvent(recName..'showNotification',instagram.showNotification);
RegisterCommand(Config.CommandName, instagram.Open);