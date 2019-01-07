function findRotation(x1,y1,x2,y2)
	local t = -math.deg(math.atan2(x2-x1,y2-y1))
	if t < 0 then t = t + 360 end;
	return t;
end

speedtimer = 500 -- make sure this is the same as the server version
direction = "none"
olddirection = "none"
climbing = 0
climbingeffort = 0
function wallclimbDoubleJump(key, keyState)
		if climbing == 0 then
			local task = getPedSimplestTask(getLocalPlayer())
			if task == "TASK_SIMPLE_IN_AIR"  then		--or task == "TASK_SIMPLE_SWIM" <-- this makes it work from water, but prevents normal climbing out of water
				radRot = math.rad ( getPedRotation(getLocalPlayer())-180)
				local radius = 1
				local px,py,pz = getElementPosition( getLocalPlayer () )
				local tx = px + radius * math.sin(radRot)
				local ty = py + -(radius) * math.cos(radRot)
				local tz = pz
				local hit, hitX, hitY, hitZ, hitlineElement, normalX, normalY, normalZ, mat, lighting, piece, worldID = processLineOfSight(px, py, pz, tx, ty, tz, true, true, false, true, false, false, false, true, getLocalPlayer (), true)
				if hit then	--if theres an climbable object in front (this needs to be expanded to a table with all valid stair/climbable obj model IDs)
					if hitlineElement then
					local objType = getElementType(hitlineElement)
						if objType == "object" then
							worldID = getElementModel(hitlineElement)
						end
					end
					 
				outputDebugString("ID: "..tostring(ID).." Material: "..tostring(mat))
					if 
						worldID == 3879 --SF airport ladders
						or worldID == 10835 --SF naval fence
						or worldID == 3872 --floodbeam 
						or worldID == 3864 --floodbeam 2
						or worldID == 1428 --dyn_ladder
						or worldID == 1437 --dyn_ladder2 
					then
						climbingeffort = 1
					elseif 
						worldID == 1407 --wood fence 
						or worldID == 1447 --dyn_mesh
						or worldID == 1411 --dyn_mesh
						or worldID == 971 --subway gate
						or worldID == 10809 --SF airp fence
						or worldID == 17018 --cunt plant fence
						or worldID == 13435 --logs
						or worldID == 18255 --cunt junk fence
						or mat == 84 --wood dense
						or mat == 17 --steep slidy grass
						or mat == 41 --hedge
						or mat == 176 --hay bale
					then
						climbingeffort = 2
					elseif 
						mat == 0
						--[[mat == 142 --dump?
						or mat == 131 --desert rocks
						or mat == 42 --wood crates
						or mat == 43 --wood (solid)
						or mat == 172 --wood fence
						or mat == 173 --wood fence
						or mat == 174 --wood fence
						or mat == 140 --junkyard piles
						or mat == 50 
						or mat == 51 
						or mat == 54 
						or mat == 55 
						or mat == 58 
						or mat == 63 --car 
						or mat == 64 --car 
						or mat == 65 --car 
						or mat == 167 --rocks below
						or mat == 18 
						or mat == 35 
						or mat == 36 
						or mat == 37 
						or mat == 109 
						or mat == 61 --cardboard box
						]]
					then
						climbingeffort = 3
					end
					
					--if climbingeffort > 0 then 
						local climbobject = getElementData( getLocalPlayer(), "climb_object" )
						if isElement(climbobject) then
							destroyElement(climbobject)
						end				
						local wallangle = findRotation(hitX+(normalX*10),hitY+(normalY*10),hitX,hitY)
						setPedRotation(getLocalPlayer(), wallangle)
						attachPlayer( hitX, hitY, hitZ, wallangle)
					--end
				end
			end
		else
			dropPlayer()
			
		end
end  
bindKey("jump", "down", wallclimbDoubleJump)

function attachPlayer( hitX, hitY, hitZ, wallangle)
	climbing = 1
	direction = "none"
	local climbobject = createObject ( 1254, hitX, hitY, hitZ, 0, 0, wallangle )
	setElementCollisionsEnabled(climbobject, false)
	attachElements ( getLocalPlayer(), climbobject, 0, -.38, 0)
	setElementData ( getLocalPlayer(), "climb_object", climbobject, false )	
	setElementAlpha( climbobject, 0 )
	triggerServerEvent ("onPlayerStartClimb", getLocalPlayer(),  hitX, hitY, hitZ, wallangle)
	setPedRotation(getLocalPlayer(), wallangle)
