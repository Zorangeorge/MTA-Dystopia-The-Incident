-- ( Syncer |server) by: Markland L. Poyser aka DarkChemical







local syncDist = 80
local powerVal = 250
local elementSyncDist = {
	ped = 400,
	veh = 400,
	obj = 100,
}
local levelRate = {}
levelRate["Primary"] = 2000
levelRate["Secondary"] = 8000
local syncers = {}
--[[
syncers[client] = player
syncers[client]["Hardwear Rank"] = 100
syncers[client]["Sync Usage"] = syncedElements
syncers[client]["Power Used"] = hwR + ping + usage
syncers[client]["Available"] = {}
syncers[client]["Available"][ped] = true
syncers[client]["Sync"] = {}
syncers[client]["Sync"][ped] = updateRate(100ms)
]]

local syncElements = {}
--[[
syncElements[ped] = {}
syncElements[ped]["Primary"] = player
syncElements[ped]["Secondary"] = player2
syncElements[ped]["Available"] = {}
syncElements[ped]["Available"][player1] = true
syncElements[ped]["Available"][player2] = true
syncElements[ped]["Available"][player3] = true
]]

function addSyncPlayer(player)
	if player then
		syncers[player] = {}
		syncers[player]["Sync Usage"] = 0
		syncers[player]["Available"] = {}
		syncers[player]["Sync"] = {}
		syncers[player]["Hardwear Rank"] = 100
		addEventHandler("onElementDestroy", player, function()
			syncers[player] = nil
		end, false)
		--setTimer(triggerClientEvent, 300, 1, player, "onClientCreateSyncZone", root, 80, 110, 30)
		local esd = elementSyncDist
		setTimer(triggerClientEvent, 300, 1, player, "onClientCreateSyncZone", root, esd.ped, esd.veh, esd.obj)
	end
end

function addSyncElement(element)
	if isElement(element) then
		if syncElements[element] then return false end
		local pri, sec = pri or false, sec or false
		syncElements[element] = {}
		syncElements[element]["Primary"] = false
		syncElements[element]["Secondary"] = false
		syncElements[element]["Available"] = {}
		addEventHandler("onElementDestroy", element, function()
			if not syncElements[element] then return end
			for player in pairs(syncElements[element]["Available"]) do
				setSyncPlayerAvailable(element, player, false, false)
			end
			syncElements[element] = nil
		end, false)
		return true
	end
end

function setSyncPlayer(element, player, level, update)
	if isElement(element) then
		local level = level or "Primary"
		if not syncElements[element] then addSyncElement(element) end
		local syncer = syncElements[element][level]
		if syncer == player then return true end
		local rate = levelRate[level]
		if syncer then
			local power = syncers[syncer]["Sync"][element]
			syncers[syncer]["Sync Usage"] = syncers[syncer]["Sync Usage"] - power
			syncers[syncer]["Sync"][element] = nil
			syncElements[element][level] = false
			if update or update == nil then
				triggerClientEvent(syncer, "onSyncElementStatus", root, element, false)
			end
		end
		if player then
			local power = powerVal/rate
			syncers[player]["Sync Usage"] = syncers[player]["Sync Usage"] + power
			syncers[player]["Sync"][element] = power
			syncElements[element][level] = player
			if update or update == nil then
				triggerClientEvent(player, "onSyncElementStatus", root, element, rate)
			end
		end
		if level == "Primary" then setElementData(element, "Syncer", syncElements[element][level]) end
	end
end

function setSyncPlayerAvailable(element, player, available, update)
	if isElement(element) and isElement(player) then
		if not syncElements[element] then addSyncElement(element) end
		local available = available or nil
		syncers[player]["Available"][element] = available
		syncElements[element]["Available"][player] = available
		if update or update == nil then
			if available then
				if not syncElements[element]["Primary"] then
					startSync(element)
				end
			else
				if syncers[player]["Sync"][element] then
					if syncElements[element]["Primary"] == player then
						setSyncPlayer(element, player, "Primary", false)
					elseif syncElements[element]["Secondary"] == player then
						setSyncPlayer(element, player, "Secondary", false)
					end
				end
			end
		end
	end
end

addEvent("onPlayerSyncableElementsUpdate", true)
function updatePlayerSyncableElements(player, elements)
	if player then
		for element in pairs(elements) do
			local available = elements[element]
			setSyncPlayerAvailable(element, player, available, true)
		end
	end
end
addEventHandler("onPlayerSyncableElementsUpdate", root, function(elements)
	local player = client
	if not syncers[player] then return false end
	updatePlayerSyncableElements(player, elements)
end)

