function table.random ( theTable ) -- evrika! theTable e folosit ca "jolly" pentru orice tabel pasat cand call-ui functia. punctul zero zoran - lua
    return theTable[math.random ( #theTable )]
end

--vehicle parts and stats--
local vehPanelNo = {0,1,2,3,4,5,6} -- panel number
local vehPanelSt = {2,3} -- panel state

local vehWheelSt = {1,2} -- 0 intact, 2 missing

local vehDoorNo = {0,1,2,3,4,5} --"-"
local vehDoorSt = {3,4}

function propMapVehicle(vehicle) --removes random panels, doors and wheels; Establishment vehicles, special vehicles and any vehicle that needs to be in working condition at start are skipped (not completed)

--if getElementData(vehicle, "vehicle_disabled") == true then return

--elseif getElementData(source,"repaired") == true then return  --setElementData(source, "repaired",false,true)

if ( getVehicleType (vehicle) == "Automobile" or getVehicleType (vehicle) == "Bike" or getVehicleType (vehicle) == "Trailer"  or getVehicleType (vehicle) == "Helicopter" or getVehicleType (vehicle) == "Plane" ) then
--and getElementData(vehicle,"vehicle-scenery") == true 

--and getElementModel (vehicle) ~= (552) -- skipped vehicles 
--and getElementModel (vehicle) ~= (427) 
--and getElementModel (vehicle) ~= (528) 
--and getElementModel (vehicle) ~= (508) 
--dozer
--

--hit it!
local x, y, z = getElementPosition(vehicle)
local rot = getElementRotation(vehicle)

setElementData(vehicle, "vehicle_disabled", true, true)

	setVehiclePanelState ( vehicle, 0, table.random(vehPanelSt) )
	setVehiclePanelState ( vehicle, 1, table.random(vehPanelSt) )
	setVehiclePanelState ( vehicle, 2, table.random(vehPanelSt) )
	setVehiclePanelState ( vehicle, 3, table.random(vehPanelSt) )
	setVehiclePanelState ( vehicle, 4, table.random(vehPanelSt) )
	setVehiclePanelState ( vehicle, 5, table.random(vehPanelSt) )
	setVehiclePanelState ( vehicle, 6, table.random(vehPanelSt) )
if getElementModel(vehicle)	~= 601 and getElementModel(vehicle)	~= 532 and getElementModel(vehicle)	~= 486 then --
	setVehicleWheelStates ( vehicle, 1, 1, 1, 1) --table.random(vehWheelSt)
end	
	setVehicleDoorState ( vehicle, 0, table.random(vehDoorSt) )
	setVehicleDoorState ( vehicle, 1, table.random(vehDoorSt) )
	setVehicleDoorState ( vehicle, 2, table.random(vehDoorSt) )
	setVehicleDoorState ( vehicle, 3, table.random(vehDoorSt) )
	setVehicleDoorState ( vehicle, 4, table.random(vehDoorSt) )
	setVehicleDoorState ( vehicle, 5, 4 ) --trunk door always missing
	--setElementCollisionsEnabled(vehicle,false)
	--local dummycolobject = createObject(3594,x,y,z,rot)
	--setElementAlpha(dummycolobject,0)
	--setElementHealth(vehicle,0)
	setElementPosition(vehicle,x,y,z-0.1)

	if getElementModel(vehicle) == 425 then 
	setElementPosition(vehicle,x,y,z-2.5); 
	setElementFrozen(vehicle,true)
	setElementSyncer(vehicle,false)
	end
	setVehicleColor(vehicle,102,84,68,102,84,68,102,84,68,102,84,68)
	

	if ( getVehicleType (vehicle) == "Plane" or  getVehicleType (vehicle) == "Helicopter") then
			setElementFrozen(vehicle,true)
			setElementSyncer(vehicle,false)
	end
	
	setVehicleDamageProof ( vehicle, true )

			
	
end

end

function propMapSceneryVehicles() -- command to prop vehicles
	
	outputDebugString("loading scavenge cols...")
	
	local vehicletable = getElementsByType ( "vehicle", resourceRoot )
	for _, veh in ipairs(vehicletable) do
		local attachments = getAttachedElements(veh)
		local x,y,z = getElementPosition(veh)
		--local rx, ry, rz = getElementRotation(veh)
		local scavengecolshape =  createColSphere(x,y,z,3)
		
			if attachments and #attachments > 0 then
				for _, attchm in ipairs(attachments) do
					if getElementData(attchm,"coltype")== "vehinteract" then
					destroyElement(attchm)
					end
				end
			end
		
		attachElements(scavengecolshape,veh,0,0,0.5)
		setElementData(scavengecolshape, "scavamount", math.random(2,8),true)
		
		setElementData(veh,"vehicle-scenery",true,true)	
		setVehicleEngineState(veh,false)
			--[[if ( getVehicleType (veh) == "Plane" or  getVehicleType (veh) == "Helicopter") then
			setElementFrozen(veh,true)
			end]]
		propMapVehicle(veh) 
	end
	
	
end
propMapSceneryVehicles() --BAM!

--[[function checkagainsttable(objtocheck,thetable)
	for _,objid in pairs(thetable) do
		if objid == objtocheck then
			return true
			--break
		end
	end	
	return false
end



function checkagainsttable(objtocheck,thetable)
	for _,objid in pairs(thetable) do
		if objid == objtocheck then
			return true
			--break
		end
	end	
	return false
end

function setLootObjectsHealth ()

outputDebugString("setting loot objects...")
	
	local objtable = getElementsByType ( "object", resourceRoot )
	for _, obj in ipairs(objtable) do
		--local objmodel = getElementModel(obj)
		if checkagainsttable(obj,lootObjects)==true then 
		setElementHealth(obj,1) 
		end
	end
end
setLootObjectsHealth() --WHOOSH!]]
