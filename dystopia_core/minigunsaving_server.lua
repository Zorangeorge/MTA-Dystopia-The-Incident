local database = dbConnect("sqlite", "saving/storage.db")
STAND_MINIGUN_MAXID = 0

dbExec(database, "CREATE TABLE IF NOT EXISTS 'vehicleminigun' (vehicle_id INT)")
dbExec(database, "CREATE TABLE IF NOT EXISTS 'standminigun' (id INTEGER PRIMARY KEY, position TEXT)")

function addVehicleMinigunToDatabase(vehicle)
	local id = getElementData(vehicle, "id")
	if not tonumber(id) then
		outputDebugString("no id")
		return
	end

	dbExec(database, "DELETE FROM vehicleminigun WHERE vehicle_id=?", tonumber(id))
	dbExec(database, "INSERT INTO vehicleminigun (vehicle_id) VALUES(?)", tonumber(id))

	outputDebugString("Succesfully added vehicle minigun to database, vehicle id: "..tostring(id))
end

function removeVehicleMinigunFromDatabase(id)
	dbExec(database, "DELETE FROM vehicleminigun WHERE vehicle_id=?", tonumber(id))
	outputDebugString("Succesfully removed vehicle minigun from database, vehicle id: "..tostring(id))
end

function addStandMinigunToDatabase(...)
	local position = table.concat({...}, ",")
	dbExec(database, "INSERT INTO standminigun (id, position) VALUES(null, ?)", position)
	outputDebugString("Succesfully added stand minigun to database, position: "..position)
	
	STAND_MINIGUN_MAXID = STAND_MINIGUN_MAXID+1
	return STAND_MINIGUN_MAXID
end

function removeStandMinigunFromDatabase(id)
	dbExec(database, "DELETE FROM standminigun WHERE id=?", tonumber(id))
	outputDebugString("Succesfully removed stand minigun from database, vehicle id: "..tostring(id))
end


function loadMinigunsFromDatabase()
	dbQuery(
		function (qh)
			local result = dbPoll(qh, 0)
			for i,v in pairs(result) do
				if v then
					local vehicle_id = tonumber(v['vehicle_id'])
					for i,vehicle in ipairs(getElementsByType("vehicle")) do
						if getElementData(vehicle, "id") and tonumber(getElementData(vehicle, "id")) == vehicle_id then
							createVehicleMinigun(vehicle)
							outputDebugString("attached vehicle minigun from database")
						end
					end
				end
			end
			setTimer(recoverPositions, 2000, 1)
		end, database, "SELECT * FROM 'vehicleminigun'"
	)

	dbQuery(
		function (qh)
			local result = dbPoll(qh, 0)
			for i,v in pairs(result) do
				if v then
					STAND_MINIGUN_MAXID = STAND_MINIGUN_MAXID + 1
					local x, y, z, xx, yy, zz = unpack(split(v['position'], ","))
					local minigun = createStandMinigun(x, y, z, xx, yy, zz)
					setElementData(minigun, "minigun_id", STAND_MINIGUN_MAXID)
				end
			end
			setTimer(recoverPositions, 2000, 1)
		end, database, "SELECT * FROM 'standminigun'"
	)
end

addEventHandler("onResourceStart", resourceRoot,
	function ()
		loadMinigunsFromDatabase()
	end
)