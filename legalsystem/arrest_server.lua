kingCOP = createElement( "Pgroup", "cops" )
kingCIV = createElement( "Pgroup", "civs" )
kingNONE = createElement( "Pgroup", "none" )

function legalstartup(startedresource)
	if startedresource == getThisResource() then
		WantedWatch = setTimer (wantedlevelmonitor, 1000, 0)
		local allplayers = getElementsByType ( "player" )
		local detectmethod = get("legalsystem.Copmethod")
		for playerKey,thePlayer in ipairs(allplayers) do
			if detectmethod == "team" then
				local copteam = get("legalsystem.Copteam")
				local thisTeam = getPlayerTeam(thePlayer)
				if thisTeam ~= false then
					if thisTeam == getTeamFromName(copteam) then
						setElementParent ( thePlayer, kingCOP )
					else
						setElementParent ( thePlayer, kingCIV )
					end
				end
			elseif detectmethod == "skin" then
				local thisSkin = getPedSkin(thePlayer)
				setElementData(getRootElement(),"Copskins",get("legalsystem.Copskins"))
				local copskins = getElementData(getRootElement(),"Copskins")
				if type(copskins) == "table" and #copskins > 0 then
					for k,skinID in ipairs(copskins) do
						copskins[skinID] = true
					end
				end				
				local isacop = 0				
				for ElementKey, ElementValue in ipairs ( copskins ) do
					if thisSkin == ElementValue then
						isacop = 1
					end
				end
				if isacop == 1 then
					setElementParent ( thePlayer, kingCOP )
				else
					setElementParent ( thePlayer, kingCIV )
				end
			end
		end
	end
end
addEventHandler( "onResourceStart", getRootElement(), legalstartup)

function copSpawnCheck()
	local detectmethod = get("legalsystem.Copmethod")
	if detectmethod == "team" then
		local copteam = get("legalsystem.Copteam")
		local thisTeam = getPlayerTeam(source)
		if thisTeam ~= false then
			if thisTeam == getTeamFromName(copteam) then
				setElementParent ( source, kingCOP )
			else
				setElementParent ( source, kingCIV )
			end
		end
	elseif detectmethod == "skin" then
		local thisSkin = getPedSkin(source)
		setElementData(getRootElement(),"Copskins",get("legalsystem.Copskins"))
		local copskins = getElementData(getRootElement(),"Copskins")
		if type(copskins) == "table" and #copskins > 0 then
			for k,skinID in ipairs(copskins) do
				copskins[skinID] = true
			end
		end
		local isacop = 0
		for ElementKey, ElementValue in ipairs ( copskins ) do
			if thisSkin == ElementValue then
				isacop = 1
			end
		end
		if isacop == 1 then
			setElementParent ( source, kingCOP )
		else
			setElementParent ( source, kingCIV )
		end
	end
end
addEventHandler ( "onPlayerSpawn", getRootElement(), copSpawnCheck )


--ARREST PLAYERS BY SMACKING WITH A NIGHTSTICK
addEvent( "onDysPedDamage",true)
function rodneykingcheck ( attacker, weapon, bodypart, loss )

if getElementType(source) == "player" then
	
	if (attacker) and (weapon == 3) then	
		if getTeamName(getPlayerTeam(attacker)) == "Establishment" then
			local thecop = attacker
			local theprisoner = source
			--local wlevel = getPlayerWantedLevel( source )	
			if (getElementData ( theprisoner, "currentstatus" ) ~= "underarrest") --[[and (wlevel > 0)]] then	
				if (getElementData ( attacker, "currentarrests" ) ~= "single" ) and (getElementData ( attacker, "currentarrests" ) ~= "double" ) then	
					setElementData ( thecop, "currentarrests", "single" )
					triggerClientEvent(thecop,"copdirections",thecop)
				elseif (getElementData ( attacker, "currentarrests" ) == "single" ) then
					setElementData ( thecop, "currentarrests", "double" )	
				end
				setElementData ( theprisoner, "currentstatus", "underarrest" )
				setElementData ( theprisoner, "captor", thecop )
				showCursor ( source, true )
				toggleAllControls ( source, false, true, false )
				walktheprisoner ( thecop, theprisoner )
				setElementData ( theprisoner, "arrestTimeout", setTimer ( freetheguy, 180000, 1, theprisoner ))
			end
		end
	end
