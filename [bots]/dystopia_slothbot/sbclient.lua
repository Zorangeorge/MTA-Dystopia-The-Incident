--CLIENT STUFF


--BOT DAMAGED
addEvent("onRemoteClientPedDamage",true)
function botDamaged ( attacker, weapon, bodypart )

if not attacker then return end
if weapon == 51 then weapon = 16 end

    if getElementType ( source ) == "ped" and getElementType ( attacker ) == "player" then
        if (getElementData (source, "slothbot") == true) then
			local weapslot = getSlotFromWeapon(weapon)
            local melee = false
			local fireweapon = false
			local botstatus = getElementData(source,"status")--or "idle"
			
				if (getPedWeapon(source) < 16) then
					melee = true
				else
					fireweapon = true				
				end
				
				if bodypart == 9 then
						local rand = math.random(0,2)
						if rand == 0 then
							setPedAnimation(source,"ped","gas_cwr",2000,false,true,false,false)
							setElementData(source,"status","paused")
							setTimer(setElementData,1000,1,source,"status","chasing",true)
							setTimer(setElementData,1000,1,source,"target", attacker,true)
						else
							setPedAnimation(source,"ped","KO_shot_face",5000,false,true,false,false)
							setElementData(source,"status","paused")
							setTimer(setElementData,3000,1,source,"status","chasing",true)
							setTimer(setElementData,3000,1,source,"target", attacker,true)
						end
				elseif  bodypart ~= 9 --[[and weapslot ~= 0 and weapslot ~= 1 and weapslot ~= 10]] then
						local rand = math.random(1,2)
						if rand == 1 then
							setPedAnimation(source,"ped","Crouch_Roll_L",1500,false,true,true,false)
						else
							setPedAnimation(source,"ped","Crouch_Roll_R",1500,false,true,true,false)
						end
				end
				
				if bodypart == 3  --[[and weapslot ~= 0 and weapslot ~= 1 and weapslot ~= 10]] then
				local rand = math.random(1,4)
					if rand == 1 then
						setPedAnimation(source,"ped","handscower",2000,false,true,false,false)
						setElementData(source,"status","paused")
						setTimer(setElementData,1000,1,source,"status","chasing",true)
						setTimer(setElementData,1000,1,source,"target", attacker,true)
					elseif rand == 2 then
						setPedAnimation(source,"ped","EV_step",2000,false,true,false,false)
						setElementData(source,"status","paused")
						setTimer(setElementData,1000,1,source,"status","chasing",true)
						setTimer(setElementData,1000,1,source,"target", attacker,true)
					elseif rand == 3 then
						setPedAnimation(source,"ped","getup",3000,false,true,false,false)
						setElementData(source,"status","paused")
						setTimer(setElementData,1500,1,source,"status","chasing",true)
						setTimer(setElementData,1500,1,source,"target", attacker,true)
					elseif rand == 4 then
						setPedAnimation(source,"ped","KO_shot_stom",5000,false,true,false,false)
						setElementData(source,"status","paused")
						setTimer(setElementData,3000,1,source,"status","chasing",true)
						setTimer(setElementData,3000,1,source,"target", attacker,true)
					end
				elseif --[[weapslot ~= 0 and weapslot ~= 1 and weapslot ~= 10 and]] (bodypart == 7 or bodypart == 8) then
					setPedAnimation(source,"ped","getup",3000,false,true,false,false)
					setElementData(source,"status","paused")
					setTimer(setElementData,1500,1,source,"status","chasing",true)
					setTimer(setElementData,1500,1,source,"target", attacker,true)
				end
			--setElementData ( source, "target", attacker )
        end
    end
end
addEventHandler ( "onRemoteClientPedDamage", getRootElement(), botDamaged )
addEventHandler ( "onClientPedDamage", getRootElement(), botDamaged )

--detects when a bot changes status and starts the new behaviour
function changestatus (dataName)
	if getElementType ( source ) == "ped" and dataName == "status" and (getElementData (source, "slothbot") == true) and getElementData (source, "status") ~= "paused" then
		if (getElementData ( source, "status" ) == "chasing" ) then
			local player = getElementData ( source, "target" )
			local oldTx, oldTy, oldTz
			if isElement(player) then oldTx, oldTy, oldTz = getElementPosition( player ) end
			local oldPx, oldPy, oldPz = getElementPosition( source )
			setTimer ( chase_aim, 80, 1, source)
			setTimer ( chase_move, 700, 1, source, oldTx, oldTy, oldTz, oldPx, oldPy, oldPz )
			setTimer ( chase_shoot, 1500, 1, source )
		elseif (getElementData ( source, "status" ) == "hunting" ) then
			local oldPx, oldPy, oldPz = getElementPosition( source )
			setTimer ( enemy_check, 600 ,1 , source )-- starts scanning for enemies
			setTimer ( hunt_move, 800, 1, source, oldPx, oldPy, oldPz, oldPx, oldPy, oldPz )
		elseif (getElementData ( source, "status" ) == "following" ) then
			local player = getElementData ( source, "leader" )
			local oldTx, oldTy, oldTz = getElementPosition( player )
			local oldPx, oldPy, oldPz = getElementPosition( source )
			setTimer ( follow_enemy_check, 500 ,1 , source )
			setTimer ( follow_move, 800, 1, source, oldPx, oldPy, oldPz, oldPx, oldPy, oldPz )
		elseif (getElementData ( source, "status" ) == "waiting" ) then	
			setTimer ( wait_enemy_check, 500 ,1 , source )
		elseif (getElementData ( source, "status" ) == "guarding" ) then
			setTimer ( guard_enemy_check, 800 ,1 , source )-- starts scanning for enemies
			setTimer ( guard_move, 400 ,1 , source )
		end
	end
end
addEventHandler( "onClientElementDataChange", getRootElement(), changestatus )

--keeps the bot's aim slightly lagged
local player
function chase_aim(ped,player)
	if (isElement(ped)) then
		if not player then
			player = getElementData ( ped, "target" )
		end
		if (getElementData ( ped, "status" ) ==  "chasing" ) and (isElement(player)) and (getElementData (ped, "slothbot") == true) then
			if getElementType(player) == "player" then
				local pedhp = getElementHealth ( ped )
				if pedhp > 0 and (isPedDead(player) == false) then
					local x,y,z = getElementPosition( player )
					local ex,ey,ez = getElementPosition( ped )
					local isclear = isLineOfSightClear (ex, ey, ez+.6, x, y, z+.6, true, false, false, true, false, false, false)

					local isattached = isElementAttached(ped)
					local botveh
					if isattached then botveh = getElementAttachedTo(ped) end
					local thetarget = getPedTarget(ped)
					if thetarget == botveh then isclear = false end

					if (isclear == true) then -- if the player target is in sight
						if isPedDucked(player) then
						local x,y,z = getElementPosition( player )
							setPedAimTarget ( ped, x, y, z-0.0 )
						else
						local x,y,z = getElementPosition( player )
							setPedAimTarget ( ped, getElementPosition( player ) )
						end
					end
					setTimer ( chase_aim, 80, 1, ped, player )
				end
			elseif getElementType(player) == "ped" then
				local pedhp = getElementHealth ( ped )
				if pedhp > 0 and (getElementHealth(player) > 0) then
					local x,y,z = getElementPosition( player )
					local ex,ey,ez = getElementPosition( ped )
					local isclear = isLineOfSightClear (ex, ey, ez+.6, x, y, z+.6, true, false, false, true, false, false, false)

					local isattached = isElementAttached(ped)
					local botveh
					if isattached then botveh = getElementAttachedTo(ped) end
					local thetarget = getPedTarget(ped)
					if thetarget == botveh then isclear = false end

					if (isclear == true) then -- if the player target is in sight
						if isPedDucked(player) then
						--local x,y,z = getElementPosition( player )
							setPedAimTarget ( ped, x, y, z-0.0 )
						else
						--local x,y,z = getElementPosition( player )
							setPedAimTarget ( ped, x, y, z )
						end
					end
					setTimer ( chase_aim, 80, 1, ped, player )
				end
			end
		end
	end
end

--bot behaviour while in chase mode 
function chase_move (ped, oldTx, oldTy, oldTz, oldPx, oldPy, oldPz)
	if (isElement(ped)) then
		local thetarget = getElementData ( ped, "target" )
		if (getElementData ( ped, "status" ) ==  "chasing" ) and (isElement(thetarget)) and (getElementData (ped, "slothbot") == true) then
			
			if getElementData(ped,"laser.aim") then
			setElementData(ped,"laser.aim",false,true)
			end
			
			local pedhp = getElementHealth ( ped )
			local tarhp = getElementHealth ( thetarget )
			if pedhp > 0 and tarhp > 0 then
				local tx,ty,tz = getElementPosition( thetarget )
				if not oldTx then oldTx, oldTy, oldTz = getElementPosition( thetarget ) end
				local px,py,pz = getElementPosition( ped )
				local isclear = isLineOfSightClear (px, py, pz+.6, tx, ty, tz+.6, true, false, false, true, false, false, false)
				local angle = ( 360 - math.deg ( math.atan2 ( ( tx - px ), ( ty - py ) ) ) ) % 360 --set the peds angle to the target
				setPedRotation( ped, angle )

				local isattached = isElementAttached(ped)
				local botveh
				if isattached then botveh = getElementAttachedTo(ped) end
				local thetarget = getPedTarget(ped)
				if thetarget == botveh then isclear = false; thetarget = getElementData ( ped, "target" ) else thetarget = getElementData ( ped, "target" ) end

				if (isclear == true) then -- if the ped can see the target
						--------------------************************************
						if (getElementType(thetarget) == "player" or getElementType(thetarget) == "ped") and isPedDucked(thetarget) then
								setPedAimTarget ( ped, tx,ty,tz-.5 )
							else
								setPedAimTarget ( ped, tx,ty,tz )
						end
						--------------------************************************
					local angle = ( 360 - math.deg ( math.atan2 ( ( tx - px ), ( ty - py ) ) ) ) % 360 --set the peds angle to the target
					setPedRotation( ped, angle )
					setElementData ( ped, "seestarget", true )
					setTimer ( chase_move, 700, 1, ped, tx, ty, tz, px, py, pz)
				else
					local angle = ( 360 - math.deg ( math.atan2 ( ( oldTx - px ), ( oldTy - py ) ) ) ) % 360 --set the peds angle to the target
					setPedRotation( ped, angle )
					setElementData ( ped, "seestarget", false )
					setTimer ( chase_move, 700, 1, ped, oldTx, oldTy, oldTz, px, py, pz)
				end
			end
		end
	end
