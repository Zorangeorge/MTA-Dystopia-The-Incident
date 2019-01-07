-- edit of stamina script made by JasperNL=D 

addEvent("SetHungerOnSpawn",true)

addEventHandler ("onClientResourceStart",getResourceRootElement(getThisResource()),
function ()
  hungerProcess = guiCreateProgressBar(-0.85,0.017,0.1,0.025,true)
  guiMoveToBack (hungerProcess)
  guiProgressBarSetProgress(hungerProcess,100)
  hungerLabel = guiCreateLabel(0.7775,0.2817,0.1737,0.0367,"",true)
  --hungerLabel = guiCreateLabel(0.7775,0.2817,0.1737,0.0367,"",true)
  guiLabelSetColor(hungerLabel,222,215,27)
  guiLabelSetVerticalAlign(hungerLabel,"center")
  guiLabelSetHorizontalAlign(hungerLabel,"center",false)
  guiSetFont(hungerLabel,"default-small")

  setTimer (dropDownHungerState,26000,0,getLocalPlayer()) --hunger timer
end)

function setHungerState (player,hungerState)
  if (player == getLocalPlayer()) then
    guiProgressBarSetProgress(hungerProcess,hungerState)
  end
end 

function getHungerState (player)
  if (player == getLocalPlayer()) then
    return guiProgressBarGetProgress(hungerProcess)
  end
end

function dropDownHungerState (player)

if getCameraTarget(localPlayer) ~= localPlayer then return end -- return if player is not the camera taregt (should solve the menu starving issue)

  if (player == getLocalPlayer()) then
    guiProgressBarSetProgress(hungerProcess,guiProgressBarGetProgress(hungerProcess) -1)
    if (guiProgressBarGetProgress(hungerProcess) == 0) then
      setElementHealth (player,getElementHealth (player) -1)
      outputStatusInfo ("Starving!", 255,0,0)
	  outputStatusInfo ("-1 hp", 255,0,0)
    elseif (guiProgressBarGetProgress(hungerProcess) == 30) then
	  outputStatusInfo ("Hungry", 240,184,81)
	elseif (guiProgressBarGetProgress(hungerProcess) == 15) or (guiProgressBarGetProgress(hungerProcess) == 5) then
	  outputStatusInfo ("Very hungry", 245,116,51)
    end
  end
end 

addEventHandler ("onClientPlayerSpawn",getRootElement(), --here set hunger level on spawn; same goes for thirst
function (team)
setTimer(function()
if source == localPlayer then
	local hunger = getElementData(acc,"hunger") or 100
	setHungerState (source,hunger)
end
end, 3000, 1)end)

function setSavedHungerState (hunger)
setHungerState(localPlayer,hunger)
end
addEventHandler("SetHungerOnSpawn",root,setSavedHungerState)

addEvent ( "eatFood", true )

function eating (player)
 
      setHungerState (getLocalPlayer(),100)
	  guiProgressBarSetProgress(hungerProcess,100)
	  
end

addEventHandler ("eatFood",localPlayer, eating)

---------------------------------------------

g_Root = getRootElement()
g_client = getLocalPlayer()

screenWidth, screenHeight = guiGetScreenSize ( )
setPlayerHudComponentVisible( "all", false)
setPlayerHudComponentVisible( "crosshair", true)
setPlayerHudComponentVisible( "radar", false)

local lifeW = 125
local lifeH = 23
local lifeX = screenWidth/1.15 
local lifeY = screenHeight * 0.02
local ammoH = 2
local pad = 5
local showAmmoBar = 1
local showAmmoCurrent = 1
local showAmmoRemaining = 1
local boundKey = "m"

function createHungText ( )
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
		local col = getPedArmor ( theTarget ) * 1.7
		local maxHealth = (100+(100*(getPedStat(theTarget, 24)-569)/431))

		local hungerLevel = getHungerState(localPlayer) /(100+(100*100-569)/431) 

		dxDrawRectangle ( lifeX+pad, lifeY+pad, lifeW-30, lifeH-2*pad, tocolor(0,0,0,150) ) --bar background
		dxDrawRectangle ( lifeX+pad, lifeY+pad, math.ceil((lifeW-2*pad)*hungerLevel), lifeH-2*pad, tocolor(255,204,0) ) --hunger bar 

	end
end



function saveHungerProgress ()
local s_hunger = guiProgressBarGetProgress(hungerProcess)
setElementData(localPlayer, "hunger", s_hunger,true)
end
setTimer(saveHungerProgress, 60000,0)

hudEnabled = true
addEventHandler ( "onClientRender", g_Root, createHungText )


