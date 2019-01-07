if not fileExists("saving/dynamic.db") then
	fileCreate("saving/dynamic.db")
end

local database = dbConnect("sqlite", "saving/dynamic.db")

if not database then
	outputDebugString("Couldn't connect to database, restarting resource.")
	setTimer(restartResource, 1500, 1, getThisResource())
	return
end

local positions = {}

local dynamic_object_ids = {
	[1217] = true, -- barrel
	[1225] = true, -- barrel
	[1370] = true, -- barrel
	[1220] = true, -- boxes
	[1221] = true, -- boxes
	[1230] = true, -- boxes
	[2900] = true, -- boxes
	[2968] = true -- boxes
}

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

function dynamic_loadPositions()
	outputDebugString("Loading dynamic obj position...")

	dbQuery(
		function (qh)
			local result = dbPoll(qh, 0)
			for i,v in pairs(result) do
				if v then
					positions[v['id']] = v['position']
					--outputDebugString(v['id'] .. ":".. v['position'])
				end
			end
			setTimer(dynamic_recoverPositions, 2000, 1)
		end, database, "SELECT * FROM 'positions'"
	)
end

function dynamic_recoverPositions()
	for _, element in ipairs(getElementsByType("object")) do
		if dynamic_object_ids[getElementModel(element)] then
			local id = getElementData(element, "id")
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
end

function dynamic_savePositions(object)
	--outputDebugString("Dynamic: saving...")
	if isElement(object) then
		local id = getElementData(object, "id")
		if id then
			savePosition(object, id)
		end
	else
		for _, element in ipairs(getElementsByType("object")) do
			if dynamic_object_ids[getElementModel(element)] then
				local id = getElementData(element, "id")
				if id then
					savePosition(element, id)
					--outputDebugString("Saving "..id.."...")
				end
			end
		end
	end
end

-- addEventHandler("onResourceStart", root,
-- 	function ()
-- 		outputDebugString("asdasdasd")
-- 		setTimer(dynamic_loadPositions, 5000, 1)
-- 	end
-- )

addCommandHandler("savepos", 
	function ()
		dynamic_savePositions()
	end
)

addCommandHandler("loadpos",
	function ()
		dynamic_loadPositions()
	end
)

--[[addEventHandler("onResourceStart", getResourceRootElement(getResourceFromName("dystopia_core")),
	function ()
		dynamic_loadPositions()
	end
)

addEventHandler("onResourceStop", getResourceRootElement(getResourceFromName("dystopia_core")),
	function ()
		dynamic_savePositions()
	end
)

addEventHandler("onResourceStart", getResourceRootElement(getResourceFromName("dystopia_vehicles")),
	function ()
		dynamic_loadPositions()
	end
)

addEventHandler("onResourceStop", getResourceRootElement(getResourceFromName("dystopia_vehicles")),
	function ()
		dynamic_savePositions()
	end
)

addEventHandler("onResourceStart", getResourceRootElement(getResourceFromName("dystopia_map")),
	function ()
		dynamic_loadPositions()
	end
)

addEventHandler("onResourceStop", getResourceRootElement(getResourceFromName("dystopia_map")),
	function ()
		dynamic_savePositions()
	end
)--]]