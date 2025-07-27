ConfigCL = {}

ConfigCL.Weekday = 5			--Day of week	See ConfigCL.WdaysLabels
ConfigCL.StartHour = 21			--Time to start the event
ConfigCL.EventDuration = 120	--Minutes
ConfigCL.MaxTeamPlayers = 14	--Max team players can join the event

ConfigCL.Zones = {
    ["drugdealer"] = {
        Label = "Drug Dealer Area",
        Center = vector3(-1163.14, 4925.43, 221.90),
        Radius = 100.0,
        NPC = vector3(-1163.14, 4925.43, 221.90),
        Status = false,
        Heading = 267.74,
    },
}

ConfigCL.DrugPrice = {
    --["weed"] = 1000,
    --["cannabis"] = 1,
    --["mushroom"] = 18,
    --["cocaine"] = 1100,
	--["cocaleaf"] = 2,
    --["crack"] = 1125,
    --["lsd"] = 38,
    --["mdma"] = 38,
    --["crystalmeth"] = 1500,
    --["morphine"] = 1000,
    ["field_weed"] = 20000,
    ["field_coke"] = 25000,
    ["field_meth"] = 30000,
}

ConfigCL.WdaysLabels = {
	[1] = 'Sunday',
	[2] = 'Mondey',
	[3] = 'Tuesday',
	[4] = 'Wednesday',
	[5] = 'Thursday',
	[6] = 'Friday',
	[7] = 'Saturday',
}