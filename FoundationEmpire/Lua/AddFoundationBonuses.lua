-- AddFoundationBonuses
-- Author: TraceF
-- DateCreated: 3/25/2015 5:14:01 PM
--------------------------------------------------------------
function AddFoundationBonuses(foundationPlayer)

	local iHandicap = Game:GetHandicapType();
	if (iHandicap == 7) then
		AddDeityBonuses(foundationPlayer);
	elseif (iHandicap == 6) then
		AddImmortalBonuses();
	elseif (iHandicap == 5) then
		AddEmperorBonuses();
	elseif (iHandicap == 4) then
		AddKingBonuses();
	elseif (iHandicap == 3) then
		AddPrinceBonuses();
	end
end

function AddKingBonuses()
end

function AddEmperorBonuses()
end

function AddImmortalBonuses()
end

function AddDeityBonuses(foundationPlayer)
	-- Master of Technology Trait bonuses
	print("Adding Deity Bonuses...");
	foundationPlayer:SetTraitPopUnhappinessMod(-95);
	foundationPlayer:SetTraitExtraFoundedCityTerritoryClaimRangeMod(19);
	foundationPlayer:SetTraitSetGreatScientistRateMod(90);
	foundationPlayer:SetTraitWonderProductionMod(95);
	foundationPlayer:SetTraitCityStateFriendshipMod(90);
	foundationPlayer:SetTraitLandTradeRouteRangeBonusMod(90);
	foundationPlayer:SetTraitTradeRouteResourceMod(90);
	foundationPlayer:SetTraitTradeReligionModifier(90);
	foundationPlayer:SetBuildingYieldModifier("BUILDING_GALACTIC_LIBRARY", "YIELD_SCIENCE", 43 );
	foundationPlayer:SetBuildingYieldModifier("BUILDING_SECOND_FOUNDATION_ACADEMY", "YIELD_SCIENCE", 33 );
	foundationPlayer:SetBuildingYieldModifier("BUILDING_GALACTIC_TEMPLE", "YIELD_FAITH", 23 );
end