--[[local blip = createBlip(-1647,-2000,14, 41 ,2,255,0,255,255)
local blip2 = createBlip(1814,-2470,14, 5 ,2,255,255,0,255)
local blip3 = createBlip(2070,-1697,14, 31 ,2,0,200,255,255)
setElementData(blip, "blip.visibleOnScreen", true)
setElementData(blip2, "blip.visibleOnScreen", true)
setElementData(blip3, "blip.visibleOnScreen", true)]]

local sx, sy = guiGetScreenSize()

local fadeDistance = 30
local minimumDistance = 5

local distanceFromEdge = 0.4

local backgroundSize = 26
local backgroundAlpha = 0

local blipImageSize = 20

addEventHandler("onClientRender", root,
function()
	if currentMission and currentMission ~= "None" then
		local middleX, middleY = getWorldFromScreenPosition(sx/2, sy/2, 100)
		local cameraX, cameraY = getCameraMatrix()
		local playerX, playerY, playerZ = getElementPosition(localPlayer)
		local cameraAngle = findRotation(cameraX, cameraY, middleX, middleY)
		
		for index, blip in ipairs(getElementsByType("blip")) do
			if getElementData(blip, "blip.visibleOnScreen") then
				local blipX, blipY, blipZ = getElementPosition(blip)
				local blipIcon = getElementData(blip, "blipIcon") or getBlipIcon(blip)
				local blipR, blipG, blipB, blipA = getBlipColor(blip)
				local alpha = blipA
				
				local targetAngle = findRotation(playerX, playerY, blipX, blipY)
				local realAngle = targetAngle - cameraAngle + 180
				
				if realAngle < 0 then
					realAngle = realAngle + 360
				end
				if realAngle > 360 then
					realAngle = realAngle - 360
				end
				
				local distance = getDistanceBetweenPoints3D(blipX, blipY, blipZ, playerX, playerY, playerZ)
				distance = math.floor(distance)
				
				local screenX, screenY = (sx * 0.5) + math.sin(math.rad(realAngle)) * (sy * distanceFromEdge), (sy * 0.5) + math.cos(math.rad(realAngle)) * (sy * distanceFromEdge)
				
				if distance <= fadeDistance then
					alpha = (blipA/(fadeDistance+minimumDistance)) * distance
					alphabg = (backgroundAlpha/(fadeDistance+minimumDistance)) * distance
					if distance < minimumDistance then
						alpha = 0
						alphabg = 0
					end
				else
					alpha = blipA
					alphabg = backgroundAlpha
				end
				
				--dxDrawBorder(screenX-backgroundSize/2, screenY-backgroundSize/2, backgroundSize, backgroundSize, 2, tocolor(blipR, blipG, blipB,alpha))
				--dxDrawRectangle(screenX-backgroundSize/2, screenY-backgroundSize/2, backgroundSize, backgroundSize, tocolor(0,0,0,alphabg))
				
				local textOffset = 18
				local text = tostring(convertNumber(distance)) .. " m"
				dxDrawText(text, screenX+1, screenY+textOffset+1, screenX+1, screenY+textOffset+1, tocolor(0, 0, 0, alpha), 1, "default-bold", "center", "top")
				dxDrawText(text, screenX, screenY+textOffset, screenX, screenY+textOffset, tocolor(255, 255, 255, alpha), 1, "default-bold", "center", "top")
				
				dxDrawImage(screenX-blipImageSize/2, screenY-blipImageSize/2, blipImageSize, blipImageSize, "blips/" .. blipIcon .. ".png", 0, 0, 0, tocolor(blipR, blipG, blipB, alpha))
			end
		end
	end
end)

function convertNumber(number)
	local formatted = number
	while true do
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return formatted
end

function dxDrawBorder(x, y, w, h, size, color, postGUI)
	size = size or 2;
	dxDrawRectangle(x - size, y, size, h, color or tocolor(0, 0, 0, 180), postGUI);
	dxDrawRectangle(x + w, y, size, h, color or tocolor(0, 0, 0, 180), postGUI);
	dxDrawRectangle(x - size, y - size, w + (size * 2), size, color or tocolor(0, 0, 0, 180), postGUI);
	dxDrawRectangle(x - size, y + h, w + (size * 2), size, color or tocolor(0, 0, 0, 180), postGUI);
end

function findRotation(startX, startY, targetX, targetY)
	local t = -math.deg(math.atan2(targetX - startX, targetY - startY))
	if t < 0 then
		t = t + 360
	end
	return t
end