end

function isPedInWeaponRange(ped)
	local weap = getPedWeapon(ped)
		local ranges ={}
			ranges[22]=100
			ranges[23]=45
			ranges[32]=70
			ranges[26]=30
			ranges[25]=40
			ranges[31]=180
			ranges[30]=160
			ranges[34]=350
			ranges[33]=250
			ranges[29]=100
			ranges[27]=40
			ranges[24]=90
			ranges[43]=1000
	if ranges[weap] then 
	return ranges[weap] 
	else 
	return false
	end
return false
end

--tells the bot when to fire its gun. (only run by the peds controller)
local player
function chase_shoot(ped,player)

--if isElementStreamedIn(ped)== false then return end --ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ

	if (isElement(ped)) then
	if not player then 
		player = getElementData ( ped, "target" )
	end
		local specialty = getElementData(ped,"specialty")
		if (isElement(player)) and (getElementData (ped, "slothbot") == true) then
			if (getElementType(player) == "ped") or (getElementType(player) == "player") then
				if (getElementData ( ped, "status" ) == "chasing" ) and (isElement(player)) then
					if (getElementHealth(ped)>0) and (getElementHealth(player)>0) and (getElementData ( ped, "controller" ) == getLocalPlayer()) then
						local x,y,z = getElementPosition( player )
						local ex,ey,ez = getElementPosition( ped )
						local isclear = isLineOfSightClear (ex, ey, ez+1, x, y, z+1, true, false, false, true, false, false, false)

						local isattached = isElementAttached(ped)
						local botveh
						if isattached then botveh = getElementAttachedTo(ped) end
						local thetarget = getPedTarget(ped)
						if thetarget == botveh then isclear = false end

						if isclear == true then -- if the ped can see the local player
							local distance = (getDistanceBetweenPoints3D (ex, ey, ez, x, y, z))
							
						--[[if getElementData(ped, "laser.on") and not getElementData(ped, "laser.aim") then setElementData(ped,"laser.aim",true,true) end]]
						if getElementData(ped, "laser.on") and getPedAmmoInClip(ped) == 0 and getElementData(ped, "laser.aim") then 
							setElementData(ped,"laser.aim",false,true) 
						elseif getElementData(ped, "laser.on") and not getElementData(ped, "laser.aim") then 
							setElementData(ped,"laser.aim",true,true)
						end
						--------------------************************************
						if isPedDucked(player) then
								setPedAimTarget ( ped, x, y, z-0.0 )
							else
								setPedAimTarget ( ped, x, y, z )
						end
						--------------------************************************
							
							if specialty == "molotov"  then----------------ZZZZZ
								iprint("weapon is projectile")
								if (distance < 75 ) then
									--local length = math.random( 2000, 5500 )
									triggerServerEvent ( "pedShootTrigger", ped, "projectile" )
									setTimer ( chase_shoot, 5000 ,1 , ped, player )
								else
									setTimer ( chase_shoot, 4000 ,1 , ped, player )
								end
							elseif specialty ==  "rocket" then
								if (distance < 100 ) then
									--local length = math.random( 2000, 5500 )
									triggerServerEvent ( "pedShootTrigger", ped, "rocket", length )
									setTimer ( chase_shoot, 5000 ,1 , ped, player )
								else
									setTimer ( chase_shoot, 4000 ,1 , ped, player )
								end
								
							elseif specialty ==  "barrel" then
								if (distance < 120 ) and getPedOccupiedVehicle(player) then
									triggerServerEvent ( "pedShootTrigger", ped, "barrel" )
									setTimer ( chase_shoot, 5000 ,1 , ped, player )
								else
									setTimer ( chase_shoot, 4000 ,1 , ped, player )
								end
							
							elseif specialty ==  "spikestrip" then
								if (distance < 150 ) and getPedOccupiedVehicle(player) then
									triggerServerEvent ( "pedShootTrigger", ped, "spikestrip" )
									setTimer ( chase_shoot, 3000 ,1 , ped, player )
								else
									setTimer ( chase_shoot, 4000 ,1 , ped, player )
								end
							
							elseif (getPedWeapon(ped) < 19)  and (getPedWeapon(ped) ~= 9) then -- if its a melee weapon hat isnt a chainsaw
								if (distance < 2 ) then
									triggerServerEvent ( "pedShootTrigger", ped, "melee" )
									setTimer ( chase_shoot, 2300, 1, ped, player )
								else
									setTimer ( chase_shoot, 1500 ,1 , ped, player )
								end
							elseif (getPedWeapon(ped) == 9) then -- if it is a chainsaw (watch out, the peds are deadly with these)
								if (distance < 2 ) then
									local length = 1500
									triggerServerEvent ( "pedShootTrigger", ped, "chainsawA", length )
									setTimer ( chase_shoot, 6000, 1, ped, player )
								else
									local length = math.random( 2100, 5500 )
									triggerServerEvent ( "pedShootTrigger", ped, "chainsawB", length )
									setTimer ( chase_shoot, length+900 ,1 , ped, player )
								end
							elseif (getPedWeapon(ped) == 22) then
								if (distance < 35 ) then
									local length = math.random( 2100, 5500 )
									triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
									setTimer ( chase_shoot, length+500 ,1 , ped, player )
								else
									setTimer ( chase_shoot, 1500 ,1 , ped, player )
								end
							elseif (getPedWeapon(ped) == 23) then
								if (distance < 35 ) then
									local length = math.random( 2000, 5500 )
									triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
									setTimer ( chase_shoot, length+400 ,1 , ped, player )
								else
									setTimer ( chase_shoot, 1500 ,1 , ped, player )
								end
							elseif (getPedWeapon(ped) == 24) then
								if (distance < 35 ) then
									local length = math.random( 2000, 5500 )
									triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
									setTimer ( chase_shoot, length+400 ,1 , ped, player )
								else
									setTimer ( chase_shoot, 1500 ,1 , ped, player )
								end
							elseif (getPedWeapon(ped) == 25) then
								if (distance < 27 ) then
									local length = 300
									triggerServerEvent ( "pedShootTrigger", ped, "gun", length)
									setTimer ( chase_shoot, 1400 ,1 , ped, player )
								else
									setTimer ( chase_shoot, 1500 ,1 , ped, player )
								end
							elseif (getPedWeapon(ped) == 26) then
								if (distance < 20 ) then
									local length = 1200
									triggerServerEvent ( "pedShootTrigger", ped, "gun", length)
									setTimer ( chase_shoot, 800 ,1 , ped, player )
								else
									setTimer ( chase_shoot, 1500 ,1 , ped, player )
								end
							elseif (getPedWeapon(ped) == 27) then
								if (distance < 25 ) then
									local length = 1200
									triggerServerEvent ( "pedShootTrigger", ped, "gun", length)
									setTimer ( chase_shoot, 1800 ,1 , ped, player )
								else
									setTimer ( chase_shoot, 1500 ,1 , ped, player )
								end
							elseif (getPedWeapon(ped) == 28) then
								if (distance < 40 ) then
									local length = math.random( 2100, 5500 )
									triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
									setTimer ( chase_shoot, length+500 ,1 , ped, player )
								else
									setTimer ( chase_shoot, 1500 ,1 , ped, player )
								end
							elseif (getPedWeapon(ped) == 29) then
								if (distance < 55 ) then
									local length = math.random( 2000, 5500 )
									triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
									setTimer ( chase_shoot, length+1500 ,1 , ped, player )
								else
									setTimer ( chase_shoot, 1500 ,1 , ped, player )
								end
							elseif (getPedWeapon(ped) == 30) then
								if (distance < 60 ) then
									local length = math.random( 2000, 5500 )
									triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
									setTimer ( chase_shoot, length+1500 ,1 , ped, player )
								else
									setTimer ( chase_shoot, 1500 ,1 , ped, player )
								end
							elseif (getPedWeapon(ped) == 31) then
								if (distance < 60 ) then
									local length = 700
									triggerServerEvent ( "pedShootTrigger", ped, "gun", length)
									setTimer ( chase_shoot, 1200 ,1 , ped, player )
								else
									setTimer ( chase_shoot, 1500 ,1 , ped, player )
								end
							elseif (getPedWeapon(ped) == 32) then
								if (distance < 30 ) then
									local length = math.random( 2000, 5500 )
									triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
									setTimer ( chase_shoot, length+600 ,1 , ped, player )
								else
									setTimer ( chase_shoot, 1500 ,1 , ped, player )
								end
							elseif (getPedWeapon(ped) == 33) then
								if (distance < 75 ) then
									local length = 400
									triggerServerEvent ( "pedShootTrigger", ped, "gun", length)
									setTimer ( chase_shoot, 1600 ,1 , ped, player )
								else
									setTimer ( chase_shoot, 1500 ,1 , ped, player )
								end
							elseif (getPedWeapon(ped) == 34) then
								if (distance < 75 ) then
									triggerServerEvent ( "pedShootTrigger", ped, "sniper")
									setTimer ( chase_shoot, 2000 ,1 , ped, player )
								else
									setTimer ( chase_shoot, 1500 ,1 , ped, player )
								end
							elseif (getPedWeapon(ped) == 37) then
								if (distance < 15 ) then
									local length = math.random( 2000, 5500 )
									triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
									setTimer ( chase_shoot, length+900 ,1 , ped, player )
								else
									setTimer ( chase_shoot, 1500 ,1 , ped, player )
								end
							elseif (getPedWeapon(ped) == 38) then
								if (distance < 65 ) then
									local length = math.random( 2000, 5500 )
									triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
									setTimer ( chase_shoot, length+900 ,1 , ped, player )
								else
									setTimer ( chase_shoot, 1500 ,1 , ped, player )
								end
							elseif (getPedWeapon(ped) == 41) then
								if (distance < 4 ) then
									local length = math.random( 2000, 5500 )
									triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
									setTimer ( chase_shoot, length+900 ,1 , ped, player )
								else
									setTimer ( chase_shoot, 1500 ,1 , ped, player )
								end
							elseif (getPedWeapon(ped) == 42) then
								if (distance < 8 ) then
									local length = math.random( 2000, 5500 )
									triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
									setTimer ( chase_shoot, length+900 ,1 , ped, player )
								else
									setTimer ( chase_shoot, 1500 ,1 , ped, player )
								end
							
							else
								setTimer ( chase_shoot, 1500 ,1 , ped, player )
							end
						else
							setTimer ( chase_shoot, 1500 ,1 , ped, player )
						end
					else	
						--------------------************************************
						local x,y,z = getElementPosition( player )
						if isPedDucked(player) then
								setPedAimTarget ( ped, x, y, z-0.0 )
							else
								setPedAimTarget ( ped, x, y, z )
						end
						--------------------************************************
						setTimer ( chase_shoot, 1500 ,1 , ped, player )					
					end
				end
			end
		end
	end
