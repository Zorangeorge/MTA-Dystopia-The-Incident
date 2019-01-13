addEvent("CreateRepairColshape")
addEvent("ServerTopNotification",true)
addEvent("ServerBottomNotification",true)
addEvent("ServerStatusInfo",true)

function displayNotif(text)
outputTopBar(text, client, 240,240,240)
end
addEventHandler ("ServerTopNotification",resourceRoot,displayNotif)

function displayStatus(text)
outputStatusInfo(text, client, 240,240,240)
end
addEventHandler ("ServerStatusInfo",resourceRoot,displayStatus)

function displayBottomNotif(text)
outputInteractInfo(text, client, 250, 200, 0)
end
addEventHandler ("ServerBottomNotification",resourceRoot,displayBottomNotif)

--vehicle parts and stats--

local vehPanelNo = {0,1,2,3,4,5,6} -- panel number
local vehPanelSt = {0,1,2,3} -- panel state

local vehWheelSt = {0,1,2} -- 0 intact, 2 missing

local vehDoorNo = {0,1,2,3,4,5} 
local vehDoorSt = {0,1,2,3,4}

function processVehiclesOnStart() -- creates colshapes around all vehicles for interaction purposes; creates vehicle accessories

local vehtable = getElementsByType("vehicle")

	for _, veh in ipairs(vehtable) do 
	
		local x,y,z = getElementPosition(veh)
		local repaircol = createColSphere(x,y,z, 3)
		local model = getElementModel(veh) 
		attachElements (repaircol,veh)
		setElementData(repaircol,"coltype","vehinteract",true)
		
		if model == 500 then -- Mesa: add a strongbox in the back
			local box = createObject(964,0,0,0)
			local strongboxcolshape =  createColSphere(0,0,0,1.3)
			attachElements(strongboxcolshape,box,0,-1,0.5)
			attachElements(box, veh, 0,-1.2,-0.3)
			setObjectScale(box,0.8)
			setElementCollisionsEnabled(box, false)
			setElementData(box,"carprop",true)
			setElementData(strongboxcolshape, "strongboxnode", true,true)
			setElementData(veh,"attachment",box)
		end
		
		if getElementID(veh) == "Chip_Ambulance" then -- chip ambulance: a way to join the Establishment as a refugee. Get in the back to get a tracking chip. Needs further scripting.
			setElementData(veh,"chipvehicle",true)
			setVehicleEngineState(veh,false)
		end
		
		if model == 447 then -- seasparrow/police armed maverick: add a gun in the front
			local gun = createObject(362,0,0,0)
			attachElements(gun, veh, -6,0.7,-0.9,-90,-55,0)
			setObjectScale(gun,1.8)
			setElementCollisionsEnabled(gun, false)
			setElementData(gun,"carprop",true)
			setElementData(veh,"driverminigun_vehweapon",gun)
			
		end
		
		if model == 434 then -- hotknife/interceptor
			local gun = createObject(362,0,0,0)
			attachElements(gun, veh, -1.2,0.1,0.1,-90,-55,0)
			setObjectScale(gun,1.8)
			setElementCollisionsEnabled(gun, false)
			setElementData(gun,"carprop",true)
			setElementData(veh,"driverminigun_vehweapon",gun)
			
		end
		
	end
end
addCommandHandler ( "ccol", processVehiclesOnStart )

function fuel_interact(hitElement)
	
local elemType = getElementType(hitElement)
local objectBarrel = getElementData(source,"fuelcolshape_barrel") or false
	
	if elemType == "player" and isPedInVehicle(hitElement) then -- don't trigger for players inside vehicles
		return
	elseif not objectBarrel then
		return
	end
	if getElementData(objectBarrel,"destroyed") == true then return end --check if the barrel is exploded
	
	if elemType == "player" and ( getElementModel(objectBarrel) == 1217 or getElementModel(objectBarrel) == 1225 ) then  -- if a player hits a fuel barrel colshape
		
		setElementData(hitElement,"insideFuelCol", source)
		
		local fuelQuant = getElementData(source,"fuel") or 0
		local friendlyFuel 
		
		if fuelQuant == 0 then friendlyFuel = "empty"
		else friendlyFuel = ""..(fuelQuant * 10).." l"
		end
		
		if fuelQuant == 0 then
			outputInteractInfo("[empty]", hitElement, 240,240,240)
		elseif fuelQuant ~= 0 then
			outputInteractInfo("Take fuel\n("..friendlyFuel..")\n[E]", hitElement, 240,240,240)
			bindKey(hitElement,"e","down",triggerRefillCanister)
			triggerClientEvent(hitElement,"showHelpMessageEvent",hitElement,fuel_help_messsage)
		end
	else 
	return
	end	
end
addEventHandler("onColShapeHit", root, fuel_interact) 

