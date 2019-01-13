---------STARTUP----------

setFPSLimit(60)

setWeather ( 10 )

	function hideMarkers()
	
	for _,marker in ipairs (getElementsByType ( "marker" )) do 
	
	if getMarkerType(marker) == "checkpoint" then destroyElement(marker) end--setMarkerColor ( marker, 0, 0, 0, 255 ) end
	
	end
	end
	
addEventHandler( "onResourceStart", resourceRoot,hideMarkers ) 
addCommandHandler("hidemarkers",hideMarkers)

setMinuteDuration (10000)-- one game minute is 10 sec real time, one game day is 4 hours real time; need to be altered on both server and client? should be the same with the respawn period of objects, items and vehicles; I must alter the time cycle to obtain 1 h night time for 3 hours daytime


function onResourceStart ( ) -- turn off name tags for players, they are replaced with custom ones
    local players = getElementsByType ( "player" ) -- Store all the players in the server into a table
    for key, player in ipairs ( players ) do       -- for all the players in the table
        setPlayerNametagShowing ( player, false )  -- turn off their nametag
    end
end
addEventHandler ( "onResourceStart", resourceRoot, onResourceStart )
 
function onPlayerJoin ( )
      -- Whoever joins the server should also have their nametags deactivated
	setPlayerNametagShowing ( source, false )
end
addEventHandler ( "onPlayerJoin", root, onPlayerJoin )

--TEAMS SETUP-----------------------------------------------------------------------------------------------------------------------------

function teamsSetup () --setting teams
    
	Bandits = createTeam ( "Bandits", 158, 106, 58 )
	Raiders = createTeam ( "Raiders", 235, 58, 19 ) 
    Scavengers = createTeam ( "Scavengers", 192, 192, 192 )
    Establishment = createTeam ("Establishment", 95, 95, 95 )
    Neutral = createTeam ("",0, 0, 0 )
    CDF = createTeam ("CDF", 72, 108, 176 )
    Zeds = createTeam ("Zombies", 100,209,63 )
	
    setTeamFriendlyFire( Raiders, true) -- false = no damage
    setTeamFriendlyFire( Scavengers, true)
    setTeamFriendlyFire( Establishment, true)
    setTeamFriendlyFire( Bandits, true)
	setTeamFriendlyFire( CDF, true)
	setTeamFriendlyFire( Neutral, true)
end

addEventHandler("onResourceStart", resourceRoot, teamsSetup)

function isPedDrivingVehicle(ped)
    assert(isElement(ped) and (getElementType(ped) == "ped" or getElementType(ped) == "player"), "Bad argument @ isPedDrivingVehicle [ped/player expected, got " .. tostring(ped) .. "]")
    local isDriving = isPedInVehicle(ped) and getVehicleOccupant(getPedOccupiedVehicle(ped)) == ped
    return isDriving, isDriving and getPedOccupiedVehicle(ped) or nil
end

function callClientFunction(client, funcname, ...)
    local arg = { ... }
    if (arg[1]) then
        for key, value in next, arg do
            if (type(value) == "number") then arg[key] = tostring(value) end
        end
    end
    -- If the clientside event handler is not in the same resource, replace 'resourceRoot' with the appropriate element
    triggerClientEvent(client, "onServerCallsClientFunction", resourceRoot, funcname, unpack(arg or {}))
end

addCommandHandler ( "clearchat",
	function ( source )
		for i=1,20 do 
			outputChatBox ( " ", source )
			outputConsole ( " ", source )
		end
	end
)


addCommandHandler ( "getpos",
	function ( player, commandName )
		local x, y, z = getElementPosition ( player )
			outputChatBox ( ""..x..", "..y..", "..z, player, 255, 255, 255 )
	end
)

function clearPeds ()
        for i, v in ipairs(getElementsByType("ped")) do
            destroyElement(v)
        end
    end
addCommandHandler("clearpeds", clearPeds)

 function table.contains(table, element)
  for index, value in pairs(table) do
    if value == element then
      return index
    end
  end
  return false
end

