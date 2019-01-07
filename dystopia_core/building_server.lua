
-- Created by Spanky
-- Made in Germany
-- Free to use.
-- If youre a bro, do not remove my name!

allBuildingsOnServer = {}

BuildableObjectsData = {}

--wooden
BuildableObjectsData[3260] = {} --Wood Panel
BuildableObjectsData[1407] = {} --Wood Fence
BuildableObjectsData[1482] = {} --Wood Platform
BuildableObjectsData[1428] = {} --Wood Ladder
BuildableObjectsData[1472] = {} --Wood Steps
BuildableObjectsData[2636] = {} --Wood Chair
BuildableObjectsData[2115] = {} --Wood Table
BuildableObjectsData[3927] = {} --Wood Sign
BuildableObjectsData[1492] = {} --Wood Door

--metal
BuildableObjectsData[1447] = {} --Metal Fence
BuildableObjectsData[1411] = {} --Metal Barbed Fence
BuildableObjectsData[3302] = {} --Metal Panel
BuildableObjectsData[3280] = {} --Metal Grate
BuildableObjectsData[2937] = {} --Metal Plank
BuildableObjectsData[1424] = {} --Metal Barrier
BuildableObjectsData[3049] = {} --Metal Strong Fence
BuildableObjectsData[1499] = {} --Metal Door
BuildableObjectsData[5779] = {} --Metal Wall

--structures
BuildableObjectsData[16281] = {} --Gate
BuildableObjectsData[1457] = {} --Shelter
BuildableObjectsData[16405] = {} --Hut Structure
BuildableObjectsData[1452] = {} --Outhouse
BuildableObjectsData[1466] = {} --Scaffold
BuildableObjectsData[1464] = {} --Reinforced Scaffold
BuildableObjectsData[1426] = {} --Scaffold Tower
BuildableObjectsData[12991] = {} --Small Cabin
BuildableObjectsData[18259] = {} --Large Cabin

--special
BuildableObjectsData[1362] = {} --Fire Bin
BuildableObjectsData[1800] = {} --Bed
BuildableObjectsData[1271] = {} --Storage
BuildableObjectsData[2451] = {} --Workbench
BuildableObjectsData[1345] = {} --Large Storage
BuildableObjectsData[16732] = {}--Fish Trap
BuildableObjectsData[3261] = {} --Potato Farm
BuildableObjectsData[1451] = {} --Critter Pen
BuildableObjectsData[1570] = {} --Trading Post

--double special or hell knows vip
--BuildableObjectsData[964] = {} --army crate(strongbox)
--BuildableObjectsData[2065] = {} --metal file cabinet (guns/ammo?)
--BuildableObjectsData[2060] = {} --sandbag
--BuildableObjectsData[3265] = {} --private sign
--BuildableObjectsData[1446] = {} --wooden nice fence
--BuildableObjectsData[2096] = {} --rocking chair
--BuildableObjectsData[1437] = {} --long ladder
--BuildableObjectsData[18267] = {} --log cabin 2

------------------------
--BuildableObjectsData[11496] = {} --large wooden platform // bad collision on lower side
--BuildableObjectsData[1418] = {} --wooden panels
--BuildableObjectsData[1410] = {} --wooden fence
--BuildableObjectsData[1456] = {} --plywood fence
--BuildableObjectsData[1459] = {} --wooden road barrier
--BuildableObjectsData[1448] = {} --flat pallet (floor/roof?)
--BuildableObjectsData[1483] = {} --sloped porch roof
--BuildableObjectsData[1471] = {} --small wooden platform/ dyn_porch // bad colision on lower side
-----------------------------------------------------------------------------------


buildable_objects = {}
current_object_distance = {}
increment = {}
--local buildable_objects = nil
--local current_object_distance = 1
--local light = nil

function moveDown (player)
if getElementData(player, "isPressingAlt") then increment[player] = 0.1 else increment[player] = 0.5 end
local x,y,z = getElementPosition(buildable_objects[player])
--local rx,ry,rz = getElementRotation(buildable_objects)
setElementPosition(buildable_objects[player],x,y,z-increment[player])
--setElementRotation(buildable_objects,rx,ry,rz)
--attachRotationAdjusted(buildable_objects,player)
end

