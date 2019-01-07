-- server script
-- MTA:SA Deathmatch 1.0 Developer preview 2 compatible

local root = getRootElement()

function callbackPlayerJoin()
  if (spawnPlayer(source, 0, 0, 5)) then
    fadeCamera(source, true)
  end
end

function callbackResourceStart(startedResource)
  if (getResourceName(startedResource) == "bomber") then
    createMarker(0, 0, 2.0, "cylinder", 5, 117, 193, 36, 255)
    createMarker(64, 220, 0, "cylinder", 5, 44, 124, 214, 255)
    call(getResourceFromName("bomber"), "regBombMarkers", getElementsByType("marker", root))
  end
end

addEventHandler("onPlayerJoin", root, callbackPlayerJoin)
addEventHandler("onResourceStart", root, callbackResourceStart)

-- Author: Ace_Gambit