addEvent("ClientTriggersWakeUp",true)

local BED_IDS = {
	--[1647] 		= 	true,
	--[1812] 		= 	true
	[1800]	 	= 	true,
	[14861] 	= 	true,
	[1801]	 	= 	true,
	[1793] 	= 	true
}

local BEDS_COLSHAPE_OFFSET = {
  --[model]	=	{x,		y, 		z, 		radius}
	[1800] 	= 	{0.3,	2.25,	1,		1.8}, --metal bed
	[1801] 	= 	{0.3,	2.25,	1,		1.8}, --good bed
	[14861] = 	{-0.25,	0,		1,		1.8}, -- coochie bed
	[1793] = 	{0.5,	2.1,		0.5,		1.8} --large matress
	--[1647] 	= 	{0,		0,		-0.063,	1.5},
	--[1812] 	= 	{0,		1.5,	0.25,	1.5}
}

--local WALKING_TO_BED = 0.35 -- ms/unit
local ENTER_TO_BED_KEY = "e"

local REPLENISH_HP_EACH = 0.5 -- seconds
local REPLENISH_LIVE_EACH = 10 -- seconds

local REPLENISH_UP_TO_X_HP = 12
local REPLENISH_UP_TO_X_LIVES = 1

local SLEEPING_COOLDOWN = 5 -- minutes

current_beds = {}
col_to_bed = {}
bed_to_col = {}
player_in_bed = {}
bed_warming = {}
player_timers = {}

function createBed(object)
	if current_beds[object] then return false end
	local x, y, z = getElementPosition(object)
	local model = getElementModel(object)

	local ox, oy, oz, _or = unpack(BEDS_COLSHAPE_OFFSET[model])
	local rx, ry, rz = getElementRotation(object)

	local colshape = createColSphere(0, 0, 0, _or)
	setElementData(colshape,"bedcol",true,true)
	attachElements(colshape, object, ox, oy, oz)
	setElementRotation(colshape, rx, ry, rz)
	detachElements(colshape, object)

	--[[addEventHandler("onColShapeHit", colshape, 
		function (player, dimension)
			and not player_in_bed[player] then
				outputChatBox("Press "..ENTER_TO_BED_KEY:upper().." to get in the bed.", player)
				bindKey(player, ENTER_TO_BED_KEY, "down", getInBed, player, object)
				triggerClientEvent(root, "sleep:collisions", root, player, object, true)
			end
		end
	)

	addEventHandler("onColShapeLeave", colshape,
		function (player, dimension)
			if isKeyBound(player, ENTER_TO_BED_KEY, "down", getInBed) then
				unbindKey(player, ENTER_TO_BED_KEY, "down", getInBed)
				triggerClientEvent(root, "sleep:collisions", root, player, object, true)
			end
		end
	)]]

	col_to_bed[colshape] = object
	bed_to_col[object] = colshape
	current_beds[object] = model
end

