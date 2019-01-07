
-- Created by Spanky
-- Made in Germany
-- Free to use.
-- If youre a bro, do not remove my name!

BuildableObjectsData = {}
BuildableObjectsData[2451] = {} --worktop (workbench?)
BuildableObjectsData[1570] = {} --trader stall (trader?)
BuildableObjectsData[2065] = {} --metal file cabinet (guns/ammo?)
BuildableObjectsData[2060] = {} --sandbag
BuildableObjectsData[2096] = {} --rocking chair
BuildableObjectsData[964] = {} --army crate(strongbox)
BuildableObjectsData[1345] = {} --black dumpster (materials storage)
BuildableObjectsData[1362] = {} --fire barel
BuildableObjectsData[2146] = {} --stretcher (medic?)
BuildableObjectsData[1271] = {} --wooden gunbox
BuildableObjectsData[2115] = {} --wooden table
BuildableObjectsData[1472] = {} --wooden steps
BuildableObjectsData[1418] = {} --wooden panel fence
BuildableObjectsData[1410] = {} --wooden panel fence
BuildableObjectsData[1407] = {} --wooden panel fence
BuildableObjectsData[1446] = {} --wooden panel fence
BuildableObjectsData[1456] = {} --wooden panel fence
BuildableObjectsData[3260] = {} --wooden panel (vertical)
BuildableObjectsData[1459] = {} --wooden road barrier
BuildableObjectsData[1424] = {} --metal road barrier
BuildableObjectsData[1447] = {} --dyn mesh fence
BuildableObjectsData[1411] = {} --dyn barbed mesh fence
BuildableObjectsData[16281] = {} --gate entrance
BuildableObjectsData[3261] = {} --greenhouse
BuildableObjectsData[1466] = {} --simple scaffold
BuildableObjectsData[1464] = {} --scaffold with wooden panel
BuildableObjectsData[1426] = {} --large scaffold
BuildableObjectsData[1428] = {} --short ladder
BuildableObjectsData[1437] = {} --long ladder
BuildableObjectsData[11496] = {} --large wooden platform - bad collision on lower side
BuildableObjectsData[2937] = {} --metal plank
BuildableObjectsData[1492] = {} --wooden door
BuildableObjectsData[1499] = {} --metal door
BuildableObjectsData[5340] = {} --metal wall
BuildableObjectsData[3049] = {} --quarry fence
BuildableObjectsData[3265] = {} --private sign
BuildableObjectsData[1451] = {} --hen pen
BuildableObjectsData[1452] = {} --outhouse
BuildableObjectsData[1448] = {} --flat pallet (floor/roof?)
BuildableObjectsData[1482] = {} --wooden elevated platform
BuildableObjectsData[16405] = {} --wooden hut skeleton
BuildableObjectsData[1483] = {} --sloped porch roof
BuildableObjectsData[1471] = {} --small wooden platform/ dyn_porch
BuildableObjectsData[18259] = {} --log cabin 1
BuildableObjectsData[18267] = {} --log cabin 2
BuildableObjectsData[3302] = {} --corrugated metal panels
BuildableObjectsData[3280] = {} --metal grate
BuildableObjectsData[2636] = {} --wooden chair
BuildableObjectsData[12991] = {} --wooden shack
BuildableObjectsData[3927] = {} --wooden notice board

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

		if getElementModel(buildable_objects[player]) == 1492 or getElementModel(buildable_objects[player]) == 1499 then -- don't freeze doors
			setElementFrozen(buildable_objects[player],false)
			setElementVelocity(buildable_objects[player],0,0,0)
		else
			setElementFrozen(buildable_objects[player],true)
		end

		setElementAlpha(buildable_objects[player],255)

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
	
		outputChatBox("Can't build here! Reposition object or press num_9 to cancel.", player)
	
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