else
	if (attacker) and (weapon == 3) then	
		if getTeamName(getPlayerTeam(attacker)) == "Establishment" then
			local thecop = attacker
			local theprisoner = source
			--local wlevel = getPlayerWantedLevel( source )	
			if (getElementData ( theprisoner, "currentstatus" ) ~= "underarrest") --[[and (wlevel > 0)]] then	
				if (getElementData ( attacker, "currentarrests" ) ~= "single" ) and (getElementData ( attacker, "currentarrests" ) ~= "double" ) then	
					setElementData ( thecop, "currentarrests", "single" )
					triggerClientEvent(thecop,"copdirections",thecop)
				elseif (getElementData ( attacker, "currentarrests" ) == "single" ) then
					setElementData ( thecop, "currentarrests", "double" )	
				end
				
				if getElementData(theprisoner,"type") == "civilian" then setElementData(theprisoner,"type","prisoner") end
				if getElementData(theprisoner,"slothbot") then setElementData(theprisoner,"slothbot","stasis") end
				
				setElementData ( theprisoner, "currentstatus", "underarrest" )
				setElementData ( theprisoner, "captor", thecop )
				--showCursor ( source, true )
				--toggleAllControls ( source, false, true, false )
				walktheprisoner ( thecop, theprisoner )
				setElementData ( theprisoner, "arrestTimeout", setTimer ( freetheguy, 180000, 1, theprisoner ))
			end
		end
	end
end
end
addEventHandler ( "onPlayerDamage", getRootElement(), rodneykingcheck )
addEventHandler ( "onDysPedDamage", getRootElement(), rodneykingcheck )

--ARREST PLAYERS BY HOLDING THEM AT GUNPOINT IF THEY HAVE LOW HP
function sightscheck ( element )
	if isElement(element) then
		if ( getElementType ( element ) == "player" ) or ( getElementType ( element ) == "ped" ) then
			if ( getControlState ( source, "aim_weapon" ) ) then
				local currentgun = getPedWeapon ( source )
				--local wlevel = getPlayerWantedLevel( element )
				if (currentgun > 19) and (currentgun < 39) --[[ and (wlevel > 0) ]]then
					if getTeamName(getPlayerTeam(source)) == "Establishment" then
						local thecop = source
						local theprisoner = element
						local cx, cy, cz = getElementPosition ( source )
						local px, py, pz = getElementPosition ( element )
						if ( getElementHealth ( element ) < 30 ) and ( getDistanceBetweenPoints3D ( cx, cy, cz, px, py, pz ) < 3 ) then
							if (getElementData ( theprisoner, "currentstatus" ) ~= "underarrest" ) then
								if (getElementData ( thecop, "currentarrests" ) ~= "single" ) and (getElementData ( thecop, "currentarrests" ) ~= "double" ) then
									triggerClientEvent(thecop,"copdirections",thecop)
									setElementData ( thecop, "currentarrests", "single" )
								elseif (getElementData ( thecop, "currentarrests" ) == "single" ) then
									setElementData ( thecop, "currentarrests", "double" )				
								end
								
								if getElementData(theprisoner,"type") == "civilian" then setElementData(theprisoner,"type","prisoner") end
								if getElementData(theprisoner,"slothbot") then setElementData(theprisoner,"slothbot","stasis") end
								
								setElementData ( theprisoner, "currentstatus", "underarrest" )
								setElementData ( theprisoner, "captor", thecop )
								showCursor ( theprisoner, true )
								toggleAllControls ( theprisoner, false, true, false )		
								walktheprisoner ( thecop, theprisoner )
								setElementData ( theprisoner, "arrestTimeout", setTimer ( freetheguy, 180000, 1, theprisoner ))
--								local arresttoolong = setTimer ( freetheguy, 180000, 1, theprisoner )
							end
						end
					end
				end
			end
		end
	end
end
addEventHandler ( "onPlayerTarget", getRootElement(), sightscheck )

