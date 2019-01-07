local damageFromWeapon2 = 1000 -- WHAT WAS THIS ACTUALLY??? STILL NEEDED?
local damageFromWeaponZZ = 1

addEventHandler("onClientPlayerDamage", getLocalPlayer(), --?? is the golf club a one-hit-killer?
function(atack,weapon,bod,los)
if(weapon == 2)then
cancelEvent()
local h = getElementHealth(source)
if(h>damageFromWeapon2)then
setElementHealth(source,h-damageFromWeapon2)
else
triggerServerEvent("killPedSpecial",source,atack)
end
end
end)

addEventHandler("onClientPlayerDamage", getLocalPlayer(),
function(atack,weapon,bod,los)
if (weapon == 2) or (weapon == 4) or (weapon == 8) or (weapon == 9) or (weapon == 10) or (weapon == 12) or (weapon == 15) then
cancelEvent()
local health = getElementHealth(source)
if(health > damageFromWeaponZZ) then
setElementHealth(source,health-damageFromWeaponZZ)
end
end
end)

------------Tracer bullets
    local weaponsThatCantFireBullets = {[0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [16] = true, [40] = true, [44] = true, [45] = true, [46] = true, [17] = true,[18] = true,[25] = true,[26] = true,[27] = true,[35] = true,[36] = true,[37] = true,[39] = true,[41] = true,[42] = true,[43] = true}
    local lines = {}
    
	function onClientWeaponFireFunc(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement)
        if weaponsThatCantFireBullets[weapon] then return end
        local mx, my, mz = getPedWeaponMuzzlePosition(source)
        lines[#lines +1] = {mx, my, mz, hitX, hitY, hitZ}
    end
    addEventHandler("onClientPlayerWeaponFire", root, onClientWeaponFireFunc)
    addEventHandler("onClientPedWeaponFire", root, onClientWeaponFireFunc)

    
	addEventHandler("onClientRender",root,
    function ()
        for index, line in pairs(lines) do
            r = dxDrawLine3D(line[1],line[2],line[3],line[4],line[5],line[6],tocolor(255,250,250,80),2.5)
			setTimer ( deleteTrace, 150, 1, r)
        end
    end)
	
	function deleteTrace (r)
            lines = {}
    end
---------- Crossbow sound 	BUG: also disables part of the Pistol shot sound; yeah, that's right the sound seems to be composite and only part of it is disabled now?!
--setWorldSoundEnabled(5,24,false) --disable original silenced sound
--disable chainsaw sound (invisible weapon is used as a faux zombie attack) -- also affects part of (some) vehicle engine sounds (Sanchez for instance)
--setWorldSoundEnabled(40,1,false)
--setWorldSoundEnabled(40,0,false)
--setWorldSoundEnabled(40,2,false)

function weaponfired(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement)
    if weapon == 23 then
    local x, y, z = getElementPosition(source)
    local sound = playSound3D("sounds/Bow_Fire_Arrow.mp3", x, y, z, false)
	end
end
addEventHandler("onClientPlayerWeaponFire", getLocalPlayer(), weaponfired)	
	
--Semi-Automatic Weaps Script By Fedor_S (Maccer)
--		config/ignore.behavior.xml: This xml will stop forcing semi-automatic bursts on weapons defined in the xml.
--		config/custom.damage.xml: This xml will add more value to your shot to any weapons defined.

local allowedWeapons = {}
local customDamage = {}

addEventHandler("onClientResourceStart", resourceRoot, 
	function (startedResource)
		if (startedResource == getThisResource()) then
			local xml = xmlLoadFile("config/ignore.behavior.xml")
			for i, node in ipairs(xmlNodeGetChildren(xml)) do
				if (xmlNodeGetName(node) == "weapon") then
					table.insert(allowedWeapons, tonumber(xmlNodeGetAttribute(node, "id")))
				end
			end
			local xml = xmlLoadFile("config/custom.damage.xml")
			for i, node in ipairs(xmlNodeGetChildren(xml)) do
				if (xmlNodeGetName(node) == "weapon") then
					table.insert(customDamage, tonumber(xmlNodeGetAttribute(node, "id")), tonumber(xmlNodeGetAttribute(node, "damage")))
				end
			end
		end
	end
)

addEventHandler("onClientPlayerWeaponFire", getRootElement(), 
	function (weapon)
		local isAllowedCheck = false
		for i, k in ipairs(allowedWeapons) do
			if (weapon == k) then
				isAllowedCheck = true
				break
			end
		end
		if not isAllowedCheck then
			setPedControlState("fire", false)
		end
	end
)

addEventHandler("onClientPedDamage", getRootElement(),
	function (attacker, weapon, bodypart, loss)
		if (getElementHealth(source) > 0) then
			if (customDamage[weapon]) then
				setElementHealth(source, getElementHealth(source)-(loss*(customDamage[weapon]/100)))
			end
		end
	end
)
    
---------RANGEFINDER

--original script by alex17 

local x1, y1 = guiGetScreenSize ()
local x = x1/1000 -- para compatibilidad con todas las resoluciones
local y = y1/1000 

local targetID = ""
local Effect = "normal vision"

addEventHandler("onClientRender", getRootElement(),
function()
   local weapon = getPedWeapon(getLocalPlayer())
   local target = getPedTarget (  getLocalPlayer() )
     if getPedControlState('aim_weapon') then
     if  weapon == 43 then      
        if ( target ) then
                   local posx, posy = getElementPosition ( target )
                   local posx2, posy2 = getElementPosition ( localPlayer )
                   
            if getElementType (target)=="vehicle" then 
                --targetID = ""..getVehicleName ( target ).."" 
                targetID = ""..retrieveCustomCarName( target ).."" 
                
                elseif getElementType ( target )=="object" then 
					if getElementModel(target) == 2971 or getElementModel(target) == 1431 or getElementModel(target) == 1440 or getElementModel(target) == 1438 or getElementModel(target) == 1441 or getElementModel(target) == 1421 then
					targetID = tostring(getElementModel(target))--"Loot boxes"
					elseif getElementModel(target) == 2968 or getElementModel(target) == 2900 or getElementModel(target) == 1230 or getElementModel(target) == 1224 or getElementModel(target) == 1220 or getElementModel(target) == 1221 then
					targetID = tostring(getElementModel(target))--"Loot box"
					elseif getElementModel(target) == 2977 then
					targetID = tostring(getElementModel(target))--"Military crate"
					elseif getElementModel(target) == 1429 then
					targetID = tostring(getElementModel(target))--"Broken TV set"
					elseif getElementModel(target) == 1558 then
					targetID = tostring(getElementModel(target))--"Medical supplies"
					elseif getElementModel(target) == 1264 then
					targetID = tostring(getElementModel(target))--"Stockpile"
					else 
					targetID = tostring(getElementModel(target))--""--return
					end
                elseif getElementType (( target ))=="player" then
                targetID = "#f4eb42"..getPlayerName ( target )..""--" Human \n ["..getPlayerName ( target ).."] : ["..getPlayerTeam ( target ).."] " ---untested
                elseif getElementType (( target ))=="ped" then
         
                    if getElementData (target, "zombie") == true then   
                    targetID = "#b20000Zombie"
					else
					targetID = getElementData (target, "name")
                    end
            end     
			if targetID ~="" then   
			dxDrawText(""..targetID.."\n#FFFFFF"..math.ceil(getDistanceBetweenPoints2D ( posx, posy, posx2, posy2 )).." m".."\n", x*1000, y*100, 0, 0, tocolor(255, 255, 255, 255), y*2, "clear", "center", "top", false, false, true, true, false)
			end   
            else
            
            return
        end
      end
      else
   end
end
)

------------BINOCULARS
local screenW,screenH = guiGetScreenSize()
local resW,resH = 1280,720
local sW,sH =  (screenW/resW), (screenH/resH)
addEvent( "DestroyBinocularsShader", true)
addEvent("BinocularsShader", true)
addEventHandler ( 'onClientKey', getRootElement ( ),
function ( button, press)
if isCursorShowing()==true then return end
if getPedWeaponSlot(getLocalPlayer ( )) == 9 and getPedWeapon(getLocalPlayer ( )) == 43 and button == "mouse2" and press == true then
--outputChatBox(tostring(getControlState("aim_weapon")))
	triggerEvent("BinocularsShader", getLocalPlayer ( ))
	if flashlight[localPlayer] then 
		setElementAlpha(flashlight[localPlayer],0)
			if isFlon[localPlayer] then --turn lamp off before unequip
			toggleLight()
			end
	end
else 
	if isElement(binocularsShader) and button == "mouse2" and press == false then 
	destroyElement(binocularsShader ) 
		if flashlight[localPlayer] then 
		setElementAlpha(flashlight[localPlayer],255) 
		end
	end
end
end)

 function showClientBinocularImage()
   binocularsShader = guiCreateStaticImage( 0, 0, screenW, screenH, "images/binocular_shader.png", false )
   guiMoveToBack (binocularsShader)
end
addEventHandler( "BinocularsShader", localPlayer, showClientBinocularImage ) 

--cunt rifle reload

function reloadrifleclient (weap, ammoleft, ammoinclip ) 
 if (weap == 33 or weap == 34) and ammoinclip==0 then 
 outputDebugString("ammoinclip:"..ammoinclip)
 outputDebugString("total ammoleft:"..ammoleft)
  triggerServerEvent ( "onRifleShoot", localPlayer )
 end 
end 
addEventHandler ( "onClientPlayerWeaponFire", localPlayer, reloadrifleclient ) 

--[[--------TASER------------
--resource for MTA: San Andreas [C] Copyright 2013-2014, Falke

local cFunc1 = {}
local cSetting1 = {}

local cFunc = {}
local cSetting = {}

cSetting["shots"] = {}
cSetting["shot_calcs"] = {}
local last_shot = 1

cFunc["render_shots"] = function()
	for index, tbl in pairs(cSetting["shots"]) do
		dxDrawFuckedLine3D(tbl[1], tbl[2], tbl[3], tbl[4], tbl[5], tbl[6], tocolor(0, 255, 0))
	end
end

cFunc["draw_shot"] = function(x1, y1, z1, x2, y2, z2)
	table.insert(cSetting["shots"], last_shot, {x1, y1, z1, x2, y2, z2})
	-- SHOT CALCULATING 
	local lastx, lasty, lastz = x1, y1, z1
	local dis = getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2)
	cSetting["shot_calcs"][last_shot] = {}
	
	for i = 1, dis, 0.5 do
	end
	last_shot = last_shot+1
end

dxDrawFuckedLine3D = function(x1, y1, z1, x2, y2, z2, color)
	local dis = getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2)
	local lastx, lasty, lastz = x1, y1, z1
end

cFunc["anim_check"] = function(_, wep, bodypart)
	if(wep == 42)  and (bodypart == 9) then
		setPedAnimation(source, "ped", "KO_shot_face", 10000, false, true, false)
	elseif(wep == 42)  and (bodypart == 8) then
		setPedAnimation(source, "CRACK", "crckdeth2", 10000, false, true, false)
	elseif(wep == 42)  and (bodypart == 7) then
		setPedAnimation(source, "CRACK", "crckdeth2", 10000, false, true, false)
	elseif(wep == 42)  and (bodypart == 6) then
		setPedAnimation(source, "CRACK", "crckdeth2", 10000, false, true, false)
	elseif(wep == 42)  and (bodypart == 5) then
		setPedAnimation(source, "CRACK", "crckdeth2", 10000, false, true, false)
	elseif(wep == 42)  and (bodypart == 4) then
		setPedAnimation(source, "CRACK", "crckdeth3", 10000, false, true, false)
	elseif(wep == 42)  and (bodypart == 3) then
		setPedAnimation(source, "ped", "KO_shot_stom", 10000, false, true, false)
	elseif(wep == 42)  and (bodypart == 2) then
		setPedAnimation(source, "CRACK", "crckdeth2", 10000, false, true, false)
	elseif(wep == 42)  and (bodypart == 1) then
		setPedAnimation(source, "CRACK", "crckdeth2", 10000, false, true, false)

	end
end
addEventHandler("onClientRender", getRootElement(), cFunc["render_shots"])
addEventHandler("onClientPedDamage", getRootElement(),cFunc["anim_check"])
addEventHandler("onClientPlayerDamage", getRootElement(),cFunc["anim_check"])
]]
---HEADSHOT
--[[function sendHeadshot ( attacker, weapon, bodypart, loss )
	if attacker == getLocalPlayer() then
		if bodypart == 9 and getElementData(source,"zombie")~= true then
			triggerServerEvent( "onServerHeadshot", getRootElement(), source, attacker, weapon, loss )
			setElementHealth ( source, 0 )
			setPedHeadless( source, true )
		end
	end
end
addEventHandler ( "onClientPedDamage", getRootElement(), sendHeadshot )
addEventHandler ( "onClientPlayerDamage", getRootElement(), sendHeadshot )]]

