if not fileExists("saving/storage.db") then
	fileCreate("saving/storage.db")
	restartResource(getThisResource())
end

CAN_BE_A_CONTAINER = {"object", "vehicle"}
BAG_ID = 1264

local CONTAINER_KEY = "id"
local UPDATE_POSITION = {"vehicles", 1264}
local DEFAULT_RADIUS = 1.5
local CUSTOM_RADIUS = {
	[482] = 3, --Burrito
	[440] = 3, --reinforced burrito
	[558] = 3, --Uranus
	[541] = 3, --uranus ram
	[426] = 3, --Premier
	[602] = 3, --reinforced premier
	[600] = 3, --Picador
	[401] = 3, --reinforced picador
	[518] = 3, --Buccaneer
	[496] = 3, --reinforced bucaneer
	[479] = 3, --Regina
	[527] = 3, --reinforced regina
	[580] = 3, --Stafford
	[575] = 3, --reinforced stafford
	[542] = 3, --Clover
	[445] = 3, --reinforced clover
	[489] = 3, --Rancher
	[400] = 3, --reinforced rancher
	[422] = 3, --Bobcat
	[589] = 3, --Reinforced Bobcat
	[466] = 3, --Glendale
	[504] = 3, --Reinforced Glendale
	[478] = 3, --Rusty Walton
	[514] = 3, --Tanker
	[408] = 3, --Trashmaster
	[467] = 3, --Rusty Oceanic 
	[536] = 3, --Rusty Blade
	[500] = 3, --"Mesa Rockcrawler" 
	[475] = 3, --"Sabre Supercharged" 
	[402] = 3, --Buffalo Bonemaster
	[434] = 3, --Interceptor
	[552] = 3, --Flat Van
	[528] = 3, --Rescue01 Van
	[508] = 3, --Journey
	[459] = 3, --Surveillance Van"
	[470] = 3, --Patriot
	[484] = 3, --"Yacht"
	[454] = 3, --"Cruiser" 
	[554] = 3, --"Yosemite" ,
	[523] = 2, --HPV 1000" ,
	[525] = 3, --"Towtruck" ,
	[515] = 3, --"Roadtrain" ,
	[463] = 2, --Freeway" ,
	[468] = 2, --"Sanchez" ,
	[586] = 2, --"Wayfarer" ,
	[581] = 2, --"BF 400" ,
	[471] = 2, --"Quadbike" ,
	[481] = 1, --"Bike" ,
	[510] = 1, --"Mountain Bike" ,
	[413] = 3, --"Pony" ,
	[543] = 3, --"Sadler" ,
	[530] = 2, --"Forklift" ,
	[596] = 3, --"Police Cruiser" ,
	[598] = 3, --"Police Cruiser" ,
	[597] = 3, --"Police Cruiser" ,
	[407] = 3, --"Firetruck" ,
	[599] = 3, --"Police Ranger" ,
	[473] = 3, --"Dinghy" ,
	[453] = 3, --"Fishing Boat" ,
	[472] = 3, --"Coastguard" ,
	[553] = 3, --"Nevada" ,
	[512] = 3, --"Cropduster" ,
	[563] = 3, --"Raindance" ,
	[487] = 3, --"Maverick" ,
	[460] = 3, --"Skimmer" ,
	[548] = 3, --"Cargobob" ,
	[469] = 3, --"Sparrow" ,
	[443] = 3, --"Siege Truck" ,
	[549] = 3, --"Tampa" ,
	[403] = 3, --"Linerunner" ,
	[568] = 3, --"Bandito" ,
	[537] = 3, --"Freight Engine" ,
	[538] = 3, --"Brown Streak",
	[521] = 2,	--"FCR-900",
	[447] = 3,	--"Gunship",
	[442] = 3, -- Romero
	[474] = 3, -- Hermes
	[455] = 3, -- Flatbed
	[490] = 3, -- Rancher FBI
	[416] = 3, -- Ambulance
	[534] = 3, -- Remington
	[576] = 3, -- Tornado
	[412] = 3, -- Voodoo
	[539] = 3, -- Vortex
	[476] = 3, -- Rustler
	[520] = 3, -- Hydra
	[417] = 3, -- Leviathan
	[498] = 3, -- Boxville
	[609] = 3, -- B. Boxville
	[593] = 3, -- Dodo
	[583] = 2, -- Tug
	[404] = 3, -- Perennial
	[458] = 3, -- Solair
	[410] = 3, -- Manana
	[421] = 3, -- Washington
	[573] = 3, -- Dune
	[545] = 3, -- Hustler
	[464] = 1.5, -- MINIGUN
	[592] = 10, -- Andromada
	[539] = 2, -- Vortex
	[433] = 3, -- Barracks	
	[414] = 3, -- Mule	
	[456] = 3 -- Yankee	
}

