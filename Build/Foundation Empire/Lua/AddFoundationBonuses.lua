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
	foundationPlayer:SetTraitExtraFoundedCityTerritoryClaimRangeMod(14);
end