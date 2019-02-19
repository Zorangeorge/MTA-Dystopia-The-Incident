addEventHandler("onClientPlayerWeaponFire", root, function(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement) --visible bullet impacts for players
    if weapon < 19 or (weapon >= 35 and weapon ~= 38) then return end -- If the player does not wield a fireweapon, return
	
	--if ammo == 1 and ammoInClip < 1 then playSound3D("sounds/empty_gun.wav",getElementPosition(localPlayer))end	-- this needs only a 'click' sound file added and can be enabled; add file to meta too 
    fxAddBulletImpact(hitX, hitY, hitZ, 0, 0, 0, math.random(1, 2), math.random(2, 5), 1.0)
end)

addEventHandler("onClientPedWeaponFire", root, function(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement) --visible bullet impacts for peds
    if weapon < 19 or (weapon >= 35 and weapon ~= 38) then return end -- If the ped does not wield a fireweapon, return
    fxAddBulletImpact(hitX, hitY, hitZ, 0, 0, 0, math.random(1, 2), math.random(2, 5), 1.0)
end)

    function onStart()
        setPedWalkingStyle(localPlayer, 0)-- model animation: 0 - standard; 69 - sneak instead of walk, armed sprint: looks like a pro feature, maybe for higher MIL stats; 
		setDevelopmentMode(true) --it's needed to see the colshapes in editor. needs to be removed on live
		triggerEvent( "switchDoF", root, false ) -- blur shader, 'near_death_blur' resource
		if getCameraShakeLevel(localPlayer) ~= 1 then setCameraShakeLevel(1) end
		setElementData(localPlayer,"pistolammo", 1)
		setElementData(localPlayer,"crossbowammo", 1)
		setElementData(localPlayer,"taserammo", 1)
		setElementData(localPlayer,"shotgunammo", 1)
		setElementData(localPlayer,"smgammo", 1)
		setElementData(localPlayer,"assaultammo", 1)
		setElementData(localPlayer,"rifleammo", 1)
		for _,painEffect in pairs(painTimers) do killTimer(painEffect) end -- stop pain effects
		setElementData(localPlayer,"minorfracture",false)
		setElementData(localPlayer,"pain",false,true)
		setElementData(localPlayer,"majorfracture",false)
		setElementData(localPlayer,"insidebutchercol",nil)
		setElementData(localPlayer,"map", false)
		setElementData(localPlayer,"level", 1)
		
		
	end
    addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()), onStart) 
	
	function addEffects(attacker, weapon, bodypart, loss) --attacker, int weapon, int bodypart [, float loss ]
	local randomchance = math.random(1,100)
	local attackerType = false
	if isElement(attacker) == false then attackerType = "impact" 
	elseif getElementType(attacker) == "ped" then attackerType = "ped"
	elseif getElementType(attacker) == "vehicle" then attackerType = "vehicle"
	end
	if attackerType == "impact" then 
			if loss > 20  and randomchance > 50 then 
				outputStatusInfo("Minor fracture!", 255,255,255)
				setElementData(localPlayer,"minorfracture",true)
				toggleControl ( "sprint", false )
			elseif loss > 30 and randomchance > 50 then 
			outputStatusInfo("Major fracture!", 255,255,255)
			setElementData(localPlayer,"majorfracture",true)
			toggleControl ( "sprint", false )
			end
			return
			
	elseif attackerType == "ped" then
				
				if getElementData(attacker, "zombie") == true and randomchance>80 then 
					startLightPainTimer() 
					setElementData(localPlayer,"pain", true,true) 
				end
				
				if getElementData(attacker, "brute") == true and randomchance>80 then 
					
					if getElementData( localPlayer, "bleeding") ~= true then
						setElementData (localPlayer, "bleeding", true, true) --"Bleeding set"
						setPedFootBloodEnabled (localPlayer, true)
						tickTimer = setTimer( bleedingPed, 1000, 60, localPlayer) 
						clearTimer = setTimer( clearBleeding, math.random (10000, 15000), 1, localPlayer) 
					end
								
				end
				
				if getElementData(attacker, "zombie") == true then
					local randinfectionchance = math.random(1,100)
					if getElementData(attacker, "runner") == true and randinfectionchance>40 then
							if getElementData(localPlayer,"infection")== false or getElementData(localPlayer,"infection")== "uninfected" then 
							triggerEvent("onInfected",localPlayer)--infect
							else --outputDebugString("Already infected")
							end
					elseif  randinfectionchance>80 then 
							if getElementData(localPlayer,"infection")== false or getElementData(localPlayer,"infection")== "uninfected" then 
							triggerEvent("onInfected",localPlayer)--infect 	
							else --outputDebugString("Already infected")
							end
					end
				end
				--[[if weapon == 5 and bodypart == 5 or bodypart == 6 and randomchance>90 then minorFracture() --if blunt weapons hit hands, there's a small chance a minor fracture occurs; UNFINISHED
				elseif weapon == 6 and bodypart == 5 or bodypart == 6 and randomchance>90 then minorFracture()
				elseif weapon == 7 and bodypart == 5 or bodypart == 6 and randomchance>75 then minorFracture() --...a bit bigger for the sledgehammer
				end]]
	end
	end
	addEventHandler("onClientPlayerDamage",root, addEffects)
	
