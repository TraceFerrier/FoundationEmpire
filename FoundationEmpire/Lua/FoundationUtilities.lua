-- FoundationUtilities.lua
-- Author: TraceF
-- DateCreated: 3/24/2015 8:21:56 PM
--------------------------------------------------------------
TypeFoundationCivilization = GameInfoTypes["CIVILIZATION_FOUNDATION"];

function GetFoundationPlayer()
	for i, player in pairs(Players) do
		if player:IsEverAlive() then
			if player:GetCivilizationType() == TypeFoundationCivilization then
				return player;
			end
		end
	end

	return nil;
end

function ShuffleOld(array)
    local n, random, j = table.getn(array), math.random
    for i=1, n do
        j,k = random(n), random(n)
        array[j],array[k] = array[k],array[j]
    end
    return array
end

function swap(array, index1, index2)
    array[index1], array[index2] = array[index2], array[index1]
end

function Shuffle(array)
    local counter = #array
    while counter > 1 do
        local index = math.random(counter)
        swap(array, index, counter)
        counter = counter - 1
    end
end
