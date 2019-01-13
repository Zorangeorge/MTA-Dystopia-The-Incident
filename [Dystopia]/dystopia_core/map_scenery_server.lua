--vehicle parts and stats--
local vehPanelNo = {0,1,2,3,4,5,6} -- panel number
local vehPanelSt = {2,3} -- panel state

local vehWheelSt = {1,2} -- 0 intact, 2 missing

local vehDoorNo = {0,1,2,3,4,5} --"-"
local vehDoorSt = {3,4}

local vehicletable = getElementsByType ( "vehicle", root )
		
function lockenforce(player, seat, jacked)

		if getElementData(source,"vehicle-scenery") == true then 
				 cancelEvent()
		end	
 end
addEventHandler ( "onVehicleStartEnter", getRootElement(), lockenforce )

function propAllSceneryVehicles() -- command to prop vehicles
	local vehicletable = getElementsByType ( "vehicle", root )
	for _, veh in ipairs(vehicletable) do
	local attachments = getAttachedElements(veh)
	local x,y,z = getElementPosition(veh)
	local rx, ry, rz = getElementRotation(veh)
	local scavengecolshape =  createColSphere(x,y,z,3)
	
	if attachments and #attachments > 0 then
		for _, attchm in ipairs(attachments) do
			if getElementData(attchm,"coltype")== "vehinteract" then
			destroyElement(attchm)
			end
		end
	end
	
	attachElements(scavengecolshape,veh,0,0,0.5)
	setElementData(scavengecolshape, "scavamount", math.random(2,8))
	
	setElementData(veh,"vehicle-scenery",true)	
	setVehicleEngineState(veh,false)
	propVehicle(veh) 
	end
	
end
addCommandHandler ( "propveh", propAllSceneryVehicles ) 

function propVehicle(vehicle) --removes random panels, doors and wheels; Establishment vehicles, special vehicles and any vehicle that needs to be in working condition at start are skipped (not completed)

if ( getVehicleType (vehicle) == "Automobile" or getVehicleType (vehicle) == "Bike" or getVehicleType (vehicle) == "Trailer" ) and getElementData(vehicle,"vehicle-scenery") == true 

--and getElementModel (vehicle) ~= (552) -- skipped vehicles 
--and getElementModel (vehicle) ~= (427) 
--and getElementModel (vehicle) ~= (528) 
--and getElementModel (vehicle) ~= (508) 
--dozer

then--hit it!
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
	setVehicleWheelStates ( vehicle, table.random(vehWheelSt), table.random(vehWheelSt), table.random(vehWheelSt), table.random(vehWheelSt)) --table.random(vehWheelSt)
end	
	setVehicleDoorState ( vehicle, 0, table.random(vehDoorSt) )
	setVehicleDoorState ( vehicle, 1, table.random(vehDoorSt) )
	setVehicleDoorState ( vehicle, 2, table.random(vehDoorSt) )
	setVehicleDoorState ( vehicle, 3, table.random(vehDoorSt) )
	setVehicleDoorState ( vehicle, 4, table.random(vehDoorSt) )
	setVehicleDoorState ( vehicle, 5, 4 ) --trunk door always missing

	setElementPosition(vehicle,x,y,z-0.35)
	setVehicleColor(vehicle,102,84,68,102,84,68,102,84,68,102,84,68)
	setTimer(function(veh)
			setElementFrozen(veh,true)
			end,3000,1, vehicle) 
end
end