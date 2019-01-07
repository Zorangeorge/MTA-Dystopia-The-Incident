-- Exp.server by Manawydan

local onDataChange=function(data,old)
if(data=="experience") and(old~=nil) then
local level = getPlayerLevel(source)
if level and level == 12 then return end
local exp = getElementData(source,data)
local n = level+1
local up,Name = getLevelValues(n)
if(exp>=up)then
triggerEvent("onPlayerLevelUp",source,n,level)
triggerClientEvent(source,"LevelUpScreen", source)
setPlayerExp(source,0)
setPlayerLevel(source,n)
end
end
end
addEventHandler("onElementDataChange",root,onDataChange)

addEvent("onPlayerLevelUp")
addEventHandler("onPlayerLevelUp",root,
function(level,old)
--outputDebugString("You leveled up!",source)
--playSound3DToElement(source,source,"sounds/levelup.wav",1,0.5)
end)

function playSound3DToElement(Element,only,sound,distancia,volume)
if(Element) and (isElement(Element)) then
only = only or root
triggerClientEvent(only,"playSoundToServer",Element,sound,distancia,volume)
end
end

-- save exp/level

function onQuit()
local account = getPlayerAccount(source)
if account and not isGuestAccount(account) then
local playerExp = getPlayerExp(source)
local playerLevel = getPlayerLevel(source)

setAccountData(account,"experience",playerExp)
setAccountData(account,"level",playerLevel)
end
end
addEventHandler("onPlayerQuit",root,onQuit)

-- load exp/level

function onLogin(before,currentAcc)
if currentAcc and not isGuestAccount(currentAcc) then
local loadExp = getAccountData(currentAcc,"experience") or 0
local loadLevel = getAccountData(currentAcc,"level") or 0
setPlayerLevel(source,loadLevel)
setPlayerExp(source,loadExp)
setElementData(source,"veh_col_veh",nil,true)
setElementData(source,"insideFuelCol",nil,true)
end
end
addEventHandler("onPlayerLogin",root,onLogin)


