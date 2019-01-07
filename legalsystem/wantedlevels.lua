--WANTED LEVEL IF A PLAYER IS MURDERED BY A NON-COP, OR IF AN INNOCENT PERSON IS MURDERED BY A COP
function aplayerdied( ammo, attacker, weapon, bodypart )
	local glevel = getPlayerWantedLevel ( source )
	if isElement(attacker) then
		local wlevel = getPlayerWantedLevel( source )
		if wlevel > 0 then
			if getElementParent(attacker) == kingCOP then
				setPlayerWantedLevel( source, 0 )
			end
		end
 		if ( getElementType( attacker ) == "player" ) then
			local wlevel = getPlayerWantedLevel( attacker )
			if wlevel < 6 then
				setPlayerWantedLevel( attacker, wlevel+1 )
			end
		elseif ( getElementType( attacker ) == "vehicle" ) then
			thekiller = getVehicleController( attacker )
			if isElement(thekiller) then
				local wlevel = getPlayerWantedLevel ( thekiller )
				if wlevel < 6 then
					setPlayerWantedLevel( thekiller, wlevel+1 )
				end
			end
		end
	end
	setPlayerWantedLevel( source, 0 )
end
addEventHandler ( "onPlayerWasted", getRootElement(), aplayerdied )

--WANTED LEVEL IF A POLICE OFFICER IS ATTACKED
function assaultinganofficer ( attacker, weapon, bodypart, loss )
	if getElementParent(source) == kingCOP then
		if isElement(attacker) then
			if ( getElementType( attacker ) == "player" ) then
				if getElementParent(attacker) == kingCOP then
					return
				end
			elseif ( getElementType( attacker ) == "vehicle" ) then
				thedriver = getVehicleController( attacker )
				if isElement(thedriver) then
					if getElementParent(thedriver) == kingCOP then
						return
					end
				end
			end
			if (getElementData ( source, "justdamaged" ) ~= "yes") and (source ~= attacker) then
				setElementData ( source, "justdamaged", "yes" )
				local damagereset = setTimer ( resethurt, 20000, 1, source )
				if ( getElementType( attacker ) == "player" ) then
					local wlevel = getPlayerWantedLevel( attacker )
					if wlevel < 1 then
						setPlayerWantedLevel( attacker, wlevel+1 )
					end
				elseif ( getElementType( attacker ) == "vehicle" ) then
					local thekiller = getVehicleController( attacker )
					if isElement(thekiller) then
						local wlevel = getPlayerWantedLevel ( thekiller )
						if wlevel < 1 then
							setPlayerWantedLevel( thekiller, wlevel+1 )
						end
					end
				end
			end
		end
	end
end
addEventHandler ( "onPlayerDamage", getRootElement(), assaultinganofficer )

function resethurt(source)
	if isElement(source) then
		setElementData ( source, "justdamaged", "none" )
	end
end

--WANTED LEVEL IF SOMEONE OTHER THAN A COP JACKS SOMEONE
function carjackcheck(theVehicle, seat, jacker)
	if isElement(jacker) then
		if getElementParent(jacker) == kingCOP then
			return
		end
		local wlevel = getPlayerWantedLevel( jacker )
		if wlevel < 4 then
			setPlayerWantedLevel( jacker, wlevel+1 )
		end
	end
end
addEventHandler ( "onPlayerVehicleExit", getRootElement(), carjackcheck )

--WANTED LEVEL IF NON-COP TRIES TO USE A COP CAR
function copcarcheck(theVehicle, seat, jacked)
	if getElementParent(source) == kingCOP then
		return
	else
		local carid =  getElementModel( theVehicle )
		if carid == 598 or carid == 596 or carid == 597 or carid == 427 or carid == 490 or carid == 599 then
			if (getElementData ( source, "currentstatus" ) ~= "underarrest" ) then
				local wlevel = getPlayerWantedLevel( source )
				if wlevel < 4 then
					setPlayerWantedLevel( source, wlevel+1 )
				end
			end
		end
	end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), copcarcheck )


-- WANTED LEVEL IF A COP SEES SOMEONE DOING SOMETHING ILLEGAL
-- TO MAKE THIS WORK WITH YOUR SCRIPT, SET A PLAYERS ELEMENT DATA "legalstatus" TO "illegal" WHILE DOING SOMETHING ILLEGAL
-- DONT FORGET TO CHANGE IT TO SOMETHING ELSE AFTERWARDS THOUGH!!
function inspection ( element )
	if isElement(element) then
		if ( getElementType ( element ) == "player" ) then
			if getElementParent(source) == kingCOP then
				local wlevel = getPlayerWantedLevel( source )
				if wlevel == 0 then
					if (getElementData ( element, "legalstatus" ) == "illegal" ) then
						local cx, cy, cz = getElementPosition ( source )
						local px, py, pz = getElementPosition ( element )
						if ( getDistanceBetweenPoints3D ( cx, cy, cz, px, py, pz ) < 15 ) then
							setPlayerWantedLevel ( element, 1 )
						end
					end
				end
			end
		end
	end
end
addEventHandler ( "onPlayerTarget", getRootElement(), inspection )

--STUFF TO MAKE BRIBE PICKUPS WORK
function pickedUpWantedCheck ( player )
	if ( getElementType(source) == "pickup" ) then
		if getPickupType ( source ) == 3 then
			if (getElementData ( source, "model" ) == "1247" ) then
				local level = getPlayerWantedLevel(player)
				if ( level > 0 ) then
					setPlayerWantedLevel ( player, level-1 )
				end
			end
		end
	end
end
addEventHandler ( "onPickupHit", getRootElement(), pickedUpWantedCheck )