--RELOAD, edited to allow for rifle reload

local blockedTasks = 
{
	"TASK_SIMPLE_IN_AIR", -- We're falling or in a jump.
	"TASK_SIMPLE_JUMP", -- We're beginning a jump
	"TASK_SIMPLE_LAND", -- We're landing from a jump
	"TASK_SIMPLE_GO_TO_POINT", -- In MTA, this is the player probably walking to a car to enter it
	"TASK_SIMPLE_NAMED_ANIM", -- We're performing a setPedAnimation
	"TASK_SIMPLE_CAR_OPEN_DOOR_FROM_OUTSIDE", -- Opening a car door
	"TASK_SIMPLE_CAR_GET_IN", -- Entering a car
	"TASK_SIMPLE_CLIMB", -- We're climbing or holding on to something
	"TASK_SIMPLE_SWIM",
	"TASK_SIMPLE_HIT_HEAD", -- When we try to jump but something hits us on the head
	"TASK_SIMPLE_FALL", -- We fell
	"TASK_SIMPLE_GET_UP" -- We're getting up from a fall
}

local function reloadRifle()
	-- Usually, getting the simplest task is enough to suffice
	local task = getPedSimplestTask (localPlayer) 

	-- Iterate through our list of blocked tasks
	for idx, badTask in ipairs(blockedTasks) do
		-- If the player is performing any unwanted tasks, do not fire an event to reload
		if (task == badTask) then
			return
		end
	end
	triggerServerEvent("relWep", resourceRoot)
	setTimer ( toggleControl, 1200, 1, "fire", true )
	if not getPedControlState('aim_weapon') then 
		dxProgressBar(1200, 1) 
	end
	
