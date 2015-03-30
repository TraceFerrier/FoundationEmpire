-- Lua Script2
-- Author: TraceF
-- DateCreated: 3/24/2015 1:20:01 PM
--------------------------------------------------------------
include("PlotWalk.lua");

TypeFoundationCivilization = GameInfoTypes["CIVILIZATION_FOUNDATION"];
local resourcesToAdd = {};
local resourcesAdded = {};
local resourceTypesCount = 30;

------------------------------------------------------------------------
-- AddFoundationResources - Adds bonus resources nearby the Foundation
-- capital. The number of extra resources depends on the current
-- difficulty level.
------------------------------------------------------------------------
function AddFoundationResources(foundationPlayer)
	
	-- Don't give a resource bonus to AI players
	if (foundationPlayer:IsHuman() == false) then
		return;
	end

	-- Only lay out resources when a new game is first started
	-- (not when a saved game is loaded).
	local iTurn = Game.GetGameTurn();
	if (iTurn > 0) then
		return;
	end

	-- Give a higher resource bonus when playing against higher difficulty levels
	local resourceToAddCount = 0;
	local iHandicap = Game:GetHandicapType();
	if (iHandicap == 7) then
		resourceToAddCount = 5;
	elseif (iHandicap == 6) then
		resourceToAddCount = 4;
	elseif (iHandicap == 5) then
		resourceToAddCount = 2;
	end
	
	print("Resources to add: " .. resourceToAddCount);

	if (resourceToAddCount == 0) then
		return;
	end

	localResourcesAdded = 0;
	print("AddFoundationResources: " .. foundationPlayer:GetName() .. " Turn: " .. iTurn);
	InitializeResources();
	local startingPlot = foundationPlayer:GetStartingPlot();
	if (startingPlot ~= nil) then
		InitPlotWalk(startingPlot:GetX(), startingPlot:GetY(), 10);
		local plot = NextPlot();
		while(plot ~= nil) do
			local resourceID = GetResourceToAdd(plot);
			if (resourceID ~= null) then
				local resourceQuantity = GetResourceQuantity(resourceID);
				plot:SetResourceType(resourceID, resourceQuantity);
				print("Resource: " .. resourceID .. "Quantity: " .. resourceQuantity);
				localResourcesAdded = localResourcesAdded + 1;
				if (localResourcesAdded == resourceToAddCount) then
					return;
				end
			end
			plot = NextPlot();
		end
	end
		
	fResourcesAdded = true;
end

------------------------------------------------------------------------
-- CanPlaceResource - return true if the resource of the given ID can
-- be placed on the given plot (i.e. the plot doesn't already have a
-- different resource, you're not trying to put whales on land, etc).
------------------------------------------------------------------------
function CanPlaceResource(plot, resourceID)
	if (plot == nil or resourceID == nil or resourceID == -1) then
		return false;
	end

	if plot:IsStartingPlot() then
		return false;
	end

	return plot:CanHaveResource(resourceID, false);
end

------------------------------------------------------------------------
-- CanPlaceResource - returns the ID of a resource that's appropriate
-- for the given plot. If no resource can/should be placed on the plot,
-- nill will be returned.
------------------------------------------------------------------------
function GetResourceToAdd(plot)
	for i = 1, resourceTypesCount do
		if (resourcesAdded[i] == false) then
			if (CanPlaceResource(plot, resourcesToAdd[i])) then
				resourcesAdded[i] = true;
				return resourcesToAdd[i];
			end
		end
	end

	return nil;
end

function InitializeResources()
	resourcesToAdd[1] = GameInfoTypes["RESOURCE_IRON"];
	resourcesToAdd[2] = GameInfoTypes["RESOURCE_OIL"];
	resourcesToAdd[3] = GameInfoTypes["RESOURCE_URANIUM"];
	resourcesToAdd[4] = GameInfoTypes["RESOURCE_MARBLE"];
	resourcesToAdd[5] = GameInfoTypes["RESOURCE_SUGAR"];
	resourcesToAdd[6] = GameInfoTypes["RESOURCE_IVORY"];
	resourcesToAdd[7] = GameInfoTypes["RESOURCE_ALUMINUM"];
	resourcesToAdd[8] = GameInfoTypes["RESOURCE_FUR"];
	resourcesToAdd[9] = GameInfoTypes["RESOURCE_WHALE"];
	resourcesToAdd[10] = GameInfoTypes["RESOURCE_PEARLS"];
	resourcesToAdd[11] = GameInfoTypes["RESOURCE_SILVER"];
	resourcesToAdd[12] = GameInfoTypes["RESOURCE_GEMS"];
	resourcesToAdd[13] = GameInfoTypes["RESOURCE_DYE"];
	resourcesToAdd[14] = GameInfoTypes["RESOURCE_SILK"];
	resourcesToAdd[15] = GameInfoTypes["RESOURCE_SPICES"];
	resourcesToAdd[16] = -1;
	resourcesToAdd[17] = -1;
	resourcesToAdd[18] = -1;
	resourcesToAdd[19] = -1;
	resourcesToAdd[20] = -1;
	resourcesToAdd[21] = -1;
	resourcesToAdd[22] = -1;
	resourcesToAdd[23] = -1;
	resourcesToAdd[24] = -1;
	resourcesToAdd[25] = -1;
	resourcesToAdd[26] = -1;
	resourcesToAdd[27] = -1;
	resourcesToAdd[28] = -1;
	resourcesToAdd[29] = -1;
	resourcesToAdd[30] = -1;
	Shuffle(resourcesToAdd);

	for i = 1, resourceTypesCount do
		resourcesAdded[i] = false;
	end
end

function GetResourceQuantity(resourceType)
	local quantity = 1;
	for row in GameInfo.Resource_QuantityTypes{ResourceType = resourceType} do
		if row.Quantity > quantity then
			quantity = row.Quantity;
		end
	end
	return quantity;
end

