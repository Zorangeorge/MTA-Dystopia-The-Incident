--by Slothman

function grapplewarp ( wallstick, hx, hy, hz, angle, groundshot)
	local theVehicle = getPedOccupiedVehicle ( source )
	if ( theVehicle ) then
		removePedFromVehicle (source)
		local carpurpose = (getElementData ( theVehicle,  "purpose" ))
		if (carpurpose ==  "grapple") then
			destroyElement(theVehicle)
		end
	end
	setPedRotation ( source, angle )
	local grapplegunslot = getPedWeaponSlot ( source )
	local px,py,pz = getElementPosition(source)
	local pedrot = getPedRotation ( source )
	local invisithing = createObject ( 1337, px, py, pz, 0, 0, pedrot )
	setElementAlpha(invisithing, 0)
	moveObject ( invisithing, 1000, hx, hy, hz, 0, 0, angle - 180)
	attachElements ( source, invisithing, 0, 0, 0)
	setPedAnimation ( source, "PARACHUTE", "FALL_SkyDive_Accel", -1, false, true, true)
	local theplayer = source
	setTimer ( wallcling, 1000, 1, theplayer, wallstick, hx, hy, hz, angle, groundshot, grapplegunslot )
	setTimer ( destroyElement, 1000, 1, invisithing)
	if (groundshot == 1) then
		setTimer ( landingonground, 1000, 1, theplayer)	
	end
end
	
addEvent( "ongrapple", true )
addEventHandler( "ongrapple", getRootElement(), grapplewarp )
	
function wallcling (theplayer, wallstick, hx, hy, hz, angle, groundshot, grapplegunslot)
	if (groundshot == 2) then
		wallstick = createVehicle ( 522, hx, hy, hz, 120, 0, angle )
	else
		wallstick = createVehicle ( 522, hx, hy, hz, 30, 0, angle )
	end
	toggleControl ( theplayer, "horn", false )
	setPlayerHudComponentVisible ( theplayer, "vehicle_name", false )
	setElementData ( wallstick, "purpose", "grapple" )
	setElementFrozen (wallstick, true)
	setElementAlpha(wallstick, 0)
	warpPedIntoVehicle ( theplayer, wallstick )
	setVehicleEngineState ( wallstick, false )
	setPedDoingGangDriveby (theplayer, false )
	setPedWeaponSlot ( theplayer, grapplegunslot )
	setTimer ( restartgrapple, 500, 1, theplayer)
end

function restartgrapple (source)
	setPedDoingGangDriveby (source, true )
end

function exitVehicle ( thePlayer, seat, jacked )
    local carpurpose = (getElementData ( source,  "purpose" ))
	if (carpurpose ==  "grapple") then
		toggleControl ( thePlayer, "horn", true )			
		setPlayerHudComponentVisible ( thePlayer, "vehicle_name", true )
		removePedFromVehicle (thePlayer)
		destroyElement(source)
	end
end
addEventHandler ( "onVehicleStartExit", getRootElement(), exitVehicle )

function landingonground (theplayer)
	local theVehicle = getPedOccupiedVehicle ( theplayer )
	if ( theVehicle ) then
		local carpurpose = (getElementData ( theVehicle,  "purpose" ))
		if (carpurpose ==  "grapple") then
			toggleControl ( theplayer, "horn", true )			
			setPlayerHudComponentVisible ( theplayer, "vehicle_name", true )
			removePedFromVehicle (theplayer)
			destroyElement(theVehicle)
		end
	end
end

addEvent( "ongrapplejump", true )
addEventHandler( "ongrapplejump", getRootElement(), landingonground)

function getoff ()
	local theVehicle = getPedOccupiedVehicle ( source )
	if ( theVehicle ) then
		local carpurpose = (getElementData ( theVehicle,  "purpose" ))
		if (carpurpose ==  "grapple") then
			toggleControl ( source, "horn", true )			
			setPlayerHudComponentVisible ( source, "vehicle_name", true )
			removePedFromVehicle (source)
			destroyElement(theVehicle)
			
		end
	end
end
addEventHandler( "onPlayerWasted", getRootElement(), getoff)
addEventHandler( "onPlayerQuit", getRootElement(), getoff)

function gluezPlayer( vehicle, x, y, z, rotX, rotY, rotZ)
	local theVehicle = getPedOccupiedVehicle ( source )
	if ( theVehicle ) then
		local carpurpose = (getElementData ( theVehicle,  "purpose" ))
		if (carpurpose ==  "grapple") then
			attachElements(theVehicle, vehicle, x, y, z, rotX, rotY, rotZ)
			
		end
	end
end
addEvent("gluezPlayer",true)
addEventHandler("gluezPlayer",getRootElement(),gluezPlayer)