if not fileExists("saving/loot.db") then
	fileCreate("saving/loot.db")
end

local database = dbConnect("sqlite", "saving/loot.db")

if not database then
	outputDebugString("Couldn't connect to database, restarting resource.")
	setTimer(restartResource, 1500, 1, getThisResource())
	return
end

local positions = {}

dbExec(database, "CREATE TABLE IF NOT EXISTS 'positions' (id TEXT, position TEXT)")

local function savePosition(element, id)
	--outputDebugString(getElementType(element))
	assert(type(element) == "userdata", "Not an element, my friend.")
	assert(id, "Object doesn't have an ID")

	local x, y, z = getElementPosition(element)
	local int, dim = getElementInterior(element), getElementDimension(element)
	local rx, ry, rz = getElementRotation(element)

	local position = table.concat({x, y, z, int, dim, rx, ry, rz}, ",")

	dbExec(database, "DELETE FROM positions WHERE id=?", id)
	dbExec(database, "INSERT INTO positions (id, position) VALUES(?,?)", id, position)
end

function loot_loadPositions()
	outputDebugString("Loading loot obj position...")

	dbQuery(
		function (qh)
			local result = dbPoll(qh, 0)
			for i,v in pairs(result) do
				if v then
					if tonumber(v['id']) then
						positions[v['id']] = v['position']
						--outputChatBox(tostring(v['id'])..";"..v['position'])
						--outputDebugString(v['id'] .. ":".. v['position'])
					end
				end
			end
			setTimer(dynamic_recoverPositions, 2000, 1)
		end, database, "SELECT * FROM 'positions'"
	)
end

function dynamic_recoverPositions()
	for _, element in ipairs(getElementsByType("object")) do
		local id = getElementData(element, "lootbox_id")
		if positions[id] then
			local location = split(positions[id], ",")
			if location then
				local x, y, z, int, dim, rx, ry, rz = unpack(location)
				setElementPosition(element, x, y, z)
				setElementInterior(element, int)
				setElementDimension(element, dim)
				setElementRotation(element, rx, ry, rz)
				--outputChatBox(id..":"..positions[id])
			end
		end
	end
end

function loot_savePositions(object)
	if isElement(object) then
		local id = getElementData(object, "lootbox_id")
		if id and tonumber(id) then
			savePosition(object, id)
		end
	else
		for _, element in ipairs(getElementsByType("object")) do
			local id = getElementData(element, "lootbox_id")
			if id and tonumber(id) then
				savePosition(element, id)
			end
		end
	end
end

addEventHandler("onResourceStart", resourceRoot,
	function ()
		outputDebugString("loading loot pos")
		setTimer(loot_loadPositions, 5000, 1)
	end
)

addCommandHandler("savepos", 
	function ()
		outputDebugString("yas")
		loot_savePositions()
	end
)

-- addCommandHandler("loadpos",
-- 	function ()
-- 		loot_loadPositions()
-- 	end
-- )