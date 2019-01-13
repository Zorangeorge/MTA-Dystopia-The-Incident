function findRotation(x1,y1,x2,y2)
	local t = -math.deg(math.atan2(x2-x1,y2-y1))
	if t < 0 then t = t + 360 end;
	return t;
end

function animLock( ped )
	if isElement(ped)  then
        setPedAnimationProgress(ped, "BMX_pedal", 1.0)
        animLockTimer = setTimer ( animLock, 300, 1, ped )
	end
end


speedtimer = 500 -- make sure its the same as the client

addEvent( "onPlayerStartClimb", true )
function startclimb(x, y, z, wallangle)
	local climbobject = createObject ( 1254, x, y, z, 0, 0, wallangle )
	setElementDimension(climbobject, getElementDimension(source))
	setElementInterior(climbobject, getElementInterior(source))
	setElementCollisionsEnabled(climbobject, false)
	attachElements ( climbobject, source, 0, .38, 0)
	setElementData ( source, "climb_object", climbobject, false )	
	setElementAlpha( climbobject, 0 )
	setPedAnimation( source)
	--setPedAnimation( source, "bsktball", "BBALL_def_loop", -1, true, true, false, true)
	--local ped = source
	setTimer(function(ped) setPedAnimation( ped, "bmx", "BMX_pedal", -1, true, false, false, false, 200) end, 200,1,source)

	setPedAnimationProgress(source, "BMX_pedal", 0.8)
	animLock( source )
	setPedRotation( source, wallangle)
end
addEventHandler ( "onPlayerStartClimb", getRootElement(), startclimb )

addEvent( "onPlayerStopClimb", true )
function stopclimb()
	setPedAnimation( source )
	local climbobject = getElementData( source, "climb_object" )
	if isElement(climbobject) then
		destroyElement(climbobject)
	end
end
addEventHandler ( "onPlayerStopClimb", getRootElement(), stopclimb )

addEvent( "onPlayerMoveClimb", true )
function moveclimb( direction)
--[[	if direction == "left" then
		setPedAnimation( source, "bsktball", "BBALL_def_stepL", -1, true, true, false, false)
	elseif direction == "right" then
		setPedAnimation( source, "bsktball", "BBALL_def_stepR", -1, true, true, false, false)
	else]]
	if direction == "up" then
		--if isTimer(animLockTimer) then killTimer(animLockTimer) end
		setPedAnimation( source, "bmx", "BMX_pedal", -1, true, true, false, false)
			--setPedAnimationProgress(source, "BMX_pedal", 0.8)

	elseif direction == "down" then
		setPedAnimation( source, "biked", "BIKEd_pushes", -1, true, true, false, false)
	end
end
addEventHandler ( "onPlayerMoveClimb", getRootElement(), moveclimb )

addEvent( "onPlayerStayClimb", true )
function resetwallanim()
	local climbobject = getElementData( source, "climb_object" )
	if isElement(climbobject) then
		setPedAnimation( source, "bmx", "BMX_pedal", 100, false, false, true, true,100)
			--setPedAnimationProgress(source, "BMX_pedal", 0.8)

		--setPedAnimation( source, "bsktball", "BBALL_def_loop", 0, false, true, false, true)
	end
end
addEventHandler ( "onPlayerStayClimb", getRootElement(), resetwallanim )

addEvent( "onPlayerRoofClimb", true )
function roofclimb()
	local climbobject = getElementData( source, "climb_object" )
	if isElement(climbobject) then
		setPedAnimation( source, "ped", "CLIMB_Stand", -1, false, true, false, false)
		setTimer ( roofland, 900, 1, source )
	end
end
addEventHandler ( "onPlayerRoofClimb", getRootElement(), roofclimb )

function roofland(player)
	local climbobject = getElementData( player, "climb_object" )
	if isElement(climbobject) then
		destroyElement(climbobject)
	end
	setPedAnimation(player)
end

addEvent( "onPlayerRotateClimb", true )
function rotateclimb(angle)
	local climbobject = getElementData( source, "climb_object" )
	if isElement(climbobject) then
		setElementRotation( source, 0, 0, angle)
	end
end
addEventHandler ( "onPlayerRotateClimb", getRootElement(), rotateclimb )


function toggleSit(thePlayer)
	if not getElementData(thePlayer, "sitting") then
		setPedAnimation(thePlayer, "ped", "seat_down", -1, false, false, false, true)
		setElementData(thePlayer, "sitting", true)
	else
		-- If you use again this command then your character stand up
		setPedAnimation(thePlayer)
		removeElementData(thePlayer, "sitting")
	end
end
addCommandHandler("sit", toggleSit)