-- FoundationSetup
-- Author: TraceF
-- DateCreated: 3/25/2015 5:11:41 PM
--------------------------------------------------------------
include("FoundationUtilities.lua");
include("AddFoundationResources.lua");
include("AddFoundationBonuses.lua");

function FoundationSetup(iCivID)
	local player = GetFoundationPlayer();
	if (player == nil) then
		return;
	end

	AddFoundationResources(player);
	AddFoundationBonuses(player);
end