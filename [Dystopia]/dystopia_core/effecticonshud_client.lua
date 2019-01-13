setTimer(function ()

if getElementHealth(localPlayer)>0 and getCameraTarget() == localPlayer then
	local hunger = guiProgressBarGetProgress(hungerProcess)
	local thirst = guiProgressBarGetProgress(thirstProcess)
	local campfire = getElementData(localPlayer,"infirecol" )
	local bleeding = getElementData(localPlayer,"bleeding")
	local incapacitated = getElementData(localPlayer,"incapacitated")
	local pain =  getElementData(localPlayer,"pain")
	local minorfracture = getElementData(localPlayer,"minorfracture")
	local majorfracture = getElementData(localPlayer,"majorfracture")
	local deathdanger = getElementHealth(localPlayer)
	local fire = isPedOnFire(localPlayer)
	local exhausted
	if stamina <=100 then exhausted = true else exhausted = nil end
	local tired
	if stamina >100 and stamina <=200 then tired = true else tired = nil end
	local butchering = getElementData(localPlayer,"insidebutchercol")
	--local vehicle = getElementData(localPlayer,"veh_col_veh")
	--if getPedOccupiedVehicle(localPlayer) then vehicle = nil end --don't show icon when driving
	--local fuelbarrel = getElementData(localPlayer,"insideFuelCol")
	local activeRadDamage = getElementData(localPlayer,"radiationDamage")
	local infected = getElementData(localPlayer,"infection")

		if fire then 
		blinkEffect1="#ce480aK"
			setTimer(setPedOnFire,1000,1,localPlayer,false)
			triggerEvent("FireBurnPain",localPlayer)
		else blinkEffect1=" "
		end 
			
		if campfire == true then 
		blinkEffect2="#41b641C"
		else blinkEffect2=" "
		end 
		
		if bleeding == true then 
		blinkEffect3="#b02c14B"
		else blinkEffect3=" "
		end 
			
		if incapacitated == true then 
		blinkEffect4="#e5e5e5I"
		else blinkEffect4=" "
		end
		
		if minorfracture == true then 
		blinkEffect5="#e5e5e5F"
		else blinkEffect5=" "
		end
		
		if majorfracture == true then 
		blinkEffect6="#fd4000F"
		else blinkEffect6=" "
		end
		
		if pain == true then 
		blinkEffect7="#e5e5e5P"
		else blinkEffect7=" "
		end
		
		if butchering ~= nil then 
		blinkEffect8="#41b641L"
		else blinkEffect8=" "
		end
		
		--[[if vehicle then 
		blinkEffect9="#41b641J"
		else blinkEffect9=" "; vehicle = nil
		end]]
		
		if exhausted ~= nil then 
		blinkEffect10="#c75133A"
		else blinkEffect10=" "
		end
		
		if tired ~= nil then 
		blinkEffect11="#d69056A"
		else blinkEffect11=" "
		end
		
		--[[if fuelbarrel ~= nil then 
		blinkEffect12="#41b641G"
		else blinkEffect12=" "
		end]]
		
		if hunger == 0 then 
		blinkEffect13="#d6bd56H"
		else blinkEffect13=" "
		end
		
		if thirst == 0 then 
		blinkEffect14="#33a6c7T"
		else blinkEffect14=" "
		end
		
		if deathdanger <= 10 then 
		blinkEffect15="#b02c14D"
		else blinkEffect15=" "
		end
		
		if activeRadDamage and activeRadDamage > 0 then
		blinkEffect16="#d6bd56R"
		else blinkEffect16=" "
		end
		
		if infected ~= "uninfected" then
		blinkEffect17="#41b641E"
		else blinkEffect17=" "
		end
		
		blinkeffecttext = ""..tostring(blinkEffect1)..""
							..tostring(blinkEffect2)..""
							..tostring(blinkEffect3)..""
							..tostring(blinkEffect4)..""
							..tostring(blinkEffect5)..""
							..tostring(blinkEffect6)..""
							..tostring(blinkEffect7)..""
							..tostring(blinkEffect8)..""
							--..tostring(blinkEffect9)..""
							..tostring(blinkEffect10)..""
							..tostring(blinkEffect11)..""
							--..tostring(blinkEffect12)..""
							..tostring(blinkEffect13)..""
							..tostring(blinkEffect14)..""
							..tostring(blinkEffect15)..""
							..tostring(blinkEffect16)..""
							..tostring(blinkEffect17)..""
		
		blinkeffecttext = blinkeffecttext:gsub( " ", "" ) --delete spaces from string
		
		--if getPedOccupiedVehicleSeat(localPlayer) then blinkeffecttext = "" end
		
		if blinkeffecttext and effectsshown then
			return
		elseif blinkeffecttext and not effectsshown then
			addEventHandler("onClientRender",getRootElement(),blinkeffecticons)
			effectsshown = true	
		elseif not blinkeffecttext and effectsshown then
			removeEventHandler("onClientRender",getRootElement(),blinkeffecticons)
			effectsshown = false
		end
end
end,1000,0)

