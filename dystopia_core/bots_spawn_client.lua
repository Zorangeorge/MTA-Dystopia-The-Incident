function getZone_func()

local player = getLocalPlayer()
local zonex,zoney,zonez = getElementPosition(player)
local zone = getZoneName(zonex,zoney,zonez)

return zone

end