--ARREST PLAYERS BY PULLING THEM OUT OF A VEHICLE
--[[function yankhimout(player, seat, jacker)
	if isElement(jacker) then
		if getElementParent(jacker) == kingCOP then
			local wlevel = getPlayerWantedLevel( player )
			if wlevel > 0 then
				if (getElementData ( jacker, "currentarrests" ) ~= "single" ) and (getElementData ( jacker, "currentarrests" ) ~= "double" ) then
					local thecop = jacker
					local theprisoner = player
					setElementData ( theprisoner, "currentstatus", "underarrest" )
					setElementData ( theprisoner, "captor", thecop )
					setElementData ( thecop, "currentarrests", "single" )
					triggerClientEvent(thecop,"copdirections",thecop)
					showCursor ( theprisoner, true )
					toggleAllControls ( theprisoner, false, true, false )		
					walktheprisoner ( thecop, theprisoner )
					setElementData ( theprisoner, "arrestTimeout", setTimer ( freetheguy, 180000, 1, theprisoner ))
				elseif (getElementData ( jacker, "currentarrests" ) == "single" ) then
					local thecop = jacker
					local theprisoner = player
					setElementData ( theprisoner, "currentstatus", "underarrest" )
					setElementData ( theprisoner, "captor", thecop )
					setElementData ( thecop, "currentarrests", "double" )
					showCursor ( theprisoner, true )
					toggleAllControls ( theprisoner, false, true, false )
					walktheprisoner ( thecop, theprisoner )
					setElementData ( theprisoner, "arrestTimeout", setTimer ( freetheguy, 180000, 1, theprisoner ))
				end				
			end
		end
	end
end
addEventHandler ( "onVehicleExit", getRootElement(), yankhimout )]]

--FORCES A PRISONER TO FOLLOW THE COP
sprintanim = "sprint_civi"
runanim = "run_player"
walkanim = "walk_player"
function walktheprisoner(thecop, theprisoner)

if getElementType(theprisoner) == "player" then
	if (getElementData ( theprisoner, "currentstatus" ) == "underarrest") and (getPedOccupiedVehicle ( theprisoner ) == false ) then
		local copx, copy, copz = getElementPosition ( thecop )
		local prisonerx, prisonery, prisonerz = getElementPosition ( theprisoner )
		copangle = ( 360 - math.deg ( math.atan2 ( ( copx - prisonerx ), ( copy - prisonery ) ) ) ) % 360
		setPedRotation ( theprisoner, copangle )
		setCameraTarget ( theprisoner, theprisoner )
		local dist = getDistanceBetweenPoints2D ( copx, copy, prisonerx, prisonery )
		if ( dist > 16 ) then
			freetheguy ( theprisoner ) --FREES PRISONER IF HE GETS FAR AWAY
		elseif ( dist > 12 ) then
			setControlState ( theprisoner, "sprint", true )
			setControlState ( theprisoner, "walk", false )
			setControlState ( theprisoner, "forwards", true )
			local zombify = setTimer ( walktheprisoner, 500, 1, thecop, theprisoner )
		elseif ( dist > 6 ) then
			setControlState ( theprisoner, "sprint", false )
			setControlState ( theprisoner, "walk", false )
			setControlState ( theprisoner, "forwards", true )
			local zombify = setTimer ( walktheprisoner, 500, 1, thecop, theprisoner )
		elseif ( dist > 1.5 ) then
			setControlState ( theprisoner, "sprint", false )
			setControlState ( theprisoner, "walk", true )
			setControlState ( theprisoner, "forwards", true )
			local zombify = setTimer ( walktheprisoner, 500, 1, thecop, theprisoner )
		elseif ( dist < 1.5 ) then
			setControlState ( theprisoner, "sprint", false )
			setControlState ( theprisoner, "walk", false )
			setControlState ( theprisoner, "forwards", false )
			local zombify = setTimer ( walktheprisoner, 500, 1, thecop, theprisoner )
		end
	end