end

function stopTeamDamage ( attacker, weapon, bodypart )
	if (isElement(attacker)) then
		local theTeam = getPlayerTeam(source)
		if (isElement(theTeam)) then
			if ( getTeamFriendlyFire ( theTeam ) == false ) then
				if (getElementType ( attacker ) == "ped") then
					if (getElementData ( attacker, "BotTeam" ) == theTeam) then
						cancelEvent() --cancel the event
					end
				elseif (getElementType ( attacker ) == "player") then
					if getPlayerTeam(attacker) == theTeam then
						cancelEvent() --cancel the event
					end
				end
			end
		end
	end
end
addEventHandler ( "onClientPlayerDamage", getRootElement(), stopTeamDamage )

--following functions are for when the server tells clients to make a ped shoot. since this happens to all the clients at once, should be synced somewhat
addEvent( "onMeleeShoot", true )
function meleeShoot(ped)
	if (isElement(ped)) then
		setPedControlState ( ped, "forwards", false )
		setPedControlState ( ped, "fire", true )
		
		setTimer ( function (ped) if ( isElement ( ped ) ) then setPedControlState ( ped, "fire", false) end end, 300, 1, ped )
		setTimer ( function (ped) if ( isElement ( ped ) ) then setPedControlState ( ped, "fire", true) end end, 800, 1, ped )
		setTimer ( function (ped) if ( isElement ( ped ) ) then setPedControlState ( ped, "fire", false) end end, 1100, 1, ped )
		setTimer ( function (ped) if ( isElement ( ped ) ) then setPedControlState ( ped, "fire", true) end end, 1400, 1, ped )
		setTimer ( function (ped) if ( isElement ( ped ) ) then setPedControlState ( ped, "fire", false) end end, 1700, 1, ped )
		setTimer ( function (ped) if ( isElement ( ped ) ) then setPedControlState ( ped, "forwards", true) end end, 2000, 1, ped )
	end
end
addEventHandler("onMeleeShoot", getRootElement(), meleeShoot)

addEvent( "onChainsawAShoot", true )
function chainsawA(ped)
	if (isElement(ped)) then
		setPedControlState ( ped, "forwards", false )
		setPedControlState ( ped, "fire", true )
		setTimer ( function (ped) if ( isElement ( ped ) ) then setPedControlState ( ped, "fire", false) end end, 1500, 1, ped )
	end
end
addEventHandler("onChainsawAShoot", getRootElement(), chainsawA)

addEvent( "onChainsawBShoot", true )
function chainsawB(ped, length)
	if (isElement(ped)) then
		setPedControlState ( ped, "fire", true )					
		setTimer ( function (ped) if ( isElement ( ped ) ) then setPedControlState ( ped, "fire", false) end end, length, 1, ped )
	end
end
addEventHandler("onChainsawBShoot", getRootElement(), chainsawB)

---**** and isPedInWeaponRange(ped)  
addEvent( "onGunShoot", true )
function gunShoot(ped, length)
	if (isElement(ped)) then
		if getElementData(ped, "laser.on") and getPedAmmoInClip(ped) == 0 and getElementData(ped, "laser.aim") then 
			setElementData(ped,"laser.aim",false,true) 
		elseif getElementData(ped, "laser.on") and not getElementData(ped, "laser.aim") then 
			setElementData(ped,"laser.aim",true,true)
		end
		setPedControlState ( ped, "fire", true )
		setTimer ( function (ped) if ( isElement ( ped ) ) then setPedControlState ( ped, "fire", false) end end, length, 1, ped )
	end
end
addEventHandler("onGunShoot", getRootElement(), gunShoot)

addEvent( "onSniperShoot", true )
function sniperShoot(ped)
	if (isElement(ped)) then
		if getElementData(ped, "laser.on") and not getElementData(ped, "laser.aim") then setElementData(ped,"laser.aim",true,true) end
		setPedControlState ( ped, "aim_weapon", true )
		setTimer ( function (ped) if ( isElement ( ped ) ) then setPedControlState ( ped, "fire", true) end end, 400, 1, ped )	
		setTimer ( function (ped) if ( isElement ( ped ) ) then setPedControlState ( ped, "fire", false) end end, 800, 1, ped )
		setTimer ( function (ped) if ( isElement ( ped ) ) then setPedControlState ( ped, "aim_weapon", false) end end, 900, 1, ped )
	end
end	
addEventHandler("onSniperShoot", getRootElement(), sniperShoot)

addEvent( "onRocketShoot", true )
function rocketShoot(ped)
	if (isElement(ped)) then
		setPedControlState ( ped, "aim_weapon", true )
		setTimer ( function (ped) if ( isElement ( ped ) ) then setPedControlState ( ped, "fire", true) end end, 400, 1, ped )	
		setTimer ( function (ped) if ( isElement ( ped ) ) then setPedControlState ( ped, "aim_weapon", false) end end, 900, 1, ped )
	end
end	
addEventHandler("onRocketShoot", getRootElement(), rocketShoot)

function findRotation3D( x1, y1, z1, x2, y2, z2 ) 
	local rotx = math.atan2 ( z2 - z1, getDistanceBetweenPoints2D ( x2,y2, x1,y1 ) )
	rotx = math.deg(rotx)
	local rotz = -math.deg( math.atan2( x2 - x1, y2 - y1 ) )
	rotz = rotz < 0 and rotz + 360 or rotz
	return rotx, 0,rotz
end

function getPositionInfrontOfElement ( element , meters ) 
    if not element or not isElement ( element ) then 
        return false 
    end 
    if not meters then 
        meters = 3 
    end 
    local posX , posY , posZ = getElementPosition ( element ) 
    local _ , _ , rotation = getElementRotation ( element ) 
    posX = posX - math.sin ( math.rad ( rotation ) ) * meters 
    posY = posY + math.cos ( math.rad ( rotation ) ) * meters 
    return posX , posY , posZ 
end 

addEvent( "onProjectileThrow", true )-------------------ZZZZZZZZZZZZ
function projectileThrow(ped)
iprint("throwing triggered")
	if (isElement(ped)) then
	iprint("throwing grenade")

		local orientation = -1 -- left is -1, right is 1 
		
		local x, y, z = getElementPosition(ped) 
		local _, _, r = getElementRotation(ped) 
		x = x + 4 * math.cos(math.rad(r)) * orientation 
		y = y + 4 * math.sin(math.rad(r)) * orientation 
				
		local grenade = createProjectile(localPlayer, 18, x, y, z+2, 1, nil,  0,0,0,  0,0,0)
		
	end
end	
addEventHandler("onProjectileThrow", getRootElement(), projectileThrow)	

--[[addEvent( "onPedSpikestripThrow", true )-------------------ZZZZZZZZZZZZ
function spikestripThrow(ped)
iprint("spikestrip triggered")
	if (isElement(ped)) then
	

		local orientation = -1 -- left is -1, right is 1 
		
		local x, y, z = getElementPosition(ped) 
		local _, _, r = getElementRotation(ped) 
		x = x + 4 * math.cos(math.rad(r)) * orientation 
		y = y + 4 * math.sin(math.rad(r)) * orientation 
				
		local spikestrip = createProjectile(localPlayer, 18, x, y, z+2, 1, nil,  0,0,0,  0,0,0)
		
	end
end	
addEventHandler("onPedSpikestripThrow", getRootElement(), spikestripThrow)	]]

addEvent( "onBarrelThrow", true )-------------------ZZZZZZZZZZZZ
function barrelThrow(ped)
iprint("barrel triggered")
	if (isElement(ped)) then
		setPedAnimation(ped,"riot","riot_punches",1200,false,false,false,false)
		local x,y,z = getElementPosition( ped )
		local rx,ry,rz = getElementRotation( ped )
		local cx,cy,cz = getPositionInfrontOfElement(ped,1)
		local vx,vy,vz = getElementVelocity(ped)
			
			--if vx>0 and vy >0 then 
			local barrel = createObject(1225,cx,cy,cz,0,90,0)
			local tx,ty,tz = getPositionInfrontOfElement(ped,10)
			local gx,gy,gz = getGroundPosition(tx,ty,tz)
			moveObject(barrel,600,tx,ty,gz,0,0,0,"OutQuad")
			setTimer(function()	setElementHealth(barrel,200); setElementVelocity(barrel,-vx,-vy,-vz-0.5) end,600,1)
			setTimer(function()local x,y,z = getElementPosition(barrel); destroyElement(barrel); createExplosion(x,y,z,12) end,1000,1)
			else
			--setElementData(ped,"specialty",false,true); 
			--setElementData(ped,"target",nil,true) 
			--setElementData(ped,"status","hunting",true) 
			--return
			--end
		
	end
end	
addEventHandler("onBarrelThrow", getRootElement(), barrelThrow)	

