--[[
THE AUTHOR OF THIS SCRIPT IS SAM@KE, HE MADE A VEHICLE DAMAGE SCRIPT AND I CONVERTED IT INTO A EXPLODING DISTANCE SCRIPT.
	Name: 101ResourceReleases
	Filename: VehicleDamage.lua
	Author: Sam@ke
--]]

local screenWidth, screenHeight
local player = getLocalPlayer()
local vehicle
local vehicleDamageShader
local screenSource
local impactTimer

local canImpact = "true"
--local tinnitusSound
local impactSoundVolume = 0
local blurStrength = 0
local colorFadeValue = 0


addEventHandler("onClientResourceStart", resourceRoot, 
function()
	
	screenWidth, screenHeight = guiGetScreenSize()
	vehicleDamageShader =  dxCreateShader("res/Shaders/damage.fx")
	screenSource = dxCreateScreenSource(screenWidth, screenHeight)
	
	if (not vehicleDamageShader) or (not screenSource) then
	end
end)


addEventHandler("onClientPreRender", root, 
function()
	
	if  (vehicleDamageShader) and (screenSource) then
		screenSource:update()
		
		blurStrength = blurStrength - 0.1
		
		if (blurStrength <= 0) then
			blurStrength = 0
		end
		
		
		if getCameraShakeLevel()<=1 then
		setCameraShakeLevel (0)
		else
		setCameraShakeLevel(getCameraShakeLevel()-2)
		end
		
		colorFadeValue = colorFadeValue - 0.0025
		
		if (colorFadeValue <= 0) then
			colorFadeValue = 0
		end
		
		impactSoundVolume = impactSoundVolume - 0.005
		
		if (impactSoundVolume <= 0) then
			impactSoundVolume = 0
			
			if (heartSound) and (isElement(heartSound)) then
				heartSound:stop()
			end
		end
		
		if (heartSound) and (isElement(heartSound)) then
			heartSound:setVolume(impactSoundVolume)
		end
		
--[[		if (tinnitusSound) and (isElement(tinnitusSound)) then
			tinnitusSound:setVolume(impactSoundVolume)
		end]]
		
		vehicleDamageShader:setValue("screenSource", screenSource)
		vehicleDamageShader:setValue("blurStrength", blurStrength)
		vehicleDamageShader:setValue("colorFadeValue", colorFadeValue)
		
		dxDrawImage(0, 0, screenWidth, screenHeight, vehicleDamageShader)
	end
end)


addEventHandler("onClientExplosion", root,
function(x,y,z)
local x2,y2,z2 = getElementPosition (localPlayer)
if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)<15 and getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)>=0 then
local eee =  getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
			setCameraShakeLevel (100)
			blurStrength = 5
			colorFadeValue = 1
			impactSoundVolume = 1
			
			--tinnitusSound = playSound("res/Sounds/tinnitus.ogg", false)
elseif getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)<25 and getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)>=15 then
local eee =  getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
			blurStrength = 3
			setCameraShakeLevel (50)
			colorFadeValue = 0.8
			impactSoundVolume = 0.7
			

			--tinnitusSound = playSound("res/Sounds/tinnitus.ogg", false)
			
			elseif getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)<35 and getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)>=25 then
local eee =  getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
			blurStrength = 1
			setCameraShakeLevel (25)
			colorFadeValue = 0.6
			impactSoundVolume = 0.4
			

			--tinnitusSound = playSound("res/Sounds/tinnitus.ogg", false)
		end

end)

addEventHandler("onClientResourceStop", resourceRoot, 
function()
	if (vehicleDamageShader) then
		vehicleDamageShader:destroy()
	end
	
	if (screenSource) then
		screenSource:destroy()
	end
	
	if (impactTimer) and (impactTimer:isValid()) then
		impactTimer:destroy()
	end
	
	
--[[	if (tinnitusSound) and (isElement(tinnitusSound)) then
		tinnitusSound:stop()
	end]]
	
				setCameraShakeLevel (0)
end)