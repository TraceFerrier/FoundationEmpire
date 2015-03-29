-- SecondFoundationer
-- Author: TraceF
-- DateCreated: 3/15/2015 3:34:29 PM
--------------------------------------------------------------

sPromotedUnits = {};
PromoDefenseHigh = "PROMOTION_SECOND_FOUNDATION_DEFENSE_HIGH";
PromoDefenseMedium = "PROMOTION_SECOND_FOUNDATION_DEFENSE_MEDIUM";
PromoDefenseLow = "PROMOTION_SECOND_FOUNDATION_DEFENSE_LOW";
PromoOffenseHigh = "PROMOTION_SECOND_FOUNDATION_ATTACK_SUPPRESS_HIGH";
PromoOffenseMedium = "PROMOTION_SECOND_FOUNDATION_ATTACK_SUPPRESS_MEDIUM";
PromoOffenseLow = "PROMOTION_SECOND_FOUNDATION_ATTACK_SUPPRESS_LOW";
TypeSecondFoundationer = GameInfoTypes["UNIT_SECOND_FOUNDATIONER"];
TypeFoundationScientist = GameInfoTypes["UNIT_FOUNDATION_SCIENTIST"];
TypeFoundationMerchantPrince = GameInfoTypes["UNIT_FOUNDATION_MERCHANT_PRINCE"];
TypeWorker = GameInfoTypes["UNIT_WORKER"];
TypeSettler = GameInfoTypes["UNIT_SETTLER"];
TypeMissionary = GameInfoTypes["UNIT_MISSIONARY"];
TypeProphet = GameInfoTypes["UNIT_PROPHET"];
TypeScientist = GameInfoTypes["UNIT_SCIENTIST"];
TypeGeneral = GameInfoTypes["UNIT_GREAT_GENERAL"];
TypeMerchant = GameInfoTypes["UNIT_MERCHANT"];
TypeArtist = GameInfoTypes["UNIT_ARTIST"];
TypeEngineer = GameInfoTypes["UNIT_ENGINEER"];
TypeWorkboat = GameInfoTypes["UNIT_WORKBOAT"];
TypeAtomicBomb = GameInfoTypes["UNIT_ATOMIC_BOMB"];
TypeNuclearMissile = GameInfoTypes["UNIT_NUCLEAR_MISSILE"];

TypeFoundationCivilization = GameInfoTypes["CIVILIZATION_FOUNDATION"];
MoveRight = 1;
MoveDown = 2;
MoveLeft = 3;
MoveUp = 4;

------------------------------------------------------------------------
-- IsPromoSet
------------------------------------------------------------------------
function IsPromoSet(unit, promo)
	return  unit:IsHasPromotion(GameInfoTypes[promo]);
end

------------------------------------------------------------------------
-- SetPromo
------------------------------------------------------------------------
function SetPromo(unit, promo)
	local isAlreadySet = unit:IsHasPromotion(GameInfoTypes[promo])
	if (isAlreadySet == false) then
		print(unit:GetName() .. ": " .. promo .. " set") 
		unit:SetHasPromotion(GameInfoTypes[promo], true)
		AddUnitToPromotionsTable(unit);
	end
end

------------------------------------------------------------------------
-- ClearPromo
------------------------------------------------------------------------
function ClearPromo(unit, promo)
	local isAlreadySet = unit:IsHasPromotion(GameInfoTypes[promo])
	if (isAlreadySet == true) then
		print(unit:GetName() .. ":" .. promo .. " cleared") 
		unit:SetHasPromotion(GameInfoTypes[promo], false)
	end
end

------------------------------------------------------------------------
-- AddUnitToPromotionsTable
------------------------------------------------------------------------
function AddUnitToPromotionsTable(unit)
	-- Make sure unit isn't already in table
	for i, unitInTable in pairs(sPromotedUnits) do
		if (unitInTable:GetID() == unit:GetID()) then
			return;
		end
	end
	
	table.insert(sPromotedUnits, unit);
end

