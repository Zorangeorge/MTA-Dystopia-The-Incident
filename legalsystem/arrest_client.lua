coptargets = 0
--ADDS BLIPS AND MARKERS FOR POLICE STATIONS
addEvent("copdirections", true)
function copshops()
	if coptargets == 0 then
		coptargets = 1
		blip1 = createBlip ( 2246.1008300781, 2453.1953125, 9.8203125, 30, 3, 0, 0, 255, 255, 50, 99999.0, getLocalPlayer() )
		marker1 = createMarker ( 2246.1008300781, 2453.1953125, 9.8203125, "cylinder", 6, 0, 0, 255, 55, getLocalPlayer() )
		colshape1 = createColSphere ( 2246.1008300781, 2453.1953125, 9.8203125, 6 )
		setElementData ( colshape1, "purpose", "copshop" )
		
		blip2 = createBlip ( -1406.9072265625, 2655.0927734375, 55.6875, 30, 3, 0, 0, 255, 255, 50,  99999.0, getLocalPlayer() )
		marker2 = createMarker ( -1406.9072265625, 2655.0927734375, 55.6875, "cylinder", 6, 0, 0, 255, 55, getLocalPlayer() )
		colshape2 = createColSphere ( -1406.9072265625, 2655.0927734375, 55.6875, 6 )
		setElementData ( colshape2, "purpose", "copshop" )
		
		blip3 = createBlip ( -209.9542, 977.7558, 18.188976, 30, 3, 0, 0, 255, 255, 50,  99999.0, getLocalPlayer() )
		marker3 = createMarker ( -209.9542, 977.7558, 18.188976, "cylinder", 6, 0, 0, 255, 55, getLocalPlayer() )
		colshape3 = createColSphere (-209.9542, 977.7558, 18.188976, 6 )
		setElementData ( colshape3, "purpose", "copshop" )
		
		blip4 = createBlip ( -1628.2619628906, 676.62005615234, 6.1901206970215, 30, 3, 0, 0, 255, 255, 50,  99999.0, getLocalPlayer() )
		marker4 = createMarker ( -1628.2619628906, 676.62005615234, 6.1901206970215, "cylinder", 6, 0, 0, 255, 55, getLocalPlayer() )
		colshape4 = createColSphere ( -1628.2619628906, 676.62005615234, 6.1901206970215, 6 )
		setElementData ( colshape4, "purpose", "copshop" )
		
		blip5 = createBlip ( 624.66278076172, -605.72027587891, 15.923292160034, 30, 3, 0, 0, 255, 255, 50,  99999.0, getLocalPlayer() )
		marker5 = createMarker ( 624.66278076172, -605.72027587891, 15.923292160034, "cylinder", 6, 0, 0, 255, 55, getLocalPlayer() )
		colshape5 = createColSphere ( 624.66278076172, -605.72027587891, 15.923292160034, 6 )
		setElementData ( colshape5, "purpose", "copshop" )
		
		blip6 = createBlip ( 1565.3386230469, -1628.5202636719, 12.382812, 30, 3, 0, 0, 255, 255, 50,  99999.0, getLocalPlayer() )
		marker6 = createMarker ( 1565.3386230469, -1628.5202636719, 12.382812, "cylinder", 6, 0, 0, 255, 55, getLocalPlayer() )
		colshape6 = createColSphere ( 1565.3386230469, -1628.5202636719, 12.382812, 6 )
		setElementData ( colshape6, "purpose", "copshop" )
		
		blip7 = createBlip ( -2164.3779296875, -2389.533203125, 29.617206573486, 30, 3, 0, 0, 255, 255, 50,  99999.0, getLocalPlayer() )
		marker7 = createMarker ( -2164.3779296875, -2389.533203125, 29.617206573486, "cylinder", 6, 0, 0, 255, 55, getLocalPlayer() )
		colshape7 = createColSphere ( -2164.3779296875, -2389.533203125, 29.617206573486, 6 )
		setElementData ( colshape7, "purpose", "copshop" )
	end
end
addEventHandler("copdirections", getRootElement(), copshops)

--TRIGGERED WHEN A COP STATION IS REACHED
function copshophit (theshape)
	if isElement(theshape) then
		if (getElementData(theshape, "purpose") == "copshop" ) then
			if ( getElementType( source ) == "player" ) then
				if (getElementData ( source, "currentstatus" ) == "underarrest") then					
					local thecaptor = (getElementData ( source, "captor" ))
					local mx, my, mz = getElementPosition(theshape)
					local clientprisonercheck = setTimer ( clientcheckforprisoners, 1500, 1, thecaptor )					
					triggerServerEvent ("lockemup", getLocalPlayer (), source, mx, my, mz  )
				end
			end
		end
	end
