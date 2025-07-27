ConfigCL = {}

ConfigCL.CreateCriminal = vector3(0.0, 0.0, 0.0)

ConfigCL.CreateMafiaNpcHash		= `s_m_y_blackops_01`
ConfigCL.CreateMafiaNpcHeading	= 275.97

ConfigCL.MaxRank = 300
ConfigCL.ExperiencePerRank = 20000
ConfigCL.MinBlackMoney = 100000

ConfigCL.AbilityPerRank = 0.5
ConfigCL.PercentPerAbility = 5
ConfigCL.IncreaseRankCost = 20	--DC
ConfigCL.ResetAbilitiesCost = 5	--DC
ConfigCL.BlackMoneyAbilityInterval = 60	--minutes
ConfigCL.BlackMoneyPerAbility = 10		--1 = 10
--ConfigCL.AbilitiesInterval = 5		--seconds

ConfigCL.MaxAllies = 1
ConfigCL.MaxWars = 3
ConfigCL.DistanceToDrawTags = 10.0

ConfigCL.AllieText = '🛡️'
ConfigCL.EnemyText = '⚔️'

ConfigCL.Tasks = {
	["roaming"] = {
		{label = "Ταξιδέψτε 100χλμ χρησιμοποιοντας οποιοδηπποτε οχημα", id = "travel100km"},
		{label = "Ταξιδέψτε 100χλμ χρησιμοποιοντας οποιοδηπποτε οχημα με 4 ατομα στο αμαξια", id = "travel100km"},
		{label = "Παραμεινετε τουλαχιστον 6 ατομα online για 30 λεπτα συνεχομενα", id = "6online30mins"},
		{label = "Μεινετε απο 20 λεπτα σε καθε ζωνη Greenzone, Redzone, Neutral Zone", id = "stay20eachzone"},

	},
	["survival"] = {
		{label = "Χρησιμοποιήστε 100 Repair Kits σε οχήματα", id = "repairkit"},
		{label = "Χρησιμοποιήστε 100 bulletproof5", id = "bulletproof5"},
	},
	["pvp"] ={
		{label = "Επιφέρετε 1500 kills σε άλλους παίκτες", id = "1500kills"},
		{label = "Ξεκινήστε 3 παραδόσεις Cargo", id = "startcargo"},

	}
}

ConfigCL.TasksEventCheck = {
	["startcargo"] = {
		progress = 0,
		checkFunc = function(src,job) 
			TriggerEvent("esx_mMafia:startcargo", job)
			return "await"
		end
	},
	["1500kills"] = {
		progress = 0,
		checkFunc = function(src,job) 
			TriggerEvent("esx_mMafia:killevent", job)
			return "await"
		end
	},
	["repairkit"] = {
		progress = 0,
		checkFunc = function(src,job) 
			TriggerEvent("esx_mMafia:repairkitchecker", job)
			return "await"
		end
	},
	["bulletproof5"] = {
		progress = 0,
		checkFunc = function(src,job) 
			TriggerEvent("esx_mMafia:bulletproof5checker", job)
			return "await"
		end
	},
	["6online30mins"] = {
		progress = 0,
		checkFunc = function(src,job) 
			local timeNow = os.time()
			local timeToEnd = timeNow + 1800
			local count = 0
			for k,v in pairs(ESX.GetPlayersFromJob(job)) do
				count = count + 1
			end
			if count < 6 then
				return "invalid"
			end
			while os.time() < timeToEnd do
				Wait(10000)
				count = 0
				for k,v in pairs(ESX.GetPlayersFromJob(job)) do
					count = count + 1
				end
				--i need to input in a var the progress that has been made. The progress is the percentage of time that has passed out of the total time. The time that has passed is timeToEnd-timeNow and the total time is timeEnd 
				local progress = (timeToEnd - os.time()) / 1800

				if count < 6 then
					break
				end
			end
			if count < 6 then
				return "failed"
			end
			return "success"
		end,
	},
	["travel100km"] = {
		progress = 0,
		checkFun = function (src,job)
			local veh = GetVehiclePedIsIn(PlayerPedId(), false)
			if veh and veh ~=0 then
				local coords = GetEntityCoords(veh)
				local distWeNeed = 10000
				while veh == GetVehiclePedIsIn(PlayerPedId(), false) do
					Wait(10000)
					local newDist = #(GetEntityCoords(veh) - coords)
					coords = GetEntityCoords(veh)
					distWeNeed = distWeNeed - newDist
					if distWeNeed < 0 then
						break
					end
				end
				if distWeNeed < 0 then
					return "success"
				else
					return "failed"
				end
			else
				return "invalid"
			end

		end
	}
}