end
-- The jump task is not instantly detectable and bindKey works quicker than getControlState
-- If you try to reload and jump at the same time, you will be able to instant reload.
-- We work around this by adding an unnoticable delay to foil this exploit.
addCommandHandler("Reload weapon", function()
	
	local weaponslot = getPedWeaponSlot(localPlayer)
	if weaponslot <2 or weaponslot >6 then return end
	
	setTimer(reloadRifle, 50, 1)
	
end)
bindKey("r", "down", "Reload weapon")
bindKey("num_dec", "down", "Reload weapon") 

--ROCKET LAUNCHER MODS
--[[rocketcrosshairvisible = false

function showrocketcrosshair ()
local tx,ty,tz = getPedTargetCollision(localPlayer) -- Gets the Point where the Targets Collision is.
--if not tx then outputDebugString("no target") else outputDebugString(tostring(tx,ty,tz)) end
local x,y = guiGetScreenSize()
if tx then sx,sy = getScreenFromWorldPosition(tx,ty,tz) end
if sx then img = dxDrawImage( sx,sy,32,32,"images/crosshair.png" ) end
if not rocketcrosshairvisible then rocketcrosshairvisible = true end
end]]

--[[function rocketlaunchermods(previousWeaponSlot, currentWeaponSlot) 
if currentWeaponSlot == 7 and rocketcrosshairvisible == false then
	if getPedTargetCollision(localPlayer) then
	addEventHandler("onClientRender",root,showrocketcrosshair)
	end
else
removeEventHandler("onClientRender",root,showrocketcrosshair)
rocketcrosshairvisible = false
end
end
addEventHandler("onClientPlayerWeaponSwitch", localPlayer, rocketlaunchermods)]]

