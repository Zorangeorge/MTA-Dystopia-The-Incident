--[[ BackWeapons script By Gothem

	Feel free to use and change it as you want,
	obviously keeping the credit to the creator.--]]
	
-----
--To prevent memory leaks, ensure each call to xmlLoadFile has a matching call to xmlUnloadFile <-----*****
---- local armed_data_file = xmlLoadFile("armed.xml")
---	local armed_nodes = xmlNodeGetChildren(armed_data_file)
--exports.bone_attach:attachElementToBone(element,ped,bone,x,y,z,rx,ry,rz)
--[[
Bone IDs:
1: head
2: neck
3: spine
4: pelvis
5: left clavicle
6: right clavicle
7: left shoulder
8: right shoulder
9: left elbow
10: right elbow
11: left hand
12: right hand
13: left hip
14: right hip
15: left knee
16: right knee
17: left ankle
18: right ankle
19: left foot
20: right foot
]]

local players = {}
local lplayer = getLocalPlayer()
local info = {}
local sx,sy = guiGetScreenSize()

function createWeapon(ply,arma)
	destroyWeapon(ply, arma)
	local model = obtainObject(arma)
	local slot = getSlotFromWeapon(arma)
	players[ply][slot] = createObject(model,0,0,0)
	setElementCollisionsEnabled(players[ply][slot],false)
end

addEvent ("CleanWeap", true) 
addEvent ("CleanRocketLauncher", true)
 
addEventHandler("CleanWeap", localPlayer, function (player, slot) destroyWeapon (player, slot) end) 

addEventHandler("CleanRocketLauncher", localPlayer, function () destroyElement (players[localPlayer][7]); players[localPlayer][7] = nil end) 

function destroyWeapon(ply,slot)
 if ply == nil then ply = localPlayer end
 	if isElement(players[ply][slot]) then
		destroyElement(players[ply][slot])
	end
	players[ply][slot] = nil
end

addEventHandler("onClientResourceStart",getResourceRootElement(),function()
	for k,v in ipairs(getElementsByType("player",root,true)) do
		players[v] = {}
		info[v] = {true,isPedInVehicle(v)}
	end
end,false)

addEventHandler("onClientPlayerQuit",root,function()
	if players[source] and source ~= lplayer then
		for k,v in pairs(players[source]) do
			destroyElement(v)
		end
		players[source] = nil
		info[source] = nil
	end
end)

addEventHandler("onClientElementStreamIn",root,function()
	if getElementType(source) == "player" and source ~= lplayer then
		players[source] = {}
		info[source] = {true,isPedInVehicle(source)}
	end
end)

addEventHandler("onClientElementStreamOut",root,function()
	if players[source] and source ~= lplayer then
		for k,v in pairs(players[source]) do
			destroyElement(v)
		end
		players[source] = nil
		info[source] = nil
	end
end)

addEventHandler("onClientPlayerSpawn",root,function()
	if players[source] then
		info[source][1] = true
	end
end)

addEventHandler("onClientPlayerWasted",root,function()
	if players[source] then
		for k,v in pairs(players[source]) do
			destroyWeapon(source,k)
		end
		info[source][1] = false
	end
end)

--[[addEventHandler("onClientPlayerWasted",root,function()
	if players[source] then
		for k,v in pairs(players[source]) do
			destroyWeapon(source,k)
		end
		info[source][1] = false
	end
end)
]]

addEvent("onPlayerModelChange",true)
addEventHandler("onPlayerModelChange",root,function()
	if players[source] then
		for k,v in pairs(players[source]) do
			--outputChatBox("destroyed")
			destroyWeapon(source,k)
		end

	end
end)

addEventHandler("onClientPlayerVehicleExit",root,function()
	if players[source] then
		info[source][2] = false
	end
end)

