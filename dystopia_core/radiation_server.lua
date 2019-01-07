local radZones = getElementsByType("Radiation_Zone")

outputDebugString("loading radiation zones...")

for _,radZone in ipairs(radZones) do

local radStrg = getElementData(radZone,"RadiationStrenght") --or "Light"
local radius = getElementData(radZone,"RadZoneSize") --or 10

	local x,y,z = getElementPosition(radZone)
	local radCol = createColSphere(x,y,z,radius)
	setElementData(radCol,"RadiationStrenght",radStrg,true)
	
	
end

--[[function triggerRadDamage (player) --WIP

end

function stopRadDamage (player) --WIP

end

function checkPlayerForRad ()
if source ~= client then return end
local radLevel =  getElementData("radiationDamage")

if radLevel and radLevel ~= 0 then triggerRadDamage(client) else stopRadDamage(client) end

end
addEventHandler("onElementDataChange",root,checkPlayerForRad)]]