ConfigCL.Unlockables = {
	{level = 50,	label = 'Female Dope Seed+',	icon = 'far fa-seedling',	price = 200,		type = 'item',			name = 'highgradefemaleseed',	dialog = true},
	{level = 70,	label = 'Meth Van Vehicle',		icon = 'far fa-rv',			price = 10000,		type = 'vehicle',		name = 'journey'},
	{level = 80,	label = 'Weapon Power Up',		icon = 'fal fa-raygun',		price = 30000,		type = 'item',			name = 'weapon_powerup', 		dialog = true},
	{level = 90,	label = 'Πεντάφυλλο Τσιγαράκι',	icon = 'far fa-joint',		price = 200,		type = 'item',			name = 'pentafyllo_tsigaraki',  dialog = true},
	{level = 90,	label = 'Τριφυλλο Τσιγαράκι',	icon = 'far fa-joint',		price = 25000,		type = 'item',			name = 'trifyllo_tsigaraki', 	dialog = true},
	{level = 90,	label = 'Μυτιά Κοκαϊνης',		icon = 'far fa-magic',		price = 25000,		type = 'item',			name = 'mytia_cocainis', 		dialog = true},
	{level = 150,	label = 'Superpotion',			icon = 'fal fa-raygun',		price = 100000,		type = 'white',			name = 'super_potion',			dialog = true},
	{level = 200,	label = '/teleport',			icon = 'fas fa-running',	price = 0,			type = 'nothing',		name = 'nothing'},
	{level = 250,	label = 'DAZZLINGOLD',			icon = 'fal fa-raygun',		price = 1000000,	type = 'white',			name = 'blueprint_DAZZLINGOLD'},
	{level = 300,	label = '/arena',				icon = 'fal fa-raygun',		price = 0,			type = 'nothing',		name = 'nothing'},
}

ConfigCL.Privileges = {
	{name = 'deposit',			label = 'Deposit'},
	{name = 'withdraw',			label = 'Withdraw'},
	{name = 'company-workers',	label = 'Manage Members'},
	{name = 'hire-worker',		label = 'Add Member'},
	{name = 'single-reward',	label = 'Single Reward'},
	{name = 'mass-reward',		label = 'Mass Reward'},
	{name = 'display-workers',	label = 'Display Members'},
	{name = 'set-meeting',		label = 'Request Backup'},
	{name = 'warehouse-toggle',	label = 'Toggle Warehouse'},
	{name = 'company-logs',		label = 'Mafia Logs'},
	{name = 'unlockables',		label = 'Unlockables'},
	{name = 'abilities',		label = 'Abilities'},
	{name = 'allies-foe',		label = 'Manage Allies-Enemies'},
	{name = 'restock',			label = 'Restock me'},
	{name = 'use-armory',		label = 'Use Armory'},
	{name = 'use-anon',			label = 'Use Anon System'},
}

ConfigCL.Abilities = {
	{name = 'stamina',		label = 'Unlimited Stamina',		icon = 'far fa-running',		color = 'blue',		text = 'Unlimited stamina for your mafia member\'s. <br/>  100% = unlimited stamina.'},
	{name = 'speed',		label = 'Increase Run Speed',		icon = 'far fa-running',		color = 'green',	text = 'Increase your mafia member\'s run speed. <br/>  10% = +1% more speed.'},
	{name = 'health',		label = 'Health Regeneration',		icon = 'fas fa-flask-potion',	color = 'blue',		text = 'Health regeneration every 5 seconds.<br/> 10% = +1% more regeneration.'},
	{name = 'vest',			label = 'Vest Regeneration',		icon = 'far fa-vest',			color = 'blue',		text = 'Vest regeneration every 5 seconds. <br/> 10% = +1% more regeneration.'},
	{name = 'armor',		label = 'Reduce Damage Taken',		icon = 'far fa-shield-alt',		color = 'red',		text = 'Reduce damage taken from enemies. <br/> 10% = -1% damage taken.'},
	{name = 'damage',		label = 'Increased Damage',			icon = 'fas fa-fire-smoke',		color = 'green',	text = 'Increase damage making to enemies. <br/> 10% = +1% more damage.'},
	{name = 'weed_sale',	label = 'Better Sale on Weed',		icon = 'far fa-cannabis',		color = 'red',		text = 'Better sale on weed. <br/> 10% = +1% better sale price.'},
	{name = 'coca_sale',	label = 'Better Sale on Cocaine',	icon = 'far fa-tree-palm',		color = 'red',		text = 'Better sale on cocaine. <br/> 10% = +1% better sale price.'},
	{name = 'meth_sale',	label = 'Better Sale on Meth',		icon = 'far fa-capsules',		color = 'red',		text = 'Better sale on meth. <br/> 10% = +1% better sale price.'},
	{name = 'black_money',	label = 'Extra Black Money',		icon = 'far fa-sack-dollar',	color = 'green',	text = 'Black money for all members every 1 hour. <br/> 10% = +100 Extra Black Money.'},
	{name = 'inventory',	label = 'Increase Inventory',		icon = 'far fa-warehouse',		color = 'green',	text = 'You can now have a bigger inventory with up to +100% more space.'},
}

