Config = {}

Config.Drawables = {
	['HatsHelmets']		 = {get = function() return GetPedPropIndex(PlayerPedId(), 0)			end, clear = function() return ClearPedProp(PlayerPedId(), 0) end},
	['Glasses']			 = {get = function() return GetPedPropIndex(PlayerPedId(), 1)			end, clear = function() return ClearPedProp(PlayerPedId(), 1) end},
	['Masks']			 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 1)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 1, 0, 0, 0) end},
	['Hair']			 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 2)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 2, 0, 0, 0) end},
	['Pants']			 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 4)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 4, 0, 0, 0) end},
	['Bags']			 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 5)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 0) end},
	['Shoes']			 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 6)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 6, 0, 0, 0) end},
	['Chains']			 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 7)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 7, 0, 0, 0) end},
	['ShirtAcc']		 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 8)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 8, 15, 0, 0) end},
	['BodyArmor']		 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 9)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 9, 0, 0, 0) end},
	['Badges']			 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 10)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 10, 0, 0, 0) end},
	['ShirtOver']		 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 11)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 11, 15, 0, 0) end},
}