function moveUp (player)
if getElementData(player, "isPressingAlt") then increment[player] = 0.1 else increment[player] = 0.5 end
local x,y,z = getElementPosition(buildable_objects[player])
--local rx,ry,rz = getElementRotation(buildable_objects)
setElementPosition(buildable_objects[player],x,y,z+increment[player])
--setElementRotation(buildable_objects,rx,ry,rz)
--attachRotationAdjusted(buildable_objects,player)
end

function moveFront (player)
local x,y,z = getElementPosition(player)
local ox,oy,oz = getElementPosition(buildable_objects[player])
fz = oz-z
if getElementData(player, "isPressingAlt") then increment[player] = 0.1 else increment[player] = 0.5 end
attachElements(buildable_objects[player],player,0,current_object_distance[player]+increment[player],fz)
current_object_distance[player] = current_object_distance[player]+increment[player]
detachElements(buildable_objects[player])
end

function moveBack (player)
local x,y,z = getElementPosition(player)
local ox,oy,oz = getElementPosition(buildable_objects[player])
fz = oz-z
if getElementData(player, "isPressingAlt") then increment[player] = 0.1 else increment[player] = 0.5 end
attachElements(buildable_objects[player],player,0,current_object_distance[player]-increment[player],fz)
current_object_distance[player] = current_object_distance[player]-increment[player]
detachElements(buildable_objects[player])
end

function rotateRight(player)
if getElementData(player, "isPressingAlt") then increment[player] = 15 else increment[player] = 30 end
local x,y,z = getElementRotation(buildable_objects[player])
setElementRotation(buildable_objects[player],x,y,z+increment[player])
--attachRotationAdjusted(buildable_objects,player)
end

function rotateLeft(player)
if getElementData(player, "isPressingAlt") then increment[player] = 15 else increment[player] = 30 end
local x,y,z = getElementRotation(buildable_objects[player])
setElementRotation(buildable_objects[player],x,y,z-increment[player])
--attachRotationAdjusted(buildable_objects,player)
end

function rotateUp(player)
if getElementData(player, "isPressingAlt") then increment[player] = 15 else increment[player] = 30 end
local x,y,z = getElementRotation(buildable_objects[player])
setElementRotation(buildable_objects[player],x+increment[player],y,z)
--attachRotationAdjusted(buildable_objects,player)
end

function rotateDown(player)
if getElementData(player, "isPressingAlt") then increment[player] = 15 else increment[player] = 30 end
local x,y,z = getElementRotation(buildable_objects[player])
setElementRotation(buildable_objects[player],x-increment[player],y,z)
--attachRotationAdjusted(buildable_objects,player)
end

function cancelBuild (player)
	if buildable_objects[player] and isElement(buildable_objects[player]) then
	triggerClientEvent(player,"PlayerFinishedPlacingObject",buildable_objects[player])
	destroyElement(buildable_objects[player]) 
	current_object_distance[player] = 1
	buildable_objects[player] = nil
	outputInteractInfo("[ building cancelled ]",player, 240,0,0 )
	end
	
	unbindKey(player,"pgdn","down",moveDown)
	unbindKey(player,"pgup","down",moveUp)
	unbindKey(player,"num_8","down",moveFront)
	unbindKey(player,"num_2","down",moveBack)
	unbindKey(player,"num_5","down",place)
	unbindKey(player,"num_4","down",rotateLeft)
	unbindKey(player,"num_6","down",rotateRight)
	unbindKey(player,"num_7","down",rotateUp)
	unbindKey(player,"num_1","down",rotateDown)
	unbindKey(player,"num_9","down",cancelBuild)
	
end