ConfigCL.Events = {
	{name = 'Battlegrounds',		time = 'ΚΑΘΕ ΜΕΡΑ ΣΤΙΣ 00:00', coords = 'vector3(0.0, 0.0, 0.0)'},
	{name = 'Ghetto Event',			time = 'ΚΑΘΕ ΜΕΡΑ ΣΤΙΣ 15:00', coords = 'vector3(0.0, 0.0, 0.0)'},
	{name = 'Central Bank',			time = 'ΚΑΘΕ ΜΕΡΑ ΣΤΙΣ 12.00', coords = 'vector3(0.0, 0.0, 0.0)'},
	{name = 'Warzone',				time = 'ΚΑΘΕ ΜΕΡΑ ΣΤΙΣ 16:00, 17:00, 21:00', coords = 'vector3(0.0, 0.0, 0.0)'},
	{name = 'City King City',		time = 'ΚΑΘΕ ΔΕΥΤΕΡΑ 20:00', coords = 'vector3(0.0, 0.0, 0.0)'},
	{name = 'City King Sandy',		time = 'ΚΑΘΕ ΤΡΙΤΗ 20:00', coords = 'vector3(0.0, 0.0, 0.0)'},
	{name = 'City King Paleto',		time = 'ΚΑΘΕ ΤΕΤΑΡΤΗ 20:00', coords = 'vector3(0.0, 0.0, 0.0)'},
	{name = 'City King Groove',		time = 'ΚΑΘΕ ΠΕΜΠΤΗ 20:00', coords = 'vector3(0.0, 0.0, 0.0)'},
	{name = 'City King Perico',		time = 'ΚΑΘΕ ΠΑΡΑΣΚΕΥΗ 20:00', coords = 'vector3(0.0, 0.0, 0.0)'},
	{name = 'Raid Blackmarket',		time = 'ΚΑΘΕ ΠΑΡΑΣΚΕΥΗ 20:00', coords = 'vector3(0.0, 0.0, 0.0)'},
	{name = 'North Territory',		time = 'ΚΑΘΕ ΤΕΤΆΡΤΗ 22.00', coords = 'vector3(0.0, 0.0, 0.0)'},
	{name = 'East Territory',		time = 'ΚΑΘΕ ΠΈΜΠΤΗ 22.00', coords = 'vector3(0.0, 0.0, 0.0)'},
	{name = 'Venice Territory',		time = 'ΚΑΘΕ ΠΑΡΑΣΚΕΎΗ 22.00', coords = 'vector3(0.0, 0.0, 0.0)'},
	{name = 'Industrial Territory',	time = 'ΚΑΘΕ ΣΑΒΒΆΤΟ 21.00', coords = 'vector3(0.0, 0.0, 0.0)'},
	{name = 'Harbor Territory',		time = 'ΚΑΘΕ ΚΥΡΙΑΚΉ 21.00', coords = 'vector3(0.0, 0.0, 0.0)'},
	{name = 'Killzone',				time = 'ΚΑΘΕ ΜΕΡΑ ΣΤΙΣ 15.00', coords = 'vector3(0.0, 0.0, 0.0)'},
}