end

function dropPlayer()
	climbing = 0
	climbingeffort = 0
	triggerServerEvent ("onPlayerStopClimb", getLocalPlayer())
	setControlState ( "jump", true )
	local climbobject = getElementData( getLocalPlayer(), "climb_object" )
	if isElement(climbobject) then
		destroyElement(climbobject)
	end
end
addEventHandler ( "onClientPlayerWasted", getLocalPlayer(), dropPlayer )
addEventHandler ( "onClientPlayerDamage", getLocalPlayer(), dropPlayer )

function climbleft()
	if climbing == 1 then
		if isTimer(controlLoop) then
			resetTimer(controlLoop)
		else
			controlLoop = setTimer( checkContols, speedtimer, 1)
		end
		local climbobject = getElementData( getLocalPlayer(), "climb_object" )
		local px, py, pz = getElementPosition( getLocalPlayer())
		local prx, pry, prot = getElementRotation(climbobject)		
		lx, ly = getPointFromDistanceRotation(px, py, 1, (prot+90)*-1)
		local clear = isLineOfSightClear( px, py, pz, lx, ly, pz, true, false, false, true, true, false, false, climbobject)
		if clear == true then
			lfx, lfy = getPointFromDistanceRotation(lx, ly, 1, (prot)*-1)			
			local clear2 = isLineOfSightClear( lx, ly, pz, lfx, lfy, pz, true, false, false, true, true, false, false, climbobject)
			if clear2 == true then
				local fx, fy = getPointFromDistanceRotation(px, py, 1, (prot)*-1)			
				local clear3 = isLineOfSightClear( lfx, lfy, pz, fx, fy, pz, true, false, false, true, true, false, false, climbobject)
				if clear3 == true then
--					do nothing, no place to move that direction		
				else
					climbMove(lfx, lfy, pz, fx, fy, pz, "left")
				end
			else
				climbMove(lx, ly, pz, lfx, lfy, pz, "left")
			end			
		else
			climbMove(px, py, pz, lx, ly, pz, "left")
		end
	end
end

function startleft()
	if direction ~= "left" then
		climbleft()
	end
end
bindKey("left", "down", startleft)

function climbright()
	if climbing == 1 then
		if isTimer(controlLoop) then
			resetTimer(controlLoop)
		else
			controlLoop = setTimer( checkContols, speedtimer, 1)
		end
		local climbobject = getElementData( getLocalPlayer(), "climb_object" )
		local px, py, pz = getElementPosition( getLocalPlayer())
		local prx, pry, prot = getElementRotation(climbobject)
		rx, ry = getPointFromDistanceRotation(px, py, 1, (prot-90)*-1)
		local clear = isLineOfSightClear( px, py, pz, rx, ry, pz, true, false, false, true, true, false, false, climbobject)
		if clear == true then
			rfx, rfy = getPointFromDistanceRotation(rx, ry, 1, (prot)*-1)			
			local clear2 = isLineOfSightClear( rx, ry, pz, rfx, rfy, pz, true, false, false, true, true, false, false, climbobject)
			if clear2 == true then
				local fx, fy = getPointFromDistanceRotation(px, py, 1, (prot)*-1)			
				local clear3 = isLineOfSightClear( rfx, rfy, pz, fx, fy, pz, true, false, false, true, true, false, false, climbobject)
				if clear3 == true then
--					do nothing, no place to move that direction
				else
					climbMove(rfx, rfy, pz, fx, fy, pz, "right")
				end
			else
				climbMove(rx, ry, pz, rfx, rfy, pz, "right")
			end			
		else
			climbMove(px, py, pz, rx, ry, pz, "right")
		end
	end
end
function startright()
	if direction ~= "right" then
		climbright()
	end
end
bindKey("right", "down", startright)

function climbup()
	if climbing == 1 then
		if isTimer(controlLoop) then
			resetTimer(controlLoop)
		else
			controlLoop = setTimer( checkContols, speedtimer, 1)
		end
		local climbobject = getElementData( getLocalPlayer(), "climb_object" )
		if isElement(climbobject) then
			local px, py, pz = getElementPosition( getLocalPlayer())
			local prx, pry, prot = getElementRotation(climbobject)
			local clear = isLineOfSightClear( px, py, pz, px, py, pz+1.6, true, false, false, true, true, false, false, climbobject)
			if clear == true then
				local ufx, ufy = getPointFromDistanceRotation(px, py, .8, (prot)*-1)
				local clear2 = isLineOfSightClear( px, py, pz+1, ufx, ufy, pz+1, true, false, false, true, true, false, false, climbobject)
				if clear2 == true then
					local fx, fy = getPointFromDistanceRotation(px, py, .9, (prot)*-1)
					local clear3 = isLineOfSightClear( ufx, ufy, pz+1, fx, fy, pz, true, false, false, true, true, false, false, climbobject)
					if clear3 == true then