end
addEventHandler ( "onClientElementColShapeHit", getRootElement(), copshophit)

function clientcheckforprisoners(thecop)
	if isElement(thecop) then
		local prisoners = 0
		local players = getElementsByType ( "player" )
		for theKey,thePlayer in ipairs(players) do
			if (getElementData ( thePlayer, "captor" ) == thecop ) then
				prisoners = prisoners+1
			end
		end
		if prisoners == 0 then
			setElementData ( thecop, "currentarrests", "none" )
			clearcopshops()
		elseif prisoners == 1 then
			setElementData ( thecop, "currentarrests", "single" )
		elseif prisoners == 2 then
			setElementData ( thecop, "currentarrests", "double" )
		end
	end
end

--REMOVES POLICE STATION BLIPS FROM COPS RADAR AND THE MARKERS
addEvent("clearcopdirections", true)
function clearcopshops()
	if coptargets == 1 then
		coptargets = 0
		destroyElement ( blip1 )
		destroyElement ( marker1 )
		destroyElement ( colshape1 )
		
		destroyElement ( blip2 )
		destroyElement ( marker2 )
		destroyElement ( colshape2 )
		
		destroyElement ( blip3 )
		destroyElement ( marker3 )
		destroyElement ( colshape3 )
		
		destroyElement ( blip4 )
		destroyElement ( marker4 )
		destroyElement ( colshape4 )
		
		destroyElement ( blip5 )
		destroyElement ( marker5 )
		destroyElement ( colshape5 )
		
		destroyElement ( blip6 )
		destroyElement ( marker6 )
		destroyElement ( colshape6 )
		
		destroyElement ( blip7 )
		destroyElement ( marker7 )
		destroyElement ( colshape7 )
	end
end
addEventHandler("clearcopdirections", getRootElement(), clearcopshops)

function sendDamagedPedToServer (attacker,weapon,bodypart,loss)
	if attacker and attacker == localPlayer and getTeamName(getPlayerTeam(attacker)) == "Establishment" then
		triggerServerEvent("onDysPedDamage",source,attacker,weapon)
	end
end
addEventHandler("onClientPedDamage",root, sendDamagedPedToServer)

--[[addEvent("makePedFollow",true)

function arrestedPedFollows(theprisoner)
	
	local thecop = localPlayer
	outputDebugString("arrestedPedFollows")
	if (getElementData ( theprisoner, "currentstatus" ) == "underarrest") and (getPedOccupiedVehicle ( theprisoner ) == false ) then
		local copx, copy, copz = getElementPosition ( thecop )
		local prisonerx, prisonery, prisonerz = getElementPosition ( theprisoner )
		copangle = ( 360 - math.deg ( math.atan2 ( ( copx - prisonerx ), ( copy - prisonery ) ) ) ) % 360
		setPedRotation ( theprisoner, copangle )
		--setCameraTarget ( theprisoner, theprisoner )
		local dist = getDistanceBetweenPoints2D ( copx, copy, prisonerx, prisonery )
		if ( dist > 16 ) then
			freetheguy ( theprisoner ) --FREES PRISONER IF HE GETS FAR AWAY
		elseif ( dist > 12 ) then
			setPedControlState ( theprisoner, "sprint", true )
			setPedControlState ( theprisoner, "walk", false )
			setPedControlState ( theprisoner, "forwards", true )
			local zombify = setTimer ( arrestedPedFollows, 500, 1, thecop, theprisoner )
		elseif ( dist > 6 ) then
			setPedControlState ( theprisoner, "sprint", false )
			setPedControlState ( theprisoner, "walk", false )
			setPedControlState ( theprisoner, "forwards", true )
			local zombify = setTimer ( arrestedPedFollows, 500, 1, thecop, theprisoner )
		elseif ( dist > 1.5 ) then
			setPedControlState ( theprisoner, "sprint", false )
			setPedControlState ( theprisoner, "walk", true )
			setPedControlState ( theprisoner, "forwards", true )
			local zombify = setTimer ( arrestedPedFollows, 500, 1, thecop, theprisoner )
		elseif ( dist < 1.5 ) then
			setPedControlState ( theprisoner, "sprint", false )
			setPedControlState ( theprisoner, "walk", false )
			setPedControlState ( theprisoner, "forwards", false )
			local zombify = setTimer ( arrestedPedFollows, 500, 1, thecop, theprisoner )
		end
	end

end

addEventHandler("makePedFollow",resourceRoot,arrestedPedFollows)]]