-- ( Syncer |client) by: Markland L. Poyser aka DarkChemical



-- Syncer
-- isElementLocal isElementSyncer 
local stop
addEventHandler("onClientResourceStop", resourceRoot, function()
	stop = true
end)

local syncInfo
do
	syncInfo = {}
	syncInfo["Position"] = getElementPosition
	syncInfo["Rotation"] = getElementRotation
	syncInfo["Velocity"] = getElementVelocity
	syncInfo["Turn"] = getElementAngularVelocity
end

local function getHardwearRank(update)
	local avg = 0
	local n = 20
	for i=1, n do
		local t = getTickCount()
		for i=1, 100000 do
			local a = i^i
			local b = i*i
			local c = ((a*b)*(a^b))^i
		end
		local t = getTickCount() - t
		avg = avg + t
		--outputChatBox("Client Hardwear Rank: \""..tostring(t).."\"", 120, 120, 255)
	end
	local avg = avg/n
	--outputChatBox("Client Hardwear Rank Average: \""..tostring(avg).."\"", 250, 120, 255)
	if update or update == nil then
		triggerServerEvent("onPlayerUpdateHardwearRank", root, avg)
	end
	return avg
end
getHardwearRank()

local syncElements = {}
local pendingUpdate = {}
elementTypeDist = {
	object = .1,
	ped = .1,
	vehicle = 0,
}

function setSyncElementStatus(element, rate)
	if rate then
		syncElements[element] = rate
		local p = {}
		local upDist = 0
		upDist = elementTypeDist[getElementType(element)] or upDist
		p.x, p.y, p.z = getElementPosition(element)
		syncElements[tostring(element)] = setTimer(function()
			if pendingUpdate[element] then pendingUpdate[element]=0 return false end
			if getElementAttachedTo(element) then return end
			if isElement(element) then
				local x, y, z = getElementPosition(element)
				if not x then return end
				local dist = upDist==0 and 10 or getDistanceBetweenPoints3D(x, y, z, p.x, p.y, p.z)
				if dist >= upDist then
					addUpdateElement(element)
					pendingUpdate[element] = true
					p.x, p.y, p.z = x, y, z
				end
			end
		end, rate, 0)
		addEventHandler("onClientElementDestroy", element, function()
			if syncElements[tostring(element)] then
				killTimer(syncElements[tostring(element)])
				syncElements[tostring(element)] = nil
			end
		end, false)
		--outputChatBox("GOT!")
	elseif syncElements[element] then
		syncElements[element] = nil
		local timer = syncElements[tostring(element)]
		killTimer(timer)
		syncElements[tostring(element)] = nil
		 --outputChatBox("LOST!")
	end
end

local syncUpdates = {}
function updateSyncElements()
	if stop then return end
	if next(syncUpdates) then
		local elements = {}
		for i, element in ipairs(syncUpdates) do
			local info = {}
			info["Position"] = {}
			info["Rotation"] = {}
			--info["Velocity"] = {}
			--info["Turn"] = {}
			local p = info["Position"]
			local r = info["Rotation"]
			local v = info["Velocity"]
			local t = info["Turn"]
			p.x, p.y, p.z = getElementPosition(element)
			r.x, r.y, r.z = getElementRotation(element, "ZXY")
			--v.x, v.y, v.z = getElementVelocity(element)
			--t.x, t.y, t.z = getElementAngularVelocity(element)
			if p.x then elements[element] = info end
			--elements[element] = info
		end
		triggerServerEvent("onSyncerUpdateElements", localPlayer, elements)
		--triggerLatentServerEvent("onSyncerUpdateElements", 5000, false, localPlayer, elements)
		syncUpdates = {}
	end
end
setTimer(updateSyncElements, 200, 0)