function clear_fuel_interact(leaveElement)
local objectBarrel = getElementAttachedTo(source) or false
local elemType = getElementType(leaveElement)
	if not objectBarrel then return	end
	
	if elemType == "player" and ( getElementModel(objectBarrel) == 1217 or getElementModel(objectBarrel) == 1225 ) then  -- if a player leaves a fuel barrel colshape
		setElementData(leaveElement,"insideFuelCol", nil)
		unbindKey(leaveElement,"e","down",triggerRefillCanister)
	end
end
addEventHandler("onColShapeLeave", root, clear_fuel_interact)

function triggerRefillCanister (player)
local itemcount, slot = hasPlayerItem("Empty Canister", player)
	if itemcount and itemcount>0 then
		if getElementData(player,"insideFuelCol") ~= nil then
				local barrel = getElementData(player,"insideFuelCol")
				local fuelQuant = getElementData(barrel,"fuel")
				
				if fuelQuant >= 1 then
					setPedWeaponSlot(player,0)
					used = true
					local x,y,z = getElementPosition( barrel )
					local px, py, pz = getElementPosition( player )
					local pedangle = ( 360 - math.deg ( math.atan2 ( ( x - px ), ( y - py ) ) ) ) % 360
					setPedRotation( player, pedangle )
					setPedAnimation ( player, "INT_HOUSE", "wash_up", 4000, true, false, false, false)
					triggerClientEvent(player, "sleep:drawDXProgress", player, 4000,4000)
					setTimer(triggerClientEvent,4000,1,player, "sleep:stopDXProgress", player)
					setTimer(createwateritsamiracle, 4500, 1, "Fuel Canister", player)
					setElementData(barrel,"fuel", fuelQuant-1 )
					local xp = getPlayerExp(player)
					setPlayerExp(player,xp+1)
					outputStatusInfo("+1 xp",player, 240,240,240 )
					
					PlayersItens[player][slot]="Empty"
					triggerClientEvent(player,"RefreshDraw",player)
					triggerClientEvent("synchronizeTables",player,PlayersItens)
				else
					outputInteractInfo("[ barrel empty! ]", player, 240,240,240)
				end
		else
			return
		end
	else
	outputInteractInfo("[ empty canister required! ]",player,255,255,255,255)
	end
end

function carscavenge_interact(hitElement)
	
local elemType = getElementType(hitElement)
local objectWreck = getElementAttachedTo(source) or false
local scavamount = getElementData(source,"scavamount")
	
	if elemType == "player" and isPedInVehicle(hitElement) then -- don't trigger for players inside vehicles
		return
	elseif not objectWreck then
		return
	end
	local vehScenery = getElementData(objectWreck,"vehicle-scenery")
	local model = getElementModel(objectWreck)
		if model == 3594 then model = "wreck"
		elseif model == 3593 then model = "wreck"
		elseif model == 13591 then model = "wreck"
		elseif model == 12957 then model = "wreck"
		elseif vehScenery then model = "vehiclescenery"
		end 
	
	if elemType == "player" and ((model == "wreck") or (model == "vehiclescenery")) then  -- if a player hits a car wreck colshape
		
		setElementData(hitElement,"insideScavengeCol", source)
		
		local partsQuant = getElementData(source,"scavamount")
		
		if partsQuant == 0 then
			return
		elseif partsQuant ~= 0 then
			outputInteractInfo("Scavenge\n[E]", hitElement, 240,240,240)
			bindKey(hitElement,"e","down",triggerScavengeWreck)
			triggerClientEvent(hitElement,"showHelpMessageEvent",hitElement,wreck_help_messsage)
		end
	else 
	return
	end	
end
addEventHandler("onColShapeHit", root, carscavenge_interact) 

function clear_carscavenge_interact(leaveElement)

local objectWreck = getElementAttachedTo(source) or false
local elemType = getElementType(leaveElement)
	
	if not objectWreck then return	end
	
	if elemType == "player" and getElementData(leaveElement,"insideScavengeCol") ~= false  then  -- if a player leaves a car wreck colshape
		setElementData(leaveElement,"insideScavengeCol", false)
		unbindKey(leaveElement,"e","down",triggerScavengeWreck)
	end
end
addEventHandler("onColShapeLeave", root, clear_carscavenge_interact)

function triggerScavengeWreck (player)
if hasPlayerItem("Toolbox", player) or getElementData(player,"toolboxequipped") == true then
triggerClientEvent(player,"ScavengingVehicle", player)
triggerClientEvent(player, "sleep:drawDXProgress", player, 4000,4000)
setTimer(triggerClientEvent,4000,1,player, "sleep:stopDXProgress", player)
else
outputInteractInfo("Toolbox required",player,255,255,255,255)
end
end

function veh_interact(hitElement)

	if getElementData(source,"coltype") == "vehinteract" and getElementType(hitElement)== "player" and isElement(getElementAttachedTo(source))==true then  
		if isPedInVehicle(hitElement) then --don't trigger for players inside vehicles
		   return 
		else 
			local player = hitElement
			local vehicle = getElementAttachedTo(source)

			if getElementData(vehicle,"vehicle-scenery") == true then --exclude prop vehicles
			return 
			end
			
			--[[local carname = retrieveCustomCarName(vehicle)
			if not carname then carname = "Vehicle" end
			outputInteractInfo(""..carname.."\n[Q]", player, 240,240,240)]]
			triggerClientEvent(hitElement,"InVehicleInteractionCol",source, vehicle)
		end
	end
