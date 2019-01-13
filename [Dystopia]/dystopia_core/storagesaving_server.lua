if not fileExists("saving/storage.db") then
	fileCreate("saving/storage.db")
end

local database = dbConnect("sqlite", "saving/storage.db")
if not database then
	outputDebugString("Couldn't connect to database, restarting resource.")
	setTimer(restartResource, 1500, 1, getThisResource())
	return
end
local positions = {}

dbExec(database, "CREATE TABLE IF NOT EXISTS 'positions' (id INT, position TEXT)")

function savePosition(element, id)
	assert(type(element) == "userdata", "Not an element, my friend.")
	assert(type(id) == "number", "Not a number, my friend.")

	local x, y, z = getElementPosition(element)
	local int, dim = getElementInterior(element), getElementDimension(element)
	local rx, ry, rz = getElementRotation(element)
	local model = getElementModel(element)

	local position = table.concat({x, y, z, int, dim, rx, ry, rz, model}, ",")

	dbExec(database, "DELETE FROM positions WHERE id=?", tonumber(id))
	dbExec(database, "INSERT INTO positions (id, position) VALUES(?,?)", tonumber(id), position)
end

function loadPositions()
	dbQuery(
		function (qh)
			local result = dbPoll(qh, 0)
			for i,v in pairs(result) do
				if v then
					positions[tonumber(v['id'])] = v['position']
				end
			end
			setTimer(recoverPositions, 2000, 1)
		end, database, "SELECT * FROM 'positions'"
	)
end

function recoverPositions()
	local filled = {}
	for _,elementType in ipairs(CAN_BE_A_CONTAINER) do
		for _, element in ipairs(getElementsByType(elementType)) do
			local id = getElementData(element, "id")
			if tonumber(id) then
				if positions[tonumber(id)] then
					local location = split(positions[tonumber(id)], ",")
					if location then
						local x, y, z, int, dim, rx, ry, rz = unpack(location)
						setElementPosition(element, x, y, z)
						setElementInterior(element, int)
						setElementDimension(element, dim)
						setElementRotation(element, rx, ry, rz)
						filled[tonumber(id)] = true
					end
				else
					filled[tonumber(id)] = true
				end
			end
		end
	end

	for id, position in pairs(positions) do
		if not filled[id] then
			local x, y, z, int, dim, rx, ry, rz = unpack(split(positions[tonumber(id)], ","))
			local bag = createObject(BAG_ID, x, y, z)
			setElementInterior(bag, int)
			setElementDimension(bag, dim)
			setElementRotation(bag, rx, ry, rz)
			setElementFrozen(bag, true)
			filled[id] = true
			setElementAsContainer(bag, "stockpile", nil, id)
		end
	end
end

function savePositions()
	for _,elementType in ipairs(CAN_BE_A_CONTAINER) do
		for _, element in ipairs(getElementsByType(elementType)) do
			local id = getElementData(element, "id")
			if tonumber(id) then
				savePosition(element, tonumber(id))
			end
		end
	end
end

addEventHandler("onResourceStart", getResourceRootElement(getResourceFromName("dystopia_core")),
	function ()
		loadPositions()
	end
)

addEventHandler("onResourceStop", getResourceRootElement(getResourceFromName("dystopia_core")),
	function ()
		savePositions()
	end
)

addEventHandler("onResourceStart", getResourceRootElement(getResourceFromName("dystopia_vehicles")),
	function ()
		loadPositions()
	end
)

addEventHandler("onResourceStop", getResourceRootElement(getResourceFromName("dystopia_vehicles")),
	function ()
		savePositions()
	end
)

addEventHandler("onResourceStart", getResourceRootElement(getResourceFromName("dystopia_map")),
	function ()
		loadPositions()
	end
)

addEventHandler("onResourceStop", getResourceRootElement(getResourceFromName("dystopia_map")),
	function ()
		savePositions()
	end
)