-- while in hunt mode, this makes the peds keep an eye out for players to attack. (only run by the peds controller)
--[[
function enemy_check (ped)
	if (isElement(ped)) then
		if ( getElementData ( ped, "status" ) == "hunting" ) and (getElementHealth(ped)>0) and (getElementData (ped, "slothbot") == true) then	
			if (getElementData ( ped, "controller" ) == getLocalPlayer()) then
				local Px,Py,Pz = getElementPosition( ped )
				if isPedDucked ( ped ) then
					local Pz = Pz-1
				end
				local enemies = getElementsByType ( "player" )
				local foundone = 0
				for theKey,thePlayer in ipairs(enemies) do
					if (isPlayerDead(thePlayer) == false) then
						local x,y,z = getElementPosition( thePlayer )
						local isclear = isLineOfSightClear (Px, Py, Pz+.6, x, y, z +.6, true, false, false, true, false, false, false, false ) 
						local distance = (getDistanceBetweenPoints3D (Px, Py, Pz, x, y, z))
						if (isclear == true) and (distance < 150) then --if a player is in line of sight and within range
							if getPlayerTeam(thePlayer) == false then
								triggerServerEvent ( "onBotFindEnemy", ped, thePlayer)
								local foundone = 1
							elseif (getElementData ( ped, "BotTeam" ) ~= getPlayerTeam (thePlayer)) then
								triggerServerEvent ( "onBotFindEnemy", ped, thePlayer) 
								local foundone = 1
							else
								if (distance < 4) then
									triggerServerEvent ( "TeamBot", ped, ped, thePlayer)
								end
							end
						end
					end
				end
				if foundone == 0 then
					local enemybots = getElementsByType ( "ped" )
					for theKey,theBot in ipairs(enemybots) do
						if (getElementHealth(theBot)>0) and (theBot ~= ped) then
							local x,y,z = getElementPosition( theBot )
							local isclear = isLineOfSightClear (Px, Py, Pz+.6, x, y, z +.6, true, false, false, true, false, false, false, false ) 
							local distance = (getDistanceBetweenPoints3D (Px, Py, Pz, x, y, z))
							if (isclear == true) and (distance < 150) then --if a player is in line of sight and within range
								if (getElementData ( ped, "BotTeam" ) == false) then
									triggerServerEvent ( "onBotFindEnemy", ped, theBot)
									local foundone = 1
								elseif (getElementData ( ped, "BotTeam" )) ~= (getElementData ( theBot, "BotTeam" )) then
									triggerServerEvent ( "onBotFindEnemy", ped, theBot) 
									local foundone = 1
								else
									if (distance < 4) then
										triggerServerEvent ( "TeamBot", ped, ped, theBot )
									end
								end
							end
						end
					end			
				end
				setTimer ( enemy_check, 500 ,1 , ped)
			else
				setTimer ( enemy_check, 2000 ,1 , ped)
			end	
		end
	end
end
]]

function playerIsBehind(player,bot)
	if getElementType(player) ~= "player" then return false end
	local px,py,pz = getElementPosition(player)
	local bx,by,bz = getElementPosition(bot)
	local botBackCol = getElementData(bot,"backSide")
	local bbx,bby,bbz = getElementPosition(botBackCol)
		if getDistanceBetweenPoints3D(px,py,pz,bx,by,bz) < getDistanceBetweenPoints3D(px,py,pz,bbx,bby,bbz) then 
			return false 
		else 
			return true 
		end
end

function playerSneakScore(player)
	local theSneakScore = 0
	if getElementType(player) ~= "player" then return 0 end
	local weatherID = getWeather()
	if isElement(player) then
		if getPedMoveState ( player ) == "crouch" or getPedMoveState ( player ) == "crawl" then
			--outputDebugString("ped is ducked")
			theSneakScore = theSneakScore + 1
		--else 
			--outputDebugString("ped NOT ducked")
		end
		if weatherID == 8 or weatherID == 9 or weatherID == 16 or weatherID == 19 then
			--outputDebugString("weather is shit")
			theSneakScore = theSneakScore + 1
		end
		--outputDebugString("sneakscore is: "..tostring(theSneakScore))
		return theSneakScore	
	end
end

function aggro(bot,player)
	triggerServerEvent ( "onBotFindEnemy", bot, player)
	if getElementData(bot,"type") == "civilian" then 
	setElementData(bot,"type",nil) 
	setPedAnimation(bot) 
	end
end

--new enemy check code from gamesnert
function table.merge(tbl1,tbl2)
	for index,value in ipairs(tbl2) do
		table.insert(tbl1,value)
	end	
	return tbl1
end

local Px,Py,Pz

function sortFunc(a,b)
	local x1,y1,z1 = getElementPosition(a)
	local x2,y2,z2 = getElementPosition(b)	
	return getDistanceBetweenPoints3D(Px,Py,Pz,x1,y1,z1) < getDistanceBetweenPoints3D(Px,Py,Pz,x2,y2,z2)
end

function getTeam(target)
	if getElementType(target)=="player" then
		return getPlayerTeam(target)
	else
		return getElementData(target,"BotTeam")
	end
end

function getDistToElement(element)
	local x,y,z = getElementPosition(element)	
	return getDistanceBetweenPoints3D(Px,Py,Pz,x,y,z)
end

-- while in hunt mode, this makes the peds keep an eye out for players to attack. (only run by the peds controller)
function enemy_check (ped)
	if (isElement(ped)) then
		if (getElementHealth(ped)>0) and (getElementData (ped, "slothbot") == true) then
			if (getElementData ( ped, "controller" ) == getLocalPlayer()) then
				Px,Py,Pz = getElementPosition( ped )
				
				if isPedDucked ( ped ) then
					Pz = Pz-1
				end			
				local shortestDistance = math.huge
				local potentialTargets = table.merge(getElementsByType("player",getRootElement(),true),getElementsByType("ped",getRootElement(),true))			
				local myTeam = getElementData(ped,"BotTeam")			
				local removeIndices = {}			
				for index,target in ipairs(potentialTargets) do
					targetTeam = getTeam(target)
					if not isElementStreamedIn(target) or getDistToElement(target) > 150 then
						table.insert(removeIndices,index)
					elseif targetTeam == myTeam and targetTeam ~= false then
						table.insert(removeIndices,index)
						if getDistToElement(target) < 4 and getElementData(ped,"type")~= "civilian" then
							triggerServerEvent ( "TeamBot", ped, ped, target)
						end
					end
				end			
				for i=#removeIndices,1,-1 do
					table.remove(potentialTargets,removeIndices[i])
				end			
				if #potentialTargets > 0 then
					table.sort(potentialTargets,sortFunc)	
					for theKey,thePlayer in ipairs(potentialTargets) do
						if thePlayer ~= ped then
							if getElementHealth(thePlayer) > 0 then
								--local thefuckingPLAYER = thePlayer
								local sneakScore = playerSneakScore(thePlayer)
								--outputDebugString("sneakScore: "..sneakScore)
								local isBehind = playerIsBehind(thePlayer,ped)
								local x,y,z = getElementPosition( thePlayer )
								local isclear = isLineOfSightClear (Px, Py, Pz+.6, x, y, z +.6, true, false, false, true, false, false, false )

								local isattached = isElementAttached(ped)
								local botveh
								if isattached then botveh = getElementAttachedTo(ped) end
								local thetarget = getPedTarget(ped)
								if thetarget == botveh then isclear = false end

											if (isclear == true) then --if a player is in line of sight and within range
									targetTeam = getTeam(thePlayer)
									if targetTeam ~= myTeam or targetTeam == false then
									local distance = getDistToElement(thePlayer)
									--outputDebugString("distance is: "..distance)
										if distance < 75 then
											if isBehind then
												if distance <25 then
													if sneakScore < 1 then
														aggro(ped,thePlayer)
														return
													end
												end
											else
												if distance > 45 and sneakScore < 1 then
													aggro(ped,thePlayer)
													return
												elseif distance <= 45 and distance >= 15 then
													if sneakScore < 2 then
													aggro(ped,thePlayer)
													return
													end
												elseif distance < 15 then
													aggro(ped,thePlayer)
													return
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
			setTimer ( enemy_check, 500 ,1 , ped)
		else
			setTimer ( enemy_check, 500 ,1 , ped)
		end
	end
end


--when the ped gets hit, will switch its target to the player who shot it
function aidamage ( attacker, weapon, bodypart )
	if (isElement(attacker)) and (getElementData (source, "slothbot") == true) and (getElementData ( source, "controller" ) == getLocalPlayer()) then
		if (getElementData ( source, "target" ) ~=  attacker ) and (getElementType ( attacker ) == "player") then
			if getPlayerTeam(attacker) == false then
				if (getElementData ( source, "status" ) ~= "following" ) then
					triggerServerEvent ( "onBotFindEnemy", source, attacker)
				else
					setElementData ( source, "target", attacker )
				end
			elseif (getElementData ( source, "BotTeam" ) ~= getPlayerTeam (attacker)) then
				if (getElementData ( source, "status" ) ~= "following" ) then
					triggerServerEvent ( "onBotFindEnemy", source, attacker) 
				else
					setElementData ( source, "target", attacker )
				end
			else
			end		
		elseif (getElementData ( source, "target" ) ~=  attacker ) and (getElementType ( attacker ) == "ped") then
			if (getElementData ( attacker, "BotTeam" ) == false) then
				if (getElementData ( source, "status" ) ~= "following" ) then
					triggerServerEvent ( "onBotFindEnemy", source, attacker) 
				else
					setElementData ( source, "target", attacker )
				end
			elseif (getElementData( source, "BotTeam" )) ~= (getElementData ( attacker, "BotTeam" )) then
				if (getElementData ( source, "status" ) ~= "following" ) then
					triggerServerEvent ( "onBotFindEnemy", source, attacker) 
				else
					setElementData ( source, "target", attacker )
				end
			else
				--same team
			end		
		end
	end
	if (isElement(attacker)) then
		local theTeam = getElementData(attacker, "BotTeam")
		if (isElement(theTeam)) then
			if ( getTeamFriendlyFire ( theTeam ) == false ) then
				if (getElementType ( attacker ) == "ped") then
					if (getElementData ( attacker, "BotTeam" ) == theTeam) then
						cancelEvent() --cancel the event
					end
				elseif (getElementType ( attacker ) == "player") then
					if getPlayerTeam(attacker) == theTeam then
						cancelEvent() --cancel the event
					end
				end
			end
		end
	end
end
addEventHandler ( "onClientPedDamage", getRootElement(), aidamage )