end
addEventHandler("onColShapeHit", root, veh_interact) 

function clear_veh_interact(leaveElement)
	if getElementData(source,"coltype") == "vehinteract" and getElementType(leaveElement)== "player" and isElement(getElementAttachedTo(source))==true then  
	local player = leaveElement
	local vehicle = getElementAttachedTo(source)
		setElementData(player,"veh_col_veh",nil) -- this whole setElementData thing was done better for the fuel object, using only one data entry, must rewrite it at some point
		setElementData(player,"veh_col_col",nil)
	end
end
addEventHandler("onColShapeLeave", root, clear_veh_interact) 

function frozeVehicle(vehicle)
setElementFrozen (vehicle, true)
end

function disableVehicle(vehicle) --removes random panels, doors and wheels; Establishment vehicles, special vehicles and any vehicle that needs to be in working condition at start are skipped (not completed)

if getElementData(vehicle, "vehicle_disabled") == true then 
	return
elseif getVehicleType (vehicle) == "Automobile" 
		and getElementModel (vehicle) ~= (552) -- skipped vehicles 
		and getElementModel (vehicle) ~= (427) 
		and getElementModel (vehicle) ~= (528) 
		and getElementModel (vehicle) ~= (508) 

then --hit it!

--local x, y, z = getElementPosition(vehicle)

setElementData(vehicle, "vehicle_disabled", true, true)

	setVehiclePanelState ( vehicle, table.random(vehPanelNo), table.random(vehPanelSt) )
	setVehiclePanelState ( vehicle, table.random(vehPanelNo), table.random(vehPanelSt) )
	setVehiclePanelState ( vehicle, table.random(vehPanelNo), table.random(vehPanelSt) )
	setVehiclePanelState ( vehicle, table.random(vehPanelNo), table.random(vehPanelSt) )
	setVehiclePanelState ( vehicle, table.random(vehPanelNo), table.random(vehPanelSt) )
	setVehiclePanelState ( vehicle, table.random(vehPanelNo), table.random(vehPanelSt) )
	setVehiclePanelState ( vehicle, table.random(vehPanelNo), table.random(vehPanelSt) )
	--setVehicleWheelStates ( vehicle, table.random(vehWheelSt), table.random(vehWheelSt), table.random(vehWheelSt), table.random(vehWheelSt))
	setVehicleDoorState ( vehicle, table.random(vehDoorNo), table.random(vehDoorSt) )
	setVehicleDoorState ( vehicle, table.random(vehDoorNo), table.random(vehDoorSt) )
	setVehicleDoorState ( vehicle, table.random(vehDoorNo), table.random(vehDoorSt) )
	setVehicleDoorState ( vehicle, table.random(vehDoorNo), table.random(vehDoorSt) )
end
end

function damageVehicleAfterSpawn(vehicle) ----damages vehicles after spawn/respawn, both body and engine; also sets fuel to a random amount
local vehPanelNo = {0,1,2,3,4,5,6} -- panel number
local vehPanelSt = {0,1,2,3} -- panel state

local vehWheelSt = {0,1,2} -- 0 intact, 2 missing

local vehDoorNo = {0,1,2,3,4,5} 
local vehDoorSt = {0,1,2,3,4}

	if getElementData(vehicle, "vehicle_disabled") == true then 
		return
	elseif (getVehicleType (vehicle) == "Automobile" 
			and getElementModel (vehicle) ~= (552) -- skipped vehicles 
			and getElementModel (vehicle) ~= (427) 
			and getElementModel (vehicle) ~= (528) 
			and getElementModel (vehicle) ~= (508) ) 
			
			or getVehicleType (vehicle) == "Bike"  
			or getVehicleType (vehicle) == "Boat"  
			or getVehicleType (vehicle) == "Plane"  
			or getVehicleType (vehicle) == "Quad"  
			or getVehicleType (vehicle) == "Helicopter"  
			

	then --hit it!

	--local x, y, z = getElementPosition(vehicle)

	--setElementData(vehicle, "vehicle_disabled", true, true)

		setVehiclePanelState ( vehicle, table.random(vehPanelNo), table.random(vehPanelSt) )
		setVehiclePanelState ( vehicle, table.random(vehPanelNo), table.random(vehPanelSt) )
		setVehiclePanelState ( vehicle, table.random(vehPanelNo), table.random(vehPanelSt) )
		setVehiclePanelState ( vehicle, table.random(vehPanelNo), table.random(vehPanelSt) )
		setVehiclePanelState ( vehicle, table.random(vehPanelNo), table.random(vehPanelSt) )
		setVehiclePanelState ( vehicle, table.random(vehPanelNo), table.random(vehPanelSt) )
		setVehiclePanelState ( vehicle, table.random(vehPanelNo), table.random(vehPanelSt) )
		--setVehicleWheelStates ( vehicle, table.random(vehWheelSt), table.random(vehWheelSt), table.random(vehWheelSt), table.random(vehWheelSt))
		setVehicleDoorState ( vehicle, table.random(vehDoorNo), table.random(vehDoorSt) )
		setVehicleDoorState ( vehicle, table.random(vehDoorNo), table.random(vehDoorSt) )
		setVehicleDoorState ( vehicle, table.random(vehDoorNo), table.random(vehDoorSt) )
		setVehicleDoorState ( vehicle, table.random(vehDoorNo), table.random(vehDoorSt) )
		
		local health = getElementHealth(vehicle)
		--local fuel = getCarFuel(vehicle)
		--local model = getElementModel(vehicle)
		--outputDebugString("Model is: "..model)
		local randhealth = math.random(300,1000)
		--outputDebugString("Fuel is: "..carFuelData[model])
		--local randfuel = math.random(0, carFuelData[model])
		--outputDebugString("Fuel is: "..carFuelData[model])
		setElementHealth(vehicle,randhealth)
		--takeCarFuel(vehicle,randfuel)
		
	end