--						do nothing, no place to move that direction
					else
						fx2, fy2 = getPointFromDistanceRotation(px, py, .4, (prot)*-1)
						climbontoroof( fx2, fy2, prot)
					end
				else
					climbMove(px, py, pz+1, ufx, ufy, pz+1, "up")
				end			
			else
--				do nothing, we arent climbing ceilings yet (maybe later)
			end
		end
	end
end

function startup()
	if direction ~= "up" then
		climbup()
	end
end
bindKey("forwards", "down", startup)

function climbdown()
	if climbing == 1 then
		if isTimer(controlLoop) then
			resetTimer(controlLoop)
		else
			controlLoop = setTimer( checkContols, speedtimer, 1)
		end
		local climbobject = getElementData( getLocalPlayer(), "climb_object" )
		local px, py, pz = getElementPosition( getLocalPlayer())
		local prx, pry, prot = getElementRotation(climbobject)
		local clear = isLineOfSightClear( px, py, pz, px, py, pz-2, true, false, false, true, true, false, false, climbobject)
		if clear == true then
			fx, fy = getPointFromDistanceRotation(px, py, 1, (prot)*-1)			
			local clear2 = isLineOfSightClear( px, py, pz-1, fx, fy, pz-1, true, false, false, true, true, false, false, climbobject)
			if clear2 == true then
				local fx, fy = getPointFromDistanceRotation(px, py, 1, (prot)*-1)
				local clear3 = isLineOfSightClear( fx, fy, pz-1, fx, fy, pz, true, false, false, true, true, false, false, climbobject)
				if clear3 == true then
--					do nothing, no place to move that direction
				else
--					do nothing, we arent climbing ceilings yet (maybe later)
				end
			else-- theres a block lined up lower (more wall)
				climbMove(px, py, pz-1, fx, fy, pz-1, "down")
			end			
		else
			dropPlayer()
		end
	end
end

function startdown()
	if direction ~= "down" then
		climbdown()
	end
end
bindKey("backwards", "down", startdown)

function climbMove(x, y, z, x1, y1, z1, thedir)
	local climbobject = getElementData( getLocalPlayer(), "climb_object" )
	local hit, hitX, hitY, hitZ, hitlineElement, normalX, normalY, normalZ = processLineOfSight(x, y, z, x1, y1, z1, true, false, false, true, false, true, false, true, climbobject, false)
	local wallangle = findWallRotation(hitX+(normalX*10),hitY+(normalY*10),hitX,hitY)
	local oldrx, oldry, oldrz = getElementRotation(climbobject)
	local anglediff = (oldrz-wallangle)*-1
	if anglediff > 179 then anglediff = anglediff-360 end -- fixes corner rotations
	if anglediff < -179 then anglediff = anglediff+360 end -- fixes corner rotations
	if thedir ~= direction then
		triggerServerEvent ("onPlayerMoveClimb", getLocalPlayer(), thedir)
	end
	direction = thedir
	moveObject(climbobject, speedtimer, hitX, hitY, hitZ, 0, 0 ,anglediff)
	if anglediff ~= 0 then
		if isTimer(stopaligning) then
			resetTimer(stopaligning)
		else
			stopaligning = setTimer ( stopalign, speedtimer, 1)
			addEventHandler("onClientRender",getRootElement(), alignplayer )
		end		
	end
end

function checkContols()
	if climbing == 1 then
		if isTimer(controlLoop) then
			controlLoop = nil
		end
		if getControlState( "left" ) == true then
			climbleft()
		elseif getControlState( "right" ) == true then
			climbright()
		elseif getControlState( "forwards" ) == true then
			climbup()
		elseif getControlState( "backwards" ) == true then
			climbdown()
		else
			direction = "none"
			triggerServerEvent ("onPlayerStayClimb", getLocalPlayer())
		end
	end
end

function getPointFromDistanceRotation(x, y, dist, angle)
	local a = math.rad(90 - angle);
	local dx = math.cos(a) * dist;
	local dy = math.sin(a) * dist;
	return x+dx, y+dy;
