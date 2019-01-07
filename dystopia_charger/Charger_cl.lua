

-- > CLIENT SCRIPT SETTINGS 

local timerun = 2.50 

-- > END SCRIPT SETTINGS


local sX, sY = guiGetScreenSize() 
local chargerun = {}
local chargewall = {}
local timersrun = {}
local timers = {}
local sounds = {}
--local lights = {}
local sound = 
{
	--charge = { "charger_charge_01", "charger_charge_02" },
	--die = { "charger_die_01", "charger_die_02", "charger_die_03" },
	--n = { "charger_lurk_02", "charger_lurk_06", "charger_spotprey_01", "charger_spotprey_02", "charger_spotprey_03" },
	--pummel = { "charger_pummel01", "charger_pummel02", "charger_pummel04" },
	--punch = { "charger_punch1", "charger_punch2", "charger_punch3", "charger_punch4" },
	smash = { "loud_chargerimpact_01", "loud_chargerimpact_02", "loud_chargerimpact_03", "loud_chargerimpact_04" },
	--themes = { "chargerbacteria", "chargerbacterias" }
}

-- EVENTS 

addEvent("onChargerClientSpecialAttack", true)
addEvent("unloadImages", true)
addEvent("charger:wasted", true)
addEvent("charger:actions", true)
--addEvent("charger:spawn", true)
--addEvent("charger:pummel", true)
addEvent("charger:cry", true)
addEvent("charger:effectwall", true)
addEvent("charger:smashsound", true)

-- EVENT HANDLERS

	-- SOUND  