end


function damageCarPostRespawn () -- a timer that triggers damageVehicleAfterSpawn() on car respawn
setTimer(damageVehicleAfterSpawn, 1000, 1, source) 
end
addEventHandler ( "onVehicleRespawn", getRootElement(), damageCarPostRespawn)


--[[
function disableAllVehicles() -- disable all vehicles -- for testing
	for _, veh in ipairs(getElementsByType("vehicle")) do 
	disableVehicle(veh) 
	end
end
addCommandHandler ( "disableallveh", disableAllVehicles ) 
]]

function damageCarsOnServerStart ()
	for _, veh in ipairs(getElementsByType("vehicle")) do 
		if tonumber(getElementID(veh)) then -- Dystopia vehicles all have a numerical ID < 1000
			damageVehicleAfterSpawn(veh) 
			
		end
	end
end
addEventHandler ( "onResourceStart",  getResourceRootElement(getThisResource()), damageCarsOnServerStart)


function turnEngineOff ( theVehicle, leftSeat, jackerPlayer ) --turns engine off when driver leaves, need another function to turn it off when car is disabled
    -- if it's the driver who got out, and he was not jacked,
    if leftSeat == 0 and not jackerPlayer then
        -- turn off the engine
        setVehicleEngineState ( theVehicle, false )
    end
end
addEventHandler ( "onPlayerVehicleExit", getRootElement ( ), turnEngineOff )

function installVehPart (vehicle,player)
local repairdone = false
	if getVehicleDoorState (vehicle, 1) > 1 then setVehicleDoorState (vehicle, 1,0) repairdone = true
	elseif repairdone == false and getVehiclePanelState (vehicle, 6) > 1 then setVehiclePanelState (vehicle, 6,0) repairdone = true 
	elseif repairdone == false and getVehiclePanelState (vehicle, 2) > 1 then setVehiclePanelState (vehicle, 2,0) repairdone = true 
	elseif repairdone == false and getVehiclePanelState (vehicle, 3) > 1 then setVehiclePanelState (vehicle, 3,0) repairdone = true 
	elseif repairdone == false and getVehiclePanelState (vehicle, 4) > 1 then setVehiclePanelState (vehicle, 4,0) repairdone = true 
	elseif repairdone == false and getVehicleDoorState (vehicle, 2) > 1 then setVehicleDoorState (vehicle, 2,0) repairdone = true 
	elseif repairdone == false and getVehiclePanelState (vehicle, 0) > 1 then setVehiclePanelState (vehicle, 0,0) repairdone = true 
	elseif repairdone == false and getVehicleDoorState (vehicle, 3) > 1 then setVehicleDoorState (vehicle, 3,0) repairdone = true 
	elseif repairdone == false and getVehiclePanelState (vehicle, 1) > 1 then setVehiclePanelState (vehicle, 1,0) repairdone = true 
	elseif repairdone == false and getVehicleDoorState (vehicle, 0) > 1 then setVehicleDoorState (vehicle, 0,0) repairdone = true 
	elseif repairdone == false and getVehiclePanelState (vehicle, 5) > 1 then setVehiclePanelState (vehicle, 5,0) repairdone = true 
	end
	
repairdone = nil

local damagedPartsRemaining = assessVehicleCondition(vehicle)
local stillNeeded = 8 - damagedPartsRemaining 

if damagedPartsRemaining >= 8 then 
	outputTopBar(""..stillNeeded.." more part(s) required", player, 255,255,255)
elseif damagedPartsRemaining == 7 --[[and getElementHealth(vehicle)>= 301]] then 
		outputInteractInfo("Vehicle operational", player, 0,255,0)
		setElementData(vehicle, "vehicle_disabled", false, true)