local BAG_SLOTS = 15
local VEHICLE_SLOTS = {
	[482] = 20, --Burrito
	[440] = 20, 
	[558] = 8, --Uranus
	[541] = 8, 
	[426] = 10, --Premier
	[602] = 10, 
	[600] = 16, --Picador
	[401] = 16, 
	[518] = 10, --Buccaneer
	[496] = 10, 
	[479] = 14, --Regina
	[527] = 14,
	[580] = 12, --Stafford
	[575] = 12,
	[542] = 10, --Clover
	[445] = 10,
	[489] = 12, --Rancher
	[400] = 12,
	[422] = 16, --Bobcat
	[589] = 16,
	[466] = 10, --Glendale
	[504] = 10, --Reinforced Glendale
	[478] = 16, --Rusty Walton
	[514] = 20, --Tanker
	[408] = 30, --Trashmaster
	[467] = 10, --Rusty Oceanic
	[536] = 8, --Rusty Blade
	[500] = 20, --"Mesa Rockcrawler" 
	[475] = 8, --"Sabre Supercharged" 
	[402] = 8, --Buffalo Bonemaster
	[434] = 8, --Interceptor
	[552] = 16, --Flat Van
	[528] = 8, --Rescue01 Van
	[508] = 20, --Journey
	[459] = 10, --Surveillance Van"
	[470] = 16, --Patriot
	[484] = 30, --"Yacht"
	[454] = 30, --"Cruiser" 
	[554] = 16, --"Yosemite" ,
	[523] = 2, --HPV 1000" ,
	[525] = 8, --"Towtruck" ,
	[515] = 20, --"Roadtrain" ,
	[463] = 2, --Freeway" ,
	[468] = 2, --"Sanchez" ,
	[586] = 10, --"Wayfarer" ,
	[581] = 2, --"BF 400" ,
	[471] = 4, --"Quadbike" ,
	[481] = 0, --"Bike" ,
	[510] = 0, --"Mountain Bike" ,
	[413] = 20, --"Pony" ,
	[543] = 16, --"Sadler" ,
	[530] = 0, --"Forklift" ,
	[596] = 10, --"Police Cruiser" ,
	[598] = 10, --"Police Cruiser" ,
	[597] = 10, --"Police Cruiser" ,
	[407] = 10, --"Firetruck" ,
	[599] = 12, --"Police Ranger" ,
	[473] = 10, --"Dinghy" ,
	[453] = 20, --"Fishing Boat" ,
	[472] = 16, --"Coastguard" ,
	[553] = 30, --"Nevada" ,
	[512] = 4, --"Cropduster" ,
	[563] = 16, --"Raindance" ,
	[487] = 8, --"Maverick" ,
	[460] = 8, --"Skimmer" ,
	[548] = 30, --"Cargobob" ,
	[469] = 4, --"Sparrow" ,
	[443] = 10, --"Siege Truck" ,
	[549] = 10, --"Tampa" ,
	[403] = 20, --"Linerunner" ,
	[568] = 4, --"Bandito" ,
	[537] = 20, --"Freight Engine" ,
	[538] = 20, --"Brown Streak",
	[521] = 2,	--"FCR-900",
	[447] = 8,	--"Gunship",	
	[442] = 14,	--"Romero",	
	[474] = 10, -- Hermes
	[455] = 30, -- Flatbed
	[490] = 20, -- Rancher FBI
	[416] = 20, -- Ambulance
	[534] = 10, -- Remington
	[576] = 10, -- Tornado
	[412] = 10, -- Voodoo
	[539] = 4, -- Vortex
	[476] = 4, -- Rustler
	[520] = 2, -- Hydra
	[417] = 24, -- Leviathan
	[498] = 24, -- Boxville
	[609] = 24, -- B. Boxville
	[593] = 8, -- Dodo
	[583] = 4, -- Tug
	[404] = 12, -- Perennial
	[458] = 12, -- Solair
	[410] = 10, -- Manana
	[421] = 10, -- Washington
	[573] = 24, -- Dune
	[545] = 6, -- Hustler
	[464] = 2, -- MINIGUN
	[592] = 100, -- Andromada
	[539] = 2, -- Vortex
	[433] = 30, -- Barracks	
	[414] = 24, -- Mule
	[456] = 26 -- Yankee	
}

