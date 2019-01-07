
rearm_marker = createMarker ( 315.66015625, 1960.3837890625, 12.640625, "cylinder", 6, 255, 92, 51, 85)
Timers = {}

function attach(hitElement) 
if getElementType(hitElement)~= "player" then return end
playerSource = hitElement 
	if isPedInVehicle(playerSource) == true then
		
		local vehicle = getPedOccupiedVehicle(playerSource)
		--if getElementData(vehicle,"bunkerbomb") then outputDebugString("already has bomb") return end
		local vehmodel = getElementModel(vehicle)
		
		if vehmodel ~= 520 and vehmodel ~= 476 and vehmodel ~= 519 and vehmodel ~= 460 
		and vehmodel ~= 563 and vehmodel ~= 425 and vehmodel ~= 447 then 
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
			--outputInteractInfo("[ Bunker Buster bomb installed ]",hitelem,240,240,240)
			outputChatBox("Drop bomb\n[R]",playerSource,240,240,240)
				--outputInteractInfo("[ Bunker Buster bomb installed ]",hitelem,240,240,240)
				outputChatBox("[ Bunker Buster bomb installed ]",playerSource,240,240,240)
		
		else
		--outputInteractInfo("[ vehicle already armed ]",hitelem,240,100,100)
		outputChatBox("[ aircraft already armed! ] ",playerSource,240,100,100)
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
	--outputInteractInfo("Arm aircraft\n[E]",hitelem,240,240,240)
	outputChatBox("Arm aircraft\n[E]",hitelem,240,240,240)
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

	 --if vz ==0 then
	 --if vz ==0 and getDistanceBetweenPoints3D ( vehicle1x, vehicle1y, vehicle1z, vehicle2x,vehicle2y, vehicle2z ) > 20 then
	 if ( isVehicleOnGround(theBomb) or vz == 0 ) and getDistanceBetweenPoints3D ( vehicle1x, vehicle1y, vehicle1z, vehicle2x,vehicle2y, vehicle2z ) > 30 then
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
		--Timers = {}
		-- blowVehicle(theBomb)
	 end
	 	--killTimer(Timers[index])
		--Timers[index] = nil
end


--addEventHandler("onMarkerHit", rearm_marker, attach)
addEventHandler("onMarkerHit", rearm_marker, hitTheArmMarker)
addEventHandler("onMarkerLeave", rearm_marker, leaveTheArmMarker)
addCommandHandler("airstrike", attach)