--used to help the server functions decide what node to send a ped by checking line of sight (this only gets triggered for the closest player)
addEvent( "pedPathfind", true )
function pedPathSearch (ped)
	local distToBeat = 9999
	local firstTarget = nil
	local px,py,pz = getElementPosition( ped )
	local allwaypoints = getElementsByType ( "pathpoint" )
	for PKey,theNode in ipairs(allwaypoints) do --first pass to find closes node in sight.
		local wx,wy,wz = getElementPosition( theNode )
		local distance = (getDistanceBetweenPoints3D( px, py, pz, wx, wy, wz ))
		if distance < distToBeat then
			if isLineOfSightClear (px, py, pz+.6, wx, wy, wz+.6, true, false, false, true, false, false, false) then
				distToBeat = distance
				firstTarget = theNode
			end
		end
	end
	triggerServerEvent ( "pedPathChoose", ped, ped, firstTarget ) -- passes along the closest target node, or nothing if none exist in sight
end
addEventHandler("pedPathfind", getRootElement(), pedPathSearch)

--sets rotation and tells the server when a target is in sight
function follow_move (ped, oldTx, oldTy, oldTz, oldPx, oldPy, oldPz)
	if (isElement(ped)) then
		local thetarget = getElementData ( ped, "leader" )
		if (getElementData ( ped, "status" ) ==  "following" ) and (isElement(thetarget)) and (getElementData (ped, "slothbot") == true) then
			local pedhp = getElementHealth ( ped )
			local tarhp = getElementHealth ( thetarget )
			if pedhp > 0 and tarhp > 0 then
				if (getElementData (ped, "follow_shooting") == true) then -- if the ped is busy shooting at an enemy
					setTimer ( follow_move, 1300, 1, ped, oldTx ,oldTy ,oldTz, px, py, pz)
				else
					local tx,ty,tz = getElementPosition( thetarget )
					local px,py,pz = getElementPosition( ped )
					local isclear = isLineOfSightClear (px, py, pz+.6, tx, ty, tz+.6, true, false, false, true, false, false, false)
					if (isclear == true) then -- if the ped can see the target
						local angle = ( 360 - math.deg ( math.atan2 ( ( tx - px ), ( ty - py ) ) ) ) % 360 --set the peds angle to the target
						setPedRotation( ped, angle )
						setElementData ( ped, "seestarget", true )
						setTimer ( follow_move, 700, 1, ped, tx ,ty ,tz, px, py, pz)
					else
						local angle = ( 360 - math.deg ( math.atan2 ( ( oldTx - px ), ( oldTy - py ) ) ) ) % 360 --set the peds angle to the target
						setPedRotation( ped, angle )
						setElementData ( ped, "seestarget", false )
						setTimer ( follow_move, 700, 1, ped, oldTx ,oldTy ,oldTz, px, py, pz)
					end
				end
			end
		end
	end
end

--sets aim while in follow mode (possible a redundant function, might combine with chase_aim)
function follow_aim(ped)
	if (isElement(ped)) then
		local enemy = getElementData ( ped, "target" )
		if (getElementData ( ped, "status" ) ==  "following" ) and (getElementData (ped, "slothbot") == true) then
			if (isElement(enemy)) then
				if getElementType(enemy) == "player" then -- if the enemy is a player
					local pedhp = getElementHealth ( ped )
					if pedhp > 0 and (isPedDead(enemy) == false) then -- if both parties are alive
						local x,y,z = getElementPosition( enemy )
						local ex,ey,ez = getElementPosition( ped )
						local isclear = isLineOfSightClear (ex, ey, ez+.6, x, y, z+.6, true, false, false, true, false, false, false)

						if (isclear == true) then -- if the enemy target is in sight
							if isPedDucked(enemy) then
								setPedAimTarget ( ped, x, y, z-0.0 )
							else
								setPedAimTarget ( ped, x, y, z )
							end
						end
						setTimer ( follow_aim, 80, 1, ped ) -- aim again in a short time
					else
						setTimer ( follow_aim, 1000, 1, ped )
					end
				elseif getElementType(enemy) == "ped" then -- if the target is a ped
					local pedhp = getElementHealth ( ped )
					if pedhp > 0 and (getElementHealth(enemy) > 0) then -- if both parties are alive
						local x,y,z = getElementPosition( enemy )
						local ex,ey,ez = getElementPosition( ped )
						local isclear = isLineOfSightClear (ex, ey, ez+.6, x, y, z+.6, true, false, false, true, false, false, false) 
						
						local isattached = isElementAttached(ped)
						local botveh
						if isattached then botveh = getElementAttachedTo(ped) end
						local thetarget = getPedTarget(ped)
						if thetarget == botveh then isclear = false end
						
						if (isclear == true) then -- if the player target is in sight
							if isPedDucked(enemy) then
								setPedAimTarget ( ped, x, y, z-0.0 )
							else
								setPedAimTarget ( ped, x, y, z )
							end
						end
						setTimer ( follow_aim, 80, 1, ped)
					else
						setTimer ( follow_aim, 1000, 1, ped)
					end
				end
			else
				setTimer ( follow_aim, 1000, 1, ped )
			end
		end
	end
end

--looks for targets while in follow mode (only runs for the controller of the ped)
function follow_enemy_check (ped)
	if (isElement(ped)) then
		if ( getElementData ( ped, "status" ) == "following" ) and (getElementHealth(ped)>0) and (getElementData (ped, "slothbot") == true) then
			if (getElementData ( ped, "controller" ) == getLocalPlayer()) then
				local Px,Py,Pz = getElementPosition( ped )
				local BSx,BSy,BSz = getElementPosition(getElementData(ped,"backSide")) --ZZ

				if isPedDucked ( ped ) then
					local Pz = Pz-1
				end
				local btarget = (getElementData ( ped, "target" ))
				if (isElement(btarget)) then
					local x,y,z = getElementPosition( btarget )
					local isclear = isLineOfSightClear (Px, Py, Pz+.6, x, y, z +.6, true, false, false, true, false, false,
							false )
					local distance = (getDistanceBetweenPoints3D (Px, Py, Pz, x, y, z))

					local isattached = isElementAttached(ped)
					local botveh
					if isattached then botveh = getElementAttachedTo(ped) end
					local thetarget = getPedTarget(ped)
					if thetarget == botveh then isclear = false end

					if (isclear == true) and (distance < 75) and (getElementHealth(btarget)>0) then
						followshoot(ped)--SHOOT AT THE TARGET
					end
				else
					setElementData ( ped, "target", nil )
					local enemies = getElementsByType ( "player" )
					local foundone = 0
					for theKey,thePlayer in ipairs(enemies) do
						if (isPedDead(thePlayer) == false) then
							local x,y,z = getElementPosition( thePlayer )
							local isclear = isLineOfSightClear (Px, Py, Pz+.6, x, y, z +.6, true, false, false, true, false, false, false )
							local distance = (getDistanceBetweenPoints3D (Px, Py, Pz, x, y, z))

							local isattached = isElementAttached(ped)
							local botveh
							if isattached then botveh = getElementAttachedTo(ped) end
							local thetarget = getPedTarget(ped)
							if thetarget == botveh then isclear = false end

							if (isclear == true) and (distance < 75) and getDistToElement(thePlayer) < getDistanceBetweenPoints3D(BSx,BSy,BSz,x,y,z) then --if a player is in line of sight and within range --RANGE IN WICH BOTS GO AGGRO --ZZ
								if (getPlayerTeam(thePlayer) == false) and (getElementHealth(thePlayer)>0) then
									setElementData ( ped, "target", thePlayer )
									followshoot(ped)--SHOOT AT NEW TARGET
									foundone = 1
								elseif (getElementData ( ped, "BotTeam" ) ~= getPlayerTeam (thePlayer)) and (getElementHealth(thePlayer)>0) then
									setElementData ( ped, "target", thePlayer )
									followshoot(ped)--SHOOT AT NEW TARGET
									foundone = 1
								else
									--on the same team
								end
							end
						end
					end
					if foundone == 0 then
						local enemybots = getElementsByType ( "ped" )
						for theKey,theBot in ipairs(enemybots) do
							if (getElementHealth(theBot)>0) and (theBot ~= ped) then
								local x,y,z = getElementPosition( theBot )
								local isclear = isLineOfSightClear (Px, Py, Pz+.6, x, y, z +.6, true, false, false, true, false, false, false )
								local distance = (getDistanceBetweenPoints3D (Px, Py, Pz, x, y, z))
								if (isclear == true) and (distance < 75) then --if a player is in line of sight and within range --RANGE IN WICH BOTS GO AGGRO
									if (getElementData ( ped, "BotTeam" ) == false) and (getElementHealth(theBot)>0) then
										setElementData ( ped, "target", theBot )
										followshoot(ped)--SHOOT AT NEW TARGET
										foundone = 1
									elseif (getElementData ( ped, "BotTeam" )) ~= (getElementData ( theBot, "BotTeam" )) and (getElementHealth(theBot)>0) then
										setElementData ( ped, "target", theBot )
										followshoot(ped)--SHOOT AT NEW TARGET
										foundone = 1
									else
										--on the same team
									end
								end
							end
						end			
					end
				end
				setTimer ( follow_enemy_check, 900 ,1 , ped)
			else
				setTimer ( follow_enemy_check, 2000 ,1 , ped)
			end
		end
	end
end

