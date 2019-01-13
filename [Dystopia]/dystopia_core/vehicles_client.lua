addEvent("InVehicleInteractionCol", true) 
addEvent("RepairingVehicle", true)

local vehicle = getElementData(localPlayer,"veh_col_veh")

addEventHandler( "InVehicleInteractionCol", root, ---source is the vehicle interaction colshape that was hit
	function(vehicle) 
	setElementData(localPlayer,"veh_col_veh", vehicle); --this and below were synchronized; vehicle hud was appearing for all streamed players (?), not only the local; tentative fix; needs confirmation; keyword UNTESTEDFIX 
	setElementData(localPlayer,"veh_col_col", source);
	
	end) 

addEvent("ScavengingVehicle",true)

localPlayerIsBusy = false

function scavengingWreck() 
   if ( source == localPlayer) then
	
	if getElementData(localPlayer,"veh_col_col") then return end
   
	if ( getElementData(localPlayer,"insideScavengeCol") == false or getElementData(localPlayer,"insideScavengeCol") == nil ) then 
	return 
	end
   
    local carWreckCol = getElementData(localPlayer,"insideScavengeCol")
	local carWreckObj = getElementAttachedTo(carWreckCol)
	local wrecktype = getElementType(carWreckObj)
	local scavamount = getElementData(carWreckCol,"scavamount") or 0
	local scavtime = 4000 
	
	
	local x,y,z = getElementPosition( carWreckCol )
	local px, py, pz = getElementPosition( localPlayer )
	local pedangle = ( 360 - math.deg ( math.atan2 ( ( x - px ), ( y - py ) ) ) ) % 360 --MAGIC SPELL TO MAKE PEDS LOOK AT STUFF
  
	if scavamount > 0 and not localPlayerIsBusy then 
				
			triggerServerEvent("ServerStatusInfo",resourceRoot,"Scavenging...") 
			localPlayerIsBusy = true
			setPedWeaponSlot(localPlayer,0)
			setPedRotation( localPlayer, pedangle ) --turn player facing the col center
			setPedAnimation ( localPlayer, "PED", "WALK_player", 1000, false, true, true, false) --make him walk towards it for a second to make sure it is right next to the object
			
			setTimer( function() 
						setPedAnimation ( localPlayer, "BOMBER", "BOM_plant", 4000, true, false, false, false) 	
						end
			, 1000, 1) 
			
			setTimer( function() 
						setElementData(getElementData(localPlayer,"insideScavengeCol"), "scavamount", scavamount-1, true) 
						triggerServerEvent("CarScavCompleted",resourceRoot,wrecktype)
						localPlayerIsBusy = false
						end
			, 4000, 1)
	
	elseif localPlayerIsBusy then
		return
	else
		triggerServerEvent("ServerStatusInfo",resourceRoot,"Nothing found...")
		return
	end
       end
		end 
addEventHandler("ScavengingVehicle",localPlayer,scavengingWreck)

function flipVehicle(vehicle) -- Flip vehicle --from freeroam resource
		if vehicle then
		local rX, rY, rZ = getElementRotation(vehicle)
		setElementRotation(vehicle, 0, 0, (rX > 90 and rX < 270) and (rZ + 180) or rZ)
		end
end
   