addEventHandler("onClientPlayerWeaponFire", root, function(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement) --rear muzzle flash for rocket launcher
    if weapon == 35 then 
--[[    local mX, mY, mZ = getPedWeaponMuzzlePosition(localPlayer)
	local x,y,z = getPedTargetCollision(localPlayer)
	local px, py, pz = getElementPosition( localPlayer )
	local r1x,r1y,r1z = getElementRotation(localPlayer)
	if x then pedangle = ( 360 - math.deg ( math.atan2 ( ( x - px ), ( y - py ) ) ) ) % 360 end--MAGIC SPELL TO MAKE PEDS LOOK AT STUFF
	if pedangle then setElementRotation(localPlayer,pedangle,r1y,r1z,"default",true) end
	local rocket = createProjectile (localPlayer,19,mX, mY, mZ)--, gx, gy, gz, 1)]]
	local player = localPlayer
	triggerServerEvent("RocketFired",player)
	end 
end)

------------------------------------LASER POINTER
-- by vick

local dots = {} -- store markers for each players laser pointer
CMD_LASER = "laser"	-- command to toggle laser on/off
CMD_LASERCOLOR = "lasercolor" -- command to change laser color
laserWidth = 2 -- width of the dx line
dotSize	= .05	-- size of the dot at the end of line