function syncElementStatus(element, info, player)
	if syncElements[element] then
		syncElements[element]["Pos"] = info
		triggerClientEvent(player, "onClientSyncUpdate", element, info)
		local p = info["Position"]
		local r = info["Rotation"]
		local v = info["Velocity"]
		local t = info["Turn"]
		--print("Sync:", element, getElementType(element), p.x)
		local x, y, z =  p.x, p.y, p.z
		--do return false end
		if p.x then setElementPosition(element, p.x, p.y, p.z, false) end
		if r.x then local _ = getElementType(element)=="ped" and setElementRotation(element, r.x, r.y, 360-r.z, "ZXY", true) or setElementRotation(element, r.x, r.y, r.z, "ZXY", true) end
		--if v.x then setElementVelocity(element, v.x, v.y, v.z) end
		--if t.x then setElementAngularVelocity(element, t.x, t.y, t.z) end
		triggerClientEvent(player, "onClientSyncUpdateEnd", element)
	end
end


addEvent("onPlayerSendSyncInfo", true)
function requestPlayerSendSyncInfo(player, element, info)
	local player = client or player
	if player and syncElements[element] then
		local syncInfo = syncElements[element]
		local pri = syncInfo["Primary"]
		local sec = syncInfo["Secondary"]
		if pri and player ~= pri then return false end
		if (player == pri) or player == sec then
			syncElementStatus(element, info, player)
		end
	end
end
addEventHandler("onPlayerSendSyncInfo", root, requestPlayerSendSyncInfo)


addEvent("onPlayerUpdateHardwearRank", true)
addEventHandler("onPlayerUpdateHardwearRank", root, function(rank)
	local player = client
	if player and rank then
		if not syncers[player] then
			addSyncPlayer(player)
		end
		syncers[player]["Hardwear Rank"] = rank
	end
end)

addEvent("onSyncerUpdateElements", true)
addEventHandler("onSyncerUpdateElements", root, function(elements)
	--local i = 0
	--local tick = getTickCount()
	--print("got:", elements)
	for element in pairs(elements) do
		--i = i+1
		local info = elements[element]
		requestPlayerSendSyncInfo(client, element, info)
	end
	--print("Synced:", elements, i, getTickCount()-tick)
end)


-- getElementSyncer setElementSyncer onElementStartSync onElementStopSync getPlayerPing

function startSync(element, player)
	if isElement(element) and not getElementSyncer(element) then
		if not syncElements[element] then addSyncElement(element) end
		if syncElements[element]["Primary"] then return false end
		local bestPlayer = player
		local n = 1000
		for player in pairs(syncElements[element]["Available"]) do
			local hwR = syncers[player]["Hardwear Rank"] --error syncers[player]["Sync"][element] remove all 
			local usage = syncers[player]["Sync Usage"]
			local ping = getPlayerPing(player)
			local p = hwR + ping + usage
			if p < n then
				bestPlayer = player
				n = p
			end
		end
		if bestPlayer then
			setSyncPlayer(element, bestPlayer, "Primary", true)
			--setElementSyncer(element, false)
		end
	end
end

function stopSync(element)
	if syncElements[element] and syncElements[element]["Primary"] then
		setSyncPlayer(element, false, "Primary", true)
		--setElementSyncer(element, true)
	end
end


addEventHandler("onElementStartSync", root, function(player)
	local element = source
	--print("SYNC:", "start", element)
	if not syncElements[element] then addSyncElement(element) end
	stopSync(element)
end)

addEventHandler("onElementStopSync", root, function(player)
	local element = source
	if not syncElements[element] then addSyncElement(element) end
	--print("SYNC:", "stop", element)
	setTimer(startSync, 300, 1, element, player)
end)


addEvent("onPlayerRequestSync", true)
addEventHandler("onPlayerRequestSync", root, function(info)
	local player = client
	local element = source
	local elementType = getElementType(element)
	if elementType ~= "ped" or elementType ~= "vehicle" then return end
	if not syncElements[element] then addSyncElement(element) end
	if syncElements[element]["Primary"] and syncElements[element]["Primary"] ~= player then
		local info = syncElements[element]["Pos"]
		local p = info["Position"]
		local x, y = getElementPosition(player)
		local dist = getDistanceBetweenPoints2D(p.x, p.y, x, y)
		if dist > 90 then
			--return false
		end
	end
	local syncer = getElementSyncer(element)
	if not syncer then
		local info = info or syncElements[element]["Pos"]
		local p = info["Position"]
		local r = info["Rotation"]
		local v = info["Velocity"]
		local t = info["Turn"]
		if p.x then setElementPosition(element, p.x, p.y, p.z, false) end
		if r.x then local _ = getElementType(element)=="ped" and setElementRotation(element, r.x, r.y, 360-r.z, "ZXY", true) or setElementRotation(element, r.x, r.y, r.z, "ZXY", true) end
		if v.x then setElementVelocity(element, v.x, v.y, v.z) end
		if t.x then setElementAngularVelocity(element, t.x, t.y, t.z) end
		--setElementSyncer(element, player)
	end
end)

addEventHandler("XonPlayerJoin", root, function()
	local player = source
	for element in pairs(syncElements) do
		if not getElementSyncer(element) then
			local info = syncElements[element]["Pos"]
			if info then
				triggerClientEvent(player, "onClientSyncUpdate", root, element, info)
			end
		end
	end
end)






