addEventHandler("RepairingVehicle",localPlayer,function() 
   if ( source == localPlayer) then
	
	if getElementData(localPlayer,"veh_col_col") == false  then  return end
	if getElementData(localPlayer,"veh_col_col") == nil  then return end
   
    local vehicle = getElementAttachedTo(getElementData(localPlayer,"veh_col_col"))
	local rX, rY, rZ = getElementRotation(vehicle)
	
	local vhealth = getElementHealth(vehicle)
	local repairtime = ((1000 - vhealth)*10)+4000 --"*X" is the factor for how much time repairs will take; if factor = 10, for 640 vehicle health, it will take 4,6 seconds; the last position "+X" represents seconds added on stack for default, to make sure anim is played and repair is not too fast; this last number should be used in conjunction with TECH skill to influence repair speed
	--outputDebugString(""..getVehicleName(vehicle).." repair duration:"..repairtime.." ms")
	
	dxProgressBar(repairtime, repairtime)
	setTimer(dxKillProgressBar,repairtime,1)

	
	local x,y,z = getElementPosition( vehicle )
	local px, py, pz = getElementPosition( localPlayer )
	local pedangle = ( 360 - math.deg ( math.atan2 ( ( x - px ), ( y - py ) ) ) ) % 360 --MAGIC SPELL TO MAKE PEDS LOOK AT STUFF
    local conditionschecked = false
	
	if vhealth >= 990 then 
		triggerServerEvent("ServerTopNotification",resourceRoot,"Vehicle is in good condition")
		setVehicleWheelStates(vehicle,0,0,0,0)
	elseif vhealth < 990 then
		conditionschecked = true
	end
		
	if 	conditionschecked == true then 
						
			if isVehicleBlown(vehicle) == true then
				setElementData(vehicle, "repaired", true,true) --tell the disableOnBodyDamage bit to give it a break
				local damagedparts = assessVehicleCondition_c(vehicle)--how many parts broke? 
				--outputDebugString(tostring(cond)) --how many still needed to have less than 8 missing?
				
				if damagedparts > 7 then
					local neededpartsno 
						if damagedparts == 8 then
							neededpartsno = 1
						elseif  damagedparts == 9 then
							neededpartsno = 2
						elseif  damagedparts == 10 then
							neededpartsno = 3
						end
					triggerServerEvent("ServerTopNotification",resourceRoot,"Install "..neededpartsno.." missing parts first!") 
				return
				
				else
					triggerServerEvent("ServerStatusInfo",resourceRoot,"Repairing...") 
					setPedWeaponSlot(localPlayer,0)
					setPedRotation( localPlayer, pedangle ) --turn player facing the col center
					setPedAnimation ( localPlayer, "PED", "WALK_player", 1000, false, true, true, false) --make him walk towards it for a second to make sure it is right next to the vehicle
					setTimer( function() setPedAnimation ( localPlayer, "INT_HOUSE", "wash_up", repairtime, true, false, false, false) end, 1000, 1) --play repair animation for a duration connected with the health that needs restoring
					setTimer( function() setElementRotation(vehicle, 0, 0, (rX > 90 and rX < 270) and (rZ + 180) or rZ) end, repairtime-50, 1) --flip the vehicle
					setTimer( function() fixVehicle(vehicle) ; setVehicleWheelStates(vehicle,0,0,0,0) end, repairtime, 1) 
					setTimer(function () triggerServerEvent("ServerTopNotification",resourceRoot,"Vehicle repaired") end, repairtime, 1) --output a message that everything is fine
					triggerServerEvent("RemoveAllCarFuel",resourceRoot,vehicle)
					setElementData(vehicle, "vehicle_disabled", false, true)
					setElementData(vehicle, "repaired", true,true)
					setElementData(vehicle,"queuedforrespawn",false,true)
					if isTimer(getElementData(vehicle,"respawntimer")) then killTimer (getElementData(vehicle,"respawntimer")) end
					setVehicleDamageProof(vehicle, false)
				end
			else  
				triggerServerEvent("ServerStatusInfo",resourceRoot,"Repairing...") 
				setPedWeaponSlot(localPlayer,0)
				setPedRotation( localPlayer, pedangle ) --turn player facing the col center
				setPedAnimation ( localPlayer, "PED", "WALK_player", 1000, false, true, true, false) --make him walk towards it for a second to make sure it is right next to the vehicle
				setTimer( function() setPedAnimation ( localPlayer, "INT_HOUSE", "wash_up", repairtime, true, false, false, false) end, 1000, 1) --play repair animation for a duration connected with the health that needs restoring
				setTimer( function() setElementRotation(vehicle, 0, 0, (rX > 90 and rX < 270) and (rZ + 180) or rZ) end, repairtime-50, 1) --flip the vehicle
				setTimer( function() setElementHealth(vehicle,1000); setVehicleWheelStates(vehicle,0,0,0,0) end, repairtime, 1) --temporary 
				setTimer(function () 
				triggerServerEvent("ServerTopNotification",resourceRoot,"Vehicle repaired") 
				local xp = getPlayerExp(localPlayer)
				local xpgain = math.floor(repairtime/4000)
				if xpgain < 1 then xpgain = 1 end
				setPlayerExp(localPlayer,xp+xpgain)
				outputStatusInfo("+"..xpgain.." xp", 240,240,240 )
				
				end, repairtime, 1) --output a message that everything is fine
				setElementData(vehicle, "vehicle_disabled", false, true) 
				setElementData(vehicle, "repaired", true,true)
				setElementData(vehicle,"queuedforrespawn",false,true)
				if isTimer(getElementData(vehicle,"respawntimer")) then killTimer (getElementData(vehicle,"respawntimer")) end
				setVehicleDamageProof(vehicle, false)
			end
	elseif conditionschecked == false then
		return
	end
	Open_CloseIn()
	Open_CloseBelt()
	end
end )      

