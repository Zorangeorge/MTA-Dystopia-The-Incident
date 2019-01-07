all_mechanic_cols = createElement("mechanicColGroup","mechanicColGroup-ID")

LS_mechanic_col = createMarker(2105.6,-1938.05,13.64,'cylinder', 3, 125, 125, 125, 125)
Doherty1 = createMarker(-2053.6428222656, 170.15090942383, 28.102718353271,'cylinder', 3, 125, 125, 125, 125)
--Doherty2 = createMarker(-2053.5793457031, 178.66848754883, 28.102718353271,'cylinder', 3, 125, 125, 125, 125)
Blueberry = createMarker(207.2626953125, -258.6435546875, 1.0,'cylinder', 3, 125, 125, 125, 125)
A69_mechanic_col = createMarker(119.2646484375, 1863.4267578125, 16.797166824341,'cylinder', 3, 125, 125, 125, 125)
RefugeeCamp_mechanic_col = createMarker(304.2314453125, 2049.5478515625, 16.640625,'cylinder', 3, 125, 125, 125, 125)
--Dillimore_mechanic_col = createMarker(304.2314453125, 2049.5478515625, 16.640625,'cylinder', 3, 125, 125, 125, 125)


setElementData(LS_mechanic_col,"mechanic_col",true);
setElementData(LS_mechanic_col,"BotTeam",getTeamFromName("Scavengers"));
setElementParent(LS_mechanic_col, all_mechanic_cols)
setElementData(Doherty1,"mechanic_col",true);
setElementData(Doherty1,"BotTeam",getTeamFromName("Scavengers"));
setElementParent(Doherty1, all_mechanic_cols)
--setElementData(Doherty2,"mechanic_col",true);
--setElementData(Doherty2,"BotTeam",getTeamFromName("Scavengers"));
--setElementParent(Doherty2, all_mechanic_cols)
setElementData(Blueberry,"mechanic_col",true);
setElementData(Blueberry,"BotTeam",getTeamFromName("Bandits"));
setElementParent(Blueberry, all_mechanic_cols)
setElementData(A69_mechanic_col,"mechanic_col",true);
setElementData(A69_mechanic_col,"BotTeam",getTeamFromName("Establishment"));
setElementParent(A69_mechanic_col, all_mechanic_cols)
setElementData(RefugeeCamp_mechanic_col,"mechanic_col",true);
setElementData(RefugeeCamp_mechanic_col,"BotTeam",getTeamFromName("Establishment"));
setElementParent(RefugeeCamp_mechanic_col, all_mechanic_cols)

function hitTheMechanicMarker(hitelem)

	if hitelem == localPlayer and getPedOccupiedVehicle(hitelem) then

	outputDebugString("entering mech col")
	outputInteractInfo("Mechanic\n[E]",240,240,240)
	bindKey("e","down",mechanicDialogueScav)
	end
	
end

function leaveTheMechanicMarker(hitelem)

	if hitelem == localPlayer then

	outputDebugString("leaving mech col")
	unbindKey("e","down",mechanicDialogueScav)
	end
	
end

addEventHandler('onClientMarkerHit',all_mechanic_cols,hitTheMechanicMarker,true);
addEventHandler('onClientMarkerLeave',all_mechanic_cols,leaveTheMechanicMarker,true);