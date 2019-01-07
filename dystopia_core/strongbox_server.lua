if not fileExists("saving/storage.db") then
	fileCreate("saving/storage.db")
end

local STRONGBOX_MODEL = 964
local STRONGBOX_COLSHAPE_OFFSETS = {0, 0, 0, 2}
local STRONGBOX_SLOTS = 100

local strongbox = {}
local isWithinStrongbox = {}

function onStrongboxHit(player, dim)
	if getElementType(player) == "player" and dim then
		isWithinStrongbox[player] = true
		setElementData(player,"strongboxobje",source)
		outputInteractInfo("Open storage\n[Q]", player, 240,240,240)
		--outputInteractInfo(text, player, 240,240,240)
							triggerClientEvent(player,"showHelpMessageEvent",player,strongbox_help_messsage)
	end
end

function onStrongboxLeave(player, dim)
	if getElementType(player) == "player" and dim then
		isWithinStrongbox[player] = nil
		setElementData(player,"strongboxobje",nil)
		triggerClientEvent(player, "strongbox.window", player)
	end
end

addCommandHandler("Inventory",
	function (player)
	
		if isWithinStrongbox[player] then
			local account = getPlayerAccount(player)
			local inventory = getAccountData(account, "strongbox.inventory") or toJSON({})
			triggerClientEvent(player, "strongbox.window", player, inventory, STRONGBOX_SLOTS)
		
		local strongbox = getElementData(player,"strongboxobje")
		if strongbox then
			local x,y,z = getElementPosition( strongbox )
			local px, py, pz = getElementPosition( player )
			local distance = getDistanceBetweenPoints3D(px, py, pz, x, y, z)
			local pedangle = ( 360 - math.deg ( math.atan2 ( ( x - px ), ( y - py ) ) ) ) % 360 --MAGIC SPELL TO MAKE PEDS LOOK AT STUFF
			setPedRotation( player, pedangle ) --turn player facing the col center
			--if distance > 1.3 then
			--outputDebugString("check")
			setPedAnimation ( player, "PED", "WALK_player", 400, false, true, true, false) --make him walk towards it for half second to make sure it is right next to the object
			--end
			setTimer( function() setPedAnimation ( player, "INT_HOUSE", "wash_up", 2000, true, false, false, false) end, 400, 1) 
		end
			
		end
	
	end
)

function setupStrongbox(element, colsize)
	local x, y, z = getElementPosition(element)
	local int, dim = getElementInterior(element), getElementDimension(element)

	local ox, oy, oz, rz = unpack(STRONGBOX_COLSHAPE_OFFSETS)

	if colsize then rz = colsize end

	local col = createColSphere(x+ox, y+oy, z+oz, rz)
	strongbox[element] = col
	addEventHandler("onColShapeHit", col, onStrongboxHit)
	addEventHandler("onColShapeLeave", col, onStrongboxLeave)
end

function clearStrongbox(element)
	if strongbox[element] then
		destroyElement(strongbox[element])
	end
end

addEvent("inventory.moveToContainer", true)
addEventHandler("inventory.moveToContainer", root,
	function (item, index, containerType)
		if containerType == "strongbox" then
			local account = getPlayerAccount(client)
			local inventory = getAccountData(account, "strongbox.inventory") or toJSON({})
			local inventory = fromJSON(inventory)

			if #inventory < STRONGBOX_SLOTS then
				table.insert(inventory, item)

				setAccountData(account, "strongbox.inventory", toJSON(inventory))
				PlayersItens[client][index] = "Empty"

				triggerClientEvent(client,"RefreshDraw", client, containerType, inventory, STRONGBOX_SLOTS)
				triggerClientEvent(client, "SynchronizeAll", client)
				triggerClientEvent(client, "synchronizeTables", client, PlayersItens)
			else
				--outputChatBox("ERROR: Your strongbox is full", client, 255, 0, 0)
				outputTopBar("Strongbox is full",client, 255,50,0)
			end
		elseif containerType == "stockpile" then
			addToStockpile(client, index, item)
		end
	end
)

addEvent("inventory.addItem", true)
addEventHandler("inventory.addItem", root,
	function (item, cType)
		if not item then return end
		if cType == "strongbox" then
			local account = getPlayerAccount(client)
			local inventory = getAccountData(account, "strongbox.inventory") or toJSON({})
			local inventory = fromJSON(inventory)

			for i, items in ipairs(inventory) do
				if item == items then
					table.remove(inventory, i)
					break
				end
			end

			setAccountData(account, "strongbox.inventory", toJSON(inventory))

			createwateritsamiracle(item, client)

			triggerClientEvent(client,"RefreshDraw", client, cType, inventory, STRONGBOX_SLOTS)
			triggerClientEvent(client, "SynchronizeAll", client)
			triggerClientEvent(client, "synchronizeTables", client, PlayersItens)
		elseif cType == "stockpile" then
			removeFromStockpile(client, item)
		end
	end
)

addEventHandler("onResourceStart", root,
	function ()
		if source == resourceRoot then
			source = root
		end

		for _, element in ipairs(getElementsByType("object", source)) do
			if getElementModel(element) == STRONGBOX_MODEL and not strongbox[element] then
				setupStrongbox(element)
			end
		end
	end
)

addEventHandler("onResourceStop", root,
	function ()
		for _, element in ipairs(getElementsByType("object", source)) do
			if strongbox[element] then
				clearStrongbox(element)
			end
		end
	end
)

function setElementAsContainer(element, containerType, interactColSize, id)
	assert(isElement(element), "Expected element got "..type(element))
	assert(type(containerType) == "string", "Expected string got "..type(containerType))
	
	if containerType == "strongbox" then
		setupStrongbox(element, interactColSize)
	else
		--outputChatBox("called for id #"..tostring(id))
		setupStockpile(element, interactColSize, id)
	end
end