function assessVehicleCondition_c (vehicle) --retrieves the number of missing vehicle parts
local damagedparts = 0
if getVehiclePanelState (vehicle, 0) > 1 then damagedparts = damagedparts+1 end
if getVehiclePanelState (vehicle, 1) > 1 then damagedparts = damagedparts+1 end
if getVehiclePanelState (vehicle, 2) > 1 then damagedparts = damagedparts+1 end
if getVehiclePanelState (vehicle, 3) > 1 then damagedparts = damagedparts+1 end
if getVehiclePanelState (vehicle, 4) > 1 then damagedparts = damagedparts+1 end
if getVehiclePanelState (vehicle, 5) > 1 then damagedparts = damagedparts+1 end
if getVehiclePanelState (vehicle, 6) > 1 then damagedparts = damagedparts+1 end
if getVehicleDoorState (vehicle, 0) > 0 then damagedparts = damagedparts+1 end
if getVehicleDoorState (vehicle, 1) > 1 then damagedparts = damagedparts+1 end
if getVehicleDoorState (vehicle, 2) > 1 then damagedparts = damagedparts+1 end
if getVehicleDoorState (vehicle, 3) > 1 then damagedparts = damagedparts+1 end
if damagedparts >= 10 then damagedparts = 10 end
return damagedparts
end

----------------------------------------------------VEHICLE HUD------------
local sx,sy = guiGetScreenSize()
local px,py = 1366,768
local x,y =  (sx/px), (sy/py) 
local vehsaude

function VehicleHud()
if getCameraTarget() ~= localPlayer and getCameraTarget() ~= getPedOccupiedVehicle(localPlayer) and getPedWeapon(localPlayer) ~= 32 then return end
local vehicle = getElementData(localPlayer,"veh_col_veh") or getPedOccupiedVehicle( localPlayer)  --draw hud for the car you're in or the car you're next to

if not vehicle or getElementType(vehicle)~= "vehicle" then return end