else

	if (getElementData ( theprisoner, "currentstatus" ) == "underarrest") and (getPedOccupiedVehicle ( theprisoner ) == false ) then
		local copx, copy, copz = getElementPosition ( thecop )
		local prisonerx, prisonery, prisonerz = getElementPosition ( theprisoner )
		copangle = ( 360 - math.deg ( math.atan2 ( ( copx - prisonerx ), ( copy - prisonery ) ) ) ) % 360
		setPedRotation ( theprisoner, copangle )
		setCameraTarget ( theprisoner, theprisoner )
		local dist = getDistanceBetweenPoints2D ( copx, copy, prisonerx, prisonery )
		if ( dist > 16 ) then
			freetheguy ( theprisoner ) --FREES PRISONER IF HE GETS FAR AWAY
		elseif ( dist > 12 ) then
			setPedAnimation ( theprisoner, "ped", sprintanim, -1, true, true, true )
			local zombify = setTimer ( walktheprisoner, 500, 1, thecop, theprisoner )
		elseif ( dist > 6 ) then
			setPedAnimation ( theprisoner, "ped", runanim, -1, true, true, true )
			local zombify = setTimer ( walktheprisoner, 500, 1, thecop, theprisoner )
		elseif ( dist > 1.5 ) then
			setPedAnimation ( theprisoner, "ped", walkanim, -1, true, true, true )
			local zombify = setTimer ( walktheprisoner, 500, 1, thecop, theprisoner )
		elseif ( dist < 1.5 ) then
			setPedAnimation ( theprisoner)
			local zombify = setTimer ( walktheprisoner, 500, 1, thecop, theprisoner )
		end
	end

end

end

--FREES A PLAYER (RESETS THEIR CONTROLS AND STATUS)
function freetheguy (theprisoner)

if isElement(theprisoner) then
	local thecaptor = (getElementData ( theprisoner, "captor" ))
	setElementData ( theprisoner, "currentstatus", "none" )
	setElementData ( theprisoner, "captor", "none" )
	
	if getElementType(theprisoner) == "player" then
		showCursor ( theprisoner, false )
		setControlState ( theprisoner, "sprint", false )
		setControlState ( theprisoner, "walk", false )
		setControlState ( theprisoner, "forwards", false )
		toggleAllControls (theprisoner, true)
	end
	
	local prisonercheck = setTimer ( checkforprisoners, 1500, 1, thecaptor )
	TimoutTimer = (getElementData ( theprisoner, "arrestTimeout" ))
	if isTimer(TimoutTimer) then
		 killTimer(TimoutTimer)
		 setElementData ( theprisoner, "arrestTimeout", nil)
		 TimeoutTimer = nil
	end
end

end

function checkforprisoners(thecop)
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
			triggerClientEvent( thecop,"clearcopdirections",thecop)
		elseif prisoners == 1 then
			setElementData ( thecop, "currentarrests", "single" )
		elseif prisoners == 2 then
			setElementData ( thecop, "currentarrests", "double" )
		end
	end
end

--[[ BLOCKED TO PREVENT CHEATING (WAS USED FOR TESTING)
function cheatescape (playerSource)
	freetheguy ( playerSource )
	setPlayerWantedLevel( playerSource, 0 )
end
addCommandHandler ( "freeme", cheatescape )
]]

-- FREE PRISONER IF DEATH OF COP OR PRISONER
function someonedied( ammo, attacker, weapon, bodypart )
	--local wlevel = getPlayerWantedLevel( source )
	--if wlevel > 0 then
		if isElement(attacker) and getElementType(attacker) == "player" then
			if getElementParent(attacker) == kingCOP then
				local Kreward = get("legalsystem.Kreward")
				--local thisreward = wlevel*Kreward
				givePlayerMoney ( attacker, Kreward ) 
			end
		end
	--end
	if (getElementData ( source, "currentstatus" ) == "underarrest") then
		freetheguy ( source ) --IF A PRISONER DIES, FREES THEM FOR RESPAWN
	end
	if (getElementData ( source, "currentarrests" ) == "single" ) or (getElementData ( source, "currentarrests" ) == "double" ) then
		setElementData ( source, "currentarrests", "none" )
		local players = getElementsByType ( "player" )
		for theKey,thePlayer in ipairs(players) do
			if (getElementData ( thePlayer, "captor" ) == source ) then
				freetheguy ( thePlayer ) --IF A COP DIES, FREES ALL HIS PRISONERS
			end
		end
	end
end
addEventHandler ( "onPlayerWasted", getRootElement(), someonedied )
addEventHandler ( "onPedWasted", getRootElement(), someonedied )

-- FREE PRISONER IF COP WAS JACKED OUT OF A CAR
function playergotout( player, seat, jacker )
	if isElement(jacker) then
		if (getElementData ( player, "currentarrests" ) == "single" ) or (getElementData ( player, "currentarrests" ) == "double" ) then
			local players = getElementsByType ( "player" )
			for theKey,thePlayer in ipairs(players) do
				if (getElementData ( thePlayer, "captor" ) == player ) then
					freetheguy ( thePlayer )
				end
			end
		end
	end