addEventHandler("charger:smashsound", root, 
	function( target )
		local randomsound = sound.smash[math.random( 1, #sound.smash) ]
		local chargesound = playSound( "sounds/smash/"..randomsound..".wav", false )
		--bindKey( "space", "down", key )
	end)

	-- LOAD IMAGES WHEN "SPECIAL ATTACK" START

addEventHandler("onChargerClientSpecialAttack", root, 

	function( ped, target, bar )

	outputDebugString("RAMMER: CLIENT SPECIAL ATTACK TRIGGERED")
	--sounds[target] = playSound( "sounds/themes/special.mp3", true )
--[[	lights[target] = {}

	local x, y, z = getPedBonePosition( ped, 8 )
	local extra = 1 
	for i = 1, 5 do 
		local id = #lights[target]+1
		extra = 1 + 1 * i
		lights[target][id] = createLight(0, x, y, z+extra, 6, 255, 0, 0, 0, 0, 0, true)
		attachElements( lights[target][id], ped, 0, -1, 0 )
	end]]


	--if ( bar == true ) then 

		--elementposx2, elementposy2, elementposw2, elementposh2 = ( sX * 0.48 ) - ( sX / 2 ), ( sY * 0.69 ), ( sX * 0.2 )/2, ( sY * 0.3 )/2 -- SPACE KEY IMAGE POSITION


		textpositionx, textpositiony = ( sX * 0.42 + sX * 0.015 ), ( sY * 0.77 ) -- "mash space to escape" 

		--elements( ped, target ) 
		bindKey( "space", "down", key )
		if isEventHandlerAdded( "onClientRender", root, dxElements ) == false then 
			addEventHandler("onClientRender", root, dxElements)
		end
		currentRammerPedThatCaughtYou = ped
	--end

	end)

	-- UNLOAD IMAGES WHEN PLAYER WIN OR LOSE

addEventHandler("unloadImages", root, 
	function( target )
		if isElement( sounds[target] )  then 

			destroyElement( sounds[target] )
--[[			for i, v in ipairs( lights[target] ) do 
				destroyElement( v )
				lights[v] = nil
			end]]

			sounds[target] = nil
			
			if ( isTimer( timers[target] ) ) then 
				--destroyElement( CHARGER )
				--destroyElement( theRedBar )
				--destroyElement( BBUTTON )
				unbindKey( "space", "down", key )
				killTimer( timers[target] )
				timers[target] = nil
				removeEventHandler("onClientRender", root, dxElements)
			end
		end
		
	end)

	-- EXECUTE ALL CHARGER ACTIONS ( MOVE, ATTACK, CHARGE, STOP MOVEMENT )

addEventHandler("charger:actions", root, 
	function( action, player, ped, target, state )
		if isPedDead( ped ) == false then 

			local x2, y2, z2 = getPositionFromElementOffset( ped, 0, 12, 0 )
			local x3, y3, z3 = getPositionFromElementOffset( ped, 0, 2, 0 )
			local px2, py2, pz2 = getElementPosition( ped )
			local isWallBlock = isLineOfSightClear( px2, py2, pz2, x2, y2, z2, true, true, false ) -- long line check
			local isWallBlock2 = isLineOfSightClear( px2, py2, pz2, x3, y3, z3, true, true, false ) -- small line
			local isTrue = isLineOfSightClear( px2, py2, pz2, x2, y2, z2, false, false, true ) -- check player
			if ( action == "move" and chargerun[ped] == nil and target == false  ) then 
				
				local x, y, z = getElementPosition( ped )
				local px, py, pz = getElementPosition( player )
				local rz = rot( x, y, px, py )
				setPedRotation( ped, rz )
				setPedControlState( ped, "forwards", true )

			end
			if ( action == "attack" and chargerun[source] == nil and target == false  ) then 
				if ( isWallBlock ) then 
					setPedControlState( ped, "fire", true )
					setTimer( setPedControlState, 100, 1, ped, "fire", false )
				end
			end
			if ( action == "stop" ) then 
				setPedControlState( ped, "forwards", false )
			end
			if ( action == "charge"  ) then 
				if (  chargerun[ped] == nil ) then 
					if ( isWallBlock and not isTrue ) then 
						chargerun[ped] = true
						timersrun[ped] = setTimer( function ( ... )
							if ( chargerun[ped] == true ) then 
								chargerun[ped] = nil
								timersrun[ped] = nil
								triggerServerEvent( "onClientDestroyColCheck", ped, ped )
							end
						end, timerun*1000, 1)
						--local randomsound = sound.charge[math.random( 1, #sound.charge) ]
						--local chargesound = playSound3D( "sounds/charge/"..randomsound..".wav", px2, py2, pz2, false )
						triggerServerEvent( "onClientCreateColCheck", ped, ped )
					end
				else 
					if ( not isWallBlock2  ) then  
						--triggerServerEvent( "onClientDestroyColCheck", ped, ped )
						if ( target ~= false and chargerun[ped] == true ) then 
							
							if isTimer( timersrun[ped] ) then 
								killTimer( timersrun[ped] )
								timersrun[ped] = nil 
							end
							chargerun[ped] = nil
							triggerServerEvent( "onClientSpecialAttack", target, ped, target )
						else 
							if chargewall[ped] == nil then
								triggerServerEvent( "onClientChargerTroughtWall", ped, ped )
								chargewall[ped] = true
							end
						end
					end
				end
			end
			--dxDrawLine3D( px2, py2, pz2, x2, y2, z2, ( not isWallBlock and tocolor( 255, 0, 0, 255 ) or tocolor( 255, 255, 255, 255 ) ) )
		end
	end)

addEventHandler("charger:wasted", root, 
	function(  )
		--local randomsound = sound.die[math.random( 1, #sound.die) ]
		--local x, y, z = getElementPosition( source )
		--local chargesound = playSound3D( "sounds/die/"..randomsound..".wav", x, y, z, false )
		--setSoundMaxDistance( chargesound, 100 )
		if isTimer( timersrun[source] ) then 
			killTimer( timersrun[source] )
		end
		chargerun[source] = nil
		timersrun[source] = nil
	end)

--[[addEventHandler("charger:spawn", root, 
	function( x, y, z )
		--local randomsound = sound.themes[math.random( 1, #sound.themes) ]
		--local chargesound = playSound3D( "sounds/themes/"..randomsound..".wav", x, y, z, false )
		--setSoundMaxDistance( chargesound, 100 )
	end)]]

--[[addEventHandler("charger:pummel", root, 
	function(  )
		local randomsound = sound.pummel[math.random( 1, #sound.pummel) ]
		local chargesound = playSound( "sounds/pummel/"..randomsound..".wav", false )
	end)]]

--[[addEventHandler("charger:cry", root, 
	function( x, y, z )
		if ( chargerun[source] == nil ) then 
			--local randomsound = sound.n[math.random( 1, #sound.n) ]
			--local chargesound = playSound3D( "sounds/n/"..randomsound..".wav", x, y, z, false )
			--setSoundMaxDistance( chargesound, 100 )
		end
	end)]]

addEventHandler("charger:effectwall", root, 
	function( ped )
		if ( isElement( ped ) ) then
			local x, y, z = getPositionFromElementOffset(ped, 0, -1, 0)
			local randomAmount =  30
			fxAddDebris(x, y, z, 15, 15, 15, 255, 0.1, randomAmount)
			createEffect("explosion_door", x, y, z) 
			setTimer( function ( ... )
				chargewall[ped] = nil
			end, 1500, 1)
			
			
		end
	end)


-- FUNCTIONS 

	-- SUPER SPEED

function spedd() 

	for i, v in ipairs( getElementsByType("ped", resourceRoot, true ) ) do
		if ( chargerun[v] == true ) then 
			local x, y, z = getElementPosition(v)
			local prot = getPedRotation(v)
			local nx, ny = getPointFromDistanceRotation(x, y, 0.5, (prot)*-1)
			local clear = isLineOfSightClear( x, y, z, nx, ny, z, true, true, true, true, true, true, true)
			if clear == true then
				local lx, ly = getPointFromDistanceRotation(x, y, 1, (prot-8)*-1)
				local rx, ry = getPointFromDistanceRotation(x, y, 1, (prot+8)*-1)
				local clearl = isLineOfSightClear( x, y, z, lx, ly, z, true, true, true, true, true, true, true)
				local clearr = isLineOfSightClear( x, y, z, rx, ry, z, true, true, true, true, true, true, true)
				if clearl == true and clearr == true then
					local nz = getGroundPosition ( nx, ny, z+1 )
					if getDistanceBetweenPoints3D( x, y, z, nx, ny, nz) < 2 then
						setElementPosition(v, nx, ny, nz+1, false)
					end
				end
			end
		end
	end			 
end
addEventHandler( "onClientRender", root, spedd )

	-- WHEN THE PLAYER PRESS "space" 
--WIN CONDITIONS	
function key( _, keystate )
	if ( keystate == "down" ) then 
	
	local rand = math.random(1,10)
	
	outputDebugString("RAMMER: ESCAPE ATTEMPT: "..rand)
	
	if rand > 8 then 
		triggerServerEvent( "onPlayerWinsRammer", getLocalPlayer(), currentRammerPedThatCaughtYou, target, "WIN" )
		unbindKey( "space", "down", key )
		outputDebugString("RAMMER: Player escaped")
		removeEventHandler("onClientRender", root, dxElements)
		currentRammerPedThatCaughtYou = nil
	end
		
	end

end



--WIN CONDITIONS

	-- IMAGES 

--[[function elements( ped, target )

    BBUTTON = guiCreateStaticImage( elementposx2, elementposy2, elementposw2, elementposh2, "images/B_BUTTON.png", false)
	--SPACE_KEY_IMAGE = guiCreateStaticImage( elementposx2, elementposy2, elementposw2, elementposh2, "images/B_BUTTON.png", false)

    timers[target] = setTimer( function( ... )

    	----------------------??? delete

    end, 300, 0)
end]]

	-- IMAGES X2
--

function dxElements()
	--dxDrawLinedRectangle( barposx, barposy, barposw/2, barposh/2, tocolor( 0, 0, 0, 255 ) )
    --dxDrawRectangle(barposx2, barposy2, barposw2/2, barposh2/2, tocolor(255, 227, 45, 255), false)
    --dxDrawRectangle(barposx3, barposy3, barposw3/2, barposh3/2, tocolor(19, 19, 19, 255), false)
	dxDrawOutlinedText( "#ffffffMash [SPACE] to escape!", textpositionx, textpositiony, sX*0.1/2, sY*0.1/2 )
end

-- OTHER FUNCTIONS

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
	if 
		type( sEventName ) == 'string' and 
		isElement( pElementAttachedTo ) and 
		type( func ) == 'function' 
	then
		local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
		if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
			for i, v in ipairs( aAttachedFunctions ) do
				if v == func then
					return true
				end
			end
		end
	end
 
	return false
end

function getPointFromDistanceRotation(x, y, dist, angle)

    a = math.rad(90 - angle);
 
    dx = math.cos(a) * dist;
    dy = math.sin(a) * dist;
 
    return x+dx, y+dy, dist;
 
end

function getPositionFromElementOffset(element,offX,offY,offZ)
    local m = getElementMatrix ( element )  -- Get the matrix
    local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform
    local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
    local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
    return x, y, z                               -- Return the transformed point
end

function rot( x1, y1, x2, y2 )
    local t = -math.deg( math.atan2( x2 - x1, y2 - y1 ) )
    return t < 0 and t + 360 or t
end

function dxDrawOutlinedText( text, x, y, w, h, color )
	local color = color or 0, 0, 0, 255
	local text = text or "Holanda"
	dxDrawText(text:gsub ( "#%x%x%x%x%x%x", "" ), x - 1, y - 1, w - 1, h - 1, tocolor(color), sX/800*1.00, "default-bold", "left", "top", false, false, false, true, false)
    dxDrawText(text:gsub ( "#%x%x%x%x%x%x", "" ), x + 1, y - 1, w + 1, h - 1, tocolor(color), sX/800*1.00, "default-bold", "left", "top", false, false, false, true, false)
    dxDrawText(text:gsub ( "#%x%x%x%x%x%x", "" ), x - 1, y + 1, w - 1, h + 1, tocolor(color), sX/800*1.00, "default-bold", "left", "top", false, false, false, true, false)
    dxDrawText(text:gsub ( "#%x%x%x%x%x%x", "" ), x + 1, y + 1, w + 1, h + 1, tocolor(color), sX/800*1.00, "default-bold", "left", "top", false, false, false, true, false)
    dxDrawText(text, x, y, w, h, tocolor(255, 255, 255, 255), sX/800*1.00, "default-bold", "left", "top", false, false, false, true, false)
end

--[[function dxDrawLinedRectangle( x, y, width, height, color, _width, postGUI )
	local _width = _width or 1
	dxDrawLine ( x, y, x+width, y, color, _width, postGUI ) -- Top
	dxDrawLine ( x, y, x, y+height, color, _width, postGUI ) -- Left
	dxDrawLine ( x, y+height, x+width, y+height, color, _width, postGUI ) -- Bottom
	return dxDrawLine ( x+width, y, x+width, y+height, color, _width, postGUI ) -- Right
end

function onClientInitScript( )
    engineImportTXD( engineLoadTXD("model/charger.txd", 110 ), 110 )
    engineReplaceModel( engineLoadDFF("model/charger.dff", 110), 110 )
end 
addEventHandler( "onClientResourceStart", resourceRoot, onClientInitScript )]]