--tells the bot to shoot while in follow mode
function followshoot(ped)
	setElementData ( ped, "follow_shooting", true )
	local btarget = (getElementData ( ped, "target" ))
	local Px,Py,Pz = getElementPosition( ped )
	local x,y,z = getElementPosition( btarget )
	setPedAimTarget ( ped, x, y, z )
	local angle = ( 360 - math.deg ( math.atan2 ( ( x - Px ), ( y - Py ) ) ) ) % 360 --set the peds angle to the target
	setPedRotation( ped, angle )
						--------------------************************************
						if isPedDucked(btarget) then
								setPedAimTarget ( ped, x, y, z-0.0 )
							else
								setPedAimTarget ( ped, x, y, z )
						end
						--------------------************************************
	local distance = (getDistanceBetweenPoints3D (Px, Py, Pz, x, y, z))
	if (getPedWeapon(ped) < 19)  and (getPedWeapon(ped) ~= 9) then -- if its a melee weapon that isnt a chainsaw
		if (distance < 2 ) then
			triggerServerEvent ( "pedShootTrigger", ped, "melee" )
			if isElement(ped) then setTimer ( function (ped) if isElement(ped) then setElementData(ped,"follow_shooting",false ) end end, 2100, 1,ped ) end
		end
	elseif (getPedWeapon(ped) == 9) then -- if it is a chainsaw (watch out, the peds are deadly with these)
		if (distance < 2 ) then
			local length = 1500
			triggerServerEvent ( "pedShootTrigger", ped, "chainsawA", length )
			if isElement(ped) then setTimer ( setElementData, length+100, 1, ped, "follow_shooting", false ) end
		else
			local length = math.random( 2100, 5500 )
			triggerServerEvent ( "pedShootTrigger", ped, "chainsawB", length )
			if isElement(ped) then setTimer ( setElementData, length+100, 1, ped, "follow_shooting", false ) end
		end
	elseif (getPedWeapon(ped) == 22) then
		if (distance < 35 ) then
			local length = math.random( 2100, 5500 )
			triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
			if isElement(ped) then setTimer ( setElementData, length+100, 1, ped, "follow_shooting", false ) end
		end
	elseif (getPedWeapon(ped) == 23) then
		if (distance < 35 ) then
			local length = math.random( 2000, 5500 )
			triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
			if isElement(ped) then setTimer ( setElementData, length+100, 1, ped, "follow_shooting", false ) end
		end
	elseif (getPedWeapon(ped) == 24) then
		if (distance < 35 ) then
			local length = math.random( 2000, 5500 )
			triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
			if isElement(ped) then setTimer ( setElementData, length+100, 1, ped, "follow_shooting", false ) end
		end
	elseif (getPedWeapon(ped) == 25) then
		if (distance < 27 ) then
			local length = 300
			triggerServerEvent ( "pedShootTrigger", ped, "gun", length)
			if isElement(ped) then setTimer ( setElementData, length+100, 1, ped, "follow_shooting", false ) end
		end
	elseif (getPedWeapon(ped) == 26) then
		if (distance < 20 ) then
			local length = 1200
			triggerServerEvent ( "pedShootTrigger", ped, "gun", length)
			if isElement(ped) then setTimer ( setElementData, length+100, 1, ped, "follow_shooting", false ) end
		end
	elseif (getPedWeapon(ped) == 27) then
		if (distance < 25 ) then
			local length = 1200
			triggerServerEvent ( "pedShootTrigger", ped, "gun", length)
			if isElement(ped) then setTimer ( setElementData, length+100, 1, ped, "follow_shooting", false ) end
		end
	elseif (getPedWeapon(ped) == 28) then
		if (distance < 40 ) then
			local length = math.random( 2100, 5500 )
			triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
			if isElement(ped) then setTimer ( setElementData, length+100, 1, ped, "follow_shooting", false ) end
		end
	elseif (getPedWeapon(ped) == 29) then
		if (distance < 55 ) then
			local length = math.random( 2000, 5500 )
			triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
			if isElement(ped) then setTimer ( setElementData, length+100, 1, ped, "follow_shooting", false ) end
		end
	elseif (getPedWeapon(ped) == 30) then
		if (distance < 60 ) then
			local length = math.random( 2000, 5500 )
			triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
			if isElement(ped) then setTimer ( setElementData, length+100, 1, ped, "follow_shooting", false ) end
		end
	elseif (getPedWeapon(ped) == 31) then
		if (distance < 60 ) then
			local length = 700
			triggerServerEvent ( "pedShootTrigger", ped, "gun", length)
			if isElement(ped) then setTimer ( setElementData, length+100, 1, ped, "follow_shooting", false ) end
		end
	elseif (getPedWeapon(ped) == 32) then
		if (distance < 30 ) then
			local length = math.random( 2000, 5500 )
			triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
			if isElement(ped) then setTimer ( setElementData, length+100, 1, ped, "follow_shooting", false ) end
		end
	elseif (getPedWeapon(ped) == 33) then
		if (distance < 75 ) then
			local length = 400
			triggerServerEvent ( "pedShootTrigger", ped, "gun", length)
			if isElement(ped) then setTimer ( setElementData, length+100, 1, ped, "follow_shooting", false ) end
		end
	elseif (getPedWeapon(ped) == 34) then
		if (distance < 75 ) then
			triggerServerEvent ( "pedShootTrigger", ped, "sniper")
			if isElement(ped) then setTimer ( setElementData, 1000, 1, ped, "follow_shooting", false ) end
		end
	elseif (getPedWeapon(ped) == 37) then
		if (distance < 15 ) then
			local length = math.random( 2000, 5500 )
			triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
			if isElement(ped) then setTimer ( setElementData, length+100, 1, ped, "follow_shooting", false ) end
		end
	elseif (getPedWeapon(ped) == 38) then
		if (distance < 65 ) then
			local length = math.random( 2000, 5500 )
			triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
			if isElement(ped) then setTimer ( setElementData, length+100, 1, ped, "follow_shooting", false ) end
		end
	elseif (getPedWeapon(ped) == 41) then
		if (distance < 4 ) then
			local length = math.random( 2000, 5500 )
			triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
			if isElement(ped) then setTimer ( setElementData, length+100, 1, ped, "follow_shooting", false ) end
		end
	elseif (getPedWeapon(ped) == 42) then
		if (distance < 8 ) then
			local length = math.random( 2000, 5500 )
			triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
			if isElement(ped) then setTimer ( setElementData, length+100, 1, ped, "follow_shooting", false ) end
		end
	end
end

--functions below are for when a player shoots a gun, it draws attention of nearby peds.
function shootingnoise ( weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement)
	if alertspacer ~= 1 then
		if (weapon == 9) then
			alertspacer = 1
			setTimer ( resetalertspacer, 5000, 1 )
			noiseradiusalert(getLocalPlayer ())
		elseif (weapon > 21) and (weapon ~= 23) and (weapon < 39) then
			alertspacer = 1
			setTimer ( resetalertspacer, 5000, 1 )
			noiseradiusalert(getLocalPlayer ())
		end
	end
end
addEventHandler ( "onClientPlayerWeaponFire", getLocalPlayer (), shootingnoise )

function resetalertspacer2 ()
	alertspacer2 = nil
end

function panicCiviliansAround (theElement)
	local Px,Py,Pz = getElementPosition( theElement )
	local aipeds = getElementsByType ( "ped" )
	for theKey,thePed in ipairs(aipeds) do
			if ( getElementData ( thePed, "type" ) == "civilian" ) and (getElementData (thePed, "slothbot") ~= true) then
				if getElementHealth(thePed)>0  then
					local Ax,Ay,Az = getElementPosition( thePed )
					local distance = (getDistanceBetweenPoints3D (Px, Py, Pz, Ax, Ay, Az))
					if (distance < 30) then -- distance where where somebody triggers civilian panic around
						if isElement(thePed) then setElementData(thePed,"panic",true,true) end
						triggerEvent("sync.message", root, thePed, 255, 50, 0, "PANIC")
						if isElement(thePed) then setTimer(setElementData,60000,1,thePed,"panic",false,true) end
					end
				end
			end
			
		
	end
end

function panicCiviliansOnAttack ( attacker, weap, bodypart)
	if not attacker then return end 
		if alertspacer2 ~= 1 then
			alertspacer2 = 1
			setTimer ( resetalertspacer2, 5000, 1 )
			panicCiviliansAround(source)
		end
end
addEventHandler ( "onClientPedDamage", root, panicCiviliansOnAttack )
addEventHandler ( "onClientPlayerDamage", localPlayer, panicCiviliansOnAttack )

function resetThreatenedStatus ()
if source and getElementData(source,"threatened") then setElementData(source,"threatened",false,true) end
end
addEventHandler ( "onClientPedDamage", root, resetThreatenedStatus )

function resetalertspacer ()
	alertspacer = nil
end

function noiseradiusalert (theElement)
	local Px,Py,Pz = getElementPosition( theElement )
	local aipeds = getElementsByType ( "ped" )
	for theKey,thePed in ipairs(aipeds) do
		if (isElement(thePed)) and (getElementData (thePed, "slothbot") == true) then
			if ( getElementData ( thePed, "status" ) == "hunting" ) or ( getElementData ( thePed, "status" ) == "waiting" ) or ( getElementData ( thePed, "status" ) == "guarding" ) then
				if (getElementType ( theElement ) == "player" and (getElementHealth(thePed)>0) ) then
					local Ax,Ay,Az = getElementPosition( thePed )
					local distance = (getDistanceBetweenPoints3D (Px, Py, Pz, Ax, Ay, Az))
					if (distance < 75) and ( isPedDead (theElement) == false ) then -- distance where shooting triggers bot aggro
						if getPlayerTeam(theElement) == false then
						setPedAnimation ( thePed, "ped", "flee_lkaround_01", -1, true, true, true )
							setTimer(triggerServerEvent,1500,1, "onBotFindEnemy", thePed, theElement)
						elseif (getElementData ( thePed, "BotTeam" ) ~= getPlayerTeam (theElement)) then
							setPedAnimation ( thePed, "ped", "flee_lkaround_01", -1, true, true, true )
							setTimer(triggerServerEvent,1500,1, "onBotFindEnemy", thePed, theElement) 
						end
					end
				end
			end
			
			if ( getElementData ( thePed, "type" ) == "civilian" ) then
				if getElementHealth(thePed)>0 and (getElementData (thePed, "slothbot") ~= true) then
					local Ax,Ay,Az = getElementPosition( thePed )
					local distance = (getDistanceBetweenPoints3D (Px, Py, Pz, Ax, Ay, Az))
					if (distance < 75) and ( isPedDead (theElement) == false ) then -- distance where shooting triggers civilian panic
						setElementData(thePed,"panic",true,true)
					end
				end
			end
			
		end
	end
end



