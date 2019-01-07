
resourceRoot = getResourceRootElement()
local mainObject
local subObjects

function propIt()
if source == mainObject then
		local vehDoorNo = {0,1,2,3,4,5} 
		local vehDoorSt = {0,1,2,3,4}

		setVehicleDoorState ( mainObject, 0, 4 )
		setVehicleDoorState ( mainObject, 1, 4 )
		setVehicleDoorState ( mainObject, 2, 4 )
		setVehicleDoorState ( mainObject, 3, 4 )
		setVehicleDoorState ( mainObject, 4, 4 )
		setVehicleDoorState ( mainObject, 5, 4 )
end
end

addEventHandler( "onResourceStart", resourceRoot,
    function()
        -- Postion and rotations from the map editor:
        local mainPos = { -756, 995, 14 }
        local mainRot = { 0, 0, 90 }            -- Two rotations are zero. See note in attachRotationAdjusted

        local subPos = { -756, 999, 24 }
        local subRot = { 89, 0, 177 }           -- One rotation is zero. See note in attachRotationAdjusted

        -- Create the objects
        mainObject = getElementByID("thecrusader1vehicle")
        subObjects = getElementsByType("object",resourceRoot)
		
		--vehicle parts and stats--

		local vehPanelNo = {0,1,2,3,4,5,6} -- panel number
		local vehPanelSt = {0,1,2,3} -- panel state

		local vehWheelSt = {0,1,2} -- 0 intact, 2 missing

		local vehDoorNo = {0,1,2,3,4,5} 
		local vehDoorSt = {0,1,2,3,4}

		setVehicleDoorState ( mainObject, 0, 4 )
		setVehicleDoorState ( mainObject, 1, 4 )
		setVehicleDoorState ( mainObject, 2, 4 )
		setVehicleDoorState ( mainObject, 3, 4 )
		setVehicleDoorState ( mainObject, 4, 4 )
		setVehicleDoorState ( mainObject, 5, 4 )

        -- Attach so they look like what they do in the map editor
		for _,part in ipairs (subObjects) do
        attachRotationAdjusted ( part, mainObject )
		end
		
		setVehicleRespawnPosition(mainObject,2257,2456,3.5)
		respawnVehicle(mainObject,2257,2456,3.5)
		--setTimer(function()  respawnVehicle(mainObject) setVehicleLocked ( mainObject, false )end,5000,1)
		addEventHandler("onVehicleRespawn",mainObject,propIt)
    end
)


function attachRotationAdjusted ( from, to )
    -- Note: Objects being attached to ('to') should have at least two of their rotations set to zero
    --       Objects being attached ('from') should have at least one of their rotations set to zero
    -- Otherwise it will look all funny

    local frPosX, frPosY, frPosZ = getElementPosition( from )
    local frRotX, frRotY, frRotZ = getElementRotation( from )
    local toPosX, toPosY, toPosZ = getElementPosition( to )
    local toRotX, toRotY, toRotZ = getElementRotation( to )
    local offsetPosX = frPosX - toPosX
    local offsetPosY = frPosY - toPosY
    local offsetPosZ = frPosZ - toPosZ
    local offsetRotX = frRotX - toRotX
    local offsetRotY = frRotY - toRotY
    local offsetRotZ = frRotZ - toRotZ

    offsetPosX, offsetPosY, offsetPosZ = applyInverseRotation ( offsetPosX, offsetPosY, offsetPosZ, toRotX, toRotY, toRotZ )

    attachElements( from, to, offsetPosX, offsetPosY, offsetPosZ, offsetRotX, offsetRotY, offsetRotZ )
end


function applyInverseRotation ( x,y,z, rx,ry,rz )
    -- Degress to radians
    local DEG2RAD = (math.pi * 2) / 360
    rx = rx * DEG2RAD
    ry = ry * DEG2RAD
    rz = rz * DEG2RAD

    -- unrotate each axis
    local tempY = y
    y =  math.cos ( rx ) * tempY + math.sin ( rx ) * z
    z = -math.sin ( rx ) * tempY + math.cos ( rx ) * z

    local tempX = x
    x =  math.cos ( ry ) * tempX - math.sin ( ry ) * z
    z =  math.sin ( ry ) * tempX + math.cos ( ry ) * z

    tempX = x
    x =  math.cos ( rz ) * tempX + math.sin ( rz ) * y
    y = -math.sin ( rz ) * tempX + math.cos ( rz ) * y

    return x, y, z
end

--toggle player immunity
function spawnCruiserToPlayer(p, c)

local x,y,z = getElementPosition(p)

if isElement(mainObject) then setElementPosition(mainObject,x,y,z) end

end
addCommandHandler("cruiser", spawnCruiserToPlayer)