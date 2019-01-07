-- client script
-- MTA:SA Deathmatch 1.0 Developer preview 2 compatible

local objClientBomber = nil

local root = getRootElement()
local player = getLocalPlayer()
local isFirstSpawn = true

-- callbacks
function callbackClientPlayerSpawn()
  if (source == player and isFirstSpawn) then
    isFirstSpawn = false
    objClientBomber = ObjClientBomber.create(player)
    objClientBomber:regBomber()
  end
end

function callbackRender()
  objClientBomber:callbackRender()
end

function callbackFunc(request, ...)
  objClientBomber:callbackFunc(request, arg[1])
end

addEventHandler("onClientPlayerSpawn", player, callbackClientPlayerSpawn)
addEventHandler("onClientRender", root, callbackRender)
-- custom events
addEvent("callbackClientBomber", true)
addEventHandler("callbackClientBomber", root, callbackFunc)

-- Author: Ace_Gambit