else
		outputInteractInfo("Vehicle parts installed", player, 255,255,255)
		local xp = getPlayerExp(player)
				setPlayerExp(player,xp+2)
				outputStatusInfo("+2 xp",player, 240,240,240 )
end 
end

function DisableVehOnBodyDamage () --disables vehicle if more than 8 car bodyparts get damaged; numbers must be tweaked

if getElementData(source, "vehicle_disabled") == true then return end
local vehparts = assessVehicleCondition(source)
local vx, vy, vz = getElementPosition(source)
if vehparts >=8  then  
		setVehicleEngineState ( source, false )
		triggerClientEvent("PlayEngineFailSound",source, vx, vy, vz)
		setElementData(source, "vehicle_disabled", true, true)
		setElementData(source, "repaired", false,true)
		if getVehicleOccupant(source,0) then
			local player = getVehicleOccupant(source)
			outputInteractInfo("Replace broken parts!", player, 245,0,0)
		end
end
end
addEventHandler("onVehicleDamage", root, DisableVehOnBodyDamage)

function assessVehicleCondition (vehicle) --returns the number of car bodyparts damaged
local damagedparts = 0
if getVehiclePanelState (vehicle, 0) > 1 then damagedparts = damagedparts+1 end
if getVehiclePanelState (vehicle, 1) > 1 then damagedparts = damagedparts+1 end
if getVehiclePanelState (vehicle, 2) > 1 then damagedparts = damagedparts+1 end
if getVehiclePanelState (vehicle, 3) > 1 then damagedparts = damagedparts+1 end
if getVehiclePanelState (vehicle, 4) > 1 then damagedparts = damagedparts+1 end
if getVehiclePanelState (vehicle, 5) > 1 then damagedparts = damagedparts+1 end
if getVehiclePanelState (vehicle, 6) > 1 then damagedparts = damagedparts+1 end
if getVehicleDoorState (vehicle, 0) > 1 then damagedparts = damagedparts+1 end
if getVehicleDoorState (vehicle, 1) > 1 then damagedparts = damagedparts+1 end
if getVehicleDoorState (vehicle, 2) > 1 then damagedparts = damagedparts+1 end
if getVehicleDoorState (vehicle, 3) > 1 then damagedparts = damagedparts+1 end
if damagedparts >= 10 then damagedparts = 10 end
return damagedparts
end

function lessenVehicleDamage(loss)
   if getVehicleType(source) == "Plane" or getVehicleType(source) == "Helicopter" then return 
   end
		local vehicleHealth = getElementHealth(source)
		setElementHealth(source, vehicleHealth-loss/4) -- a quarter of the real damage
end

addEventHandler("onVehicleDamage", getRootElement(), lessenVehicleDamage)

-----------------------passenger/driver ped damage on vehicle damage----------------
--[[
function damagePed(ped, dmg)
	health = getElementHealth(ped)
	if health < dmg then
		killPed(ped)
	else
		setElementHealth(ped, health - dmg)
		fadeCamera(ped, false, 1, 255, 0, 0)
		setTimer(fadeCamera, 200, 1, ped, true)
	end
end

function onVehicleDamage(dmg)
	if getVehicleOccupant(source) then
		player = getVehicleOccupant(source)
		if dmg < 51 and dmg > 25 then
			damagePed(player, 1)
		elseif dmg < 101 and dmg > 50 then
			damagePed(player, 2.5)
		elseif dmg < 501 and dmg > 100 then
			damagePed(player, 5)
		end
	end
end
addEventHandler("onVehicleDamage", root, onVehicleDamage)
]]

--[[function fixExplosions()
  local vehicle = source
  local vehicletype = getVehicleType(vehicle)
   if vehicletype ~= "Plane" and vehicletype ~= "Helicopter" then
	  if getElementHealth(vehicle) < 300 then
      setVehicleDamageProof(vehicle, true)
      setVehicleEngineState(vehicle, false)
	  setElementHealth(vehicle, 300)
	  setElementData(vehicle, "vehicle_disabled",true,true)
	  setElementData(vehicle, "repaired", false,true)
	  elseif getElementHealth(vehicle) > 301 then
      setVehicleDamageProof(vehicle, false)
	  end
	else
	  if getElementHealth(vehicle) < 300 then
      setVehicleDamageProof(vehicle, true)
      setVehicleEngineState(vehicle, false)
	  setElementHealth(vehicle, 300)
	  setElementData(vehicle, "vehicle_disabled",true,true)
	  setElementData(vehicle, "repaired", false,true)
	  local x,y,z = getElementPosition(vehicle)
	  createExplosion(x,y,z,4)
	  end
	end
end]]
--addEventHandler("onVehicleDamage", root, fixExplosions)

function lockSwitch(p)
	local veh = getPedOccupiedVehicle(p)
	if not veh then return end
	if (isVehicleLocked(veh)) and (getVehicleOccupant(veh) == p) then
		setVehicleLocked(veh, false)
	elseif not (isVehicleLocked(veh)) and (getVehicleOccupant(veh) == p) then
		setVehicleLocked(veh, true)
	end