local BAG_ID_START_FROM = 1000
local storage = {}
storage.database = dbConnect("sqlite", "saving/storage.db")
storage.containers = {}
storage.position = {}
storage.colshapes = {}
storage.inventory = {}
storage.id = {}
storage.slots = {}
storage.maxid = BAG_ID_START_FROM

local isWithinStockpile = {}

if not storage.database then
	outputDebugString("STORAGE: An error occured when trying to connect to the database.", 1)
	return
end

dbExec(storage.database, "CREATE TABLE IF NOT EXISTS 'stockpile' (id TEXT PRIMARY KEY, inventory TEXT)")

local masterquery = dbQuery(
	function (qh)
		local result = dbPoll(qh, 0)
		if result then
			for _, data in pairs(result) do
				if data and data['id'] then
					storage.inventory[tonumber(data['id'])] = fromJSON(data['inventory']) or {}
				end
				
				if storage.maxid < tonumber(data['id']) then
					storage.maxid = tonumber(data['id'])
				end
				--local stockpile = createObject(146)
			end
		end
	end,
storage.database, "SELECT * FROM 'stockpile'")

function setupStockpile(element, interactColSize, id)
	if storage.colshapes[element] then
		outputDebugString("Already exists, skipping.")
		return
	end
	local container_id = getElementData(element, CONTAINER_KEY) or id
	local container_id = container_id and tonumber(container_id)

	local elementType = getElementType(element)

	if not container_id then -- new crafted bag
		storage.maxid = storage.maxid+1
		for _,elementType in ipairs(CAN_BE_A_CONTAINER) do
			for _, element in ipairs(getElementsByType(elementType)) do
				local id = getElementData(element, "id")
				if id == storage.maxid then
					storage.maxid = storage.maxid + 1
				end
			end
		end
		dbExec(storage.database, "INSERT INTO 'stockpile' VALUES(?, ?)", storage.maxid, toJSON({}))
		container_id = storage.maxid
	end

	if UPDATE_POSITION[elementType] or UPDATE_POSITION[getElementModel(element)] then
		storage.position[container_id] = element
	end
	storage.containers[container_id] = element
	local x, y, z = getElementPosition(element)
	local radius = interactColSize or DEFAULT_RADIUS
	local colshape = createColSphere(x, y, z, radius)
	attachElements(colshape, element)
	storage.colshapes[element] = colshape

	storage.id[colshape] = container_id
	if not storage.inventory[container_id] then
		storage.inventory[container_id] = {}
	end

	setElementData(element, "id", container_id)
	storage.slots[container_id] = (getElementType(element) == "vehicle" and VEHICLE_SLOTS[getElementModel(element)] or BAG_SLOTS)
	
	addEventHandler("onColShapeHit", colshape,
		function (player, dim)
			if getElementType(player) == "player" and dim and not getPedOccupiedVehicle(player) then
				isWithinStockpile[player] = source
				local text
				local help_text
				if getElementType(element) == "vehicle" then 
					text =  "Open storage\n[Q]"
					help_text = vehicle_help_messsage
				else 
					text = "Open stockpile\n[Q]" 
					help_text = stockpile_help_messsage
				end
				outputInteractInfo(text, player, 240,240,240)
							triggerClientEvent(player,"showHelpMessageEvent",player,help_text)
			end
		end
	)

	addEventHandler("onColShapeLeave", colshape,
		function (player, dim)
			if getElementType(player) == "player" and dim then
				local stockpile = isWithinStockpile[player]
				if stockpile then
					local id = storage.id[stockpile]
					local container = storage.containers[id]
					triggerClientEvent(player, "storage:stockpile", player, false, false, false, container)
					isWithinStockpile[player] = nil
				end
			end
		end
	)
end