end
addEventHandler ( "onVehicleExit", getRootElement(), playergotout )

-- FREE PRISONER IF THE COP OR THE PRISONER DISCONNECTS
function aplayerleft()
	if (getElementData ( source, "currentarrests" ) == "single" ) or (getElementData ( source, "currentarrests" ) == "double" ) then
		local players = getElementsByType ( "player" )
		for theKey,thePlayer in ipairs(players) do
			if (getElementData ( thePlayer, "captor" ) == source ) then
				freetheguy ( thePlayer ) -- IF A COP DISCONNECTS, FREES HIS PRISONERS
			end
		end
	end
end
addEventHandler ( "onPlayerQuit", getRootElement(), aplayerleft )

-- FREE PRISONER IF A COP CAR GOT TOO DAMAGED
function cardamaged(loss)
	local carid =  getElementModel( source )
	if carid == 598 or carid == 596 or carid == 597 or carid == 427 or carid == 490 then
		local carhealth = getElementHealth ( source )
		if ( getElementHealth ( source ) < 500 ) then
			guy1 = getVehicleOccupant ( source, 2 )
			if isElement(guy1) then
				if (getElementData ( guy1, "currentstatus" ) == "underarrest") then
					freetheguy( guy1 )
				end
			end
			guy2 = getVehicleOccupant ( source, 2 )
			if isElement(guy2) then
				if (getElementData ( guy2, "currentstatus" ) == "underarrest") then
					freetheguy( guy2 )
				end
			end
			guy3 = getVehicleOccupant ( source, 3 )
			if isElement(guy3) then
				if (getElementData ( guy3, "currentstatus" ) == "underarrest") then
					freetheguy(guy3)
				end
			end
		end
	end
end
addEventHandler ( "onVehicleDamage", getRootElement(), cardamaged )

--LOADS A PRISONER INTO A COP CAR
function copcarenter (vehicle, seat, jacked )

	if getTeamName(getPlayerTeam(source)) == "Establishment" then
	
		local carid =  getElementModel( vehicle )
		if carid == 598 or carid == 596 or carid == 597 or carid == 427 or carid == 490 then
		
			if (getElementData ( source, "currentarrests" ) == "single" ) or (getElementData ( source, "currentarrests" ) == "double" ) then
				local players = getElementsByType ( "player" )
				for theKey,thePlayer in ipairs(players) do
					if (getElementData ( thePlayer, "captor" ) == source ) then
						local copx, copy, copz = getElementPosition ( source )
						local prisonerx, prisonery, prisonerz = getElementPosition ( thePlayer )
						local dist = getDistanceBetweenPoints2D ( copx, copy, prisonerx, prisonery )
						if ( dist < 6 ) then
							if (getVehicleOccupant ( vehicle, 2 ) == false) then
								warpPedIntoVehicle ( thePlayer, vehicle, 2 )
							elseif (getVehicleOccupant ( vehicle, 3 ) == false) then
								warpPedIntoVehicle ( thePlayer, vehicle, 3 )
							end
						end
					end
				end
				
				local peds = getElementsByType ( "ped" )
				for theKey,thePed in ipairs(peds) do
					if (getElementData ( thePed, "captor" ) == source ) then
						local copx, copy, copz = getElementPosition ( source )
						local prisonerx, prisonery, prisonerz = getElementPosition ( thePed )
						local dist = getDistanceBetweenPoints2D ( copx, copy, prisonerx, prisonery )
						if ( dist < 6 ) then
							if (getVehicleOccupant ( vehicle, 2 ) == false) then
								warpPedIntoVehicle ( thePed, vehicle, 2 )
							elseif (getVehicleOccupant ( vehicle, 3 ) == false) then
								warpPedIntoVehicle ( thePed, vehicle, 3 )
							end
						end
					end
				end
			end
		end	
	elseif carid == 599 then
		if getElementParent(source) == kingCOP then
			if (getElementData ( source, "currentarrests" ) == "single" ) or (getElementData ( source, "currentarrests" ) == "double" ) then
				local players = getElementsByType ( "player" )
				for theKey,thePlayer in ipairs(players) do
					if (getElementData ( thePlayer, "captor" ) == source ) then
						local copx, copy, copz = getElementPosition ( source )
						local prisonerx, prisonery, prisonerz = getElementPosition ( thePlayer )
						local dist = getDistanceBetweenPoints2D ( copx, copy, prisonerx, prisonery )
						if ( dist < 6 ) then
							if (getVehicleOccupant ( vehicle, 2 ) == false) then
								warpPedIntoVehicle ( thePlayer, vehicle, 1 )
							end
						end
					end
				end
			end
		end
	end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), copcarenter )