------------------------------------------------------------------------
-- ClearAllPromotions
------------------------------------------------------------------------
function ClearAllPromotions(unit)
	ClearPromo(unit, PromoDefenseHigh);
	ClearPromo(unit, PromoDefenseMedium);
	ClearPromo(unit, PromoDefenseLow);
	ClearPromo(unit, PromoOffenseHigh);
	ClearPromo(unit, PromoOffenseMedium);
	ClearPromo(unit, PromoOffenseLow);
end

------------------------------------------------------------------------
-- ClearAllCurrentPromotions
------------------------------------------------------------------------
function ClearAllCurrentPromotions()
	for i, unitInTable in pairs(sPromotedUnits) do
		ClearAllPromotions(unitInTable);
	end
	
	sPromotedUnits = {};
end

------------------------------------------------------------------------
-- ApplyPromotionsToFriend
------------------------------------------------------------------------
function ApplyPromotionsToFriend(unit, distance)
	if distance < 2 then
		ClearPromo(unit, PromoDefenseLow);
		ClearPromo(unit, PromoDefenseMedium);
		SetPromo(unit, PromoDefenseHigh);
	elseif distance < 4 then
		if (IsPromoSet(unit, PromoDefenseHigh) == false) then
			ClearPromo(unit, PromoDefenseLow);
			SetPromo(unit, PromoDefenseMedium);
		end
	elseif distance < 6 then
		if (IsPromoSet(unit, PromoDefenseHigh) == false and IsPromoSet(unit, PromoDefenseMedium) == false) then
			SetPromo(unit, PromoDefenseLow);
		end
	end
end

------------------------------------------------------------------------
-- ApplyPromotionsToEnemy 
------------------------------------------------------------------------
function ApplyPromotionsToEnemy(unit, distance)
	if distance < 2 then
		ClearPromo(unit, PromoOffenseLow);
		ClearPromo(unit, PromoOffenseMedium);
		SetPromo(unit, PromoOffenseHigh);
	elseif distance < 4 then
		if (IsPromoSet(unit, PromoOffenseHigh) == false) then
			ClearPromo(unit, PromoOffenseLow);
			SetPromo(unit, PromoOffenseMedium);
		end
	elseif distance < 6 then
		if (IsPromoSet(unit, PromoOffenseHigh) == false and IsPromoSet(unit, PromoOffenseMedium) == false) then
			SetPromo(unit, PromoOffenseLow);
		end
	end
end

function CanUnitTakeSecondFoundationerPromotion(unit)
	local unitType = unit:GetUnitType();

	if (unitType == TypeSecondFoundationer) then
		return false;
	end

	if (unitType == TypeFoundationScientist) then
		return false;
	end

	if (unitType == TypeFoundationMerchantPrince) then
		return false;
	end

	if (unitType == TypeWorker) then
		return false;
	end

	if (unitType == TypeSettler) then
		return false;
	end

	if (unitType == TypeMissionary) then
		return false;
	end

	if (unitType == TypeProphet) then
		return false;
	end

	if (unitType == TypeScientist) then
		return false;
	end

	if (unitType == TypeGeneral) then
		return false;
	end

	if (unitType == TypeMerchant) then
		return false;
	end

	if (unitType == TypeArtist) then
		return false;
	end

	if (unitType == TypeEngineer) then
		return false;
	end

	if (unitType == TypeWorkboat) then
		return false;
	end

	if (unitType == TypeAtomicBomb) then
		return false;
	end

	if (unitType == TypeNuclearMissile) then
		return false;
	end

	return true;
end