end
addCommandHandler("lock", lockSwitch)

function unlock(p, seat, jacker)
	if (seat == 0) and (p) and (isVehicleLocked(source)) then
		setVehicleLocked(source, false)
	end
end
addEventHandler("onVehicleExit", root, unlock)


--[[
function engineSwitch(source)
	local veh = getPedOccupiedVehicle (source)
	if not veh then return end
	if (isPedInVehicle (source)) and (getVehicleOccupant(veh) == source) then
		if getVehicleEngineState ( veh ) then
			setVehicleEngineState ( veh, false )
		else
			setVehicleEngineState ( veh, true )
        end
	end
end
addCommandHandler("engine", engineSwitch)
]]

function lightSwitch(source)
	local veh = getPedOccupiedVehicle (source)
	if not veh then return end
	if (isPedInVehicle (source)) and (getVehicleOccupant(veh) == source) then
		if (getVehicleOverrideLights(veh) ~= 2) then
			setVehicleOverrideLights(veh, 2)
		elseif (getVehicleOverrideLights(veh) ~= 1) then
			setVehicleOverrideLights(veh, 1)
		end
	end
end
addCommandHandler("light", lightSwitch)

local carFuelData = {};

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()),
    function()--carFuel
        local xml = xmlLoadFile("config/vehicleFuelData.xml");
        local xmlNodes = xmlNodeGetChildren(xml);
        for i,node in ipairs(xmlNodes) do
           carFuelData[tonumber(xmlNodeGetAttribute(node,'id'))] = tonumber(xmlNodeGetAttribute(node,'fuel'));
        end
        xmlUnloadFile(xml);
       
    end
)

function playSoundOnDisabled(vehicle,seat,jacked)
local x,y,z = getElementPosition(vehicle)
if getElementData(vehicle,"vehicle_disabled")==true then triggerClientEvent(source,"PlayEngineFailSound",vehicle,x,y,z) end

local function getCarFuel(v)
	if getElementType(v) == 'vehicle' then
		if getVehicleType(v) == 'Automobile' or getVehicleType(v) == 'Bike' or getVehicleType(v) == 'Monster Truck' or getVehicleType(v) == 'Quad' then
			local fuel = getElementData(v,'fuel');
			local model = getElementModel(v);
			if not carFuelData[model] then model = 0; end
			if not fuel then
				if carFuelData[model] then
					fuel = carFuelData[model];
					setElementData(v,'fuel',carFuelData[model]);
				else
					fuel = carFuelData[0];
					setElementData(v,'fuel',carFuelData[0]);
				end
			end
			return fuel;
		end
	elseif getElementType(v) == 'player' then
		local fuel = getElementData(v,'fuel');
		if not fuel then
			setElementData(v,'fuel',0);
			return 0;
		end
		return fuel;
	end
end

if getCarFuel(vehicle) == 0 then outputTopBar("No fuel", source, 240,0,0) end

end
addEventHandler ( "onPlayerVehicleEnter", root, playSoundOnDisabled)

addEventHandler ( "onPlayerVehicleEnter",root,

function( veh, seat, jackerPlayer )
    if getElementData(veh, "vehicle_disabled") == true then setVehicleEngineState ( veh, false )
	elseif getElementData(veh, "vehicle_disabled") == false and seat == 0 and getElementHealth(veh) >= 301  then setVehicleEngineState ( veh, true )
    end
	toggleVehicleRespawn(veh,true)
end)

addEventHandler ( "onPlayerVehicleExit",root,

function( veh, seat, jackerPlayer )
    if seat == 0 and not jackerPlayer then
        setVehicleEngineState ( veh, false )
		setVehicleOverrideLights ( veh, 1 )
    end
	
	local safezone = 0
	local gx, gy, gz = getElementPosition(veh)
    local allradars = getElementsByType("radararea")
    
	for theKey,theradar in ipairs(allradars) do
        if getElementData(theradar, "safeAreas") == true then
            if isInsideRadarArea ( theradar, gx, gy ) and getElementModel(veh)~= 464 then
                safezone = 1
				--outputDebugString("safeZone 1")
				outputTopBar( "Your vehicle is safe", source, 0, 240, 0 )
				break
            end
        end
    end
	
	if safezone == 0 then
	toggleVehicleRespawn(veh,true)
	--outputDebugString("safeZone 0")
	else
	toggleVehicleRespawn(veh,false)
	end
	
	
end)

function respawnResolution (vehicle)
	if isElement(vehicle) and (getElementData (vehicle, "queuedforrespawn") == false or getElementModel(vehicle) == 464) then --make sure it won't respawn if it was repaired; DONE, needs testing -> I need to directly kill the respawn timer when car is repaired instead; i'll end up with a long-running timer for each exploded vehicle, regardless of the car being repaired meanwhile
		return 
	else 
		respawnVehicle(vehicle)
		setElementData(vehicle, "vehicle_disabled", false, true);--zzzz
		setElementData(vehicle, "repaired", true,true)
		setElementData(vehicle, "queuedforrespawn", false,true)
	end
