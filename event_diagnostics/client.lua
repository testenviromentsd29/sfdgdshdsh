local hasEntered = {}

Citizen.CreateThread(function()
	while not GlobalState.hasPlayerSpawned do Wait(100) end

	InitScript()
end)

function InitScript()
	Citizen.CreateThread(function()
		while true do
			Wait(5000)

			for k,v in pairs(Config.Events) do
				if not hasEntered[k] then
					if GetResourceState(k) == 'started' or GetResourceState(k) == 'running' then
						if v.onClient() then
							if not hasEntered[k] then
								hasEntered[k] = true
								TriggerServerEvent('event_diagnostics:entered', k)
							end

							break
						end
					end
				end
			end
		end
	end)
end