function getInBed(_, _, _, player, bed)
	unbindKey(player, ENTER_TO_BED_KEY, "down", getInBed)
		
	if bed_warming[bed] then
		return
	end

	if not player_timers[player] then player_timers[player] = {} end

	if isTimer(player_timers[player][1]) or isTimer(player_timers[player][2]) then
		return
	end

	local account = getPlayerAccount(player)

	if not isGuestAccount(account) then
		cooldown = getAccountData(account, "sleep:cooldown")
	else
		cooldown = getElementData(player, "sleep:cooldown")
	end

	if cooldown and tonumber(cooldown) and tonumber(cooldown) >= getRealTime().timestamp then
		outputTopBar( "You're rested, wait "..math.ceil((tonumber(cooldown)-getRealTime().timestamp)/60).." minutes to sleep again.", player, 255,255,255)
		--outputChatBox("You're rested, wait for "..math.ceil((tonumber(cooldown)-getRealTime().timestamp)/60).." minutes before sleeping again", player)
		return
	end
	
	local theBed = bed
	local bed = bed_to_col[bed]
	local px, py, pz = getElementPosition(player)
	local bx, by, bz = getElementPosition(bed)
	local _, _, rz = getElementRotation(theBed)
	local model = getElementModel(bed)

	--local ox, oy, oz = unpack(BEDS_COLSHAPE_OFFSET[model])
	local deg = findRotation(px, py, bx, by)

	setElementRotation(player, 0, 0, deg, "default")
	--setPedAnimation(player, "ped", "walk_player", -1, false, false)

	local distance = getDistanceBetweenPoints3D(px, py, pz, bx, by, bz)

	player_timers[player][1] = setTimer(
		function (player)
			if isElement(player) then
				setPedAnimation(player, "int_house", "lou_in", -1, false, false)
				triggerClientEvent(root, "sleep:collisions", root, player, theBed, false)
				triggerClientEvent(player, "sleep:addShader", player, 1500)
				player_timers[player][2] = setTimer(
					function (player)
						bindKey(player, ENTER_TO_BED_KEY, "down", wakeUp, player)
						setElementPosition(player, bx, by, bz)
						setPedAnimation(player, "int_house", "bed_loop_r", -1, false, false)
						setElementRotation(player, 0, 0, rz+270, "default")
						player_timers[player][3] = setTimer(replenisHealthPoints, REPLENISH_HP_EACH*1000, REPLENISH_UP_TO_X_HP, player)
						player_timers[player][4] = setTimer(replenishLives, REPLENISH_LIVE_EACH*1000, REPLENISH_UP_TO_X_LIVES, player)
						triggerClientEvent(player, "sleep:drawDXProgress", player, REPLENISH_LIVE_EACH*1000, REPLENISH_UP_TO_X_HP)
						outputInteractInfo("Wake up\n["..ENTER_TO_BED_KEY:upper().."]", player, 255, 255, 255)
						outputStatusInfo("Sleeping...", player, 255, 255, 255)
					end, 
				1500, 1, player)
			end
		end, 
	50, 1, player)

	setElementData(player, "sleeping", true)
	player_in_bed[player] = bed
	bed_warming[bed] = player
end

function replenisHealthPoints(player)
	local health = getElementHealth(player)
	if health >= getPedMaxHealth(player) then
		killTimer(sourceTimer)
	else
		triggerClientEvent(player, "sleep:updateHealth", player, health+1)
		outputStatusInfo("+ 1 hp",player, 0,200,0)
	end
end

function replenishLives(player)
	local lives = getElementData(player, "lives")
	--if lives and lives > 0 and lives < 2 then
	if lives and lives > 0 and lives < 3 then
		setElementData(player, "lives", lives + 1)
		outputStatusInfo("+1 life",player, 0,200,0 )
		local account = getPlayerAccount(player)
		if not isGuestAccount(account) then
			setAccountData(account, "sleep:cooldown", getRealTime().timestamp + SLEEPING_COOLDOWN*60)
		else
			setElementData(player, "sleep:cooldown", getRealTime().timestamp + SLEEPING_COOLDOWN*60)
		end
	end
	wakeUp(player)
end

function wakeUp(player, _, _, kick_anim)
	if isElement(player) and player_in_bed[player] then
		if isTimer(player_timers[player][1]) or isTimer(player_timers[player][2]) then
			return
		end

		if isTimer(player_timers[player][3]) then
			killTimer(player_timers[player][3])
		end

		if isTimer(player_timers[player][4]) then
			killTimer(player_timers[player][4])
		end
		unbindKey(player, ENTER_TO_BED_KEY, "down", wakeUp)
		triggerClientEvent(player, "sleep:stopDXProgress", player)
		triggerClientEvent(player, "sleep:removeShader", player, 4000)

		local bed = player_in_bed[player]

		if kick_anim == 0 then
			setPedAnimation(player, "ped", "KO_skid_front", 2300, false, true, true, false)
			setTimer(
				function ()
					setPedAnimation(player)
				end,
			2500, 1)
		else
			setPedAnimation(player, "int_house", "bed_out_r", -1, false, true, true, false)
			setTimer(saveBedRespawnPosition, 1500, 1, player)
		end
	end
	if isElement(player_in_bed[player]) then
		bed_warming[player_in_bed[player]] = nil
	end
	player_in_bed[player] = nil
	player_timers[player] = nil
	waking_up[player] = nil
	setElementData(player, "sleeping", false)
