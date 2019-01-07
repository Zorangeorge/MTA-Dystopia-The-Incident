-- server script
-- MTA:SA Deathmatch 1.0 Developer preview 2 compatible

local objBomber = nil

local resource = getThisResource()
local resourceRoot = getResourceRootElement(resource)
local resourceMapRoot = getRootElement()

-- callbacks
function callbackResourceStart()
  outputDebugString("* " .. getResourceInfo(resource, "name") .. " " .. getResourceInfo(resource, "version") .. " by " .. getResourceInfo(resource, "author"))
  outputDebugString("* " .. getResourceInfo(resource, "description"))
  objBomber = ObjBomber.create(resource)
  objBomber:regBomber()
end

function callbackResourceStop()
  if (resourceMapRoot) then
    unregBombMarkers(getElementsByType("marker", resourceMapRoot))
  end
  outputDebugString("* Bomber resource stopped")
end

function callbackMarkerHit(hitPlayer, matchingDimension)
  if (matchingDimension) then
    objBomber:callbackFunc("funcReloadBomber", hitPlayer)
  end
end

function callbackFunc(request, ...)
  objBomber:callbackFunc(request, source, arg[1])
end

-- exports
function regBombMarker(marker)
  addEventHandler("onMarkerHit", marker, callbackMarkerHit, false)
end

function regBombMarkers(markers)
  for _, marker in ipairs(markers) do
    addEventHandler("onMarkerHit", marker, callbackMarkerHit, false)
  end
end

function unregBombMarker(marker)
  removeEventHandler("onMarkerHit", marker, callbackMarkerHit)
end

function unregBombMarkers(markers)
  for _, marker in ipairs(markers) do
    removeEventHandler("onMarkerHit", marker, callbackMarkerHit)
  end
end

addEventHandler("onResourceStart", resourceRoot, callbackResourceStart)
addEventHandler("onResourceStop", resourceRoot, callbackResourceStop)
-- custom events
addEvent("callbackServerBomber", true)
addEventHandler("callbackServerBomber", resourceMapRoot, callbackFunc)

-- Author: Ace_Gambit