end

function respawnExplodedVehicleSetup() 
	toggleVehicleRespawn(source,false) 
	if getElementModel(source) == 592 or getElementModel(source) == 464 then --andromada,used for aircrashes or RC baron used for miniguns
	return 
	end 
	local blownrespawntimer = setTimer(respawnResolution, 3600000/2, 1, source) ---------- EXPLODED VEHICLE RESPAWN TIMER: 1800000 = 0.5 hour
	setElementData(source,"queuedforrespawn",true,true)
	setElementData(source,"respawntimer",blownrespawntimer,true)
	
end
addEventHandler("onVehicleExplode", getRootElement(), respawnExplodedVehicleSetup)

---------------UPGRADES---------------
-----SMOKE---------
function toggleSmoke(keyPresser)
			local vehicle = getPedOccupiedVehicle(keyPresser)
			if vehicle and getElementData(vehicle,"smokeinstalled") ~= true then return end
			if (vehicle) and getElementData(vehicle,"smokestatus") ~= "on" then
				attachElements(createObject(2780,getElementPosition(keyPresser)), getPedOccupiedVehicle(keyPresser),0,-2,-0.5,270,0,0)
				attachElements(createObject(2780,getElementPosition(keyPresser)), getPedOccupiedVehicle(keyPresser),0,0,0,270,0,0)
				attachElements(createObject(2780,getElementPosition(keyPresser)), getPedOccupiedVehicle(keyPresser),0,2,-0.5,270,0,0)
				setElementData(vehicle,"smokestatus","on")
			
				for k,smoke in pairs(getAttachedElements(vehicle)) do
					if getElementModel(smoke) == 2780 then
					setElementAlpha(smoke,0)
					setElementCollisionsEnabled(smoke,false)
					end
				end
			else
				if (vehicle) and getElementData(vehicle,"smokestatus") == "on" then
				for k,smoke in pairs(getAttachedElements(vehicle)) do
					if getElementModel(smoke) == 2780 then
						destroyElement(smoke)
						setElementData(vehicle,"smokestatus","off")
					end
				end
				end
			end
		end

local aliveplayers = getAlivePlayers() 
for _,player in pairs(aliveplayers) do bindKey ( player, "z", "down", toggleSmoke) end

function bindSmoke()
bindKey ( source, "z", "down", toggleSmoke)
end
addEventHandler("onlayerJoin",root,bindSmoke)


---------- AIRCRAFT WEAPONS | BOMBS | AIRBOMB
aircraftReArmPoints = createElement("ReArmPointsGroup","ReArmPoints")
rearm_markerA69 = createMarker ( 315.66015625, 1960.3837890625, 15.640625, "cylinder", 6, 255, 92, 51, 85)
rearm_markerCarrier = createMarker ( 3189.484375, 159.8505859375, 15.18906211853, "cylinder", 6, 255, 92, 51, 85)
setElementParent(rearm_markerA69, aircraftReArmPoints)
setElementParent(rearm_markerCarrier, aircraftReArmPoints)
Timers = {}

function attach(hitElement) 
if getElementType(hitElement)~= "player" then return end
playerSource = hitElement 
	if isPedInVehicle(playerSource) == true then
		
		local vehicle = getPedOccupiedVehicle(playerSource)
		--if getElementData(vehicle,"bunkerbomb") then outputDebugString("already has bomb") return end
		local vehmodel = getElementModel(vehicle)
		
		if vehmodel ~= 520 and vehmodel ~= 476 and vehmodel ~= 519 and vehmodel ~= 460 
		and vehmodel ~= 563 and vehmodel ~= 425 and vehmodel ~= 447 and vehmodel ~= 553 then 
		return 
		end
		
		local x,y,z = getElementPosition(playerSource)
		local rx,ry,rz = getVehicleRotation(getPedOccupiedVehicle(playerSource))
		--local attachedElements = getAttachedElements(getPedOccupiedVehicle(playerSource))

		if not getElementData(vehicle,"bunkerbomb") then
			local missile = createObject(3786,x,y,z,rx,ry,rz)
			attachElements(missile,getPedOccupiedVehicle(playerSource),0,0,-1.1,0,355,270)
			setElementCollisionsEnabled(missile,false)
			setElementData(vehicle,"bunkerbomb",missile)
			bindKey (playerSource,"r","down",dropBomb,missile,vehicle)
			
			--outputInteractInfo("[ Bunker Buster bomb installed ]",playerSource,240,240,240)
			outputInteractInfo("[ Bunker Buster bomb installed ]\n Drop bomb: [R] ",playerSource,255,200,0)
					
		else
		outputInteractInfo("[ aircraft already armed! ]",playerSource,240,100,100)
		--outputChatBox("[ aircraft already armed! ] ",playerSource,240,100,100)
		end
	end
end


--[[function armMarkerDialogue ()
triggerClientEvent(player,"ShowQuestWindow",root,ped)
end]]

