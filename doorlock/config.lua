Config = {}

SavedDoors = json.decode(LoadResourceFile(GetCurrentResourceName(), 'doors.json')) or {}
noGoZones = json.decode(LoadResourceFile(GetCurrentResourceName(), 'nogo.json')) or {}
for k,v in pairs(SavedDoors) do
	SavedDoors[k].textCoords = vector3(v.textCoords.x, v.textCoords.y, v.textCoords.z)
	
	for x,y in pairs(v.doors) do
		SavedDoors[k].doors[x].objCoords = vector3(y.objCoords.x, y.objCoords.y, y.objCoords.z)
	end
end

for k,v in pairs(noGoZones) do
	noGoZones[k].coords = vector3(v.coords.x, v.coords.y, v.coords.z)
end