------------------------------------------------------------------------
-- FindUnitsInRangeOfSecondFoundationerAndApplyEffects 
------------------------------------------------------------------------
function FindUnitsInRangeOfSecondFoundationerAndApplyEffects(secondFoundationerUnit)
	local foundationPlayer = Players[secondFoundationerUnit:GetOwner()];
	local foundationTeam = Teams[foundationPlayer:GetTeam()];
	local secondFoundationerX = secondFoundationerUnit:GetX();
	local secondFoundationerY = secondFoundationerUnit:GetY();
	local plotX = secondFoundationerX;
	local plotY = secondFoundationerY;
	local lastPlotReached = false;
	local moveDistance = 1;
	local moveDirection = MoveRight;
	local distanceMoved = 0;
	
	while(lastPlotReached == false) do
		plot = Map.GetPlot(plotX, plotY)
		if (plot ~=nil) then
			local distanceFromSecondFoundationer = Map.PlotDistance(secondFoundationerX, secondFoundationerY, plotX, plotY);
			
			if (distanceFromSecondFoundationer > 6) then
				lastPlotReached = true;
				break;
			end
			
			terrainType = plot:GetTerrainType();
			-- print("X: " .. plotX .. " Y: " .. plotY .. " Terrain: " .. terrainType .. " Distance: " .. distanceFromSecondFoundationer .. " MoveDirection: " .. moveDirection);
			if (plot:GetNumUnits() > 0) then
				for i = 0, plot:GetNumUnits() - 1, 1 do
					local unit = plot:GetUnit(i);
					if (unit ~= nil) then
						if (CanUnitTakeSecondFoundationerPromotion(unit)) then
							-- print("Found unit: " .. unit:GetName());
							unitPlayerID = unit:GetOwner();
							unitPlayer = Players[unitPlayerID];
							unitTeamID = unitPlayer:GetTeam();
							unitTeam = Teams[unitTeamID];
							isFoundationUnit = unitPlayer:GetCivilizationType() == TypeFoundationCivilization;
							isFoundationAtWarWithUnit = foundationTeam:IsAtWar(unitTeamID);
							
							if (isFoundationAtWarWithUnit == true) then
								-- print("Foundation is at war with this unit");
							end
							
							if (isFoundationUnit or foundationPlayer:IsAllies(unitPlayerID) or foundationPlayer:IsFriends(unitPlayerID)) then
								ApplyPromotionsToFriend(unit, distanceFromSecondFoundationer);
							elseif (isFoundationAtWarWithUnit or unitTeam:IsBarbarian()) then
								ApplyPromotionsToEnemy(unit, distanceFromSecondFoundationer);
							end
						end
					end
				end
			end
		end
		
		if (moveDirection == MoveRight) then
			plotX = plotX + 1;
			distanceMoved = distanceMoved + 1;
			if (distanceMoved == moveDistance) then
				moveDirection = MoveDown;
				distanceMoved = 0;
			end
		elseif (moveDirection == MoveDown) then
			plotY = plotY + 1;
			distanceMoved = distanceMoved + 1;
			if (distanceMoved == moveDistance) then
				moveDistance = moveDistance + 1;
				moveDirection = MoveLeft;
				distanceMoved = 0;
			end
		elseif (moveDirection == MoveLeft) then
			plotX = plotX - 1;
			distanceMoved = distanceMoved + 1;
			if (distanceMoved == moveDistance) then
				moveDirection = MoveUp;
				distanceMoved = 0;
			end
		elseif (moveDirection == MoveUp) then
			plotY = plotY - 1;
			distanceMoved = distanceMoved + 1;
			if (distanceMoved == moveDistance) then
				moveDistance = moveDistance + 1;
				moveDirection = MoveRight;
				distanceMoved = 0;
			end
		end
	end	 
end

------------------------------------------------------------------------
-- ApplySecondFoundationerEffects - 
------------------------------------------------------------------------
function ApplySecondFoundationerEffects()

	ClearAllCurrentPromotions();
	-- Search through all players to find the Foundation player
	for i, player in pairs(Players) do
		if player:IsEverAlive() then
			if player:GetCivilizationType() == TypeFoundationCivilization then
			
				-- Search through all Foundation units to find Second Foundationers
				for unit in player:Units() do
					if unit:GetUnitType() == TypeSecondFoundationer then
					
						-- A Second Foundationer has been found - find all friendly and enemy
						-- units that are within range of the SF, and apply the appropriate
						-- defense or offense promotions
						-- print("Found Second Foundationer...");
						FindUnitsInRangeOfSecondFoundationerAndApplyEffects(unit);
					end
				end
			end
		end
	end
end

function HandleFoundationEffects(iPlayer)
	ApplySecondFoundationerEffects();
end

-- GameEvents.UnitSetXY.Add(ApplySecondFoundationerEffects)

GameEvents.PlayerDoTurn.Add(HandleFoundationEffects)