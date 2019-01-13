addEvent("onInfected",true)
--addEvent("onInfected2",true)
addEvent("clearInfectionEffects",true)

local infectionCoughSound
local zedShader

function infectionDamage ()
local health = getElementHealth(localPlayer)
if health <= 10 then triggerServerEvent("killPedSpecial",localPlayer,root) else setElementHealth(localPlayer,health-10) end
infectionCoughSound = playSound("sounds/cough.mp3",false)
outputStatusInfo("-10 hp",255,0,0)
end

function createzedshader ()
local screenX, screenY = guiGetScreenSize()
if isElement(zedShader) then destroyElement(zedShader) end
zedShader = guiCreateStaticImage( 0, 0, screenX, screenY, "shaders/infectionshader.png", false ) 
guiMoveToBack (zedShader)
--outputDebugString("shader created")
end

function startInfectionStage2 ()
if not infectionDamageLoop then infectionDamageLoop = setTimer(infectionDamage,1000*35,0) end --10000*2,0) end
outputStatusInfo("Infection aggravated!",240, 0, 0)
setElementData(localPlayer,"infection","stage2",true)
playSound("sounds/wasted.mp3")
createzedshader ()
--outputDebugString("stage2 started")
end

--[[addEventHandler("onInfected2", root, function()
startInfectionStage2 ()
end)]]
		
addEventHandler("onInfected", root, function()
        --addEventHandler("onClientRender", root, drawInfected1) --in screenmessages_client
		--removeScreen("infected")
		setElementData ( source, "infection", "stage1",true) 
		outputStatusInfo("Infected!",240, 0, 0)
        playSound("sounds/wasted.mp3")
		if isTimer(infectionStage2timer) then killTimer(infectionStage2timer) end 
		infectionStage2timer = setTimer(startInfectionStage2,60000*20,1) --end--60000*20,1) end
		end)
		
--[[addEventHandler("onClientPlayerWasted",root,function () 
if isTimer(infectionStage2timer) then killTimer(infectionStage2timer) end
if isTimer(infectionDamageLoop) then killTimer(infectionDamageLoop) end
if isElement(zedShader) then destroyElement(zedShader) end
end)
]]



function clearInfectionEff ()
--if source ~= getLocalPlayer() then return end
if isElement(zedShader) then destroyElement(zedShader) 	--outputDebugString("shader removed")
 end
	if isTimer(infectionStage2timer) then killTimer(infectionStage2timer) 	--outputDebugString("timer stage2 removed")
 end
	if isTimer(infectionDamageLoop) then killTimer(infectionDamageLoop) 	--outputDebugString("timer damage loop removed")
 end
	setElementData(localPlayer,"infection","uninfected",true)
	--outputDebugString("infection removed")

end
addEventHandler("onClientPlayerWasted",root, clearInfectionEff)
addEventHandler("clearInfectionEffects",root, clearInfectionEff)