if vehicle then

	if getElementData(vehicle,"vehicle-scenery") == true then --exclude prop vehicles
		return 
	end
		
	        if ( getElementHealth( vehicle ) >= 1000 ) then
            vehsaude = 100
	        else
	        vehsaude = math.floor(getElementHealth ( vehicle )/10) --last number must be max vehicle health/100
	end
        
        dxDrawRectangle(x*1140, y*680, x*211, y*19, tocolor(100, 100, 100, 227), false) 
        dxDrawImage(x*1083, y*674, x*33, y*32, "images/1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(x*1140, y*645, x*211, y*19, tocolor(100, 100, 100, 227), false) 
        dxDrawImage(x*1083, y*638, x*33, y*32, "images/2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		
		if vehsaude < 50 then healthbarcolor = tocolor(255,141,0,227)
		elseif vehsaude < 40 then healthbarcolor = tocolor(255,0,0,227)
		else healthbarcolor = tocolor(74, 145, 31, 227)
		end
				
        dxDrawRectangle(x*1140, y*645, x*211/100*vehsaude, y*19, healthbarcolor, false) -- Vehicle health bar
	
	
	local car = getPedOccupiedVehicle(localPlayer) or getElementData(localPlayer,"veh_col_veh")
	local vehcondition = assessVehicleCondition_c(car)
	local vehcondtranslated
	local hullbarcolor
		if vehcondition == 0 then vehcondtranslated = 100 
		elseif vehcondition == 1 then vehcondtranslated = 90 
		elseif vehcondition == 2 then vehcondtranslated = 80 
		elseif vehcondition == 3 then vehcondtranslated = 70
		elseif vehcondition == 4 then vehcondtranslated = 60
		elseif vehcondition == 5 then vehcondtranslated = 50
		elseif vehcondition == 6 then vehcondtranslated = 40; hullbarcolor = tocolor(255,141,0,227)
		elseif vehcondition == 7 then vehcondtranslated = 30; hullbarcolor = tocolor(255,141,0,227)
		elseif vehcondition == 8 then vehcondtranslated = 20; hullbarcolor = tocolor(255,0,0,227)
		elseif vehcondition == 9 then vehcondtranslated = 10; hullbarcolor = tocolor(255,0,0,227)
		elseif vehcondition == 10 then vehcondtranslated = 0; hullbarcolor = tocolor(255,0,0,227)
		end
	if not hullbarcolor then hullbarcolor = tocolor(74, 145, 31, 227) end
		if (vehcondition) then
        dxDrawRectangle(x*1140, y*680, x*211/100*vehcondtranslated, y*19, hullbarcolor, false) -- HULL bar
      --[[  dxDrawText("Damaged: "..vehcondition.." parts", x*1140 - 1, y*679 - 1, x*1351 - 1, y*699 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false) -- hull damage text
        dxDrawText("Damaged: "..vehcondition.." parts", x*1140 + 1, y*679 - 1, x*1351 + 1, y*699 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Damaged: "..vehcondition.." parts", x*1140 - 1, y*679 + 1, x*1351 - 1, y*699 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Damaged: "..vehcondition.." parts", x*1140 + 1, y*679 + 1, x*1351 + 1, y*699 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Damaged: "..vehcondition.." parts", x*1140, y*679, x*1351, y*699, tocolor(254, 254, 254, 227), 1.00, "default-bold", "center", "center", false, false, false, false, false)
		]] -- damaged parts text display (over the hull bar)
	else
        dxDrawText(" ", x*1140 - 1, y*679 - 1, x*1351 - 1, y*699 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText(" ", x*1140 + 1, y*679 - 1, x*1351 + 1, y*699 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText(" ", x*1140 - 1, y*679 + 1, x*1351 - 1, y*699 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText(" ", x*1140 + 1, y*679 + 1, x*1351 + 1, y*699 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText(" ", x*1140, y*679, x*1351, y*699, tocolor(254, 254, 254, 227), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	end
	end
end
addEventHandler("onClientRender", root, VehicleHud)

--------------------------------------------------------ENGINE FAIL SOUND-------------------
addEvent("PlayEngineFailSound",true)

function engineFailSound(x,y,z)  
local engfailsound = playSound3D("sounds/enginefail.mp3", x, y, z, false)
setSoundMaxDistance(engfailsound, 25)
setSoundVolume(engfailsound, 0.8)
attachElements(engfailsound, source)
local soundTime = math.random(2,5)
setTimer(function(engfailsound) 
		if isElement(engfailsound) then 
		destroyElement(engfailsound) 
		end end
		,(soundTime*1000), 1, engfailsound)
if not getPedOccupiedVehicle(localPlayer) then destroyElement(engfailsound) end
end
addEventHandler("PlayEngineFailSound", root, engineFailSound)


--[[ HYDRA MISSILES by
Luca aka
specahawk aka
spopo aka
Anirudh Katoch aka
(All rights reserved)
MIT License - Do whatever you want.
]]

----User settings---

local SHOOT_COOLDOWN = 1000 --Cooldown between homing shots
local LOCKON_TIME = 2000 --Time required to lock on to a target
local LOCK_RANGE = 330 --Maximum distance between you and the target
local LOCK_ANGLE = 1.0472 --(in radians) We cannot lock on targets unless they are within this angle of the front of the hydra
local VALID_TARGET_FUNCTION = function (vehicle) --Used to decide whether a vehicle should appear as a lock-on option
	local targetTeam = vehicle.controller and vehicle.controller.team
	local ourTeam = localPlayer.team
	if targetTeam and ourTeam and targetTeam == ourTeam then
		return false --The target vehicle has someone driving, and both of you are on the same team
	end
	return true
end
--[[
	to implement team tagging, or to disallow certain vehicles from being targetted, define the VALID_TARGET_FUNCTION
	VALID_TARGET_FUNCTION should take as parameter a vehicle, and return a boolean (true means it can be targetted)
	Here is an example of a function that will only let us target HYDRAS of OTHER TEAMS that are MORE THAN 50m AWAY and are DIRECTLY VISIBLE
	local VALID_TARGET_FUNCTION = function(vehicle)
		local targetTeam = vehicle.controller and vehicle.controller.team
		local ourTeam = localPlayer.team
		if targetTeam and ourTeam and targetTeam == ourTeam then
			return false --The target vehicle has someone driving, and both of you are on the same team
		end
		if vehicle.model ~= 520 then
			return false --Target is not a hydra, so it's not allowed
		end
		if (vehicle.position-localPlayer.position).length < 50 then
			return false --Closer than 50 metres
		end
		if not isLineOfSightClear(localPlayer.position, vehicle.position, true, false) then
			return false --Not directly visible
			--(Remember to account for your own vehicle and the target blocking the line)
		end
		return true --Target satisfied all criteria
	end
]]

---Don't touch stuff below this line---

--print("Starting resource 'better-hydra-missiles'")

--[[local next, pairs, ipairs, localPlayer, addEvent, createProjectile, addEventHandler, triggerEvent, math, table, resourceRoot, isElement, getTickCount, getElementType, getElementsByType, tostring, dxDrawLine, removeEventHandler, bindKey, unbindKey, toggleControl, root, tocolor, getScreenFromWorldPosition, isControlEnabled =
      next, pairs, ipairs, localPlayer, addEvent, createProjectile, addEventHandler, triggerEvent, math, table, resourceRoot, isElement, getTickCount, getElementType, getElementsByType, tostring, dxDrawLine, removeEventHandler, bindKey, unbindKey, toggleControl, root, tocolor, getScreenFromWorldPosition, isControlEnabled;]]

local validTarget = VALID_TARGET_FUNCTION or function() return true end
LOCK_ANGLE = math.cos(LOCK_ANGLE)

local inHydra = false
local firestate = nil
local visibleVehicles = {}
local lockedVehicles = {}
local nearbyVehicles = {}
getNearbyVehicles = function() return nearbyVehicles end --Used by other files
local getTarget, stopHydra, currentHydra

local function checkForLockout(vehicle)
	if visibleVehicles[vehicle] then
		triggerEvent("onClientHydraMissilesSystemLockout", localPlayer, vehicle)
		visibleVehicles[vehicle] = nil
		lockedVehicles[vehicle] = nil
		-- if getTarget() == vehicle then
			getTarget()
		-- end
	end
end

local function prev(t, index)
	local cur, val = next(t, index)
	while index ~= next(t, cur) do
		cur, val = next(t, cur)
	end
	return cur, val
end

local target
local function switchTarget(key, keystate, dir)
	if not inHydra then
		return
	end
	local it = next
	if dir == "back" then
		it = prev
	end
	local prev = target
	if target and not lockedVehicles[target] then
		target = nil
	end
	target = (it(lockedVehicles, target))
	if target == nil then --i.e. was last item
		target = (it(lockedVehicles, target))
	end
	if target~=prev then
		triggerEvent("onClientHydraMissilesSystemTargetChange", localPlayer, target)
	end
end
getTarget = function()
	if not inHydra then
		return
	end
	if not target or not lockedVehicles[target] then
		switchTarget()
	end
	return target
end

local lastShot = SHOOT_COOLDOWN*-2
local function shootMissile()
	if not inHydra then
		return
	end
	local target = getTarget()
	if not target or getTickCount() < lastShot + SHOOT_COOLDOWN then
		return
	end
	lastShot = getTickCount()
	local hydra = localPlayer.vehicle
	if triggerEvent("onClientHydraMissilesSystemShootHoming", localPlayer, target)==true then
		createProjectile( hydra, 20, hydra.position, 1, target)
	end
end



local function update()
	local curtime = getTickCount()
	if not localPlayer.vehicle then --idk why, but sometimes the player has no vehicle sometime before vehicle exit event is fired
		stopHydra() --The Avengers
		return
	end
	local target = getTarget()
	for _, vehicle in ipairs(nearbyVehicles) do
		local visibleNow = false
		local locked = lockedVehicles[vehicle]
		if vehicle~=localPlayer.vehicle and not vehicle.blown and validTarget(vehicle) then
			local targPos = vehicle.position
			local myPos = localPlayer.position
			local displacement = targPos-myPos
			local dist = displacement.length
			local cosAngle = localPlayer.vehicle.matrix.forward:dot(displacement)/dist
			if dist < LOCK_RANGE and cosAngle>LOCK_ANGLE then
				local aX, aY = getScreenFromWorldPosition(targPos)
				if (aY) then
					local R = 1000/math.min(math.max(dist, 20), 100)
					local color
					visibleNow = true
					local tween
					if locked then
						tween = 0
					else
						tween = 1 - (curtime - (visibleVehicles[vehicle] or curtime))/LOCKON_TIME
						tween=tween^4 --easing function

					end
					if vehicle == target then
						color = tocolor(255, 99, 71, 220)
					elseif locked then
						color = tocolor(255,165,0, 160)						
					else
						color = tocolor(255,215,0, (1-tween)*80)
					end
					do
						--Draw the corners of the target box outline
						dxDrawLine( aX+R+(8+tween*300), aY+R+(8+tween*300), aX+R*0.8, aY+R+(8+tween*300),color, 2 )
						dxDrawLine( aX+R+(8+tween*300), aY-R-(8+tween*300), aX+R*0.8, aY-R-(8+tween*300),color, 2 )
						dxDrawLine( aX+R+(8+tween*300), aY+R+(8+tween*300), aX+R+(8+tween*300), aY+R*0.8,color, 2 )
						dxDrawLine( aX-R-(8+tween*300), aY+R+(8+tween*300), aX-R-(8+tween*300), aY+R*0.8,color, 2 )

						dxDrawLine( aX-R-(8+tween*300), aY+R+(8+tween*300), aX-R*0.8, aY+R+(8+tween*300),color, 2 )
						dxDrawLine( aX-R-(8+tween*300), aY-R-(8+tween*300), aX-R*0.8, aY-R-(8+tween*300),color, 2 )
						dxDrawLine( aX+R+(8+tween*300), aY-R-(8+tween*300), aX+R+(8+tween*300), aY-R*0.8,color, 2 )
						dxDrawLine( aX-R-(8+tween*300), aY-R-(8+tween*300), aX-R-(8+tween*300), aY-R*0.8,color, 2 )
					end
				end
			end
		end
		if not visibleNow then
			checkForLockout(vehicle)
		elseif visibleVehicles[vehicle] then
			if not locked and curtime - visibleVehicles[vehicle] > LOCKON_TIME then
				lockedVehicles[vehicle] = true
				triggerEvent("onClientHydraMissilesSystemLockonEnd", localPlayer, vehicle)
			end 
		else
			triggerEvent("onClientHydraMissilesSystemLockonStart", localPlayer, vehicle)
			visibleVehicles[vehicle] = curtime
		end
	end
end


local function homingState(key,state)
	if not inHydra then return end
	if state == "down" then
		firestate = isControlEnabled("vehicle_secondary_fire")
		toggleControl("vehicle_secondary_fire",false)
		bindKey("vehicle_secondary_fire","down",shootMissile)
		triggerEvent("onClientHydraMissilesSystemHomingStateOn", localPlayer, currentHydra)
	else
		toggleControl("vehicle_secondary_fire",firestate)
		firestate = nil
		unbindKey("vehicle_secondary_fire","down",shootMissile)
		triggerEvent("onClientHydraMissilesSystemHomingStateOff", localPlayer, currentHydra)
	end
end

local function vehicleGoneHandler() --This also triggers on localPlayer's vehicle, and does nothing to it
	removeEventHandler("onClientElementDestroy", source, vehicleGoneHandler)
	removeEventHandler("onClientElementStreamOut", source, vehicleGoneHandler)
	if getElementType( source ) == "vehicle" then
		for i, v in ipairs(nearbyVehicles) do
			if v == source then
				checkForLockout(source)
				table.remove(nearbyVehicles, i)
				return
			end
		end
	end
end

local function prepAfterStreamIn(vehicle)
	addEventHandler("onClientElementStreamOut", vehicle, vehicleGoneHandler)
	addEventHandler("onClientElementDestroy", vehicle, vehicleGoneHandler)	
end

local function streamInHandler()
	if getElementType( source ) == "vehicle" then
		table.insert(nearbyVehicles, source)
		prepAfterStreamIn(source)
	end
end


local function startHydra(vehicle)
	if not inHydra and vehicle and isElement(vehicle) and vehicle.model == 520 or getElementData(vehicle,"hydrahud") then
		nearbyVehicles = getElementsByType("vehicle", root, true)
		for i, v in ipairs(nearbyVehicles) do
			prepAfterStreamIn(v)
		end
		addEventHandler("onClientElementStreamIn", root, streamInHandler)
		addEventHandler("onClientVehicleExplode", vehicle, stopHydra)
		addEventHandler("onClientElementDestroy", vehicle, stopHydra)
		addEventHandler("onClientElementStreamOut", vehicle, stopHydra) --Is this even possible?
		inHydra = tostring(isControlEnabled("handbrake"))
		currentHydra = vehicle --To remove the listeners later
		toggleControl("handbrake", false)
		bindKey("handbrake","down",homingState)
		bindKey("handbrake","up",homingState)
		bindKey("mouse_wheel_up","down",switchTarget, "back")
		bindKey("mouse_wheel_down","down",switchTarget)
		bindKey("horn","down",switchTarget)
		addEventHandler( "onClientRender", root,  update)
		triggerEvent("onClientHydraMissilesSystemStart", localPlayer, vehicle)
	end
end
stopHydra = function()
	if inHydra then
		local target = getTarget()
		for i, v in ipairs(nearbyVehicles) do
			if v ~= target then
				removeEventHandler("onClientElementDestroy", v, vehicleGoneHandler)
				removeEventHandler("onClientElementStreamOut", v, vehicleGoneHandler)
				checkForLockout(v)
			end
		end
		checkForLockout(target)
		if target then
			removeEventHandler("onClientElementDestroy", target, vehicleGoneHandler)
			removeEventHandler("onClientElementStreamOut", target, vehicleGoneHandler)
		end
		removeEventHandler("onClientRender", root, update)
		unbindKey("handbrake","down",homingState)
		unbindKey("handbrake","up",homingState)
		if firestate ~= nil then
			homingState("handbrake","up")
		end
		local vehicle = currentHydra
		currentHydra = nil
		unbindKey("mouse_wheel_up","down",switchTarget)
		unbindKey("mouse_wheel_down","down",switchTarget)
		unbindKey("horn","down",switchTarget)
		toggleControl("handbrake", inHydra=="true")
		inHydra = false
		removeEventHandler("onClientElementStreamIn", root, streamInHandler)
		if isElement(vehicle) then
			removeEventHandler("onClientVehicleExplode", vehicle, stopHydra)
			removeEventHandler("onClientElementDestroy", vehicle, stopHydra)
			removeEventHandler("onClientElementStreamOut", vehicle, stopHydra)
		else
			outputDebugString("There was an annoying problem on this line, write a bug report please.")
		end
		triggerEvent("onClientHydraMissilesSystemStop", localPlayer, vehicle)
	end
end

local function initScript()

	if localPlayer.vehicle and localPlayer.vehicle.model == 520 then
		startHydra(localPlayer.vehicle)
	end
	addEventHandler("onClientResourceStop", resourceRoot, stopHydra)
	addEventHandler("onClientPlayerVehicleExit",localPlayer,stopHydra)
	addEventHandler("onClientPlayerWasted",localPlayer,stopHydra)
	addEventHandler("onClientPlayerVehicleEnter",localPlayer,startHydra)
end

addEvent("onClientHydraMissilesSystemStart")
addEvent("onClientHydraMissilesSystemStop")
addEvent("onClientHydraMissilesSystemLockonStart")
addEvent("onClientHydraMissilesSystemLockonEnd")
addEvent("onClientHydraMissilesSystemLockout")
addEvent("onClientHydraMissilesSystemTargetChange")
addEvent("onClientHydraMissilesSystemShootHoming")
addEvent("onClientHydraMissilesSystemHomingStateOn")
addEvent("onClientHydraMissilesSystemHomingStateOff")

addEventHandler("onClientResourceStart",resourceRoot,initScript)

--testing calllbacks:
-- local function callback()
-- 	outputChatBox(eventName.." was called")
-- end
-- addEventHandler("onClientHydraMissilesSystemStart", localPlayer, callback)
-- addEventHandler("onClientHydraMissilesSystemStop", localPlayer, callback)
-- addEventHandler("onClientHydraMissilesSystemLockonStart", localPlayer, callback)
-- addEventHandler("onClientHydraMissilesSystemLockonEnd", localPlayer, callback)
-- addEventHandler("onClientHydraMissilesSystemLockout", localPlayer, callback)
-- addEventHandler("onClientHydraMissilesSystemTargetChange", localPlayer, callback)
-- addEventHandler("onClientHydraMissilesSystemShootHoming", localPlayer, callback)
-- addEventHandler("onClientHydraMissilesSystemHomingStateOn", localPlayer, callback)
-- addEventHandler("onClientHydraMissilesSystemHomingStateOff", localPlayer, callback)

---focus: User settings:

local CAMERA_DISTANCE = 40

----

local Vector3, addEventHandler, root, localPlayer, Camera, setCameraTarget =
      Vector3, addEventHandler, root, localPlayer, Camera, setCameraTarget;

local up = Vector3(0, 0, 5)
local target, homing, setCamTarg_flag
setCamTarg_flag = false
addEventHandler("onClientRender", root, function()
	if homing and target then
		setCamTarg_flag = true
		local dir = (localPlayer.position - target.position)
		dir:normalize()
		local campos = localPlayer.position + dir*CAMERA_DISTANCE + up
		Camera.setMatrix(campos, target.position)
	elseif setCamTarg_flag then
		setCameraTarget(localPlayer)
		setCamTarg_flag = false
	end
end)

addEventHandler("onClientHydraMissilesSystemTargetChange", localPlayer, function(t) target = t end)
addEventHandler("onClientHydraMissilesSystemHomingStateOn", localPlayer, function() homing = true end)
addEventHandler("onClientHydraMissilesSystemHomingStateOff", localPlayer, function() homing = false end)

----Visor User settings---

local RANGE = 200 --Elements further away don't get a box around them
local LABEL_FUNCTION = nil --Should take a vehicle and return the text to be shown for it (e.g. Player's clan, or vehicle model, or score etc.)
local COLOR_FUNCTION = nil --Should take a vehicle (may be empty vehicle) and return R,G,B of colour of the box around it (e.g. team color, or just red and green for "enemy and ally")
--examples for both of these are the default functions below
local VALID_VEHICLE_FUNCTION = nil --Similar to VALID_TARGET_FUNCTION in missile.lua

---------------------

COLOR_FUNCTION = COLOR_FUNCTION or function ( vehicle )
	local plr = vehicle.controller
	if not plr then
		return 255,255,255
	else
		--return getPlayerNametagColor(plr)
		if plr.team and plr.team == localPlayer.team then
			return 30, 255, 30
		else
			return 255, 30, 30
		end
	end
end
VALID_VEHICLE_FUNCTION = VALID_VEHICLE_FUNCTION or function() return true end

local function update()	
	for i, v in ipairs(getNearbyVehicles()) do
		local aX, aY = getScreenFromWorldPosition(v.position)
		local dist = (v.position-localPlayer.position).length
		if aY and not v.blown and localPlayer.vehicle ~= v and dist<RANGE and VALID_VEHICLE_FUNCTION(v) then
			local R = 1000/math.min(math.max(dist, 20), 100)
			local r, g, b = COLOR_FUNCTION(v)
			local alpha = math.min(60, 60*(RANGE-dist)/50)
			local color = tocolor(r, g, b, alpha)
			dxDrawLine( aX+R, aY+R, aX-R, aY+R, color, 2 )
			dxDrawLine( aX+R, aY-R, aX-R, aY-R, color, 2 )
			dxDrawLine( aX+R, aY-R, aX+R, aY+R, color, 2 )
			dxDrawLine( aX-R, aY-R, aX-R, aY+R, color, 2 )
			dxDrawText( math.floor( dist ).."m", aX-20, aY+25, 25, 20, color, 0.9 )
			dxDrawText(retrieveCustomCarName(v), aX-20, aY+40, 25, 20, color, 0.9)
		end
	end
end

addEventHandler("onClientHydraMissilesSystemStart", localPlayer, function()
	addEventHandler( "onClientRender", root,  update)
end)
addEventHandler("onClientHydraMissilesSystemStop", localPlayer, function()
	removeEventHandler( "onClientRender", root,  update)
end)