localPlayer = getLocalPlayer()
oldcolors = {r=255,g=0,b=0,a=255}

addEventHandler("onClientResourceStop", getRootElement(), function(res)
	if res == getThisResource() then
		--outputChatBox("unloaded laserpointer", 245,0,0)
		SetLaserEnabled(localPlayer, false)		
	end
end )

addEventHandler("onClientElementDataChange", localPlayer,
	function(dataName, oldValue)
		if getElementType(source) == "player" and source == localPlayer and dataName == "laser.on" then
			local newValue = getElementData(source, dataName)
			if oldValue == true and newValue == false then
				unbindKey("aim_weapon", "both", AimKeyPressed)
			elseif oldValue == false and newValue == true then
				bindKey("aim_weapon", "both", AimKeyPressed)		
			end
		end
	end
)

addEventHandler( "onClientRender",  getRootElement(),
	function()
	
		local players = getElementsByType("player")
		local peds = getElementsByType("ped")
		
		for k,v in ipairs(players) do
		-- if not isElementStreamedIn(v) then return end --this might be worthy, test it
			if getElementData(v, "laser.on") then
				DrawLaser(v)
			end
		end
		
		for k,p in ipairs(peds) do
		-- if not isElementStreamedIn(v) then return end --this might be worthy, test it
			if getElementData(p, "laser.on") then
				DrawLaser(p)
			end
		end
	end
)

--[[addEventHandler( "onClientPreRender",  getRootElement(),
	function()
		local players = getElementsByType("player")
		for k,v in ipairs(players) do
			if getElementData(v, "laser.on") then
			
			end
		end
	end
)]]

function AimKeyPressed(key, state) -- attempt to sync when aiming with binds, getPedControlState seems weird...
	if state == "down" then
		setTimer(setElementData,500,1,localPlayer, "laser.aim", true, true)--***********
	elseif state == "up" then
		setElementData(localPlayer, "laser.aim", false, true)
	end
end

function DrawLaser(player)
	if getElementData(player, "laser.on") then
			
			local targetself = getPedTarget(player)
			if targetself and targetself == player then
				targetself = true
			else
				targetself = false
			end	
			
			if getElementType(player)== "player" then
			
				if getElementData(player, "laser.aim") and IsPlayerWeaponValidForLaser(player) == true and targetself == false then
					local x,y,z = getPedWeaponMuzzlePosition(player)
					if not x then
						--outputDebugString("getPedWeaponMuzzlePosition failed")
						x,y,z = getPedTargetStart(player)
					end
					local x2,y2,z2 = getPedTargetEnd(player)
					if not x2 then
						return
					end			
					local x3,y3,z3 = getPedTargetCollision(player)
					local r,g,b,a = 240,0,0,255 --laser color, hardcoded to red
					if x3 then -- collision detected, draw til collision and add a dot
						dxDrawLine3D(x,y,z,x3,y3,z3, tocolor(r,g,b,a), laserWidth)
						DrawLaserDot(player, x3,y3,z3)
					else -- no collision, draw til end of weapons range
						dxDrawLine3D(x,y,z,x2,y2,z2, tocolor(r,g,b,a), laserWidth)
						DestroyLaserDot(player)
					end
				else
					DestroyLaserDot(player) -- not aiming, remove dot, no laser
				end
			
			else
					if getElementData(player, "laser.aim") and	IsPlayerWeaponValidForLaser(player) == true  then
					local x,y,z = getPedWeaponMuzzlePosition(player)
					if not x then
						--outputDebugString("getPedWeaponMuzzlePosition failed")
						x,y,z = getPedTargetStart(player)
					end
					local x2,y2,z2 = getPedTargetEnd(player)
					if not x2 then
						return
					end			
					local x3,y3,z3 = getPedTargetCollision(player)
					local r,g,b,a = 240,0,0,255 --laser color, hardcoded to red
					if x3 then -- collision detected, draw til collision and add a dot
						dxDrawLine3D(x,y,z,x3,y3,z3, tocolor(r,g,b,a), laserWidth)
						DrawLaserDot(player, x3,y3,z3)
					else -- no collision, draw til end of weapons range
						if x2 then
						dxDrawLine3D(x,y,z,x2,y2,z2, tocolor(r,g,b,a), laserWidth)
						DestroyLaserDot(player)
						end
					end
				else
					DestroyLaserDot(player) -- not aiming, remove dot, no laser
				end
			
			end
			
	else
		DestroyLaserDot(player)
	end