ConfigCL.Mafia = {
	Data = {
		--AK47
		{job = 'ms2', skin = 'COMPONENT_AK47_VARMOD_GREEKMAFIA', clip = 'COMPONENT_AK47_GREEKMAFIA_CLIP_01', type = 'AK47'},
		{job = 'brotherhood2', skin = 'COMPONENT_AK47_VARMOD_GREEKMAFIA1', clip = 'COMPONENT_AK47_GREEKMAFIA1_CLIP_01', type = 'AK47'},
		{job = 'compton', skin = 'COMPONENT_AK47_VARMOD_GREEKMAFIA2', clip = 'COMPONENT_AK47_GREEKMAFIA_CLIP_02', type = 'AK47'},
		{job = 'vagos2', skin = 'COMPONENT_AK47_VARMOD_VAGOS', clip = 'COMPONENT_AK47_VAGOS_CLIP_01', type = 'AK47'},

		--M4A5
		{job = 'peaky2', skin = 'COMPONENT_M4A5_VARMOD_GREEKMAFIA1', clip = 'COMPONENT_M4A5_GREEKMAFIA_CLIP_01', type = 'M4A5',},
		{job = 'crips2', skin = 'COMPONENT_M4A5_VARMOD_GREEKMAFIA2', clip = 'COMPONENT_M4A5_GREEKMAFIA_CLIP_02', type = 'M4A5'},
		{job = 'sinaloa3', skin = 'COMPONENT_M4A5_VARMOD_GREEKMAFIA3', clip = 'COMPONENT_M4A5_GREEKMAFIA_CLIP_03', type = 'M4A5'},
		{job = 'families2', skin = 'COMPONENT_M4A5_VARMOD_GREEKMAFIA4', clip = 'COMPONENT_M4A5_GREEKMAFIA_CLIP_04', type = 'M4A5'},
		{job = 'bloods2', skin = 'COMPONENT_M4A5_VARMOD_GREEKMAFIA5', clip = 'COMPONENT_M4A5_GREEKMAFIA_CLIP_05', type = 'M4A5'},
		{job = 'omerta2', skin = 'COMPONENT_M4A5_VARMOD_GREEKMAFIA6', clip = 'COMPONENT_M4A5_GREEKMAFIA_CLIP_06', type = 'M4A5'},
		{job = 'white2', skin = 'COMPONENT_M4A5_VARMOD_GREEKMAFIA7', clip = 'COMPONENT_M4A5_GREEKMAFIA_CLIP_07', type = 'M4A5'},
		{job = 'madrazo2', skin = 'COMPONENT_M4A5_VARMOD_GREEKMAFIA8', clip = 'COMPONENT_M4A5_GREEKMAFIA_CLIP_08', type = 'M4A5'},
		{job = 'yakuza2', skin = 'COMPONENT_M4A5_VARMOD_GREEKMAFIA9', clip = 'COMPONENT_M4A5_GREEKMAFIA_CLIP_09', type = 'M4A5'},
		{job = 'los', skin = 'COMPONENT_M4A5_VARMOD_GREEKMAFIA10', clip = 'COMPONENT_M4A5_GREEKMAFIA_CLIP_10', type = 'M4A5'},
		{job = 'bratva', skin = 'COMPONENT_M4A5_VARMOD_GREEKMAFIA11', clip = 'COMPONENT_M4A5_GREEKMAFIA_CLIP_11', type = 'M4A5'},
		{job = 'gang1', skin = 'COMPONENT_M4A5_VARMOD_GREEKMAFIA14', clip = 'COMPONENT_M4A5_GREEKMAFIA_CLIP_14', type = 'M4A5'},
	
        --G36K
        {job = 'medellin12', skin = 'COMPONENT_G36K1_VARMOD_GREEKMAFIA1', clip = 'COMPONENT_G36K1_GREEKMAFIA_CLIP_01', type = 'G36K'},
        {job = 'crips2', skin = 'COMPONENT_G36K2_VARMOD_GREEKMAFIA2', clip = 'COMPONENT_G36K2_GREEKMAFIA_CLIP_01', type = 'G36K'},
        {job = 'soamafia', skin = 'COMPONENT_G36K3_VARMOD_GREEKMAFIA3', clip = 'COMPONENT_G36K3_GREEKMAFIA_CLIP_01', type = 'G36K'},

       --[[  --BARSKA
        {job = 'svmafia', skin = 'COMPONENT_BARSKA_VARMOD_GREEKMAFIA1', clip = 'COMPONENT_BARSKA_GREEKMAFIA_CLIP_01'},

        --AUG1
        {job = 'eldragon', skin = 'COMPONENT_AUG_VARMOD_GREEKMAFIA1', clip = 'COMPONENT_AUG_GREEKMAFIA_CLIP_01'}, ]]
    }
}

--[[ConfigCL.JobGradeLabels = {
	['greek'] = {
		{label = 'ΑΡΧΗΓΟΣ',		grade = 3},
		{label = 'ΥΠΑΡΧΗΓΟΣ',	grade = 2},
		{label = 'ΕΚΤΕΛΕΣΤΗΣ',	grade = 1},
		{label = 'ΤΣΙΡΑΚΙ',		grade = 0},
	},
	['english'] = {
		{label = 'BOSS',		grade = 3},
		{label = 'UNDERBOSS',	grade = 2},
		{label = 'KILLER',		grade = 1},
		{label = 'TRIAL',		grade = 0},
	}
}

ConfigCL.MafiaTypesMenu = {
	['gang'] = {
		{label = 'OG',				grade = 3},
		{label = 'G',				grade = 2},
		{label = 'Young OG',		grade = 1},
		{label = 'Young G',			grade = 0},
	},
	['mafia'] = {
		{label = 'Αρχηγός',			grade = 3},
		{label = 'Υπαρχηγός',		grade = 2},
		{label = 'Εκτελεστής',		grade = 1},
		{label = 'Τσιράκι',			grade = 0},
	},
	['cartel'] = {
		{label = 'Drug Lord',		grade = 3},
		{label = 'Drug Managment',	grade = 2},
		{label = 'Crewmate',		grade = 1},
		{label = 'Informationer',	grade = 0},
	},
}]]