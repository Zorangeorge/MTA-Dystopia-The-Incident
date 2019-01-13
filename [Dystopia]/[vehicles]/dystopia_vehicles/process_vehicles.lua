function processVehiclesOnStart() -- creates colshapes around all vehicles for interaction purposes

outputDebugString("loading vehicle cols...")

local vehtable = getElementsByType("vehicle")

	for _, veh in ipairs(vehtable) do 
	
	toggleVehicleRespawn(veh,true)
	if getElementModel(veh) == 464 then toggleVehicleRespawn(veh,false) end
	setVehicleIdleRespawnDelay(veh,3600000/2)  -- this is the respawn delay when idle; 3600000 = 1 hour; needs to be set equal with vehicle explosion respawn timer
	
	
	
		local x,y,z = getElementPosition(veh)
		local repaircol = createColSphere(x,y,z, 3.2)
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
			attachElements(gun, veh, -0.6,0.7,-0.9,-90,-55,0)
			setObjectScale(gun,1.8)
			setElementCollisionsEnabled(gun, false)
			setElementData(gun,"carprop",true)
			setElementData(veh,"weapon",gun)
			
		end
		
		if model == 434 then -- hotknife/interceptor
			local gun = createObject(362,0,0,0)
			attachElements(gun, veh, -1.2,0.1,0.1,-90,-55,0)
			setObjectScale(gun,1.8)
			setElementCollisionsEnabled(gun, false)
			setElementData(gun,"carprop",true)
			setElementData(veh,"weapon",gun)
			
		end

		--[[		if model == 528 then -- fbi van
			local gun = createObject(362,0,0,0)
			attachElements(gun, veh, -1.2,0.1,0.1,-90,-55,0)
			setObjectScale(gun,1.8)
			setElementCollisionsEnabled(gun, false)
			setElementData(gun,"carprop",true)
			setElementData(veh,"weapon",gun)
		end]]
	
		
	end
	
end
addEventHandler( "onResourceStart", resourceRoot,processVehiclesOnStart ) 

addEventHandler("onVehicleRespawn",resourceRoot, function (explodedbool)
	setElementData(source, "vehicle_disabled", false, true);--zzzz
	setElementData(source, "repaired", true,true)
	setElementData(source, "queuedforrespawn", false,true)
	local respawnTimer = getElementData(source,"respawntimer")
	if respawnTimer and isTimer(respawnTimer) then killTimer(respawnTimer) end
	removeElementData(source,"respawntimer")
end)