end
function DrawLaserDot (player, x,y,z)
	if not dots[player] then
		dots[player] = createMarker(x,y,z, "corona", .05, 240,0,0,255)
	else
		setElementPosition(dots[player], x,y,z)
	end
end
function DestroyLaserDot(player)
	if dots[player] and isElement(dots[player]) then
		destroyElement(dots[player])
		dots[player] = nil
	end
end

function IsPlayerWeaponValidForLaser(player) -- returns false for unarmed and awkward weapons
	local weapon = getPedWeapon(player)
	if weapon and weapon > 21 and weapon < 39 and weapon ~= 35 and weapon ~= 36 then
		return true
	end
	return false
end

addEvent("EnableDisableLaserPointer",true)

function SetLaserEnabled(player, state) -- returns false if invalid params passed, true if successful changed laser enabled
	if not player or isElement(player) == false then return false end
	if getElementType(player) ~= "player" then return false end
	if state == nil then return false end
	
	if state == true then -- enable laser
		setElementData(player, "laser.on", true, true)
		setElementData(player, "laser.aim", false, true)
		if player == localPlayer then outputInteractInfo("Laser on", 255,200,0) end
		return true
	elseif state == false then -- disable laser
		setElementData(player, "laser.on", false, true)
		setElementData(player, "laser.aim", false, true)
		if player == localPlayer and getElementHealth(player) > 0 then outputInteractInfo("Laser off", 255,200,0) end
		return true
	end
	return false
end

function IsLaserEnabled(player) -- returns true or false based on player elementdata "laser.on"
	if getElementData(player, "laser.on") == true then
		return true
	else
		return false
	end
end

addEvent("ToggleLaserPointer",true)

function ToggleLaserEnabled(cmd)
	player = localPlayer
	if IsLaserEnabled(player) ~= true then	
		SetLaserEnabled(player, true)
		outputInteractInfo("Laser on", 255,200,0)
	else
		SetLaserEnabled(player, false)
		if getElementHealth(player) > 0 then
		outputInteractInfo("Laser off", 255,200,0)
		end
	end
end

addEventHandler("EnableDisableLaserPointer",root,SetLaserEnabled)
addEventHandler("ToggleLaserPointer",root,ToggleLaserEnabled)

addEvent("GlassTrapEffects",true)

function createGlassTrapEffects(player,x,y,z)

	if getElementData( player, "bleeding") ~= true then
					   setElementData (player, "bleeding", true, true) --"Bleeding set"
	end
	setPedFootBloodEnabled (player, true)
	tickTimer = setTimer( bleedingPed, 1000, 60, player) 
	clearTimer = setTimer( clearBleeding, math.random (10000, 20000), 1, player)

end
addEventHandler("GlassTrapEffects",root,createGlassTrapEffects)

--GADGETS

function isPedAiming ( thePedToCheck )
	if isElement(thePedToCheck) then
		if getElementType(thePedToCheck) == "player" or getElementType(thePedToCheck) == "ped" then
			if getPedTask(thePedToCheck, "secondary", 0) == "TASK_SIMPLE_USE_GUN" then
				return true
			end
		end
	end
	return false