function create(player, command, id)
if buildable_objects[player] then outputInteractInfo("[ already building! ]",player, 240,0,0 ) return end
local x,y,z = getElementPosition(player)
buildable_objects[player] = createObject(id,x,y,z)
current_object_distance[player] = 1
setElementAlpha(buildable_objects[player],150)
attachElements(buildable_objects[player],player,0,current_object_distance[player],0)
detachElements(buildable_objects[player])
setElementDoubleSided(buildable_objects[player],true)
setElementCollisionsEnabled(buildable_objects[player],false)
bindKey(player,"pgdn","down",moveDown)
bindKey(player,"pgup","down",moveUp)
bindKey(player,"num_8","down",moveFront)
bindKey(player,"num_2","down",moveBack)
bindKey(player,"num_5","down",place)
bindKey(player,"num_4","down",rotateLeft)
bindKey(player,"num_6","down",rotateRight)
bindKey(player,"num_7","down",rotateUp)
bindKey(player,"num_1","down",rotateDown)
bindKey(player,"num_9","down",cancelBuild)

triggerClientEvent(player,"PlayerIsPlacingObject",buildable_objects[player])

end
addCommandHandler( "co", create )

function place(player)

	if getElementData(buildable_objects[player],"canBeBuilt") then 

		setElementCollisionsEnabled(buildable_objects[player],true)
		detachElements(buildable_objects[player])
		
		setPedAnimation ( player, "INT_HOUSE", "wash_up", 5000, true, false, false, false)
		setTimer(outputStatusInfo, 5000, 1,"+2 xp",player, 240,240,240 )
		triggerClientEvent(player, "sleep:drawDXProgress", player, 5000,5000)
		setTimer(triggerClientEvent,5000,1,player, "sleep:stopDXProgress", player)
		
		
		if getElementModel(buildable_objects[player]) == 1492 or getElementModel(buildable_objects[player]) == 1499 then -- don't freeze doors
			setElementFrozen(buildable_objects[player],false)
			setElementVelocity(buildable_objects[player],0,0,0)
		else
			setElementFrozen(buildable_objects[player],true) --freeze buildable
		end
		
		setElementData(buildable_objects[player],"owner",player)
		table.insert(allBuildingsOnServer,buildable_objects[player]) --add the building to the current table
		local x, y, z = getElementPosition(buildable_objects[player])
		local xr, yr, zr = getElementRotation(buildable_objects[player])
		setPersistent(buildable_objects[player], "building", x, y, z, xr, yr, zr)
		setElementAlpha(buildable_objects[player],255)
		setElementDoubleSided(buildable_objects[player],true)

		unbindKey(player,"pgdn","down",moveDown)
		unbindKey(player,"pgup","down",moveUp)
		unbindKey(player,"num_8","down",moveFront)
		unbindKey(player,"num_2","down",moveBack)
		unbindKey(player,"num_5","down",place)
		unbindKey(player,"num_4","down",rotateLeft)
		unbindKey(player,"num_6","down",rotateRight)
		unbindKey(player,"num_7","down",rotateUp)
		unbindKey(player,"num_1","down",rotateDown)
		unbindKey(player,"num_9","down",cancelBuild)

		triggerClientEvent(player,"PlayerFinishedPlacingObject",buildable_objects[player])

		current_object_distance[player] = 1
		buildable_objects[player] = nil
	
	else
		outputInteractInfo("[ Can't build! ]",player, 240,0,0 )
		--outputChatBox("Get closer, reposition object or press num_9 to cancel.",player)
	
	end
	
end

addEvent("ClientCancelledPlacement",true)
function cancelBuildByClient ()
	if buildable_objects[client] == source and isElement(buildable_objects[client]) then
	--triggerClientEvent(client,"PlayerFinishedPlacingObject",buildable_objects[client])
	destroyElement(buildable_objects[client]) 
	current_object_distance[client] = 1
	buildable_objects[client] = nil
	end
	
	unbindKey(client,"pgdn","down",moveDown)
	unbindKey(client,"pgup","down",moveUp)
	unbindKey(client,"num_8","down",moveFront)
	unbindKey(client,"num_2","down",moveBack)
	unbindKey(client,"num_5","down",place)
	unbindKey(client,"num_4","down",rotateLeft)
	unbindKey(client,"num_6","down",rotateRight)
	unbindKey(client,"num_7","down",rotateUp)
	unbindKey(client,"num_1","down",rotateDown)
	unbindKey(client,"num_9","down",cancelBuild)
	
end
addEventHandler("ClientCancelledPlacement",root,cancelBuildByClient)

----UTILS
--[[
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
]]