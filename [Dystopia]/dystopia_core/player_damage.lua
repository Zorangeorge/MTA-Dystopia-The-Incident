
-- Author: JT Pennington (JTPenn)

-- Stealth Kills
----------------->>

function stealthKills(target)
	cancelEvent()
end
addEventHandler("onClientPlayerStealthKill", localPlayer, stealthKills)

-- Exploit Blocking
-------------------->>

function blockExploit(attacker, attackerWeapon, bodypart, loss)
	local attackerType = false
	local aDim = false
	if (isElement(attacker)) then
		attackerType = getElementType(attacker)
		aDim = getElementDimension(attacker)
	end
	
	-- Wall Exploit (In question)
	if (attacker and attackerWeapon and ((attackerWeapon >= 22 and attackerWeapon <= 34) or attackerWeapon == 38) and attackerType == "player") then
		local px, py, pz = getPedBonePosition(attacker, 8)
		local tx, ty, tz = getPedBonePosition(source, 8)
		
		--test
		local laX,laY,laZ = getPedBonePosition(source, 23)
		local raX,raY,raZ = getPedBonePosition(source, 33)
		
		if (not isLineOfSightClear(px, py, pz, tx, ty, tz, true, false, false, true, false, false, false, attacker)) and (not isLineOfSightClear(px, py, pz, laX, laY, laZ, true, false, false, true, false, false, false, attacker)) and (not isLineOfSightClear(px, py, pz, raX, raY, raZ, true, false, false, true, false, false, false, attacker)) then
			if (attacker == localPlayer) then
				return
			elseif (source == localPlayer) then
				cancelEvent(true)
				return
			end
		end
	end
end
addEventHandler("onClientPlayerDamage", localPlayer, blockExploit)

function onClientPlayerDamage(attacker, weapon, bodypart, loss)

		-- Damage for localPlayer -->>
	if (source == localPlayer) then
	
			-- Make Tased Players Invincible
		if (getElementData(source, "tased")) then
			cancelEvent()
			return
		end

	end

		-- Damage Involving Player Attackers -->>
	if (attacker and isElement(attacker) and getElementType(attacker) == "player") then
		
		-- Miscellaneous Damage
		------------------------>>

		-- Disable Katana 1-Hit Kill
		if (weapon == 8 and loss > 50) then
			cancelEvent()
			return
		end

	end
	
		-- Damage Involving Vehicle Attackers -->>
	if (attacker and isElement(attacker) and getElementType(attacker) == "vehicle") then
		 if loss>50 then 
			setElementData(source,"majorfracture",true,true) 
			setElementData(source,"incapacitated",true,true)
			setTimer(function() setElementData(source,"incapacitated",false,true) end ,10000,1)
		end
	end	
end
addEventHandler("onClientPlayerDamage", root, onClientPlayerDamage)

--------------DAMAGE SOURCE HUD --moved to it's own script file
--[[local gRoot = getRootElement()
local gLPlayer = getLocalPlayer()
local gResourceRoot = getResourceRootElement()
local gDamageSources = {}
local gDamageAlpha = 0
local gDamageAlpha2 = 0
local gScreenX, gScreenY = guiGetScreenSize()
local gTick = nil

local gSourceAlpha = 255
local gDamageAlpha_head = 255
local gDamageAlpha_nothead = 159

local fadeOutDirection = 255  -- per second
local fadeOutDamaged = 255    -- per second


function findRotation(startX, startY, targetX, targetY) -- Doomed-Space-Marine
    local t = -math.deg(math.atan2(targetX - startX, targetY - startY))
     if t < 0 then
        t = t + 360
    end
    return t
end

function displayDamageSources()
    local tx, ty = getWorldFromScreenPosition(gScreenX * 0.5, gScreenY * 0.5, 100)
    local cx, cy = getCameraMatrix()
    local px, py = getElementPosition(gLPlayer)
    local cameraAngle = findRotation(cx, cy, tx, ty)
    
    for index, value in pairs(gDamageSources) do
        if value.a < 0 then
            gDamageSources[index] = nil
        else
            if value.x ~= false then
                local targetAngle = findRotation(px, py, value.x, value.y)
                local realAngle = targetAngle - cameraAngle + 180
                
                if realAngle < 0 then
                    realAngle = realAngle + 360
                end
                
                if realAngle > 360 then
                    realAngle = realAngle - 360
                end
                
                for i = -9, 9, 2 do
                    local disX, disY = (gScreenX * 0.5) + math.sin(math.rad(realAngle + i)) * (gScreenY * 0.25), (gScreenY * 0.5) + math.cos(math.rad(realAngle + i)) * (gScreenY * 0.25)
                    
                    dxDrawImage(disX - 8, disY - 8, 16, 16, "dmg.png", 0, 0, 0, tocolor(255, 255, 255, value.a))
                end
            end
            
            if getTickCount() - value.c >= 1000 then
                if value.aa == nil then
                    value.aa = value.a
                end
                
                if value.cc == nil then
                    value.cc = getTickCount()
                end
                
                value.a = math.floor(value.aa - (fadeOutDirection * (getTickCount() - value.cc) / 1000))
            end
        end
    end
end
addEventHandler("onClientRender", gRoot, displayDamageSources)

function displayDamageEffect()
    if gDamageAlpha > 0 and gTick ~= nil then
        dxDrawRectangle(0, 0, gScreenX, gScreenY, tocolor(0, 0, 0, gDamageAlpha))
        gDamageAlpha = math.floor(gDamageAlpha2 - (fadeOutDamaged * (getTickCount() - gTick) / 1000))
        
        if gDamageAlpha < 0 then
            gDamageAlpha = 0
            gDamageAlpha2 = 0
            gTick = nil
        end
    end
end
addEventHandler("onClientRender", gRoot, displayDamageEffect)

function afterDamage_damage(attacker, weapon, bodypart)
    local ax, ay, az = nil, nil, nil
    
    if isElement(attacker) == true  then 
        ax, ay, az = getElementPosition(attacker)
    else
        ax, ay, az = false, false, false
    end

    if weapon == 35 or weapon == 36 or weapon == 37 or weapon == 16 or weapon == 17 or weapon == 18 or weapon == 39 then
        ax, ay, az = false, false, false
    end
    
    local idx = #gDamageSources + 1
    
    if idx > 30 then
        local idx2 = idx % 30
        idx = idx - idx2 * 30
    end
    
    gDamageSources[idx] = {}
    gDamageSources[idx].x = ax
    gDamageSources[idx].y = ay
    gDamageSources[idx].z = az
    gDamageSources[idx].a = gSourceAlpha
    gDamageSources[idx].c = getTickCount()
    
    if bodypart == 9 then   -- headshot
        gDamageAlpha = gDamageAlpha_head
        gDamageAlpha2 = gDamageAlpha_head
    else    -- not headshot
        if gDamageAlpha < 159 then
            gDamageAlpha = gDamageAlpha_nothead
            gDamageAlpha2 = gDamageAlpha_nothead
        end
    end
    
    gTick = getTickCount()
end
addEventHandler("onClientPlayerDamage", gLPlayer, afterDamage_damage)

function damagedFunc(ax, ay, az)
    local idx = #gDamageSources + 1
    
    gDamageSources[idx] = {}
    gDamageSources[idx].x = ax
    gDamageSources[idx].y = ay
    gDamageSources[idx].z = az
    gDamageSources[idx].a = 255
end
addEvent("damaged", true)
addEventHandler("damaged", gRoot, damagedFunc)
]]