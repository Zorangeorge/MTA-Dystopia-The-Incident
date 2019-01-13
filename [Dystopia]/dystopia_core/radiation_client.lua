--radHandlerCheck = 0

function radHit() 
local health = getElementHealth(localPlayer)
local radDam = getElementData(localPlayer,"radiationDamage")

	--if health > radDam then
	setElementHealth(localPlayer,health-radDam)
	--outputDebugString("radiation damage: "..radDam)
	outputStatusInfo("-"..radDam.." hp", 250,0,0)
	--else 
	--killPed(localPlayer)
	--end
	

end

function radiationEffectsStart (hitelem,_)
	if hitelem ~= localPlayer then return end
	if not getElementData(source,"RadiationStrenght") then return end
	local radDamage = tonumber(getElementData(source,"RadiationStrenght"))
	--outputDebugString("rad damage: "..radDamage) 
	--if radHandlerCheck == 0 then 
	--addEventHandler("onClientRender",root, radiationDamage) 
	--radHandlerCheck = 1 
	setElementData(localPlayer,"radiationDamage",radDamage,true)
	radiationDamage()
	--outputDebugString("handler added") 
	--end
end

function radiationEffectsStop (hitelem,_)

	if not getElementData(source,"RadiationStrenght") then return end
	if hitelem ~= localPlayer then return end
local activeRadDamage = getElementData(localPlayer,"radiationDamage")
	if activeRadDamage >= 2 then 
	setElementData(localPlayer,"radiationDamage",activeRadDamage-2,true); 
		--if radHandlerCheck == 1 then 
		--radHandlerCheck = 0; 
		--outputDebugString("2 rad dam removed");   
		if getElementData(localPlayer,"radiationDamage") <= 0 then
			if isTimer(radDamageLoop) then 
			killTimer(radDamageLoop) 
			radDamageLoop = nil
			end 
		end
	end
end

function radiationDamage()
local activeRadDamage = getElementData(localPlayer,"radiationDamage")
	if activeRadDamage > 0 then 
		if not radDamageLoop then radDamageLoop = setTimer(radHit,5000,0) end
	end
end

addEventHandler("onClientColShapeHit",root, radiationEffectsStart)
addEventHandler("onClientColShapeLeave",root, radiationEffectsStop)

addEvent("TriggerRadFromServer",true)
addEventHandler("TriggerRadFromServer",root,radiationDamage)

function clearRad ()
	
	if source == localPlayer then 
		setElementData(localPlayer,"radiationDamage",0,true) 
	end
	
	if isTimer(radDamageLoop) then 
		killTimer(radDamageLoop) 
		radDamageLoop = nil
	end 
	
	--outputDebugString("All rad damage removed");   

end

addEventHandler("onClientPlayerWasted",root, clearRad)