function blinkeffecticons ()
	if not LoginVisible and not myTitleImage and dialogueGuiShowed ~=1  and localPlayerBubbleActive ~= 1 then
		dxDrawTextOnElement(localPlayer,blinkeffecttext,1,1,255,255,255,200,0.3,DystopiaFont,false,false,false,false,false,false,localPlayer)
	end
end

-- dxDrawTextOnElement by Has[S]oN.
function dxDrawTextOnElement(TheElement,text,height,distance,R,G,B,alpha,size,font,checkBuildings,checkVehicles,checkPeds,checkDummies,seeThroughStuff,ignoreSomeObjectsForCamera,ignoredElement)

if not isElement(TheElement) then  return end 
--if not isElement(TheElement) then removeEventHandler("onClientRender",root,showItemWorldInfo) return end

				local x, y, z = getElementPosition(TheElement)
				local x2, y2, z2 = getElementPosition(localPlayer)
				local distance = distance or 20
				local height = height or 1
                                local checkBuildings = checkBuildings or true
                                local checkVehicles = checkVehicles or false
                                local checkPeds = checkPeds or false
                                local checkObjects = checkObjects or true
                                local checkDummies = checkDummies or true
                                local seeThroughStuff = seeThroughStuff or false
                                local ignoreSomeObjectsForCamera = ignoreSomeObjectsForCamera or false
                                local ignoredElement = ignoredElement or nil
				if (isLineOfSightClear(x, y, z, x2, y2, z2, checkBuildings, checkVehicles, checkPeds , checkObjects,checkDummies,seeThroughStuff,ignoreSomeObjectsForCamera,ignoredElement)) then
					local sx, sy = getScreenFromWorldPosition(x, y, z+height)
					if(sx) and (sy) then
						local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
						if(distanceBetweenPoints < distance) then
							--dxDrawText(text, sx+2+4, sy+2+4, sx, sy, tocolor(0, 0, 0, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center", false, false, false,true)
							dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center", false, false, true,true)
							
			end
		end
	end
end

--[[local standingOnElem --= nil
local theItemName --= nil
local handlerAddDone = nil
addEvent("ShowItemWorldInfo",true)
function startShowingItemName (elem,itemName)
standingOnElem = elem
theItemName = itemName 
	if handlerAddDone == nil then 
		addEventHandler("onClientRender",root,showItemWorldInfo);
		handlerAddDone = 1
		setTimer(function() removeEventHandler("onClientRender",root,showItemWorldInfo); standingOnElem = nil handlerAddDone = nil end,60000,1)
	end
end

function showItemWorldInfo ()
	--dxDrawTextOnElement(standingOnElem,theItemName,0,1,255,255,255,200,1,ChunkfiveFontDXSmall,false,false,false,false,false,false)--,-0.3,1,255,255,255,200,0.05,ChunkfiveFontDXSmall,false,false,false,false,false,false) -monospacefont
end

addEventHandler("ShowItemWorldInfo",root,startShowingItemName)]]
