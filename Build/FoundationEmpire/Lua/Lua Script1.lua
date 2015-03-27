-- Lua Script1
-- Author: Trace
-- DateCreated: 3/14/2015 12:07:14 PM
--------------------------------------------------------------

function OnCityCanTrain(playerID, cityID, unitID)
	local player = Players[playerID]
	local city = player:GetCityByID(cityID)
	local unit = player:GetUnitByID(unitID)

	print(player:GetName())
	print(city:GetName())
	if (unit ~= nil) then
		print (unit:GetName())
	end

	if unitID == GameInfoTypes["UNIT_FOUNDATION_DEFENDER"] then
		if player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_FOUNDATION"] then
			print("OnCityCanTrain: CIVILIZATION_FOUNDATION allows Foundation Defender")
			return true
		else
			print("OnCityCanTrain: Non-CIVILIZATION_FOUNDATION blocked from building Foundation Defender")
			return false
		end
	end

	return true
end

GameEvents.CityCanTrain.Add(OnCityCanTrain)

function OnPlayerCanTrain(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)

	print(player:GetName())
	if (unit ~= nil) then
		print (unit:GetName())
	end

	if unitID == GameInfoTypes["UNIT_FOUNDATION_DEFENDER"] then
		if player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_FOUNDATION"] then
			print("OnPlayerCanTrain: CIVILIZATION_FOUNDATION allows Foundation Defender")
			return true
		else
			print("OnPlayerCanTrain: Non-CIVILIZATION_FOUNDATION blocked from building Foundation Defender")
			return false
		end
	end

	return true
end

GameEvents.PlayerCanTrain.Add(OnPlayerCanTrain)