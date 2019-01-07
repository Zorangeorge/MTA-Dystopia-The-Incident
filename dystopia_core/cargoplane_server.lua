-----------------------
----- Cargo Plane ----- -- Makes a Cargo plane that and hauls cars automaticly to all airports and
--------- by----------- -- contains a mod of Ransoms nuke resource (random nukes & base for all moving objects)
------- KWKSND -------- -- Makes Multi Theft Auto more fun :D
-----------------------

local resourceRoot = getResourceRootElement(getThisResource())
--local otherCARGOPLANEPieces = getElementsByType ( "otherCARGOPLANEPieces" )
local CARGOPLANEMovements = getElementsByType ( "CARGOPLANEMovements" )
count = 0

liftHeli = { [592]=true }
action = "a"
attached = "2"
magcount = 0
root = getRootElement ()
slot = 1
colclean2 = { }
colclean3 = { }
floor2 = nil

CARGOPLANECenter = createObject ( 2995, 0.0 , -3.650002, 0.550000, 12.89155, -0.40, -180.00002)
setElementID(CARGOPLANECenter, "CARGOPLANECenter" )
setElementAlpha(CARGOPLANECenter,0)
--setElementDimension(CARGOPLANECenter,1)
setElementAlpha(CARGOPLANECenter,0)
setElementCollisionsEnabled(CARGOPLANECenter,false)
realCargoPlane = createVehicle (592, 0.0 , -3.650002, 0.550000)
setVehicleEngineState (realCargoPlane, true)
setVehicleDamageProof (realCargoPlane, true)
setElementRotation(realCargoPlane,12.89155, -0.40, -180.00002)
attachElements ( realCargoPlane, CARGOPLANECenter,0,0,-2.2,12,0,180)
CargoPlaneBlip = createBlipAttachedTo ( CARGOPLANECenter, 5, 2, 0, 255, 255, 255, 0, 999 )
brHideBlip(CargoPlaneBlip)

function checkCargoPlanePilot ()
--[[	if not CargoPlanePilot then 
	CargoPlanePilot = createPed(278,0,0,0)
	setElementData(CargoPlanePilot,"name","Pilot")
	setElementData(CargoPlanePilot,"BotTeam",getTeamFromName("Establishment"))
	warpPedIntoVehicle(CargoPlanePilot,realCargoPlane,0)
	outputDebugString("pilot on duty")
	end]]
	
	if not isElement(CargoPlanePilot) then 
	CargoPlanePilot = createPed(278,0,0,0)
	setElementData(CargoPlanePilot,"name","Pilot")
	setElementData(CargoPlanePilot,"BotTeam",getTeamFromName("Establishment"))
	warpPedIntoVehicle(CargoPlanePilot,realCargoPlane,0)
	outputDebugString("pilot on duty")
	end
	
end

checkCargoPlanePilot ()

function startMovingCARGOPLANE ()
	local CARGOPLANEMovements = getElementsByType ( "CARGOPLANEMovements" )
	count = count + 1
	if count > #CARGOPLANEMovements then --end of table reached, reset counter go back to entry 1
    		setObjectRotation ( CARGOPLANECenter, 12.89155, 0.0, -180.00002 ) 
    		--outputChatBox("#FF0000SAN #FFFFFFNews Flash!!", getRootElement(), 255, 255, 255, true )
    		--outputChatBox(" #FFFFFFA stolen Cargo Plane is in the SF area!!", getRootElement(), 255, 255, 255, true )
     		count = 1
	end
	
	local timeInMS = getElementData(CARGOPLANEMovements[count],"timeInMS")
	local id = getElementData(CARGOPLANEMovements[count],"pointID")
	
	--outputChatBox("Pilot: "..id)
	--triggerEvent("SendYellToNearbyPlayers",root,CargoPlanePilot,id)
	
	if (count == 6) or (count == 18) or (count == 29) or (count == 44) then -- gear down
			--setVehicleLandingGearDown(realCargoPlane, true)
			--triggerEvent("SendYellToNearbyPlayers",root,CargoPlanePilot,"We are"..id)
			checkCargoPlanePilot ()
			triggerClientEvent("onChatIncome",CargoPlanePilot,"We are"..id)--*****************

			setVehicleLandingGearDown(realCargoPlane, true)
			triggerClientEvent("openCargoPlaneDoor",realCargoPlane)
	end
	
	if (count == 10) or (count == 22) or (count == 33) or (count == 48) then -- detach vehicles
    		--triggerEvent("SendYellToNearbyPlayers",root,CargoPlanePilot,id)
			checkCargoPlanePilot ()
			triggerClientEvent("onChatIncome",CargoPlanePilot,id)--*************
    		--cargoLift1 ( action ) --19,20,21,22 l si tk 24 viraj
	end
	
	if (count == 11) or (count == 23) or (count == 34) or (count == 49) then -- attach vehicles
   		 --triggerEvent("SendYellToNearbyPlayers",root,CargoPlanePilot,"Hold on to something, we're goin' up!")
			checkCargoPlanePilot ()
			triggerClientEvent("onChatIncome",CargoPlanePilot,"Hold on to something, we're goin' up!")--**
	end
	
	if (count == 15)--[[SF]] or (count == 27)--[[AA]] or (count == 38)--[[LV]] or (count == 53)--[[LS]] then -- gear up
		setVehicleLandingGearDown(realCargoPlane, false)
		triggerClientEvent("closeCargoPlaneDoor",realCargoPlane)
		--triggerEvent("SendYellToNearbyPlayers",CargoPlanePilot,CargoPlanePilot,"Approaching next destination: "..id)
		checkCargoPlanePilot ()
		triggerClientEvent("onChatIncome",CargoPlanePilot,"Approaching next destination: "..id)
	end
	--48 landing LS
	--9 landing SF
	--11 taking off
	--21 landing AA
	moveObject ( CARGOPLANECenter, tonumber (getElementData(CARGOPLANEMovements[count],"timeInMS")), tonumber (getElementData(CARGOPLANEMovements[count],"destX")), tonumber (getElementData(CARGOPLANEMovements[count],"destY")), tonumber (getElementData(CARGOPLANEMovements[count],"destZ")), tonumber (getElementData(CARGOPLANEMovements[count],"destRX")), tonumber (getElementData(CARGOPLANEMovements[count],"destRY")), tonumber (getElementData(CARGOPLANEMovements[count],"destRZ"))) --- get rest of dest stuff etc etc
        setTimer ( startMovingCARGOPLANE, tonumber ( getElementData(CARGOPLANEMovements[count],"timeInMS")), 1 ) --this specifies how long until next coords are called

	--outputDebugString("index is: "..count)
	--outputDebugString(" ETA: "..timeInMS)
	--outputDebugString(" ID: "..getElementData(CARGOPLANEMovements[count],"pointID"))
end

startMovingCARGOPLANE ()