--the following 3 functions set the ped controls when the server dictates
addEvent( "bot_Jump", true )
function Bjump ( ped )
	if (isElement(source)) then
	if getElementData(source, "laser.aim") then setElementData(source,"laser.aim",false,true) end
		setPedControlState( source, "jump", true )
		setTimer ( function (source) if ( isElement ( source ) ) then setPedControlState ( source, "jump", false) end end, 800, 1, source )
	end
end
addEventHandler( "bot_Jump", getRootElement(), Bjump )

addEvent( "bot_Forwards", true )
function Bforward ()

	if (isElement(source)) then
	if getElementData(source, "laser.aim") then setElementData(source,"laser.aim",false,true) end
		setPedControlState( source, "forwards", true )
	end
end
addEventHandler( "bot_Forwards", getRootElement(), Bforward )

addEvent( "bot_Stop", true )
function Bstop ( )

	if (isElement(source)) then
	if getElementData(source, "laser.aim") then setElementData(source,"laser.aim",false,true) end
		setPedControlState( source, "forwards", false )
	end
end
addEventHandler( "bot_Stop", getRootElement(), Bstop )

--this function keeps the ped running towards whatever element is set as its "targetpath" elementdata
function hunt_move (ped,oldX,oldY,oldZ) 
	if (isElement(ped)) then
		if (getElementData ( ped, "status" ) == "hunting" ) and (getElementData (ped, "slothbot") == true) then
			local pedhp = getElementHealth ( ped )
			if pedhp > 0 then
				local target = getElementData( ped, "targetpath")
				if (isElement(target)) then
					local tx,ty,tz = getElementPosition( target )
					local px,py,pz = getElementPosition( ped )
					local angle = ( 360 - math.deg ( math.atan2 ( ( tx - px ), ( ty - py ) ) ) ) % 360
					setPedRotation( ped, angle )
					setTimer ( hunt_move, 700, 1, ped, px ,py ,pz)
				else
					setTimer ( hunt_move, 700, 1, ped, px ,py ,pz)
				end
			else
			if getElementData(ped, "laser.aim") then setElementData(ped,"laser.aim",false,true) end
			end
		end
	end
end

--this is to correct the problem that unstreamed peds loose all but 1 bullet for the local player
function Streamin ()
	if getElementData (source, "slothbot") == true then
		local theweapon = getElementData ( source, "BotWeapon" )		
		triggerServerEvent ( "StreamWeapon", source, theweapon)
		givePedWeapon(source,theweapon,999999,true)
	end		
end
addEventHandler( "onClientElementStreamIn", getRootElement(), Streamin )

function wait_enemy_check (ped)
	if (isElement(ped)) then
		if ( getElementData ( ped, "status" ) == "waiting" ) and (getElementHealth(ped)>0) and (getElementData (ped, "slothbot") == true) then	
			if (getElementData ( ped, "controller" ) == getLocalPlayer()) then
				local Px,Py,Pz = getElementPosition( ped )
				local BSx,BSy,BSz = getElementPosition(getElementData(ped,"backSide"))
				if isPedDucked ( ped ) then
					local Pz = Pz-1
				end
				local enemies = getElementsByType ( "player" )
				local foundone = 0
				for theKey,thePlayer in ipairs(enemies) do
					if (isPedDead(thePlayer) == false) then
						local x,y,z = getElementPosition( thePlayer )
						local isclear = isLineOfSightClear (Px, Py, Pz+.6, x, y, z +.6, true, false, false, true, false, false, false )
						local distance = (getDistanceBetweenPoints3D (Px, Py, Pz, x, y, z))


						local isattached = isElementAttached(ped)
						local botveh
						if isattached then botveh = getElementAttachedTo(ped) end
						local thetarget = getPedTarget(ped)
						if thetarget == botveh then isclear = false end

						if (isclear == true) and (distance < 75) and  getDistToElement(thePlayer) < getDistanceBetweenPoints3D(BSx,BSy,BSz,x,y,z) then --if a player is in line of sight and within range --ZZ
							if getPlayerTeam(thePlayer) == false then
								triggerServerEvent ( "onBotFindEnemy", ped, thePlayer)
								foundone = 1
							elseif (getElementData ( ped, "BotTeam" ) ~= getPlayerTeam (thePlayer)) then
								triggerServerEvent ( "onBotFindEnemy", ped, thePlayer) 
								foundone = 1
							else
								if (distance < 28) and getElementData(ped,"type")~= "civilian" then
									triggerServerEvent ( "TeamBot", ped, ped, thePlayer)
								end
								--on the same team
							end
						end
					end
				end
				if foundone == 0 then
					local enemybots = getElementsByType ( "ped" )
					for theKey,theBot in ipairs(enemybots) do
						if (getElementHealth(theBot)>0) and (theBot ~= ped) then
							local x,y,z = getElementPosition( theBot )
							local isclear = isLineOfSightClear (Px, Py, Pz+.6, x, y, z +.6, true, false, false, true, false, false, false )
							local distance = (getDistanceBetweenPoints3D (Px, Py, Pz, x, y, z))

							local isattached = isElementAttached(ped)
							local botveh
							if isattached then botveh = getElementAttachedTo(ped) end
							local thetarget = getPedTarget(ped)
							if thetarget == botveh then isclear = false end

							if (isclear == true) and (distance < 75) then --if a player is in line of sight and within range
								if (getElementData ( ped, "BotTeam" ) == false) then
									triggerServerEvent ( "onBotFindEnemy", ped, theBot)
									foundone = 1
								elseif (getElementData ( ped, "BotTeam" )) ~= (getElementData ( theBot, "BotTeam" )) then
									triggerServerEvent ( "onBotFindEnemy", ped, theBot) 
									foundone = 1
								else
									--on the same team
									if (distance < 15) and getElementData(ped,"type")~= "civilian" then
										triggerServerEvent ( "TeamBot", ped, ped, theBot )
									end
								end
							end
						end
					end			
				end
				setTimer ( wait_enemy_check, 500 ,1 , ped)
			else
				setTimer ( wait_enemy_check, 2000 ,1 , ped)
			end	
		end
	end
end

function guard_enemy_check (ped)
	if (isElement(ped)) then
		if ( getElementData ( ped, "status" ) == "guarding" ) and (getElementHealth(ped)>0) and (getElementData (ped, "slothbot") == true) then
			if (getElementData ( ped, "controller" ) == getLocalPlayer()) then
				local Px,Py,Pz = getElementPosition( ped )
				local BSx,BSy,BSz = getElementPosition(getElementData(ped,"backSide")) --ZZ

				if isPedDucked ( ped ) then
					local Pz = Pz-1
				end
				local btarget = (getElementData ( ped, "target" ))
				if (isElement(btarget)) then
					local x,y,z = getElementPosition( btarget )
					local isclear = isLineOfSightClear (Px, Py, Pz+.6, x, y, z +.6, true, false, false, true, false, false, false )
					local distance = (getDistanceBetweenPoints3D (Px, Py, Pz, x, y, z))

					local isattached = isElementAttached(ped)
					local botveh
					if isattached then botveh = getElementAttachedTo(ped) end
					local thetarget = getPedTarget(ped)
					if thetarget == botveh then isclear = false end

					if (isclear == true) and (distance < 100) and (getElementHealth(btarget)>0) then
						guardshoot(ped)--SHOOT AT THE TARGET
					end
				else
					setElementData ( ped, "target", nil )
					local enemies = getElementsByType ( "player" )
					local foundone = 0
					for theKey,thePlayer in ipairs(enemies) do
						if (isPedDead(thePlayer) == false) then
							local x,y,z = getElementPosition( thePlayer )
							local isclear = isLineOfSightClear (Px, Py, Pz+.6, x, y, z +.6, true, false, false, true, false, false, false )
							local distance = (getDistanceBetweenPoints3D (Px, Py, Pz, x, y, z))

							local isattached = isElementAttached(ped)
							local botveh
							if isattached then botveh = getElementAttachedTo(ped) end
							local thetarget = getPedTarget(ped)
							if thetarget == botveh then isclear = false end

							if (isclear == true) and
							(distance < 100) and 
							--[[getDistToElement(thePlayer)]] distance < getDistanceBetweenPoints3D(BSx,BSy,BSz,x,y,z) then --if a player is in line of sight and within range --ZZ
								if (getPlayerTeam(thePlayer) == false) and (getElementHealth(thePlayer)>0) then
									setElementData ( ped, "target", thePlayer )
									guardshoot(ped)--SHOOT AT NEW TARGET
									foundone = 1
								elseif (getElementData ( ped, "BotTeam" ) ~= getPlayerTeam (thePlayer)) and (getElementHealth(thePlayer)>0) then
									setElementData ( ped, "target", thePlayer )
									guardshoot(ped)--SHOOT AT NEW TARGET
									foundone = 1
								else
									--on the same team
								end
							end
						end
					end
					if foundone == 0 then
						local enemybots = getElementsByType ( "ped" )
						for theKey,theBot in ipairs(enemybots) do
							if (getElementHealth(theBot)>0) and (theBot ~= ped) then
								local x,y,z = getElementPosition( theBot )
								local isclear = isLineOfSightClear (Px, Py, Pz+.6, x, y, z +.6, true, false, false, true, false, false, false )

								local isattached = isElementAttached(theBot)
								local botveh
								if isattached then botveh = getElementAttachedTo(theBot) end
								local thetarget = getPedTarget(theBot)
								if thetarget == botveh then isclear = false end

								local distance = (getDistanceBetweenPoints3D (Px, Py, Pz, x, y, z))
								if (isclear == true) and (distance < 100) then --if a player is in line of sight and within range
									if (getElementData ( ped, "BotTeam" ) == false) and (getElementHealth(theBot)>0) then
										setElementData ( ped, "target", theBot )
										guardshoot(ped)--SHOOT AT NEW TARGET
										foundone = 1
									elseif (getElementData ( ped, "BotTeam" )) ~= (getElementData ( theBot, "BotTeam" )) and (getElementHealth(theBot)>0) then
										setElementData ( ped, "target", theBot )
										guardshoot(ped)--SHOOT AT NEW TARGET
										foundone = 1
									else
										--on the same team
									end
								end
							end
						end			
					end
				end
				setTimer ( guard_enemy_check, 900 ,1 , ped)
			else
				setTimer ( guard_enemy_check, 2000 ,1 , ped)
			end
		end
	end