addCommandHandler("Inventory",
	function (player)
		local stockpile = isWithinStockpile[player]
		if stockpile then
			local id = storage.id[stockpile]
			local container = storage.containers[id]
			if getElementData(container, "isContainerBeingUsed") and getElementData(container, "isContainerBeingUsed") ~= player then
				--outputChatBox("The container is already in use.", player, 255, 0, 0)
				--outputInteractInfo("Already in use", player, 240,200,0)
				outputTopBar("Already in use!",player, 255,100,0)
				return
			end
			local name = getElementType(container) and retrieveCustomCarName(container) or "Stockpile"
			triggerClientEvent(player, "storage:stockpile", player, storage.inventory[id], storage.slots[id], name, container)
			
			if getElementData(container, "isContainerBeingUsed") ~= nil then return end
	
		if not getPedOccupiedVehicle(player) then
			local x,y,z = getElementPosition( container )
			local px, py, pz = getElementPosition( player )
			local pedangle = ( 360 - math.deg ( math.atan2 ( ( x - px ), ( y - py ) ) ) ) % 360 --MAGIC SPELL TO MAKE PEDS LOOK AT STUFF
			setPedRotation( player, pedangle ) --turn player facing the col center
			setPedAnimation ( player, "PED", "WALK_player", 900, false, true, true, false) --make him walk towards it for a second to make sure it is right next to the vehicle
			setTimer( function() setPedAnimation ( player, "INT_HOUSE", "wash_up", 3500, true, false, false, false) end, 900, 1) --play repair animation for a duration connected with the health that needs restoring
		end
			
		end
	end
)

addEventHandler("onResourceStop", getResourceRootElement(getResourceFromName("dystopia_core")),
	function ()
		for _, elementType in ipairs(CAN_BE_A_CONTAINER) do
			for _, element in ipairs(getElementsByType(elementType, source)) do
				if storage.colshapes[element] then
					destroyElement(storage.colshapes[element])
				end
			end
		end
	end
)

addEventHandler("onResourceStart", getResourceRootElement(getResourceFromName("dystopia_core")),
	function ()
		setTimer(lookup, 1500, 1)
	end
)

function addToStockpile(player, index, item)
	local current = isWithinStockpile[player]
	local id = storage.id[current]
	local inv = storage.inventory[id]
	if inv then
		if #inv < storage.slots[id] then
			table.insert(inv, item)
			PlayersItens[player][index] = "Empty"
			triggerClientEvent(player, "RefreshDraw", player, "stockpile", inv, storage.slots[id])
			triggerClientEvent(player, "SynchronizeAll", player)
			triggerClientEvent(player, "synchronizeTables", player, PlayersItens)
			dbExec(storage.database, "DELETE FROM stockpile WHERE id=?", tostring(id))
			dbExec(storage.database, "INSERT INTO stockpile (id, inventory) VALUES(?,?)", tostring(id), toJSON(inv))
		else
			outputTopBar("Container is full", player, 255, 50, 0)
		end
	end
end

function removeFromStockpile(player, item)
	local current = isWithinStockpile[player]
	local id = storage.id[current]
	local inv = storage.inventory[id]

	if inv then
		for i, items in ipairs(inv) do
			if item == items then
				table.remove(inv, i)
				break
			end
		end

		createwateritsamiracle(item, player)
		storage.inventory[id] = inv

		triggerClientEvent(player,"RefreshDraw", player, "stockpile", inv, storage.slots[id])
		triggerClientEvent(player, "SynchronizeAll", player)
		triggerClientEvent(player, "synchronizeTables", player, PlayersItens)

		dbExec(storage.database, "UPDATE stockpile SET inventory=? WHERE id=?", toJSON(inv), tostring(id))
	end
end

function getStockpileItems(player)
	local current = isWithinStockpile[player]
	local id = storage.id[current]
	local inv = storage.inventory[id]

	return inv
end

function lookup()
	for _, elementType in ipairs(CAN_BE_A_CONTAINER) do
 		for _, element in ipairs(getElementsByType(elementType)) do
 			local id = getElementData(element, "id")
 			if tonumber(id) then
 				setupStockpile(element, CUSTOM_RADIUS[getElementModel(element)] or nil, tonumber(id))
 			end
 		end
 	end
end

addEventHandler("onVehicleEnter",root, function(pl) 

triggerClientEvent(pl,"onCloseStorageWindow",pl)
triggerClientEvent(pl,"onCloseInventory",pl)

 end)

-- >=1<=1000: vehicles, >=1001: objects, peds
-- Strongbox: player's inventory
-- Stockpile: dynamic world inventory Model: 1264