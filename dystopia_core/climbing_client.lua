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
			if task == "TASK_SIMPLE_IN_AIR"  or task == "TASK_SIMPLE_JUMP" then--"TASK_SIMPLE_SWIM"<-- this makes it work from water, but prevents normal climbing out of water
				radRot = math.rad ( getPedRotation(getLocalPlayer())-180)
				local radius = 1
				local px,py,pz = getElementPosition( getLocalPlayer () )
				local tx = px + radius * math.sin(radRot)
				local ty = py + -(radius) * math.cos(radRot)
				local tz = pz
				local hit, hitX, hitY, hitZ, hitlineElement, normalX, normalY, normalZ, mat, lighting, piece, worldID = processLineOfSight(px, py, pz, tx, ty, tz, true, true, false, true, false, false, false, true, getLocalPlayer (), true)
				if hit then	--if theres an climb-able object in front (this needs to be expanded to a table with all valid stair/climbable obj model IDs)
					if hitlineElement then
					local objType = getElementType(hitlineElement)
						if objType == "object" then
							worldID = getElementModel(hitlineElement)
						end
					end
					 
					outputDebugString("ID: "..tostring(ID).." Material: "..tostring(mat))
					
					if 	worldID == 3879 --SF airport ladders
						or worldID == 1428 --dyn_ladder
						or worldID == 1437 --dyn_ladder2 
					then
						climbingeffort = 1
						--add different amounts of climbing effort for various surfaces/object types
					end
					
					if climbingeffort > 0 then 
						local climbobject = getElementData( getLocalPlayer(), "climb_object" )
						if isElement(climbobject) then
							destroyElement(climbobject)
						end
						
						local wallangle = findRotation(hitX+(normalX*10),hitY+(normalY*10),hitX,hitY)
						setPedRotation(getLocalPlayer(), wallangle)
						attachPlayer( hitX, hitY, hitZ, wallangle)
					end
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
if climbing > 0 then
	climbing = 0
	climbingeffort = 0
	
	triggerServerEvent ("onPlayerStopClimb", localPlayer)
	setPedAnimation(localPlayer)
	setPedControlState ( localPlayer,"jump", true )
	setTimer(function(pl) setElementFrozen(pl,true) end,200,1,localPlayer)
	setTimer(function(pl) setElementFrozen(pl,false) end,400,1,localPlayer)
	detachElements(localPlayer)
	local climbobject = getElementData( localPlayer, "climb_object" )
	if isElement(climbobject) then
		destroyElement(climbobject)
	end
end
end
addEventHandler ( "onClientPlayerWasted", localPlayer, dropPlayer )
addEventHandler ( "onClientPlayerDamage", localPlayer, dropPlayer )

function climbup()
	if climbing == 1 then
		if isTimer(controlLoop) then
			resetTimer(controlLoop)
		else
			controlLoop = setTimer( checkControls, speedtimer, 1)
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
			controlLoop = setTimer( checkControls, speedtimer, 1)
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

function checkControls()
	if climbing == 1 then
		if isTimer(controlLoop) then
			controlLoop = nil
		end
--[[		if getPedControlState( localPlayer,"left" ) == true then
			climbleft()
		elseif getPedControlState( localPlayer,"right" ) == true then
			climbright()
		else]]if getPedControlState( localPlayer,"forwards" ) == true then
			climbup()
		elseif getPedControlState( localPlayer,"backwards" ) == true then
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
	detachElements(localPlayer)
	local climbobject = getElementData( player, "climb_object" )
	if isElement(climbobject) then
		destroyElement(climbobject)
	end
	--setPedAnimation( player)
	setElementPosition(localPlayer, x, y, z+.7 ,false)
	--local fx,fy,fz = getPositionFromElementOffset(player,0,3,0)
	--setElementPosition ( climbobject, fx,fy, z+1)
	--jumpdummy = createObject(1448,x, y, z+2) --an invisible object to bump player into when jumping to unlock controls
	--setElementAlpha(jumpdummy,0)
	setPedControlState ( localPlayer,"jump", true )
	--setPedControlState ( localPlayer,"jump", false )
	--setElementFrozen(localPlayer,true)
	--setElementFrozen(localPlayer,false)
	--setPedControlState ( player,"crouch", true )
	--setPedAnimation( player)
	--setTimer(function() destroyElement(jumpdummy) end,1000,1)
	--setTimer(function() setElementFrozen(localPlayer,false) end,1000,1)
	--setPedControlState ( localPlayer,"jump", true )
	--setTimer(function(pl) setElementFrozen(pl,true) end,200,1,localPlayer)
	--setTimer(function(pl) setElementFrozen(pl,false) end,400,1,localPlayer)
	--setTimer(function(pl,x, y, z) setElementPosition(pl,x, y, z,false) end,400,1,localPlayer,x, y, z+.8)
	setPedRotation( player, angle)
	climbing = 0
	climbingeffort = 0
	--dropPlayer()
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


