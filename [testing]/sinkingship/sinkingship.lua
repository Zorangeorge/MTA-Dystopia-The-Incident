--[[
players = getElementsByType ( "player" )
for k,v in pairs(players) do
	r = 10
	angle = math.random(0, 359.99) --random angle between 0 and 359.99
	centerX = 515
	centerY = -2466.5
	spawnX = r*math.cos(angle) + centerX --circle trig math
	spawnY = r*math.sin(angle) + centerY --circle trig math
	spawnAngle = 360 - math.deg( math.atan2 ( (600 - spawnX), (-2500 - spawnY) ) )
	spawnPlayer ( v, spawnX, spawnY, 1, spawnAngle )	
end
]]

--setWeather ( 8 )
ship_offset_height = -3
ship_dummy = createObject ( 3106, 600, -2500, -10.000000, 0, 0.000000, math.deg(45.000000) ) --createVehicle ( 446, 594.024994, -2507.973343,4, 0.000000, 0.000000, 0.000000 )

ship = createVehicle ( 446, 594.024994, -2507.973343,4, 0.000000, 0.000000, 0.000000 )
setElementFrozen(ship,true)
attachElements ( ship, ship_dummy, -6.024994, -7.973343, 16.240688+ship_offset_height, 0.000000, 0.000000, 0.000000 )
setElementParent ( ship, ship_dummy )
createBlip ( 600, -2500, -10.000000, 9, 2)
--[[function mapLoad (  )
	setWaveHeight ( 0.7 )
end
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()),mapLoad )
]]

function sinkit (  )
	local x,y,z = getElementPosition ( ship_dummy )
	setElementFrozen(ship,false)
	--setElementCollisionsEnabled(ship_dummy,false)
	moveObject ( ship_dummy, 5000, x, y, z-5, 0, 0, 0 )
	setTimer ( startTiltA, 5000, 1 )
end
addCommandHandler ( "sink", sinkit )

function resetit (  )
destroyElement(ship_dummy)
destroyElement(ship)

ship_dummy = createObject ( 3106, 600, -2500, -10.000000, 0, 0.000000, 0 )
ship = createVehicle ( 446, 594.024994, -2507.973343,4, 0.000000, 0.000000, 0.000000 )
setElementFrozen(ship,true)
attachElements ( ship, ship_dummy, -6.024994, -7.973343, 16.240688+ship_offset_height, 0.000000, 0.000000, 0.000000 )
--setElementFrozen(ship,true)
setElementParent ( ship, ship_dummy )
end
addCommandHandler ( "resetship", resetit )

function startTiltA (  )
	local x,y,z = getElementPosition ( ship_dummy )
	--setElementFrozen(ship_dummy,false)
	moveObject ( ship_dummy, 10000, x, y, z-10, 0, 10, 0 )
	setTimer ( startTiltB, 10000, 1 )
	--setTimer ( setElementFrozen, 10000, 1,ship_dummy,true )
end

function startTiltB (  )
	local x,y,z = getElementPosition ( ship_dummy )
	--setElementFrozen(ship_dummy,false)
	moveObject ( ship_dummy, 10000, x, y, z-5, 0, 20, 0 )
	setTimer ( startTiltC, 5000, 1 )
	--setTimer ( setElementFrozen, 10000, 1,ship_dummy,true )
end

function startTiltC (  )
	local x,y,z = getElementPosition ( ship_dummy )
	--setElementFrozen(ship_dummy,false)
	moveObject ( ship_dummy, 15000, x, y, z, 0, 20, 0 )
	setTimer ( startTiltD, 5000, 1 )
	--setTimer ( setElementFrozen, 15000, 1,ship_dummy,true )
end

function startTiltD (  )
	local x,y,z = getElementPosition ( ship_dummy )
	--setElementFrozen(ship_dummy,false)
	moveObject ( ship_dummy, 5000, x, y, z-7, 0, 15, 0 )
	setTimer ( startTiltE, 5000, 1 )
	--setTimer ( setElementFrozen, 5000, 1,ship_dummy,true )
end

function startTiltE (  )
	local x,y,z = getElementPosition ( ship_dummy )
	--setElementFrozen(ship_dummy,false)
	moveObject ( ship_dummy, 10000, x, y, z-5, 0, 15, 0 )
	outputChatBox("check")
	setTimer ( startTiltF, 5000, 1 )
	--setTimer ( setElementFrozen, 10000, 1,ship_dummy,true )
end

function startTiltF (  )
	local x,y,z = getElementPosition ( ship_dummy )
	--setElementFrozen(ship_dummy,false)
	moveObject ( ship_dummy, 5000, x, y, z-5, 0, 10, 0 )
	setTimer ( setElementFrozen, 5000, 1,ship,true )
	setTimer ( detachElements, 5000, 1,ship )
end