-----------	FRACTURE Effects
function minorfractureEffects()
if getElementData(localPlayer,"minorfracture") == true then
local randomchance = math.random(0,100)
	if getPedControlState ( "jump" ) then 
		local oldhealth = getElementHealth(localPlayer)
		setElementHealth(localPlayer,oldhealth - 5)
		startLightPainTimer()
		setElementData(localPlayer,"minorfracture", false)
		if randomchance>70 then setTimer(function() setElementData(localPlayer,"majorfracture", true) end, 5000, 1); outputStatusInfo("Fracture aggravated!", 255,255,255) else setTimer(function() setElementData(localPlayer,"minorfracture", true) end, 5000, 1)
	end
end	
end
end
addEventHandler("onClientKey",root,minorfractureEffects)

function majorfractureEffects()
if getElementData(localPlayer,"majorfracture") == true then
	if getPedControlState ( "jump" ) then 
		local oldhealth = getElementHealth(localPlayer)
		setElementHealth(localPlayer,oldhealth - 10)
		outputStatusInfo("-10 hp ", 255,0,0)
		startPainTimer()
		setElementData(localPlayer,"majorfracture", false)
		setTimer(function() setElementData(localPlayer,"majorfracture", true) end, 5000, 1)
	end
end	
end
addEventHandler("onClientKey",root,majorfractureEffects)


-------------DROWNING DAMAGE
-------------STAMINA---------------------
oxygen = 100 
oxygen_MAX = 100 -- Planned: default is 100, can be leveled up to 300 by gaining SURV levels

function oxygenCycle ()

	local x,y,z = getElementPosition(localPlayer)
		if not isElementInWater(localPlayer) then 
			setTimer( oxygenCycle, 200, 1) 
			return 
		end

		if getPedSimplestTask(localPlayer,"primary",2) == "TASK_SIMPLE_SWIM" and z<-0.6 then 
			oxygen = oxygen - 1 
		else
			oxygen = oxygen+10
		end

		if oxygen > oxygen_MAX then
			oxygen = oxygen_MAX
		end
	
		if oxygen < 0 then
			oxygen = 0
			outputStatusInfo ("Drowning!", 240,0,0)
			--setPedAnimation( localPlayer, "ped", "FALL_collapse",1500,false,true,true,false)
			local health = getElementHealth(localPlayer)
			if health>0 then setElementHealth(localPlayer,health-2) end
		end
	
    setTimer( oxygenCycle, 200, 1)
end

function startOxygen ( )
--if isElementInWater ( localPlayer ) ~= true then return else 
    setTimer( oxygenCycle, 200, 1)

--end
end

addEventHandler ( "onClientResourceStart", resourceRoot, startOxygen )

function restoreOxygen (amount)
    if oxygen < oxygen_MAX then 
    oxygen = oxygen+amount
    end
end

	OxygenProcess = guiCreateProgressBar(10,0.017,0.1,0.025,true)
	guiMoveToBack (OxygenProcess)
	guiProgressBarSetProgress(OxygenProcess,oxygen)

local g_Root = getRootElement()
local g_client = getLocalPlayer()

local screenWidth, screenHeight = guiGetScreenSize ( )

local lifeW = 125
local lifeH = 23
local lifeX = screenWidth/100 
local lifeY = screenHeight - screenHeight/70
local pad = 5

function createOxyText ( )
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
                
        local oxygenLevel = oxygen /(100+(100*100-569)/431) 
		--local x,y,z = getElementPosition(localPlayer)
		local alpha = 255
		
		if not isElementInWater(localPlayer) then --getPedSimplestTask(localPlayer,"primary",2) == "TASK_SIMPLE_SWIM"
		--[[alpha = 255
		else ]]
		alpha = 0
		end
		
		
		local color = tocolor(255,255,255,alpha) 
 
        dxDrawRectangle ( lifeX+pad, lifeY+pad-30, math.ceil((lifeW-2*pad)*oxygenLevel), lifeH-2*pad, color ) 
        
    end
end

hudEnabled = true
addEventHandler ( "onClientRender", g_Root, createOxyText )

------------------------------------------------------------------------

--[[function displayMyTask () ---TEMP Enable for developing only
    local x,y = 100,200
    for k=0,4 do
        local a,b,c,d = getPedTask ( getLocalPlayer(), "primary", k )
        dxDrawText ( "Primary task #"..k.." is "..tostring(a).." -> "..tostring(b).." -> "..tostring(c).." -> "..tostring(d).." -> ", x, y )
        y = y + 15
    end
    y = y + 15
    for k=0,5 do
        local a,b,c,d = getPedTask ( getLocalPlayer(), "secondary", k )
        dxDrawText ( "Secondary task #"..k.." is "..tostring(a).." -> "..tostring(b).." -> "..tostring(c).." -> "..tostring(d).." -> ", x, y )    
        y = y + 15
    end
end    
addEventHandler ( "onClientRender", root, displayMyTask )]]

