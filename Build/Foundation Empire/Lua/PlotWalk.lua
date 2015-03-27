-- PlotWalk
-- Author: Trace
-- DateCreated: 3/24/2015 1:47:13 PM
--------------------------------------------------------------
local MoveRight = 1;
local MoveDown = 2;
local MoveLeft = 3;
local MoveUp = 4;
local plotStartX = -1;
local plotStartY = -1;
local plotX = -1;
local plotY = -1;
local plotMaxDistanceFromStart = -1;
local moveDistance = 1;
local moveDirection = MoveRight;
local distanceMoved = 0;

------------------------------------------------------------------------
-- InitPlotWalk - sets up the initial conditions for a spiral walk of
-- plots that surround the plot starting at the given startX,startY
-- position. NextPlot will return nil once a plot is walked that is
-- farther from the starting position than the number of tiles given
-- by maxDistanceFromStart.
------------------------------------------------------------------------
function InitPlotWalk(startX, startY, maxDistanceFromStart)
	plotStartX = startX;
	plotStartY = startY;
	plotMaxDistanceFromStart = maxDistanceFromStart;
	plotX = startX;
	plotY = startY;
end

------------------------------------------------------------------------
-- NextPlot - returns the next plot in the spiral plot walk initialized
-- by a call to InitPlotWalk. Once the end of the walk is reached, nil
-- will be returned.
------------------------------------------------------------------------
function NextPlot()

	local foundPlot = nil;
	while(foundPlot == null) do
		local plot = Map.GetPlot(plotX, plotY);
		if (plot ~=nil) then
			local distanceFromStart = Map.PlotDistance(plotStartX, plotStartY, plotX, plotY);
			if (distanceFromStart > plotMaxDistanceFromStart) then
				return nil;
			end
			
			foundPlot = plot;
			local terrainType = plot:GetTerrainType();
			print("X: " .. plotX .. " Y: " .. plotY .. " Terrain: " .. terrainType .. " Distance: " .. distanceFromStart .. " MoveDirection: " .. moveDirection);
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
	
	return foundPlot;
end