function addUpdateElement(element)
	if isElement(element) then
		if not syncUpdates[element] then
			syncUpdates[#syncUpdates+1] = element
			syncUpdates[element] = #syncUpdates
		end
		return true
	else
		outputDebugString("invalid element at 'addUpdateElement'", 2)
		return false
	end
end

addEvent("onSyncElementsStatus", true)
addEventHandler("onSyncElementsStatus", root, function(elements)
	for element in pairs(elements) do
		local rate = elements[element]
		setSyncElementStatus(element, rate)
	end
end)


addEvent("onSyncElementStatus", true)
addEventHandler("onSyncElementStatus", root, function(element, rate)
	setSyncElementStatus(element, rate)
end)


local availableElements = {}
local availableElementsUpdates = {}

local sycableTypes = {
	object = true,
	ped = true,
	vehicle = true,
}

local syncZone = {}
addEvent("onServerRequestSyncer", true)
addEvent("onClientCreateSyncZone", true)
function createSyncZone(sizeP, sizeV, sizeO)
	for _, t in ipairs({"object", "ped", "vehicle"}) do
		for _, element in ipairs(getElementsByType(t, root, true)) do
			if not (isElementLocal(element) or availableElements[element]) then
				availableElementsUpdates[element] = true
				availableElements[element] = true
			end
		end
	end
	addEventHandler("onClientElementStreamIn", root, function()
		local element = source
		if isElementLocal(element) or availableElements[element] then return false end
		if not sycableTypes[getElementType(element)] then return end
		availableElementsUpdates[element] = true
		availableElements[element] = true
	end)
	addEventHandler("onClientElementStreamOut", root, function()
		local element = source
		if isElementLocal(element) then return false end
		availableElementsUpdates[element] = false
		availableElements[element] = false
	end)
	local size = {}
	size.ped, size.vehicle, size.object = sizeP or 80, sizeV or 120, sizeO or 50
	for i, v in ipairs({"ped", "vehicle", "object"}) do
		local size = size[v] or 80
		if syncZone[v] then destroyElement(syncZone[v]) syncZone[v] = nil end
		local x, y = getElementPosition(localPlayer)
		syncZone[v] = createColCircle(x, y+1, size)
		addEventHandler("onClientColShapeHit", syncZone[v], function(element)
			if getElementType(element) == v then
				local info = {}
				info["Position"] = {}
				info["Rotation"] = {}
				info["Velocity"] = {}
				info["Turn"] = {}
				local p = info["Position"]
				local r = info["Rotation"]
				local v = info["Velocity"]
				local t = info["Turn"]
				p.x, p.y, p.z = getElementPosition(element)
				r.x, r.y, r.z = getElementRotation(element, "ZXY")
				--v.x, v.y, v.z = getElementVelocity(element)
				--t.x, t.y, t.z = getElementAngularVelocity(element)
				triggerServerEvent("onPlayerRequestSync", element, info)
				--outputChatBox("Request Sync")
			end
		end, false)
		addEventHandler("onClientElementDestroy", syncZone[v], function()
			if next(availableElements) then
				local t = {}
				for element in pairs(availableElements) do
					t[element] = false
				end
				triggerServerEvent("onPlayerSyncableElementsUpdate", root, t)
				availableElements = {}
				t = nil
			end
		end, false)
		attachElements(syncZone[v], localPlayer)
	end
end
addEventHandler("onClientCreateSyncZone", root, createSyncZone)
--createSyncZone(100)

setTimer(function()
	if next(availableElementsUpdates) then
		--outputChatBox("sent")
		triggerServerEvent("onPlayerSyncableElementsUpdate", root, availableElementsUpdates)
		--triggerLatentServerEvent("onPlayerSyncableElementsUpdate", root, availableElementsUpdates)
		availableElementsUpdates = {}
	end
end, 120, 0)

local realPositions = {}
local syncPositions = {}
addEvent("onClientSyncUpdate", true)
addEvent("onClientSyncUpdateEnd", true)
addEventHandler("onClientSyncUpdate", root, function(info)
	local element = source
	syncPositions[element] = info
	local info = {}
	info["Position"] = {}
	info["Rotation"] = {}
	info["Velocity"] = {}
	info["Turn"] = {}
	local p = info["Position"]
	local r = info["Rotation"]
	local v = info["Velocity"]
	local t = info["Turn"]
	p.x, p.y, p.z = getElementPosition(element)
	r.x, r.y, r.z = getElementRotation(element, "ZXY")
	--v.x, v.y, v.z = getElementVelocity(element)
	--t.x, t.y, t.z = getElementAngularVelocity(element)
	realPositions[element] = info
end)
addEventHandler("onClientSyncUpdateEnd", root, function()
	local element = source
	local p = syncPositions[element]["Position"] or {}
	if pendingUpdate[element] == true then
		pendingUpdate[element] = nil
	elseif pendingUpdate[element] == 0 then
		pendingUpdate[element] = nil
		local upDist = 0
		upDist = elementTypeDist[getElementType(element)] or upDist
		p.x, p.y, p.z = getElementPosition(element)
		local x, y, z = getElementPosition(element)
		if x then
			local dist = upDist==0 and 10 or getDistanceBetweenPoints3D(x, y, z, p.x, p.y, p.z)
			if dist >= upDist then
				addUpdateElement(element)
				pendingUpdate[element] = true
				p.x, p.y, p.z = x, y, z
			end
		end
	end
	local info = realPositions[element]
	if not info then return end
	local p = info["Position"]
	local r = info["Rotation"]
	local v = info["Velocity"]
	local t = info["Turn"]
	if p.x then setElementPosition(element, p.x, p.y, p.z, false) end
	if r.x then local _ = getElementType(element)=="ped" and setElementRotation(element, r.x, r.y, 360-r.z, "ZXY", true) or setElementRotation(element, r.x, r.y, r.z, "ZXY", true) end
	if v.x then setElementVelocity(element, v.x, v.y, v.z) end
	if t.x then setElementAngularVelocity(element, t.x, t.y, t.z) end
	realPositions[element] = nil
	syncPositions[element] = nil
end)

addEventHandler("onClientPreRender", root, function()
	local rem = {}
	for element, info in pairs(syncPositions) do
		local inf = {}
		inf["Position"] = {}
		inf["Rotation"] = {}
		inf["Velocity"] = {}
		inf["Turn"] = {}
		local p = inf["Position"]
		local r = inf["Rotation"]
		local v = inf["Velocity"]
		local t = inf["Turn"]
		p.x, p.y, p.z = getElementPosition(element)
		if not p.x then rem[element] = true end
		r.x, r.y, r.z = getElementRotation(element, "ZXY")
		--v.x, v.y, v.z = getElementVelocity(element)
		--t.x, t.y, t.z = getElementAngularVelocity(element)
		local revert = true
		for i, d in pairs(info) do
			local x, y, z = inf[i].x, inf[i].y, inf[i].z
			if x~=d.x or y~=d.y or z~=d.z then revert = false break end 
		end
		if revert then
			local info = realPositions[element]
			local p = info["Position"]
			local r = info["Rotation"]
			local v = info["Velocity"]
			local t = info["Turn"]
			if p.x then setElementPosition(element, p.x, p.y, p.z, false) end
			if r.x then local _ = getElementType(element)=="ped" and setElementRotation(element, r.x, r.y, 360-r.z, "ZXY", true) or setElementRotation(element, r.x, r.y, r.z, "ZXY", true) end
			if v.x then setElementVelocity(element, v.x, v.y, v.z) end
			if t.x then setElementAngularVelocity(element, t.x, t.y, t.z) end
			--realPositions[element] = nil
			--syncPositions[element] = nil
			rem[element] = true
		elseif inf then
			realPositions[element] = inf
		end
	end
	for element in pairs(rem or {}) do
		syncPositions[element] = nil
		realPositions[element] = nil
	end
	rem = nil
end)




addEventHandler("onClientElementDestroy", root, function()
	realPositions[source] = nil
	syncPositions[source] = nil
	local n = syncUpdates[source]
	if n==nil then return end
	syncUpdates[n] = nil
	syncUpdates[source] = nil
end)




if false then -- Sync Element Display
	local syncedElements = {}
	local eTypes = {"ped"}--, "object", "vehicle"}
	
	local w, h = 10, 10
	local text, tw, th = "Sync", 20, 20
	addEventHandler("onClientRender", root, function()
		local md = getFarClipDistance()
		for i=1, #syncedElements do
			local e = syncedElements[i]
			if e then
				local x, y, z = getElementPosition(localPlayer)
				local x2, y2, z2 = getElementPosition(e)
				local sx, sy = getScreenFromWorldPosition(x2, y2, z2+1.5)
				local d = getDistanceBetweenPoints2D(x, y, x2, y2)
				--local w, h = 20/d, 20/d
				local _w, _h = w/2, h/2
				if d<=md and sx and sy then
					local color = (isElementSyncer(e) and tocolor(50, 255, 50, 160)) or (getElementData(e, "Syncer")==localPlayer and tocolor(50, 50, 255, 160)) or (getElementData(e, "Syncer") and tocolor(250, 200, 50, 160)) or tocolor(255, 50, 50, 160)
					--dxDrawImage(sx-_w, sy-_h, w, h, "dot.png", 0, 0, 0, color)
					dxDrawText(text, sx-(tw/2), sy-th, tw, th, color, 1, "default", "left", "top")
				end
			end
		end
	end)
	local function update()
		for i, type in pairs(eTypes) do
			local elements = getElementsByType(type, true)
			for i=1, #elements do
				local e = elements[i]
				if e then
					local sync = getElementData(e, "Syncer")--==localPlayer
					if not syncedElements[e] then
						syncedElements[#syncedElements+1] = e
						syncedElements[e] = #syncedElements
					elseif true then
					elseif sync and not syncedElements[e] then
						syncedElements[#syncedElements+1] = e
						syncedElements[e] = #syncedElements
					elseif syncedElements[e] and not sync then
						syncedElements[syncedElements[e]] = nil
						syncedElements[e] = nil
					end
				end
			end
		end
	end
	
	addEventHandler("onClientElementDestroy", root, function()
		if syncedElements[source] then
			syncedElements[syncedElements[source]] = nil
			syncedElements[source] = nil
		end
	end)
	
	setTimer(update, 2000, 0)
	update()
end






