function createMarkerAttachedTo(element, mType, size, r, g, b, a, visibleTo, xOffset, yOffset, zOffset)
	mType, size, r, g, b, a, visibleTo, xOffset, yOffset, zOffset = mType or "checkpoint", size or 4, r or 0, g or 0, b or 255, a or 255, visibleTo or getRootElement(), xOffset or 0, yOffset or 0, zOffset or 0
	assert(isElement(element), "Bad argument @ 'createMarkerAttachedTo' [Expected element at argument 1, got " .. type(element) .. "]") assert(type(mType) == "string", "Bad argument @ 'createMarkerAttachedTo' [Expected string at argument 2, got " .. type(mType) .. "]") assert(type(size) == "number", "Bad argument @ 'createMarkerAttachedTo' [Expected number at argument 3, got " .. type(size) .. "]") assert(type(r) == "number", "Bad argument @ 'createMarkerAttachedTo' [Expected number at argument 4, got " .. type(r) .. "]")	assert(type(g) == "number", "Bad argument @ 'createMarkerAttachedTo' [Expected number at argument 5, got " .. type(g) .. "]") assert(type(b) == "number", "Bad argument @ 'createMarkerAttachedTo' [Expected number at argument 6, got " .. type(b) .. "]") assert(type(a) == "number", "Bad argument @ 'createMarkerAttachedTo' [Expected number at argument 7, got " .. type(a) .. "]") assert(isElement(visibleTo), "Bad argument @ 'createMarkerAttachedTo' [Expected element at argument 8, got " .. type(visibleTo) .. "]") assert(type(xOffset) == "number", "Bad argument @ 'createMarkerAttachedTo' [Expected number at argument 9, got " .. type(xOffset) .. "]") assert(type(yOffset) == "number", "Bad argument @ 'createMarkerAttachedTo' [Expected number at argument 10, got " .. type(yOffset) .. "]") assert(type(zOffset) == "number", "Bad argument @ 'createMarkerAttachedTo' [Expected number at argument 11, got " .. type(zOffset) .. "]")
	local m = createMarker(0, 0, 0, mType, size, r, g, b, a, visibleTo)
	if m then if attachElements(m, element) then return m end end return false
end

-----------BREAKABLE OBJ SYNC by eXo|dragon
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),
function ()
	setElementData(getRootElement(),"breakableObjectSyncTrustAttacker",get("breakableobjectsync.TrustObjectAttacker"),true)
end)

addEvent("objSBreak",true)
addEventHandler("objSBreak",getRootElement(),
function (obj)
	if client == source then
		triggerEvent("onObjectBreak",obj,client)
	end
end)

addEvent("onObjectBreak",false)
addEventHandler("onObjectBreak",getRootElement(),
function (attacker)
	if not wasEventCancelled() then
		triggerClientEvent("objCBreak",attacker,source)
		setElementData(source,"objBroken",true,true)
	elseif getElementData(getRootElement(),"breakableObjectSyncTrustAttacker") and attacker then
		triggerClientEvent(attacker,"onClientObjectRespawn",obj,false)
	end
end)

function breakObject(obj)
	if isElement(obj) and getElementType(obj) == "object" then
		return triggerEvent("onObjectBreak",obj)
	else
		return false
	end
end

function respawnObject(obj)
	if isElement(obj) and getElementType(obj) == "object" then
		return triggerEvent("onObjectRespawn",obj,true)
	else
		return false
	end
end

addEvent("onObjectRespawn",false)
addEventHandler("onObjectRespawn",getRootElement(),
function (triggeredByScript)
	if not wasEventCancelled() then
		triggerClientEvent("onClientObjectRespawn",source,triggeredByScript)
		setElementData(source,"objBroken",false,true)
	end
end)

function firecolBurn(hitElement)
	
local elemType = getElementType(hitElement)

	if ( (elemType ~= "player") or (getElementData(source,"burncol") ~= true) ) then return end

	if elemType == "player" and isPedInVehicle(hitElement) then	return  -- don't trigger for players inside vehicles
	
	else  -- if a player hits a fire burn colshape on foot
		
		setElementData(hitElement,"onfire", true)
		outputStatusInfo("On fire!", hitElement, 250, 0, 0, 5000)
		setPedOnFire(hitElement,true)
		setTimer(setPedOnFire,5000,1,hitElement,false)
		local player = hitElement
		triggerClientEvent(player,"FireBurnPain",player)
	end	

end
addEventHandler("onColShapeHit", root, firecolBurn) 

function firecolBurnsPedsToo(hitElement)
	
local elemType = getElementType(hitElement)

	if ( (elemType ~= "ped") or (getElementData(source,"burncol") ~= true) ) then return end

	if elemType == "ped" and isPedInVehicle(hitElement) then	return  -- don't trigger for players inside vehicles
	
	else  -- if a ped hits a fire burn colshape on foot
		
		setElementData(hitElement,"onfire", true)
		setPedOnFire(hitElement,true)
		setTimer(setPedOnFire,5000,1,hitElement,false)
		setTimer(function() 
			local health = getElementHealth(hitElement)
			setElementHealth(hitElement,health - 5)	end
		,1000,5)	
	end	
end
addEventHandler("onColShapeHit", root, firecolBurnsPedsToo) 

function firecolHeals(hitElement)
	
local elemType = getElementType(hitElement)
	if ( (elemType ~= "player") or (getElementData(source,"firecol") ~= true) ) then return end
	if elemType == "player" and isPedInVehicle(hitElement) then	return  -- don't trigger for players inside vehicles
	else  -- if a player hits a fire colshape
		setElementData(hitElement,"infirecol", true)
	end	
	triggerClientEvent(hitElement,"showHelpMessageEvent",hitElement,firebin_help_messsage)
