if not fileExists("saving/persistent.db") then
	fileCreate("saving/persistent.db")
end

local database = dbConnect("sqlite", "saving/persistent.db")
if not database then
	outputDebugString("[persistent.db] Couldn't connect to database, restarting resource.")
	setTimer(restartResource, 1500, 1, getThisResource())
	return
end

local persistentID = 0

dbExec(database, "CREATE TABLE IF NOT EXISTS 'positions' (id INT, data TEXT, type TEXT)")

addEvent("removeBuildingForClient",true)

local function savePosition(id, data, type) -- -- ... = "building", x, y, z, xr, yr, zr, model
	dbExec(database, "DELETE FROM positions WHERE id=?", tonumber(id))
	dbExec(database, "INSERT INTO positions (id, data, type) VALUES(?,?,?)", tonumber(id), data, type)
end

function removePersistentObjectFromDatabase(id)
	dbExec(database, "DELETE FROM positions WHERE id=?", tonumber(id))
	outputDebugString("removed object from database, id: "..tostring(id))
end


function removePersistentObjectFromDatabaseFromClient(object)
	local pID = getElementData(object, "persistent_id")
	if pID then
		dbExec(database, "DELETE FROM positions WHERE id=?", tonumber(pID))
		outputDebugString(getPlayerName(source)..": removed object, id: "..tostring(pID))
		setPedAnimation( source, "BOMBER", "BOM_Plant",5000,true,false,false,false)
		triggerClientEvent(source, "sleep:drawDXProgress", source, 5000,5000)
		outputStatusInfo("Removing object...",source, 240,240,240 )
		setElementAlpha(object,150)
		setTimer(triggerClientEvent,5000,1,"sleep:stopDXProgress",source)
		setTimer(destroyElement,5000,1,object)
	end
end
addEventHandler("removeBuildingForClient",root,removePersistentObjectFromDatabaseFromClient)

function persistent_loadObjects()
	dbQuery(
		function (qh)
			local result = dbPoll(qh, 0)
			for i,v in pairs(result) do
				if v then
					local _type = v['type']
					local obj
					--outputChatBox(v['id']..":".._type)
					if (_type == "bed") then
						local data = v['data']
						local vx, vy, vz, xr, yr, vrot = unpack(split(v['data'], ","))
						--outputChatBox(v['data'])
						obj = buildABed(vx, vy, vz, xr, yr, vrot)
					elseif (_type == "shelter") then
						local data = v['data']
						local vx, vy, vz, xr, yr, vrot = unpack(split(v['data'], ","))
						obj = buildASShelter(vx, vy, vz, xr, yr, vrot)
					elseif (_type == "barricade") then
						local data = v['data']
						local vx, vy, vz, xr, yr, vrot = unpack(split(v['data'], ","))
						obj = buildABarricade(vx, vy, vz, xr, yr, vrot)
					elseif (_type == "wirefence") then
						local data = v['data']
						local vx, vy, vz, xr, yr, vrot = unpack(split(v['data'], ","))
						obj = buildAWireFence(vx, vy, vz, xr, yr, vrot)
					elseif (_type == "building") then
						local data = v['data']
						local vx, vy, vz, xr, yr, vrot, model = unpack(split(v['data'], ","))
						obj = createObject(model,vx, vy, vz)
					
						setTimer(function(obj,xr, yr, vrot)
									setElementDoubleSided(obj,true)
									setElementRotation(obj,xr, yr, vrot)
								 end,2000,1,obj,xr, yr, vrot)
						
						if model == 1492 or model == 1499 then -- don't freeze doors
							--setElementFrozen(obj,false)
							setElementVelocity(obj,0,0,0)
						else
							setElementFrozen(obj,true) --freeze buildable
						end						
					else
						outputDebugString("Unknown object type, no callback function available for: ".._type)
					end

					setElementData(obj, "persistent_id", tonumber(v['id']))
					setElementData(obj, "persistent_type", _type)

					if tonumber(v['id']) > persistentID then
						persistentID = tonumber(v['id'])
					end
				end
			end
		end, database, "SELECT * FROM 'positions'"
	)
end
addEventHandler("onResourceStart", resourceRoot, function () setTimer(persistent_loadObjects, 5000, 1) end)

function persistent_savePositions()
	for _, object in ipairs(getElementsByType("object")) do
		local pID = getElementData(object, "persistent_id")
		if tonumber(pID) then
			persistent_updatePosition(object)
		end
	end
end
addCommandHandler("savebuildpos", persistent_savePositions)

function setPersistent(object, type, ...) -- ... = obj,"building", x, y, z, xr, yr, zr
	local id = getPersistentID()
	local thetable = {...}
	local model = getElementModel(object)
	table.insert(thetable,model)
	local args = table.concat(thetable, ",") -- -- ... = "building", x, y, z, xr, yr, zr, model

	savePosition(id, args, type)

	setElementData(object, "persistent_id", id)
	setElementData(object, "persistent_type", type)
end

function persistent_updatePosition(object)
	local id = getElementData(object, "persistent_id")
	if tonumber(id) then
		local _type = getElementData(object, "persistent_type")
		if _type == "bed" then
			local x, y, z = getElementPosition(object)
			local rx, ry, rz = getElementRotation(object)
			args = table.concat({x, y, z, rx, ry, rz}, ",")
			--outputChatBox(args)
			savePosition(tonumber(id), args, _type)
		elseif (_type == "shelter") then
			local x, y, z = getElementPosition(object)
			local rx, ry, rz = getElementRotation(object)
			args = table.concat({x, y, z, rx, ry, rz}, ",")
			savePosition(tonumber(id), args, _type)
		elseif (_type == "barricade") then
			local x, y, z = getElementPosition(object)
			local rx, ry, rz = getElementRotation(object)
			args = table.concat({x, y, z, rx, ry, rz}, ",")
			savePosition(tonumber(id), args, _type)
		elseif (_type == "wirefence") then
			local x, y, z = getElementPosition(object)
			local rx, ry, rz = getElementRotation(object)
			args = table.concat({x, y, z, rx, ry, rz}, ",")
			savePosition(tonumber(id), args, _type)
		elseif (_type == "building") then
			local data = v['data']
			local x, y, z = getElementPosition(object)
			local rx, ry, rz = getElementRotation(object)
			local model = getElementModel(object)
			args = table.concat({x, y, z, rx, ry, rz, model}, ",")
			savePosition(tonumber(id), args, _type)
		else
			outputDebugString("Unknown object type, not updating position for: ".._type)
		end
	end
end

function getPersistentID()
	persistentID = persistentID+1
	return (persistentID)
end