end

function shootgrenade()
local stompergrenades=getElementData(localPlayer,"stomperammo") or 0
		local x,y,z = getElementPosition( localPlayer )
		local mx,my,mz = getPedTargetCollision (localPlayer)
		local distance 
		if mx then distance = getDistanceBetweenPoints3D(x,y,z,mx,my,mz) end
		if not distance then distance = 100 end
		local projectilespeed = 0.1*distance/2.5
		if projectilespeed >=1.2 then projectilespeed = 1.2 end
		if not isPedAiming(localPlayer) then projectilespeed = 0.5 end
		local grenade = createProjectile ( localPlayer, 16, x,y,z, projectilespeed)

end

function shootmolotov()
local stompergrenades=getElementData(localPlayer,"stomperammo") or 0
		local x,y,z = getElementPosition( localPlayer )
		local mx,my,mz = getPedTargetCollision (localPlayer)
		local distance 
		if mx then distance = getDistanceBetweenPoints3D(x,y,z,mx,my,mz) end
		if not distance then distance = 100 end
		local projectilespeed = 0.1*distance/2.5
		if projectilespeed >=1.2 then projectilespeed = 1.2 end
		if not isPedAiming(localPlayer) then projectilespeed = 0.5 end
		local grenade = createProjectile ( localPlayer, 18, x,y,z, projectilespeed)

end

--[[function throwSatchel()
local stompergrenades=getElementData(localPlayer,"stomperammo") or 0
		local x,y,z = getElementPosition( localPlayer )
		local mx,my,mz = getPedTargetCollision (localPlayer)
		local distance 
		if mx then distance = getDistanceBetweenPoints3D(x,y,z,mx,my,mz) end
		if not distance then distance = 100 end
		local projectilespeed = 0.1*distance/2.5
		if projectilespeed >=1.2 then projectilespeed = 1.2 end
		local grenade = createProjectile ( localPlayer, 18, x,y,z, projectilespeed)

end]]

function shootteargas()
local stompergrenades=getElementData(localPlayer,"stomperammo") or 0
		local x,y,z = getElementPosition( localPlayer )
		local mx,my,mz = getPedTargetCollision (localPlayer)
		local distance 
		if mx then distance = getDistanceBetweenPoints3D(x,y,z,mx,my,mz) end
		if not distance then distance = 100 end
		local projectilespeed = 0.1*distance/2.5
		if projectilespeed >=1.2 then projectilespeed = 1.2 end
		if not isPedAiming(localPlayer) then projectilespeed = 0.5 end
		local grenade = createProjectile ( localPlayer, 17, x,y,z, projectilespeed)
end

function shootstomper()
local stompergrenades=getElementData(localPlayer,"stomperammo") or 0
	if not isPedAiming(localPlayer) then
	return
	elseif getElementData(localPlayer,"stomperequipped") ~= true then
	return
	elseif stompergrenades == 0 then
	outputStatusInfo("[ no ammo ]", 255,255,255)
	return
	else
		local weapon = getPedWeapon(localPlayer)
		if (weapon == 31) or (weapon == 30) then
		local x,y,z = getElementPosition( localPlayer )
		local mx,my,mz = getPedTargetCollision (localPlayer)
		local gx, gy, gz = getPedWeaponMuzzlePosition(localPlayer)
		local sound = playSound3D( 'sounds/m79.wav', x, y, z, false )
		local distance 
		if mx then distance = getDistanceBetweenPoints3D(x,y,z,mx,my,mz) end
		if not distance then distance = 100 end
		local projectilespeed = 0.1*distance/2.5
		if projectilespeed >=1.2 then projectilespeed = 1.2 end
		setSoundMaxDistance( sound, 30 )
		setSoundVolume(sound, 0.2)
		triggerServerEvent("recargar", localPlayer, localPlayer)
		local grenade = createProjectile ( localPlayer, 17, gx, gy, gz, projectilespeed)
		setElementData(localPlayer,"stomperammo",stompergrenades-1)
		grensmoke = createEffect ( "gunsmoke", gx, gy, gz)
		setTimer ( destroyElement, 1000, 1, grensmoke )
		end
	end
end