end
addEventHandler("onColShapeHit", root, firecolHeals) 

function firecolLeave(hitElement)
	
local elemType = getElementType(hitElement)
	if ( (elemType ~= "player") or (getElementData(source,"firecol") ~= true) ) then return end
	if elemType == "player" and isPedInVehicle(hitElement) then	return  -- don't trigger for players inside vehicles
	else  -- if a player leaves a fire colshape
		setElementData(hitElement,"infirecol", false)
	end	
end
addEventHandler("onColShapeLeave", root, firecolLeave) 

function onFireColDataChange(data,old)
	if getElementType(source)=="player" and (data=="infirecol") and not old then
		local player = source
		triggerClientEvent(player,"FireColHeals",player)
		outputInteractInfo("Cook\n[J]",player, 255,255,255)
	elseif (data=="infirecol") and old == true then
		local player = source
		triggerClientEvent(player,"FireColHealStops",player)
	end
end
addEventHandler("onElementDataChange",root,onFireColDataChange)

---------SYNCHRONIZE TIME
function syncClientTime ()
local player = source
serverhour, serverminutes = getTime ()
triggerClientEvent(player, "SyncTime", resourceRoot, serverhour, serverminutes)
end
addEventHandler ( "onPlayerLogin", root, syncClientTime )

function getMyData ( thePlayer, command ) 
    local data = getAllElementData ( thePlayer )     -- get all the element data of the player who entered the command
    for k, v in pairs ( data ) do                    -- loop through the table that was returned
        outputConsole ( k .. ": " .. tostring ( v ) )             -- print the name (k) and value (v) of each element data, we need to make the value a string, since it can be of any data type
    end
end
addCommandHandler ( "elemdata", getMyData )-- output all element data to console

---------GLUE to vehicles
--[[function gluePlayer(slot, vehicle, x, y, z, rotX, rotY, rotZ)
	attachElements(source, vehicle, x, y, z, rotX, rotY, rotZ)
	setPedWeaponSlot(source, slot)
	setElementData(source, "glued",true)
end
addEvent("gluePlayer",true)
addEventHandler("gluePlayer",getRootElement(),gluePlayer)
function ungluePlayer()
	detachElements(source)
	setElementData(source, "glued",true)
end
addEvent("ungluePlayer",true)
addEventHandler("ungluePlayer",getRootElement(),ungluePlayer)
-- Vehicle
addEvent("glueVehicle",true)
function glueVehicle(attachedTo, x, y, z, rotX, rotY, rotZ)
	attachElements(source, attachedTo, x, y, z, rotX, rotY, rotZ)
end
addEventHandler("glueVehicle",getRootElement(),glueVehicle)

addEvent("unglueVehicle",true)
function unglueVehicle()
	detachElements(source)
end
addEventHandler("unglueVehicle",getRootElement(),unglueVehicle)]]

function checkagainsttable(objtocheck,thetable)
	for _,objid in pairs(thetable) do
		if objid == objtocheck then
			return true
			--break
		end
	end	
	return false
end

----LIST ONLINE PLAYERS
function listOnlinePlayers ( thePlayer, command )
    local allplayers = getElementsByType ( "player" )     
    for k, player in pairs ( allplayers ) do                    -- loop through the table that was returned
        outputDebugString ( k .. ": " .. getPlayerName(player) )    -- print 
    end
end
addCommandHandler ( "listplayers", listOnlinePlayers )

--LOD ADJUSTMENTS

largeObjectsForLODAdjust = {
8464,
8392,
8390,
7584,
8421,
4336,
8489,
10357,
354,
16258,
6994,
1383,
1388,
1391,
3887,
3866,
11011,
4550,
4571,
4832,
1395,
5463,
10795,
10793,
10794,
791,
722,
790,
705,
14396,
14397,
2956,
10771,
10770,
11237,
1595,
3279
}
outputDebugString("loading LODs...")
for i,w in ipairs(getElementsByType("object")) do
	if table.contains(largeObjectsForLODAdjust,getElementModel(w)) then
	local x,y,z = getElementPosition(w)
	local rx, ry, rz = getElementRotation(w)
			
	setLowLODElement(w, createObject(getElementModel(w), x, y, z, rx, ry, rz, true));
	local lowlod = getLowLODElement (w)
	setElementCollisionsEnabled(lowlod,false) -- Important
	end
end


function isPlayerInACL(player, acl)
   local accountName = getAccountName( getPlayerAccount(player) )
   if accountName ~= "guest" and type( aclGetGroup(acl) ) == "userdata" then
      return isObjectInACLGroup( "user."..accountName, aclGetGroup(acl) )
   end
   return false
end