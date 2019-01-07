--//---------------------------------

--[[

	** MTA:SA - LEFT 4 DEAD 2 PROJECT! **

		SCRIPT CREATED BY: CodeHit
		SPECIAL INFECTED NAME: CHARGER(L4D2)
		DATE: AUGUST, 17 - (2017)         --> ( MES, DAY - (YEAR) )

	** MTA:SA - LEFT 4 DEAD 2 PROJECT! **

]]

--//---------------------------------

--UTILS
function table.random ( theTable ) 
    return theTable[math.random ( #theTable )]
end

-- SCRIPT SETTINGS 
local zpHealth = 300 -- CHARGER HEALTH 
local zpSkinID = 110 -- CHARGER SKIN
local zpWalkStyle = 127 -- CHARGER WALKING STYLE
local zpChargerPower = 0.1
local bar = true -- enable bar
RAMMER_DAMAGE = 30 
-- SCRIPT SETTINGS END

local chargers = {} 
local chargersColShapes = {}
local chargerCheckColShapes = {}
local chargerMov = {}
local chargerSpecialTimer = {}
local chargerChargeCycle = {}
local chargerCameraTimer = {}
local chargerState = {}

local playerSpecial = {}

-- EVENTS 

addEvent("onClientCreateColCheck", true) 
addEvent("onClientDestroyColCheck", true)
addEvent("onClientChargerTroughtWall", true)
addEvent("onClientSpecialAttack", true)
addEvent("onPlayerWinsRammer", true)

-- EVENT HANDLERS 

	-- CREATE A COLSHAPE WHILE THE CHARGER CHARGE

addEventHandler("onClientCreateColCheck", root, 
	function( ped )
		if not isElement( chargerCheckColShapes[ped] ) then 
			chargerCheckColShapes[ped] = createColSphere( ped.position, 3 )
			attachElements( chargerCheckColShapes[ped], ped )
		end
	end)

	-- DESTROY A COLSHAPE WHEN RUN ENDS

addEventHandler("onClientDestroyColCheck", root, 
	function( ped )
		if ( isElement( chargerCheckColShapes[ped] ) ) then 
			destroyElement( chargerCheckColShapes[ped] )
			chargerChargeCycle[ped] = setTimer(function( ... ) end, 12000, 1)
			if ( getData(ped, "charger.attached") ~= false  ) then 
				startSpecialAttack( ped, getData( ped, "charger.attached") )
			end
		end
	end)
	-- START SPECIAL 

addEventHandler("onClientSpecialAttack", root, 
	function( ped, player )
		if ( isElement( ped ) and isElement( player ) and playerSpecial[player] == nil)  then 
			setPedAnimation( ped, "ped", "HIT_Front", -1, false, false, false )
			setTimer( startSpecialAttack, 500, 1, ped, player )
			triggerClientEvent( player, "charger:smashsound", player, player )
			outputDebugString("Rammer: Start special attack...")
			playerSpecial[player] = true
		end
	end)

	-- WHEN THE CHARGER CHOKE WITH WALL

addEventHandler("onClientChargerTroughtWall", root, 
	function( ped )
		if ( isElement( ped ) )  then 
			local nearestPlayer, dist = getNearestPlayer( ped, chargersColShapes[ped] )
			troughtWall( ped )
			triggerClientEvent( getRootElement(), "charger:effectwall", getRootElement(), ped )
		end

	end)

	-- PLAYER WIN OR LOSE

addEventHandler("onPlayerWinsRammer", root, 
	function( ped, target, state )
	outputDebugString("RAMMER: onPlayerWinsRammer TRIGGERED")
	target = client
	outputDebugString(tostring(ped).." "..tostring(target))
		if ( isElement( ped ) and isElement( target ) )  then 
		outputDebugString(tostring(ped).." "..tostring(target))
			if ( state == "WIN" ) then 
				local elementAttacheds = getAttachedElements(ped)
				for i, v in ipairs( elementAttacheds ) do 
					detachElements( v )
				end
				setElementCollisionsEnabled( target, true )
				toggleAllControls( target, true )
				--setPedAnimation( target, "ped", "getup", 2000, false )
				setControlState(target,"jump",true)
				setPedAnimation( target)
				setPedAnimation( ped)
				setPedAnimation( ped, "ped", "handscower", 3000, false, false, false )
				setTimer(setPedAnimation,3000,1, ped, "RAPPING", "Laugh_01", 4000, false, false, true, false  )
				setTimer( setControlState, 10000, 1, target, "jump", false )
				killTimer( chargerSpecialTimer[ped] )
				chargerSpecialTimer[ped] = nil
				--killTimer( chargerCameraTimer[ped] )
				--chargerCameraTimer[ped] = nil
				--setCameraTarget( target )
				chargerState[ped] = "sit"
				setData( ped, "charger.attached", false )
				
				setTimer( function() 
					if isElement( ped ) then
						setPedAnimation( ped )
						setElementFrozen( ped, false )
						chargerState[ped] = "run"
					end
				end, 6000, 1)
				playerSpecial[target] = nil
			end
			triggerClientEvent( target, "unloadImages", target, target )
		end
		
	end)



-- FUNCTIONS 


	-- SPAWN THE CHARGER

--[[function spawnCharger( x, y, z )
	local ped = Ped( zpSkinID, x + 30 , y, z, math.random( 0, 360 ), true)
	ped.walkingStyle = zpWalkStyle
	exports['extra_health']:setElementExtraHealth( ped, zpHealth )
	chargersColShapes[ped] = createColSphere( ped.position, 100 )
	attachElements( chargersColShapes[ped], ped )
	chargers[ped] = true
	chargerMov[ped] = setTimer( chargerMovements, 100, 0, ped, chargersColShapes[ped] )
	--triggerClientEvent( root, "charger:spawn", root, x + 30 , y, z)
	setElementData( ped, "zp_zclass", "Charger" )
	triggerEvent( "onChargerSpawn", ped, x, y, z)
	chargerState[ped] = "run"
end]]

local rammerSkins = {277,128,264,167,67}
addEvent("BruteFrenzy",true)
function spawnDystopiaRammer( x, y, z , rot, skin)
if not skin then skin = table.random(rammerSkins) end
	local ped = Ped( skin, x , y, z, rot, true)
	triggerClientEvent("MorphZombieUP",root,ped)
	triggerClientEvent("sync.message", root, ped, 255, 125, 0, "FRENZIED!")
	ped.walkingStyle = zpWalkStyle
	
	setElementData(ped,"zombie",true,true)
	setElementData(ped,"brute",true,true)
	setElementData(ped,"rammer",true,true)
	setElementHealth(ped,200)
	setPedArmor(ped,100)
	exports['extra_health']:setElementExtraHealth( ped, zpHealth )
	chargersColShapes[ped] = createColSphere( ped.position, 100 )
	attachElements( chargersColShapes[ped], ped )
	chargers[ped] = true
	chargerMov[ped] = setTimer( chargerMovements, 150, 0, ped, chargersColShapes[ped] )
	--triggerClientEvent( root, "charger:spawn", root, x + 30 , y, z)
	setElementData( ped, "zp_zclass", "Charger" )
	triggerEvent( "onChargerSpawn", ped, x, y, z)
	chargerState[ped] = "run"
	setElementData(ped,"name","Rammer",true)
end
addEventHandler("BruteFrenzy",root,spawnDystopiaRammer)


function spawnRammer( p )
	local x, y, z = getElementPosition( p )
	spawnDystopiaRammer( x+2, y, z )
end
addCommandHandler("rammer", spawnRammer)
	-- WHEN TE CHARGER DEATH

function chargerWasted( _, killer, wep, bodypart )
	if ( source and getElementData( source, "zp_zclass") == "Charger" ) then
		--local killerWeapon = killer and getElementType( killer ) == "player" and getPedWeapon( killer ) or 0 
		--local killerName = killer and getElementType( killer ) == "player" and getPlayerName( killer ) or "Unknown"
		destroyCharger( source )
		detachAttachedEnemy( source )
		triggerClientEvent( "charger:wasted", source )
		--exports['killmessages']:outputMessage( {killerName,{"padding",width=3},{"icon",id = killerWeapon},{"padding",width=3},{"color",r=255,g=220,b=30},"Charger"},getRootElement(),wr,wg,wb )
		triggerEvent("onChargerWasted", source, killer, wep, bodypart)
	end
end 
addEventHandler("onPedWasted", root, chargerWasted)

	-- WHEN TE PLAYER DEATH

function playerWasted( _, killer )

	for thePed, theValue in pairs( chargers ) do 
			local elementAttacheds = getAttachedElements(thePed)
			--if #elementAttacheds == 0 then return end
			for i, v in ipairs( elementAttacheds ) do 
				if ( source == v ) then 
					setCameraTarget( source )
					detachElements( source )
					setElementCollisionsEnabled( source, true )
					toggleAllControls( source, true )
					killTimer( chargerSpecialTimer[thePed] )
					chargerSpecialTimer[thePed] = nil
					setData( thePed, "charger.attached", false )
					setPedAnimation( thePed )
					setElementFrozen( thePed, false )
					playerSpecial[source] = nil
					triggerClientEvent( source, "unloadImages", source, source )
					if isTimer( chargerCameraTimer[thePed] ) then killTimer( chargerCameraTimer[thePed] ) end
					if chargerCameraTimer[thePed] then chargerCameraTimer[thePed] = nil end
					chargerState[thePed] = "run"
				end
			end
	end
	
end 
addEventHandler("onPlayerWasted", root, playerWasted)

	-- CHARGER ACTIONS ( ATTACK, MOVE, CHARGE, STOP )

function chargerMovements( ped, zone )
	if ( isElement( ped ) and isElement( zone ) ) then 

		local x, y, z = getElementPosition( ped ) 
		local player, dist = getNearestPlayer( ped, zone )
		local randomize = math.random( 1, 200 )
		local target = getData( ped, "charger.attached" )
		if ( player  ) then 
			if ( dist < 3 ) then 
				triggerClientEvent( "charger:actions", ped, "attack", player, ped, target )
			end
			local px, py, pz =  getElementPosition( player )
			triggerClientEvent( "charger:actions", ped, "move", player, ped, target )
			if not ( isTimer( chargerChargeCycle[ped] ) ) then 
				triggerClientEvent( "charger:actions", ped, "charge", nil, ped, target )
			end

			if ( randomize == 3 ) then 
				triggerClientEvent( "charger:cry", ped, x, y, z )
			end

		else 
			triggerClientEvent( "charger:actions", ped, "stop", nil, ped, target, player )
		end
		-- another func 
		if ( target and chargerState[ped] == "run" ) then
			for i, v in ipairs( getElementsByType("player") ) do 
				local shortestDistance = getDistanceBetweenPoints3D( ped.position, v.position )
				if ( shortestDistance < 5  ) then 
					if ( isElementAttached( v ) == false and isTimer( chargerSpecialTimer[ped] ) == false  ) then
						local aPosX, aPosY, _ = getElementPosition(ped) 
						local sPosX, sPosY, _ = getElementPosition(v) 
						local angle = math.atan2(aPosX - sPosX, aPosY - sPosY) - math.rad(90) 
						local velX, velY, velZ = getElementVelocity(v) 
						setElementVelocity(v, velX , velY , velZ+0.1)
						setTimer(setElementVelocity, 50, 1, v, velX + zpChargerPower*-math.cos(angle), velY + zpChargerPower*math.sin(angle), velZ + zpChargerPower) 
						setElementHealth( v, getElementHealth( v ) - 2.5 ) -- 4 HITS: 2.5 + 2.5 + 2.5 + 2.5 = 10.
						chargerState[ped] = "trought"
					end
				end
			end
		end
		--outputChatBox( tostring( target ) ) 
	end
end

	-- DESTROY SPECIFIED CHARGER

function destroyCharger( ch )

	local col = chargersColShapes[ch]
	local col2 = chargerCheckColShapes[ch]
	if chargersColShapes[ch] then chargersColShapes[ch] = nil end
	if isTimer( chargerSpecialTimer[ch] ) then killTimer( chargerSpecialTimer[ch] ) end
	if chargerSpecialTimer[ch] then chargerSpecialTimer[ch] = nil end
	if chargerMov[ch] then chargerMov[ch] = nil end
	if col2 and isElement(col2) then destroyElement(col2) end
	if col and isElement(col) then destroyElement(col) end
	if chargers[ch] then chargers[ch] = nil end
	if isElement(ch) then setTimer( destroyElement, 10000, 1, ch ) end
	if chargerState[ch] then chargerState[ch] = nil end
	if isTimer( chargerCameraTimer[ch] ) then killTimer( chargerCameraTimer[ch] ) end
	if chargerCameraTimer[ch] then chargerCameraTimer[ch] = nil end

end

	-- DETECT IF A PLAYER HIT A COLSHAPE

function colShapeChecker( player )
--outputDebugString("RAMMER: COLSHAPE CHECKER")
	if ( player and getElementType( player ) == "player" ) then

		for thePed, theValue in pairs( chargers ) do 
			if ( source == chargerCheckColShapes[thePed] ) then 
				if ( getData( thePed, "charger.attached") == false ) then 
					setData( thePed, "charger.attached", player )
					attachElements( getData( thePed, "charger.attached" ), thePed, 0, 0.6, 0 )
					setElementCollisionsEnabled( getData( thePed, "charger.attached"), false )
					setPedAnimation( getData( thePed, "charger.attached"), "ped", "FALL_fall")
					--toggleAllControls( player, false )
					--setElementData(player,"incapacitated",true,true)	
					--triggerClientEvent( getRootElement(), "charger:smashsound", getRootElement(), player )
				end
			end
		end

	end
end
	-- SPECIAL CHARGER ATTACK

function startSpecialAttack( ped, target )
outputDebugString("RAMMER: SPECIAL ATTACK CHECK")
	if ( isElement( ped ) and isElement( target ) ) then 
outputDebugString("RAMMER: SPECIAL ATTACK OK")
		triggerClientEvent( target, "onChargerClientSpecialAttack", target, ped, target, bar )
		setPedAnimation( target, "ped", "cower", -1, false, false, false )
		setPedAnimation( ped, "CARRY", "putdwn05", -1, false, false, false  )
		
		triggerEvent("onChargerSpecialAttack", ped, target)
		triggerClientEvent("sync.message", root, ped, 255, 50, 0, "BAM!")

		--chargerCameraTimer[ped] = setTimer( function( ... )
		--	local x, y, z = getPositionFromElementOffset( ped, 0, -3, 2 )
		--	setCameraMatrix( target, x, y-3, z+1, x, y+1, z-0.5 )
		--end, 100,0)

	--setElementData(target,"incapacitated",true,true)	

		local cycle = 0

		chargerSpecialTimer[ped] = setTimer( function ( ... )
			setElementFrozen( ped, true )
			if ( cycle == 0 ) then 
				--setPedAnimation( target, "ped", "FALL_back", -1, false )
				setPedAnimation( ped, "BSKTBALL", "BBALL_react_miss" )
				setTimer( setPedAnimation, 250, 1,  ped, "ped", "IDLE_stance" )
				cycle = 1 
			elseif ( cycle == 1 ) then 
				--setPedAnimation( ped, "SWORD", "sword_4", -1, false )
				setPedAnimation( ped, "ped", "FightA_G", -1, false,false,true )
				--setTimer( setPedAnimation, 200, 1, target, "ped", "KO_skid_front", 0, false )
				--setTimer( setPedAnimation, 200, 1, target, "ped", "Floor_hit_f", -1, true, false, true )
				setTimer( setPedAnimation, 200, 1, target, "SWEET", "Sweet_injuredloop", 10000, true,false,false, false )
				setElementHealth( target, getElementHealth( target ) - RAMMER_DAMAGE )				
				cycle = 0
				--setTimer( triggerClientEvent, 150, 1,  target, "charger:pummel", target )
			end

		end, 700, 0)
		
	end
end

	-- ANIMATION TROUGHT WALL 

function troughtWall( ped )
outputDebugString("RAMMER: THROUGH WALL")
	setPedAnimation( ped, "ped", "HIT_Front", -1, false, false, false)
	--setPedAnimation( ped, "ped", "handscower", 3000, false )
	--setTimer( setPedAnimation, 2000, 1, ped, "ped", "handscower", 3000, false,false,true)
	setTimer( setPedAnimation, 2000, 1, ped )
end

	-- SET TO NORMALITY ATTACHED PLAYER WHEN CHARGER WASTED

function detachAttachedEnemy( theCharger )
outputDebugString("RAMMER: DETACH ATTACHED ENEMY")
	if theCharger then 
		setElementFrozen( theCharger, false )
		local attachs = getAttachedElements( theCharger )
		for key, value in ipairs( attachs ) do 
			if ( value and getElementType( value ) == "player" ) then 
				setPedAnimation( value )
				toggleAllControls( value, true )
				setElementCollisionsEnabled( value, true )
				detachElements( value )
				setCameraTarget( value )
				playerSpecial[value] = nil
				if ( restop == nil ) then 
					triggerClientEvent( value, "unloadImages", value, value )
				end
			end
		end
	end
end

	-- START EVENT

function initScript( )
	addEventHandler( "onColShapeHit", root, colShapeChecker ) ---!!!!! INEFFICIENT
end 
addEventHandler("onResourceStart", resourceRoot, initScript)

	-- WHEN TE RESOURCE STOP DETACH ALL ELEMENTS

function pauseScript( )
	restop = true
	for i, v in pairs( chargers ) do 
		detachAttachedEnemy( i )
	end
end 
addEventHandler("onResourceStop", resourceRoot, pauseScript)



function spwnCharger( p )
	local x, y, z = getElementPosition( p )
	spawnCharger( x, y, z )
end
addCommandHandler("spawnrammer", spwnCharger)



-- FALL_back

 -- Al terminar la carga, o al chocar con una pared quitar -10 puntos de vida
 -- Si tiene a un superviviente mientras hace la carga y choca, temblor en la pantalla




-- Physics test 
--[[

addCommandHandler("tester", 
	function( p )
		local fX, fY, fZ = getElementPosition( p )
		local x, y, z = getElementVelocity( p )
		local x2, y2, z2 = getElementRotation( p )
		local vX, vY, vZ = math.sin(z2*0.0174532925), math.cos(z2*0.0174532925), math.sin(z2*0.0174532925)

		local phy = createVehicle( 594, fX, fY, fZ+1, x2, y2, z2)
		setElementVelocity( phy, x*vX-1, y*vY-1, z*vZ-0.1 )
		setTimer( function( ... )
			if ( isVehicleOnGround( phy ) == true ) then 
				outputChatBox("cayó")
				local p1, p2, p3 = getElementPosition( phy )
			end
		end, 100, 0)
	end)

]]


addCommandHandler( "deleterammers", 
	function ( p )
		for i, v in pairs( chargers ) do 
			killPed( i ) 
		end
	end)

