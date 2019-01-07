-------------STAMINA---------------------
stamina = 1000 
stamina_MAX = 1000 -- Planned: default is 1000, can be leveled up to 1500 by gaining SURV levels

addEvent ( "drinkRestoreStamina", true )
addEvent("PainDrainsStamina",true)
addEvent("AlcoholDrainsStamina",true)
local carryingObject = getElementData(localPlayer, "carriedObject")

function staminaCycle ()

	if adrenalinelevel ~= 0  then setTimer( staminaCycle, 200, 1) return end
	if carryingObject then toggleControl("sprint", false) else toggleControl("sprint", true) end

	if getPedTask(localPlayer,"secondary",0) == "TASK_SIMPLE_FIGHT" and getPedMoveState ( localPlayer ) ~= "sprint" then 
		stamina = stamina - 2	
    elseif getPedMoveState ( localPlayer ) == "sprint" then
		stamina = stamina-4		
    elseif getPedMoveState ( localPlayer ) == "jump" then
        stamina = stamina-5
    elseif getPedMoveState ( localPlayer ) == "climb" then
        stamina = stamina-8
	
	elseif isPedInVehicle ( localPlayer ) == true then
		stamina = stamina+10 
	elseif getPedMoveState ( localPlayer ) == "stand" then
        stamina = stamina+6
    elseif getPedMoveState ( localPlayer ) == "walk" then
        stamina = stamina+5
    elseif getPedMoveState ( localPlayer ) == "powerwalk" then
        stamina = stamina+4
    elseif getPedMoveState ( localPlayer ) == "jog" then
        stamina = stamina+3
	elseif getPedMoveState ( localPlayer ) == "crouch" then
        stamina = stamina+10
    elseif getPedMoveState ( localPlayer ) == "crawl" then
        stamina = stamina+5
	elseif getElementData( localPlayer, "climb_object" ) then
		if climbingeffort == 1 then
			stamina = stamina-8
		elseif climbingeffort == 2 then
			stamina = stamina-20
		elseif climbingeffort == 3 then
			stamina = stamina-40
		end
	else
        stamina = stamina+1
    end
	


    if stamina > stamina_MAX then
        stamina = stamina_MAX
    end
	
	if getElementData(localPlayer,"drunk")~=true then
		if stamina < 100 then
			--if getCameraShakeLevel(localPlayer) ~= 200 then setCameraShakeLevel(200) end
		end
		if stamina > 100 and stamina < 200 then
			--if getCameraShakeLevel(localPlayer) ~= 100 then setCameraShakeLevel(100) end
			outputStatusInfo ("Low stamina", 240,184,81)
		end
		if stamina > 200 and stamina < 300 then
			--if getCameraShakeLevel(localPlayer) ~= 50 then setCameraShakeLevel(50) end
			toggleControl("jump", true)
		end 
		if stamina > 300 then
			--if getCameraShakeLevel(localPlayer) ~= 1 then setCameraShakeLevel(1) end
			toggleControl("sprint", true)
		end

		if stamina < 0 then
			toggleControl("jump", false)
			toggleControl("sprint", false)
			stamina = 0
			outputStatusInfo ("No stamina!", 245,116,51)
			setPedAnimation( localPlayer, "ped", "FALL_collapse",1500,false,true,false,false)
			--dropPlayer()
		end
	end	
    setTimer( staminaCycle, 200, 1)
end

function startStamina ( )
if isPedInVehicle ( localPlayer ) == true then return else 
    setTimer( staminaCycle, 200, 1)

end
end
addEventHandler ( "onClientResourceStart", resourceRoot, startStamina )

function restoreStamina (amount)
    if stamina < stamina_MAX then 
    stamina = stamina+amount
    end
    
end
addEventHandler ( "drinkRestoreStamina", localPlayer, restoreStamina )

function painDrainStamina ()
if stamina > 300 then
stamina = stamina - 100
outputStatusInfo("-100 stamina", 250,100,0 )
else return
end
end

function alcoholDrainStamina ()
outputStatusInfo("-1000 stamina", 250,100,0 )
if stamina >= 1000 then
stamina = stamina - 1000
else stamina = 0
end
end

addEventHandler ( "PainDrainsStamina", localPlayer, painDrainStamina )
addEventHandler ( "AlcoholDrainsStamina", localPlayer, alcoholDrainStamina )

	staminaProcess = guiCreateProgressBar(10,0.017,0.1,0.025,true)
	guiMoveToBack (staminaProcess)
	guiProgressBarSetProgress(staminaProcess,stamina)

local g_Root = getRootElement()
local g_client = getLocalPlayer()

local screenWidth, screenHeight = guiGetScreenSize ( )
setPlayerHudComponentVisible( "all", false)
setPlayerHudComponentVisible( "crosshair", true)
setPlayerHudComponentVisible( "radar", false)

local lifeW = 125
local lifeH = 23
local lifeX = screenWidth/100 
local lifeY = screenHeight - screenHeight/70
--local ammoH = 2
local pad = 5
--local showAmmoBar = 1
--local showAmmoCurrent = 1
--local showAmmoRemaining = 1
--local boundKey = "u"
function createStaText ( )
    local theTarget
    local target = getCameraTarget()
	
	if isElement(target) then
		if getElementType(target) == "player" or getElementType(target) == "ped" then
			theTarget = target
		elseif getElementType(target) == "vehicle" then
			theTarget = getVehicleOccupant( target )
		end
    end
        
    if theTarget then
        --local col = getPedArmor ( theTarget ) * 1.7
        local maxHealth = (100+(100*(getPedStat(theTarget, 24)-569)/431))
        
        local staminaLevel = stamina /(100+(100*100-569)/431) 
		
		local color
		
		if adrenalinelevel > 0 then 
			color = tocolor(0,102,255) 
		else 
			color = tocolor(0,190,255) 
		end
        
        dxDrawRectangle ( lifeX+pad, lifeY+pad, math.ceil((lifeW-2*pad)*staminaLevel), lifeH-2*pad, color ) --stamina bar 
        
    end
end

hudEnabled = true
addEventHandler ( "onClientRender", g_Root, createStaText )

function toggleHUD( cmd )
    if hudEnabled then
        removeEventHandler( "onClientRender", g_Root, createStaText )
    else
        addEventHandler ( "onClientRender", g_Root, createStaText )
    end
    hudEnabled = not hudEnabled
end
addCommandHandler("ishud", toggleHUD)
--bindKey ( boundKey, "down", toggleHUD )

function resetCameraShakeOnWasted ()
	if source == localPlayer then
	setCameraShakeLevel(1)
	end
end
addEventHandler("onClientPlayerWasted",root,resetCameraShakeOnWasted)
addEventHandler("onClientPlayerSpawn",root,resetCameraShakeOnWasted)


-- https://wiki.multitheftauto.com/wiki/GetPedTask
-- https://wiki.multitheftauto.com/wiki/IsPedDoingTask
-- https://wiki.multitheftauto.com/wiki/List_of_player_tasks
-- TASK_SIMPLE_FIGHT 
--getPedTask(localPlayer,"secondary",0) == "TASK_SIMPLE_FIGHT"