end

--tells the bot to shoot while in guard mode
function guardshoot(ped)

if isElementStreamedIn(ped)== false then return end --ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ

	if (getElementData( ped, "forcedmoving" ) ~= true) then
		setElementData ( ped, "guard_shooting", true )
		local btarget = (getElementData ( ped, "target" ))
		local Px,Py,Pz = getElementPosition( ped )
		local x,y,z = getElementPosition( btarget )
		setPedAimTarget ( ped, x, y, z )
		local angle = ( 360 - math.deg ( math.atan2 ( ( x - Px ), ( y - Py ) ) ) ) % 360 --set the peds angle to the target
		setPedRotation( ped, angle )
		local distance = (getDistanceBetweenPoints3D (Px, Py, Pz, x, y, z))
		
		if getElementData(ped, "laser.on") and getPedAmmoInClip(ped) == 0 and getElementData(ped, "laser.aim") then 
			setElementData(ped,"laser.aim",false,true) 
		elseif getElementData(ped, "laser.on") and not getElementData(ped, "laser.aim") then 
			setElementData(ped,"laser.aim",true,true)
		end
		
						--------------------************************************
						if isPedDucked(btarget) then
								setPedAimTarget ( ped, x, y, z-0.0 )
							else
								setPedAimTarget ( ped, x, y, z )
						end
						--------------------************************************
		
--[[		if getElementData(ped, "laser.on") and not getElementData(ped, "laser.aim") then setElementData(ped,"laser.aim",true,true) end]]
		
		if (getPedWeapon(ped) < 19)  and (getPedWeapon(ped) ~= 9) then -- if its a melee weapon that isnt a chainsaw
			if (distance < 2 ) then
				triggerServerEvent ( "pedShootTrigger", ped, "melee" )
				setTimer ( setElementData, 2100, 1, ped, "guard_shooting", false )
			end
		elseif (getPedWeapon(ped) == 9) then -- if it is a chainsaw (watch out, the peds are deadly with these)
			if (distance < 2 ) then
				local length = 1500
				triggerServerEvent ( "pedShootTrigger", ped, "chainsawA", length )
				setTimer ( setElementData, length+100, 1, ped, "guard_shooting", false )
			else
				local length = math.random( 2100, 5500 )
				triggerServerEvent ( "pedShootTrigger", ped, "chainsawB", length )
				setTimer ( setElementData, length+100, 1, ped, "guard_shooting", false )
			end
		elseif (getPedWeapon(ped) == 22) then
			if (distance < 35 ) then
				local length = math.random( 2100, 5500 )
				triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
				setTimer ( setElementData, length+100, 1, ped, "guard_shooting", false )
			end
		elseif (getPedWeapon(ped) == 23) then
			if (distance < 35 ) then
				local length = math.random( 2000, 5500 )
				triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
				setTimer ( setElementData, length+100, 1, ped, "guard_shooting", false )
			end
		elseif (getPedWeapon(ped) == 24) then
			if (distance < 35 ) then
				local length = math.random( 2000, 5500 )
				triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
				setTimer ( setElementData, length+100, 1, ped, "guard_shooting", false )
			end
		elseif (getPedWeapon(ped) == 25) then
			if (distance < 27 ) then
				local length = 300
				triggerServerEvent ( "pedShootTrigger", ped, "gun", length)
				setTimer ( setElementData, length+100, 1, ped, "guard_shooting", false )
			end
		elseif (getPedWeapon(ped) == 26) then
			if (distance < 20 ) then
				local length = 1200
				triggerServerEvent ( "pedShootTrigger", ped, "gun", length)
				setTimer ( setElementData, length+100, 1, ped, "guard_shooting", false )
			end
		elseif (getPedWeapon(ped) == 27) then
			if (distance < 25 ) then
				local length = 1200
				triggerServerEvent ( "pedShootTrigger", ped, "gun", length)
				setTimer ( function() if isElement(ped) then setElementData(ped, "guard_shooting", false ) end end, length+100, 1)
			end
		elseif (getPedWeapon(ped) == 28) then
			if (distance < 40 ) then
				local length = math.random( 2100, 5500 )
				triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
				setTimer ( setElementData, length+100, 1, ped, "guard_shooting", false )
			end
		elseif (getPedWeapon(ped) == 29) then
			if (distance < 55 ) then
				local length = math.random( 2000, 5500 )
				triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
				setTimer ( function() if isElement(ped) then setElementData(ped, "guard_shooting", false) end end, length+100, 1)
			end
		elseif (getPedWeapon(ped) == 30) then
			if (distance < 60 ) then
				local length = math.random( 2000, 5500 )
				triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
				setTimer ( setElementData, length+100, 1, ped, "guard_shooting", false )
			end
		elseif (getPedWeapon(ped) == 31) then
			if (distance < 60 ) then
				local length = 700
				triggerServerEvent ( "pedShootTrigger", ped, "gun", length)
				setTimer ( setElementData, length+100, 1, ped, "guard_shooting", false )
			end
		elseif (getPedWeapon(ped) == 32) then
			if (distance < 30 ) then
				local length = math.random( 2000, 5500 )
				triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
				setTimer ( setElementData, length+100, 1, ped, "guard_shooting", false )
			end
		elseif (getPedWeapon(ped) == 33) then
			if (distance < 75 ) then
				local length = 400
				triggerServerEvent ( "pedShootTrigger", ped, "gun", length)
				setTimer ( setElementData, length+100, 1, ped, "guard_shooting", false )
			end
		elseif (getPedWeapon(ped) == 34) then
			if (distance < 75 ) then
				triggerServerEvent ( "pedShootTrigger", ped, "sniper")
				setTimer ( setElementData, 1000, 1, ped, "guard_shooting", false )
			end
		elseif (getPedWeapon(ped) == 37) then
			if (distance < 15 ) then
				local length = math.random( 2000, 5500 )
				triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
				setTimer ( setElementData, length+100, 1, ped, "guard_shooting", false )
			end
		elseif (getPedWeapon(ped) == 38) then
			if (distance < 65 ) then
				local length = math.random( 2000, 5500 )
				triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
				setTimer ( setElementData, length+100, 1, ped, "guard_shooting", false )
			end
		elseif (getPedWeapon(ped) == 41) then
			if (distance < 4 ) then
				local length = math.random( 2000, 5500 )
				triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
				setTimer ( setElementData, length+100, 1, ped, "guard_shooting", false )
			end
		elseif (getPedWeapon(ped) == 42) then
			if (distance < 8 ) then
				local length = math.random( 2000, 5500 )
				triggerServerEvent ( "pedShootTrigger", ped, "gun", length )
				setTimer ( setElementData, length+100, 1, ped, "guard_shooting", false )
			end
		end
	end
end

function guard_move(ped)
	if (isElement(ped)) then
		if ( getElementData ( ped, "status" ) == "guarding" ) and (getElementHealth(ped)>0) and (getElementData (ped, "slothbot") == true) then
			local guardcol = getElementData ( ped, "guardcol" )
			if (isElement(guardcol)) then
				if (getElementData (ped, "guard_shooting") == true) then -- if the ped is busy shooting at an enemy
					setTimer ( guard_move, 1200, 1, ped)
				else
					local x,y,z = getElementPosition( guardcol )
					local px,py,pz = getElementPosition( ped )
					local angle = ( 360 - math.deg ( math.atan2 ( ( x - px ), ( y - py ) ) ) ) % 360
					setPedRotation( ped, angle )
					setTimer ( guard_move, 800 ,1 , ped)
				end
			end
		end
	end		
end

resourceRoot = getResourceRootElement()

function resourcestart()
	local players = getElementsByType ( "player" )
	if #players == 1 then
		local peds = getElementsByType ( "ped" )
		for theKey,thePed in ipairs(peds) do
			if (getElementData (thePed, "slothbot") == true) then
				triggerServerEvent ( "onClientSetBotController", thePed, thePed )
				local pedstatus = getElementData ( thePed, "stasisstatus" )
				if (pedstatus ~= false) then
					setElementData ( thePed, "status", pedstatus )
					setElementData ( thePed, "stasisstatus", nil )
				else
					setElementData ( thePed, "status", "hunting")
				end
			end
		end
	else
		local peds = getElementsByType ( "ped" )
		for theKey,thePed in ipairs(peds) do
			if (getElementData ( thePed, "status" ) == "chasing" ) then
				local player = getElementData ( thePed, "target" )
				if player and thePed then 
				local oldTx, oldTy, oldTz = getElementPosition( player )
				local oldPx, oldPy, oldPz = getElementPosition( thePed )
				setTimer ( chase_aim, 80, 1, thePed)
				setTimer ( chase_move, 700, 1, thePed, oldTx, oldTy, oldTz, oldPx, oldPy, oldPz )
				setTimer ( chase_shoot, 1500, 1, thePed )
				end
			elseif (getElementData ( thePed, "status" ) == "hunting" ) then
				local oldPx, oldPy, oldPz = getElementPosition( thePed )
				setTimer ( enemy_check, 600 ,1 , thePed )-- starts scanning for enemies
				setTimer ( hunt_move, 800, 1, thePed, oldPx, oldPy, oldPz, oldPx, oldPy, oldPz )
			elseif (getElementData ( thePed, "status" ) == "following" ) then
				local player = getElementData ( thePed, "leader" )
				local oldTx, oldTy, oldTz = getElementPosition( player )
				local oldPx, oldPy, oldPz = getElementPosition( thePed )
				setTimer ( follow_enemy_check, 500 ,1 , thePed )
				setTimer ( follow_move, 800, 1, thePed, oldPx, oldPy, oldPz, oldPx, oldPy, oldPz )
			elseif (getElementData ( thePed, "status" ) == "waiting" ) then	
				setTimer ( wait_enemy_check, 500 ,1 , thePed )
			elseif (getElementData ( thePed, "status" ) == "guarding" ) then
				setTimer ( guard_enemy_check, 800 ,1 , thePed )-- starts scanning for enemies
				setTimer ( guard_move, 400 ,1 , thePed )
			end
		end	
	end
end
addEventHandler( "onClientResourceStart", resourceRoot, resourcestart )