function hitTheArmMarker(hitelem)

local elemtype = getElementType(hitelem)

	if elemtype == "player" and getPedOccupiedVehicle(hitelem) then
	outputDebugString("entering aircraft arming col")
	outputInteractInfo("Arm aircraft: [E]",hitelem,240,240,240)
	--outputChatBox("Arm aircraft: [E]",hitelem,240,240,240)
	bindKey(hitelem,"e","down",attach)
	end
	
end

function leaveTheArmMarker(hitelem)
local elemtype = getElementType(hitelem)

	if elemtype == "player" then
	outputDebugString("leaving aircraft arming col")
	unbindKey(hitelem,"e","down",attach)
	end
	
end

--[[
function armBomb ()




end
]]

function dropBomb (playerSource,command,state,missile,vehicle)


	local vehicle = getPedOccupiedVehicle(playerSource)
	if not getElementData(vehicle,"bunkerbomb") then return end
	local missile = getElementData(vehicle,"bunkerbomb")
		local x,y,z = getElementPosition(playerSource)
		local rx,ry,rz = getVehicleRotation(getPedOccupiedVehicle(playerSource))
	detachElements(missile)
	setElementData(vehicle,"bunkerbomb",nil)
	unbindKey (playerSource,"r","down",dropBomb)
	local vx,vy,vz = getElementVelocity(getPedOccupiedVehicle(playerSource))
	local flowerpot = createVehicle(594, x,y,z-2,rx,ry,rz)
	setElementAlpha ( flowerpot, 0 )
	attachElements(missile,flowerpot,0,0,0,0,0,270)
	setElementVelocity(flowerpot,vx,vy,vz)
	for i = 1,500 do
		if Timers[i] == nil then
			Timers[i] = setTimer(checkBlow, 100,500, flowerpot, playerSource, i,missile)
			break
		end
	end
end

function checkBlow(theBomb, thePlayer, index,missile)

	local vx,vy,vz = getElementVelocity(theBomb)
	local vehicle1x, vehicle1y, vehicle1z = getElementPosition ( theBomb )
	
	if isPedInVehicle(thePlayer) then
		vehicle2x, vehicle2y, vehicle2z = getElementPosition ( getPedOccupiedVehicle(thePlayer) )
	else
		vehicle2x, vehicle2y, vehicle2z = getElementPosition (thePlayer)
	end
		 --outputChatBox("BOMB: v-speed: "..vz)
		 --outputChatBox("BOMB: bomb on ground: "..tostring(isVehicleOnGround(theBomb)))
		 --outputChatBox("BOMB: distance to plane: "..tostring(getDistanceBetweenPoints3D ( vehicle1x, vehicle1y, vehicle1z, vehicle2x,vehicle2y, vehicle2z )))

	 if isElement(theBomb) and vz > 0 and getDistanceBetweenPoints3D ( vehicle1x, vehicle1y, vehicle1z, vehicle2x,vehicle2y, vehicle2z ) > 30 then

		local x,y,z = getElementPosition(theBomb)
		createExplosion ( x,y,z+3, 7)
		createExplosion ( x+5,y,z, 7)
		createExplosion ( x,y+5,z, 7)
		createExplosion ( x-5,y,z, 7)
		createExplosion ( x,y-5,z, 7)
		destroyElement(theBomb)
		destroyElement(missile) 
		killTimer(Timers[index])
		Timers[index] = nil

	elseif isElement(theBomb) and getDistanceBetweenPoints3D ( vehicle1x, vehicle1y, vehicle1z, vehicle2x,vehicle2y, vehicle2z ) > 100 then 
	
		local x,y,z = getElementPosition(theBomb)
		createExplosion ( x,y,z+3, 7)
		createExplosion ( x+5,y,z, 7)
		createExplosion ( x,y+5,z, 7)
		createExplosion ( x-5,y,z, 7)
		createExplosion ( x,y-5,z, 7)
		destroyElement(theBomb)
		destroyElement(missile) 
		killTimer(Timers[index])
		Timers[index] = nil
		
--[[	elseif isElement(theBomb) and isVehicleOnGround(theBomb) then]]

		
	elseif isElement(theBomb) and index == 500 then
		local x,y,z = getElementPosition(theBomb)
		createExplosion ( x,y,z+3, 7)
		createExplosion ( x+5,y,z, 7)
		createExplosion ( x,y+5,z, 7)
		createExplosion ( x-5,y,z, 7)
		createExplosion ( x,y-5,z, 7)
		destroyElement(theBomb)
		destroyElement(missile) 
		killTimer(Timers[index])
		Timers[index] = nil
	
	end

	 
end


--addEventHandler("onMarkerHit", rearm_marker, attach)
addEventHandler("onMarkerHit", aircraftReArmPoints, hitTheArmMarker,true)
addEventHandler("onMarkerLeave", aircraftReArmPoints, leaveTheArmMarker,true)
addCommandHandler("airstrike", attach)