addEventHandler("onClientPreRender",root,function()
	for k,v in pairs(players) do
		local x,y,z = getPedBonePosition(k,3)
		local rot = math.rad(90-getPedRotation(k))
		local i = 15
		local wep = getPedWeaponSlot(k)
		local ox,oy = math.cos(rot)*0.22,-math.sin(rot)*0.22
		local alpha = getElementAlpha(k)
		local wx, wy, wz
		local wrx, wry, wrz
		
		
		for q,w in pairs(v) do
			if q == wep then
				destroyWeapon(k,q)
				--exports.bone_attach:detachElementFromBone(w)
			else
				setElementRotation(w,0,95,getPedRotation(k)+90)
				setElementAlpha(w,alpha)
				
				if q==2 and getPedWeapon(k,2) == 23 then --crossbow
				
				local playerrot = getPedRotation ( k )
				local radRot = math.rad ( playerrot )
				local radius = 0.2
				local px,py,pz = getElementPosition( k )
				local tx = px + radius * math.sin(radRot)
				local ty = py + -(radius) * math.cos(radRot)
				local tz = z-0.2
				setElementPosition ( w, tx, ty, tz )
				setElementRotation(w,-10,-(50+i),getPedRotation(k)+90)
					
				elseif q==2 and getPedWeapon(k,2) == 22 then --pistol
					local px,py,pz = getPedBonePosition(k,51)
					local qx,qy = math.sin(rot)*0.11,math.cos(rot)*0.11
					setElementPosition(w,px+qx,py+qy,pz)

				elseif q==2 and getPedWeapon(k,2) == 24 then --taser
					local px,py,pz = getPedBonePosition(k,51)
					local qx,qy = math.sin(rot)*0.11,math.cos(rot)*0.11
					setElementPosition(w,px+qx,py+qy,pz)
					
				elseif q==4 and getPedWeapon(k,4) == 32 then --auto pistol
					local px,py,pz = getPedBonePosition(k,41)
					local qx,qy = math.sin(rot)*0.06,math.cos(rot)*0.06
					setElementPosition(w,px-qx,py-qy,pz)
					
				elseif q==4 and getPedWeapon(k,4) == 28 then --uzi
					local px,py,pz = getPedBonePosition(k,41)
					local qx,qy = math.sin(rot)*0.06,math.cos(rot)*0.06
					setElementPosition(w,px-qx,py-qy,pz)
					
				elseif q==3 and getPedWeapon(k,3) == 26 then --sawn-off
					setElementPosition(w,x+ox,y+oy,z-0.1)
					setElementRotation(w,-15,-(50+i),getPedRotation(k))
					
				elseif q==1 and getPedWeapon(k,1) == 4  then --knife
					local playerrot = getPedRotation ( k )
					local radRot = math.rad ( playerrot )
					local radius = 0.16
					local px,py,pz = getElementPosition( k )
					local tx = px + radius * math.sin(radRot)
					local ty = py + -(radius) * math.cos(radRot)
					local tz = z-0.12
					setElementPosition ( w, tx, ty, tz )
					setElementRotation(w,-17,-230,getPedRotation(k))

				elseif q==1 and getPedWeapon(k,1) == 3  then --nightstick
					local playerrot = getPedRotation ( k )
					local radRot = math.rad ( playerrot )
					local radius = 0.15
					local px,py,pz = getElementPosition( k )
					local tx = px + radius * math.sin(radRot)
					local ty = py + -(radius) * math.cos(radRot)
					local tz = z-0.15
					setElementPosition ( w, tx, ty, tz )
					setElementRotation(w,-8,-230,getPedRotation(k))
					
				elseif q==1 and getPedWeapon(k,1) == 6  then  --crowbar
					local playerrot = getPedRotation ( k )
					local radRot = math.rad ( playerrot )
					local radius = 0.15
					local px,py,pz = getElementPosition( k )
					local tx = px + radius * math.sin(radRot)
					local ty = py + -(radius) * math.cos(radRot)
					local tz = z-0.2
					setElementPosition ( w, tx, ty, tz )
					setElementRotation(w,-8,-230,getPedRotation(k))
					
				elseif q==1 and getPedWeapon(k,1) == 2  then -- sword 
					local playerrot = getPedRotation ( k )
					local radRot = math.rad ( playerrot )
					local radius = 0.25
					local px,py,pz = getElementPosition( k )
					local tx = px + radius * math.sin(radRot)
					local ty = py + -(radius) * math.cos(radRot)
					local tz = z+0.22
					setElementPosition ( w, tx, ty, tz )
					setElementRotation(w,-5,180,getPedRotation(k))
					
				elseif q==1 and getPedWeapon(k,1) == 5  then --baseball bat
					local playerrot = getPedRotation ( k )
					local radRot = math.rad ( playerrot )
					local radius = 0.18
					local px,py,pz = getElementPosition( k )
					local tx = px + radius * math.sin(radRot)
					local ty = py + -(radius) * math.cos(radRot)
					local tz = z+0.2
					setElementPosition ( w, tx, ty, tz )
					setElementRotation(w,-17,180,getPedRotation(k)+90)

				elseif q==1 and getPedWeapon(k,1) == 7  then --sledgehammer
					local playerrot = getPedRotation ( k )
					local radRot = math.rad ( playerrot )
					local radius = 0.2
					local px,py,pz = getElementPosition( k )
					local tx = px + radius * math.sin(radRot)
					local ty = py + -(radius) * math.cos(radRot)
					local tz = z+0.25
					setElementPosition ( w, tx, ty, tz )
					setElementRotation(w,-8,180,getPedRotation(k))
					
				elseif q==1 and getPedWeapon(k,1) == 8  then --axe
					local playerrot = getPedRotation ( k )
					local radRot = math.rad ( playerrot )
					local radius = 0.2
					local px,py,pz = getElementPosition( k )
					local tx = px + radius * math.sin(radRot)
					local ty = py + -(radius) * math.cos(radRot)
					local tz = z+0.22
					setElementPosition ( w, tx, ty, tz )
					setElementRotation(w,-5,180,getPedRotation(k))

				elseif q==1 and getPedWeapon(k,1) == 9  then --chainsaw
					local playerrot = getPedRotation ( k )
					local radRot = math.rad ( playerrot )
					local radius = 0.25
					local px,py,pz = getElementPosition( k )
					local tx = px + radius * math.sin(radRot)
					local ty = py + -(radius) * math.cos(radRot)
					local tz = z+0.3
					setElementPosition ( w, tx, ty, tz )
					setElementRotation(w,-8,90,getPedRotation(k))
				
				elseif q==7 and getPedWeapon(k,7) == 35  then --rocket launcher -- this and the next does not seem to take rotation... wtf
					local playerrot = getPedRotation ( k )
					local radRot = math.rad ( playerrot )
					local radius = 0.2
					local px,py,pz = getElementPosition( k )
					local tx = px + radius * math.sin(radRot)
					local ty = py + -(radius) * math.cos(radRot)
					local tz = z
					setElementPosition ( w, tx, ty, tz )
					setElementRotation(w,-8,90,getPedRotation(k))
					
				elseif q==7 and getPedWeapon(k,7) == 36  then --HS rocket launcher
					local playerrot = getPedRotation ( k )
					local radRot = math.rad ( playerrot )
					local radius = 0.2
					local px,py,pz = getElementPosition( k )
					local tx = px + radius * math.sin(radRot)
					local ty = py + -(radius) * math.cos(radRot)
					local tz = z-0.2
					setElementPosition ( w, tx, ty, tz )
					setElementRotation(w,-5,90,getPedRotation(k))
				
				else --all other weaps; some need adjusting for sure; some are not implemented 
					
					--exports.bone_attach:attachElementToBone(w,k,8,wx,wy,wz,-17,-(50+i),getPedRotation(k))
					
					setElementPosition(w,x+ox,y+oy,z-0.2)
					setElementRotation(w,-17,-(50+i),getPedRotation(k))
					i=i+15
				end
			end
		end
		if info[k][1] and not info[k][2] then
			for i=1,7 do
				local arma = getPedWeapon(k,i)
				if arma~=wep and arma>0 and not players[k][i] then
					createWeapon(k,arma)
				end
			end
		end
		
--[[		if getPedArmor(k) > 0 and not getElementData(k,"armor_obj") then
		local x,y,z = getElementPosition(k)
		local rx,ry,rz = getElementRotation(k)
		local object_armor = createObject(1242,x,y,z)
			--setElementRotation(object_armor,0,0,rz)
		--attachElements(object_armor,k,0,-0.03,0.3)
		--exports.bone_attach:attachElementToBone(object_armor,k,3,0,0.045,0.045,5,0,0)
		exports.bone_attach:attachElementToBone(object_armor,k,3,  0.18, 0, 0.3,      -30, -50, 90  )---30, -50, 130
		setElementCollisionsEnabled(object_armor,false)
		setObjectScale(object_armor,1.0)
		setElementData(k,"armor_obj",object_armor)
		elseif getPedArmor(k) <= 0  then
			if getElementData(k,"armor_obj") then
				destroyElement(getElementData(k,"armor_obj"))
				setElementData(k,"armor_obj",nil)
			end
		end]]
		
		
	end
end)



function obtainObject(arma)
	local m
	if arma > 1 and arma < 9 then
		m = 331 + arma
	elseif arma == 9 then
		m = 341
	elseif arma == 15 then
		m = 326
	elseif (arma > 21 and arma < 30) or (arma > 32 and arma < 39) or (arma > 40 and arma < 44) then
		m = 324 + arma
	elseif arma > 29 and arma < 32 then
		m = 325 + arma
	elseif arma == 32 then
		m = 372
	elseif arma == 10 then
		m = 321
	elseif arma == 11 then
		m = 322
	elseif arma == 12 then
		m = 323
	elseif arma == 14 then
		m = 325
	elseif arma == 15 then
		m = 326
	elseif arma == 46 then
		m = 371
	end
	return m
end