end

addEventHandler("ClientTriggersWakeUp",root,wakeUp)

waking_up = {}
addEventHandler("onPlayerDamage", root,
	function (attacker, weapon)
		if source and attacker and player_in_bed[source] then
			if not waking_up[source] or tonumber(waking_up[source]) <= getRealTime().timestamp  then
				wakeUp(source, "e", "down", weapon)
				waking_up[source] = getRealTime().timestamp + 5
			end
		end
	end
)

addEventHandler("onResourceStop", resourceRoot,
	function ()
		for player in pairs(player_in_bed) do
			if isElement(player) then
				wakeUp(player)
			end
		end
	end
)

addEventHandler("onResourceStart", root,
	function ()
		if source == getThisResource() then return end
		setTimer(
			function ()
				for _, object in ipairs (getElementsByType("object")) do
					if BED_IDS[getElementModel(object)] then
						createBed(object)
					end
				end
			end, 
		1000, 1)
	end
)

addEventHandler("onResourceStart", resourceRoot,
	function ()
		for _, object in ipairs (getElementsByType("object")) do
			if BED_IDS[getElementModel(object)] then
				createBed(object)
			end
		end
	end
)

addEventHandler("onResourceStop", root,
	function ()
		if source == getThisResource() then return end
		for _, object in ipairs(getElementsByType("object", source)) do
			if BED_IDS[getElementModel(object)] then
				if current_beds[object] then
					current_beds[object] = nil
				end
				if col_to_bed[bed_to_col[object]] then
					col_to_bed[bed_to_col[object]] = nil
				end
				if bed_to_col[object] then
					destroyElement(bed_to_col[object])
					bed_to_col[object] = nil
				end
			end
		end
	end
)

addEvent("sleep:onColShapeHit", true)
addEventHandler("sleep:onColShapeHit", root,
	function (colshape)
	if getElementData(colshape,"bedcol") then
		if not player_in_bed[client] then
			local player = client
			local object = col_to_bed[colshape]
			outputInteractInfo("Sleep\n["..ENTER_TO_BED_KEY:upper().."]", player, 255, 255, 255)
			bindKey(player, ENTER_TO_BED_KEY, "down", getInBed, player, object)
			triggerClientEvent(root, "sleep:collisions", root, player, object, true)
		end
	end
	end
)

addEvent("sleep:onColShapeLeave", true)
addEventHandler("sleep:onColShapeLeave", root,
	function (colshape)
		if not player_in_bed[client] then
			local player = client
			local object = col_to_bed[colshape]
			if isKeyBound(player, ENTER_TO_BED_KEY, "down", getInBed) then
				unbindKey(player, ENTER_TO_BED_KEY, "down", getInBed)
				triggerClientEvent(root, "sleep:collisions", root, player, object, true)
			end
		end
	end
)

function findRotation( x1, y1, x2, y2 ) 
    local t = -math.deg( math.atan2( x2 - x1, y2 - y1 ) )
    return t < 0 and t + 360 or t
end

function getPedMaxHealth(ped)
    return math.max(1, 100 + (getPedStat(ped, 24) - 569) / 4.31)
end

function saveBedRespawnPosition(player)
local x,y,z = getElementPosition(player)
local acc = getPlayerAccount(player)
setAccountData(acc,"bedspawnx",x) 
setAccountData(acc,"bedspawny",y) 
setAccountData(acc,"bedspawnz",z)
outputTopBar( "Respawn location saved!", player, 0, 240, 0 )
end
