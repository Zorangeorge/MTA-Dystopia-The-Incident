addEvent("SetThirstOnSpawn",true)

addEventHandler ("onClientResourceStart",getResourceRootElement(getThisResource()),
function ()
  thirstProcess = guiCreateProgressBar(-0.85,0.017,0.1,0.025,true)
  guiMoveToBack (thirstProcess)
  guiProgressBarSetProgress(thirstProcess,100)
  thirstLabel = guiCreateLabel(0.7775,0.2817,0.1737,0.0367,"",true)
  guiLabelSetColor(thirstLabel,222,215,27)
  guiLabelSetVerticalAlign(thirstLabel,"center")
  guiLabelSetHorizontalAlign(thirstLabel,"center",false)
  guiSetFont(thirstLabel,"default-small")
  setTimer (dropDownthirstState,20000,0,getLocalPlayer()) --thirst timer
end)

function setThirstState (player,thirstState)
  if (player == getLocalPlayer()) then
    guiProgressBarSetProgress(thirstProcess,thirstState)
  end
end 

function getThirstState (player)
  if (player == getLocalPlayer()) then
    return guiProgressBarGetProgress(thirstProcess)
  end
end

function saveThirstProgress ()
local s_thirst = guiProgressBarGetProgress(thirstProcess)
setElementData(localPlayer, "thirst", s_thirst,true)
end
setTimer(saveThirstProgress, 60000,0)

function dropDownthirstState (player)

if getCameraTarget(localPlayer) ~= localPlayer then return end -- return if player is not the camera taregt (should solve the menu starving issue)

  if (player == getLocalPlayer()) then
    guiProgressBarSetProgress(thirstProcess,guiProgressBarGetProgress(thirstProcess) -1)
    if (guiProgressBarGetProgress(thirstProcess) == 0) then
      setElementHealth (player,getElementHealth (player) -1)
      outputStatusInfo ("Dehydrated!", 200,0,0)
	  outputStatusInfo ("-1 hp", 200,0,0)
    elseif (guiProgressBarGetProgress(thirstProcess) == 45) then
	outputStatusInfo ("Thirsty", 250,100,0)
	elseif (guiProgressBarGetProgress(thirstProcess) == 20) or (guiProgressBarGetProgress(thirstProcess) == 10) then
	outputStatusInfo ("Very thirsty", 200,0,0)
    end
  end
end 

function setSavedThirstState (thirst)
setThirstState(localPlayer,thirst)
end
addEventHandler("SetThirstOnSpawn",root,setSavedThirstState)

addEventHandler ("onClientPlayerSpawn",getRootElement(), -- here set thirst level on spawn;
function (team)
setTimer( function()
if source == localPlayer then
	local thirst = getElementData(source,"thirst") or 100
	--outputDebugString("thirst: "..thirst)
	setThirstState (source,thirst)
end
end, 3000,1)end)

addEvent ( "drinkWater", true )

function drinking (amount)
local thirststate = getThirstState (getLocalPlayer())
  
	if amount =="canister" then
	  setThirstState (getLocalPlayer(),thirststate+100)
      guiProgressBarSetProgress(thirstProcess,thirststate+100)
	else
      setThirstState (getLocalPlayer(),thirststate+50)
      guiProgressBarSetProgress(thirstProcess,thirststate+50)
	end 
	
	if getThirstState (getLocalPlayer()) > 100 then setThirstState (getLocalPlayer(),100) end
end
addEventHandler ("drinkWater",localPlayer, drinking)
---------------------------------------------

local g_Root = getRootElement()
local g_client = getLocalPlayer()

screenWidth, screenHeight = guiGetScreenSize ( )
setPlayerHudComponentVisible( "all", false)
setPlayerHudComponentVisible( "crosshair", true)
setPlayerHudComponentVisible( "radar", false)

local lifeW = 125
local lifeH = 23
local lifeX = screenWidth/1.15 
local lifeY = screenHeight * 0.045
local ammoH = 2
local pad = 5
local showAmmoBar = 1
local showAmmoCurrent = 1
local showAmmoRemaining = 1
local boundKey = "m"
function createThirstText ( )
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
        local thirstLevel = getThirstState(localPlayer) /(100+(100*100-569)/431) 
        dxDrawRectangle ( lifeX+pad, lifeY+pad, lifeW-30, lifeH-2*pad, tocolor(0,0,0,150) ) --bar background
        dxDrawRectangle ( lifeX+pad, lifeY+pad, math.ceil((lifeW-2*pad)*thirstLevel), lifeH-2*pad, tocolor(144,195,212) ) --thirst bar
    end
end

hudEnabled = true
addEventHandler ( "onClientRender", g_Root, createThirstText )

-- original stamina script was made by JasperNL=D ; 