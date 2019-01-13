gRoot = getRootElement()
gLPlayer = getLocalPlayer()
gResourceRoot = getResourceRootElement()
gDamageSources = {}
gDamageAlpha = 0
gDamageAlpha2 = 0
gScreenX, gScreenY = guiGetScreenSize()
gTick = nil

gSourceAlpha = 255
gDamageAlpha_head = 255
gDamageAlpha_nothead = 159

fadeOutDirection = 255	-- per second
fadeOutDamaged = 255	-- per second





local WeaponPlayerDamageFactor = 1.21
--local theHPloss = 0 
--addEvent("syncDamageValueLocalPlayer",true) 
--addEventHandler("syncDamageValueLocalPlayer", localPlayer, function(_, _, _, _, message) theHPloss = message*1.21 end)


function displayDamageSources()
	
	if #gDamageSources>0 then
			
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
						DamDisX, DamDisY = (gScreenX * 0.5) + math.sin(math.rad(realAngle + i)) * (gScreenY * 0.25), (gScreenY * 0.5) + math.cos(math.rad(realAngle + i)) * (gScreenY * 0.25)
						dxDrawImage(DamDisX - 8, DamDisY - 8, 16, 16, "images/dmg.png", 0, 0, 0, tocolor(255, 255, 255, value.a))
					end
					
	--[[				local damText = false
					if not damText then damText = dxDrawText("-"..tostring(math.floor(theHPloss)),DamDisX - 8, DamDisY - 8, 16, 16, tocolor(255, 255, 255, value.a),1,"pricedown") end
					setTimer(function() if isElement(damText) then destroyElement(damtext); damText = false end end,1000,1)]]
					
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

function afterDamage_damage(attacker, weapon, bodypart,loss)
	
	--[[outputDebugString("original phealth is:"..tostring(thePlayerHealth))
	theHPloss = thePlayerHealth - getElementHealth(localPlayer)
	outputDebugString("new phealth is:"..tostring(thePlayerHealth-theHPloss))
	outputDebugString("loss is:"..theHPloss)
	thePlayerHealth = getElementHealth(localPlayer)]]
	
	local ax, ay, az = nil, nil, nil
	local attackerType 
	
	if isElement(attacker) then attackerType = getElementType(attacker) else attackerType = false end
	
	if isElement(attacker) == true and attackerType == "player" and getPlayerName(attacker) ~= getPlayerName(source) then
		ax, ay, az = getElementPosition(attacker)	
	elseif isElement(attacker) == true and attackerType == "ped" then
		ax, ay, az = getElementPosition(attacker)
	else
		ax, ay, az = false, false, false
	end
	
	---[[
	if weapon == 35 or weapon == 36 or weapon == 37 or weapon == 16 or weapon == 17 or weapon == 18 or weapon == 39 then
		ax, ay, az = false, false, false
	end
	--]]
	
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
	
	if bodypart == 9 then	-- headshot
		gDamageAlpha = gDamageAlpha_head
		gDamageAlpha2 = gDamageAlpha_head
	else	-- not headshot
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

function findRotation(startX, startY, targetX, targetY)	-- Doomed-Space-Marine
	local t = -math.deg(math.atan2(targetX - startX, targetY - startY))
	
	if t < 0 then
		t = t + 360
	end
	
	return t
end

addEventHandler("onClientVehicleDamage", root,
	function (att)
		if (isElement(att) and getElementType(att) == "vehicle") then
			if isElementAttached(att) and getElementAttachedTo(att) == source then
				outputDebugString("no damage")
				cancelEvent()
			end
		end
	end
)