--WARPS A PRISONER TO JAIL AND MAKES THEM SERVE THEIR TIME
addEvent ("lockemup", true )
function donotpassgo(player, mx, my, mz)
	if (isPedInVehicle(player)) then
	    removePedFromVehicle(player)
	end
	local thecaptor = (getElementData ( player, "captor" ))
	if isElement(thecaptor) then
		local prisonercheck = setTimer ( checkforprisoners, 1500, 1, thecaptor )
		local wlevel = getPlayerWantedLevel( player )
		local Areward = get("legalsystem.Areward")
		local thisreward = wlevel*Areward
		givePlayerMoney ( thecaptor, thisreward ) -- REWARDS AN ARREST
	end
	setElementInterior(player, 6)	
	local dimension = math.random ( 7, 99 )
	setElementDimension ( player, dimension )
	setElementPosition(player, 265.34832763672, 78.314476013184, 1001.0390625)
	showCursor ( player, false )
	setControlState ( player, "sprint", false )
	setControlState ( player, "walk", false )
	setControlState ( player, "forwards", false )
	toggleAllControls (player, true)
	setElementData ( player, "captor", "none" )
	triggerEvent ( "onJailsStart", player ) -- TRIGGERS DELETION OF BLIP ONCE JAILED
	local jailtime = get("legalsystem.jailtime")
	local hadenough = setTimer ( doingyourtime, jailtime, 1, player, mx, my, mz )
	TimoutTimer = (getElementData ( player, "arrestTimeout" ))
	if isTimer(TimoutTimer) then
		killTimer(TimoutTimer)
		 setElementData ( player, "arrestTimeout", nil)
		 TimeoutTimer = nil
	end
end
addEventHandler ( "lockemup", getRootElement(), donotpassgo )

function doingyourtime(player, mx, my, mz)
	local wlevel = getPlayerWantedLevel( player )
	if wlevel > 0 then
		setPlayerWantedLevel( player, wlevel-1 )
		local jailtime = get("legalsystem.jailtime")
		local hadenough = setTimer ( doingyourtime, jailtime, 1, player, mx, my, mz )
	else
		shawshank(player, mx, my, mz)
	end
end

--LETS A PRISONER OUT OF JAIL
function shawshank(player, mx, my, mz)
	setElementInterior(player, 0)
	setElementDimension ( player, 0)
	setElementPosition(player, mx, my, mz+1)
	setElementData ( player, "currentstatus", "none" )
end

--MONITORS WANTED LEVELS AND CREATES OR DESTROYS BLIP BASED ON WANTED LEVEL
function wantedlevelmonitor()
	local allplayers = getElementsByType ( "player" )
	for playerKey,thePlayer in ipairs(allplayers) do
		if (getElementData ( thePlayer, "wantedstatus" ) ~= "Wanted" ) then
			if getPlayerWantedLevel(thePlayer) > 0 then
				setElementData ( thePlayer, "wantedstatus", "Wanted", false )
			end
		else
			if getPlayerWantedLevel(thePlayer) == 0 then
				setElementData ( thePlayer, "wantedstatus", "unWanted", false )
			end
		end
	end
end

function changestatus (dataName)
	if getElementType ( source ) == "player" and dataName == "wantedstatus" then
		if (getElementData ( source, "wantedstatus" ) == "Wanted" ) then
			local thisblip = createBlipAttachedTo (source, 56, 4, 255, 0, 0, 255, 0, 99999, kingCOP )
			setElementData ( thisblip, "purpose", "wantedblip", false )
		elseif (getElementData ( source, "wantedstatus" ) == "unWanted" ) then
			local attachedElements = getAttachedElements ( source )
			if ( attachedElements ) then
				for ElementKey, ElementValue in ipairs ( attachedElements ) do
					if (getElementData ( ElementValue, "purpose" ) == "wantedblip" ) then
						destroyElement(ElementValue)
					end
				end
			end
		end
	end
end
addEventHandler( "onElementDataChange", getRootElement(), changestatus )
