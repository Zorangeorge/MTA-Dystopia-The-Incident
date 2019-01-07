SAMObjects = {3884, 3267}
AllSAMColShapesDummy = createElement("SAMSites","SAMs")

local allObjects = getElementsByType("object")

local SAMNumber = 0

for _,obj in ipairs(allObjects) do
	if getElementModel(obj)== 3884 or getElementModel(obj)== 3267 then
	local x,y,z = getElementPosition(obj)
	local SAMcol = createColSphere(x,y,z,200)
	setElementParent(SAMcol, AllSAMColShapesDummy)
	setElementData(SAMcol,"SAMObject",obj)
	SAMNumber = SAMNumber+1
	end
end

outputDebugString(SAMNumber.." SAMs created")
SAMNumber = nil

function SAMColhit ( pla, dim )
	if getElementType ( pla ) == "player" then
	local vehicle = getPedOccupiedVehicle ( pla )
		if vehicle and getVehicleController (vehicle) == pla and (getVehicleType(vehicle)== "Plane" or getVehicleType(vehicle)== "Helicopter") then
			
			if ( getTeamName(getPlayerTeam(pla)) == "Establishment" ) then
				--outputChatBox ( "Welcome, "..getClientName(pla).."!", pla, 0, 150, 0 )
			else
				if not getElementData ( pla, "inRestrictedArea") then 
					setElementData ( pla, "inRestrictedArea", true );
					--outputChatBox ( "Warning, restricted air space!", pla, 150, 0, 0 ) 
					outputInteractInfo ( "[Warning!]\n[restricted airspace]", pla, 140, 0, 0 ) 
					--outputTopBar ( "You entered restricted airspace", pla, 140, 0, 0 ) 
				end
				triggerClientEvent ( pla, "destroyTrespasser", root, pla, source )
				
			end
		end
	end
end
addEventHandler ( "onColShapeHit", AllSAMColShapesDummy, SAMColhit,true )

function SAMColleave ( pla, dim )
	if getElementType ( pla ) == "player" then
	--local vehicle = getPedOccupiedVehicle ( pla )
		--if vehicle and getVehicleController (vehicle) == pla --[[and (getVehicleType(vehicle)== "Plane" or getVehicleType(vehicle)== "Helicopter")]]  then
			if ( getTeamName(getPlayerTeam(pla)) == "Establishment" ) then
				--outputChatBox ( "Good Bye!", pla, 0, 100, 0 )
			else
				if getElementData ( pla, "inRestrictedArea")==true then setElementData ( pla, "inRestrictedArea", false ) end
				triggerClientEvent ( pla, "destroyTimer", root,source )
				outputDebugString ( "*"..getPlayerName(pla).." has left col shape" )
			end
		--end
	end
end
addEventHandler ( "onColShapeLeave", AllSAMColShapesDummy, SAMColleave,true )

--[[function clearSAMsActive()
	if getElementData ( source, "inRestrictedArea") == true then
		setElementData ( source, "inRestrictedArea", false )
	end
end
addEventHandler ( "onPlayerWasted", root, clearSAMsActive)]]