end

function climbontoroof(fx2, fy2, prot)
	local climbobject = getElementData( getLocalPlayer(), "climb_object" )
	local px, py, pz = getElementPosition( getLocalPlayer())
	climbing = 0
	local hit, hitX, hitY, hitZ, hitlineElement, normalX, normalY, normalZ = processLineOfSight(fx2, fy2, pz+2, fx2, fy2, pz-.4, true, false, false, true, false, true, false, true, climbobject, false)
	triggerServerEvent ("onPlayerRoofClimb", getLocalPlayer())	
	setElementPosition(climbobject, px, py, hitZ)
	setTimer ( roofland, 900, 1, getLocalPlayer(),hitX, hitY, hitZ, prot)
end

function roofland(player,x, y, z, angle)
	local climbobject = getElementData( player, "climb_object" )
	if isElement(climbobject) then
		destroyElement(climbobject)
	end
	setPedAnimation( player)
	setElementPosition(player, x, y, z+.7 )
	--local fx,fy,fz = getPositionFromElementOffset(player,0,3,0)
	--setElementPosition ( climbobject, fx,fy, z+1)
	setElementFrozen(player,true)
	setControlState ( "jump", true )
	setElementFrozen(player,false)
	
	setPedRotation( player, angle)
	--setPedAnimation( player, "PLAYIDLES", "stretch",500, false, false, true, false)
	--setPedAnimation(player)
end

function alignplayer()
	local theclimbobject = getElementData( getLocalPlayer(), "climb_object" )
	if isElement(theclimbobject) then
		local rx, ry, rz = getElementRotation(theclimbobject)
		setPedRotation( getLocalPlayer(), rz)
	end
end

function stopalign()
	removeEventHandler("onClientRender",getRootElement(), alignplayer )
	stopaligning = nil
	local theclimbobject = getElementData( getLocalPlayer(), "climb_object" )
	if isElement(theclimbobject) then
		local rx, ry, rz = getElementRotation(theclimbobject)
		triggerServerEvent ("onPlayerRotateClimb", getLocalPlayer(), rz )
	end
end

function findWallRotation(x1,y1,x2,y2)
	local t = -math.deg(math.atan2(x2-x1,y2-y1))
	if t < 0 then t = t + 360 end;
	return t;
end



--[[function toggleclimbgrapple()
	if getElementData( getLocalPlayer(), "passive_power" ) == "wallclimb" and getElementData( getLocalPlayer(), "transport_power" ) == "grapple" then
		if climbing == 0 then
			local theVehicle = getPedOccupiedVehicle ( getLocalPlayer() )
			if ( theVehicle ) then
				local carpurpose = (getElementData ( theVehicle,  "purpose" ))
				if (carpurpose ==  "grapple") then
					destroyElement(theVehicle)
					radRot = math.rad ( getPedRotation(getLocalPlayer())-180)
					local radius = 2
					local px,py,pz = getElementPosition( getLocalPlayer () )
					local tx = px + radius * math.sin(radRot)
					local ty = py + -(radius) * math.cos(radRot)
					local tz = pz
					local hit, hitX, hitY, hitZ, hitlineElement, normalX, normalY, normalZ = processLineOfSight(px, py, pz, tx, ty, tz, true, false, false, true, false, false, false, true, getLocalPlayer (), false)
					if hit then	--if theres a wall in front
						local wallangle = findRotation(hitX+(normalX*10),hitY+(normalY*10),hitX,hitY)
						triggerServerEvent ( "ongrapplejump", getLocalPlayer(), getLocalPlayer() )
						setPedRotation(getLocalPlayer(), wallangle)
						setTimer( attachPlayer, 300, 1, hitX, hitY, hitZ, wallangle)
						setTimer( setPedRotation, 301, 1, getLocalPlayer(), wallangle)
					end
				end
			end
			
		elseif climbing == 1 then
			if getPedOccupiedVehicle ( getLocalPlayer() ) == false then
				local climbobject = getElementData( getLocalPlayer(), "climb_object" )
				local px, py, pz = getElementPosition( climbobject)
				local rx, ry, rz = getElementRotation(climbobject)
				dropPlayer()
				triggerServerEvent ( "ongrappletoggle", getLocalPlayer(),getLocalPlayer(), false, px, py, pz, rz, 0, 2  )
			end
		end
	end
end
addCommandHandler ( "transport", toggleclimbgrapple )]]