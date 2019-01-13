addEvent("onPlayerActivateCraftItem",true)
addEvent("onPlayerRetrieveCraftItem",true)
addEvent("onPlayerToggleCraftItem",true)
addEvent("synchronizeCraftServer",true)

PlayersCraftItems = {"Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty"}

function crafttablesynchronize_server(table_)
PlayersCraftItems = table_
end
addEventHandler("synchronizeCraftServer",root,crafttablesynchronize_server)

function activateCraftItem(id,index) -- use item function

	local x, y, z = getElementPosition(client)
	local used = false
	local health = getElementHealth(client)
	local xp = getPlayerExp(client)

	if id=="Nail Bat" then  
	local itemcount1, slot1 = hasPlayerItem("Wood", client)
	local itemcount2, slot2 = hasPlayerItem("Scrap Metal", client)
		if itemcount1 and itemcount2 then 
			setPedAnimation ( client, "INT_HOUSE", "wash_up", 3000, true, false, false, false)		
			setTimer(createwateritsamiracle, 3000, 1,"Nail Bat",client) 
			outputStatusInfo("[ crafting "..id.."... ]",client, 240,240,240 )  
			PlayersItens[client][slot1] = "Empty"
			PlayersItens[client][slot2] = "Empty"
			setPlayerExp(client,xp+2)
			setTimer(outputStatusInfo, 3000, 1,"+2 xp",client, 240,240,240 )
			triggerClientEvent(client, "sleep:drawDXProgress", client, 3000,3000)
			setTimer(triggerClientEvent,3000,1,client, "sleep:stopDXProgress", client)

		end
	used=true
	
	elseif id=="Crossbow" then  
	local itemcount1, slot1 = hasPlayerItem("Wood", client)
	local itemcount2, slot2 = hasPlayerItem("Scrap Metal", client)
	local itemcount3, slot3 = hasPlayerItem("Wire", client)
		if itemcount1 and itemcount2 and itemcount3 then 
			setPedAnimation ( client, "INT_HOUSE", "wash_up", 5000, true, false, false, false)		
			setTimer(createwateritsamiracle, 5000, 1,"Crossbow",client) 
			outputStatusInfo("[ crafting "..id.."... ]",client, 240,240,240 ) 
			PlayersItens[client][slot1] = "Empty"
			PlayersItens[client][slot2] = "Empty"
			PlayersItens[client][slot3] = "Empty"
			setPlayerExp(client,xp+3)
			setTimer(outputStatusInfo, 5000, 1,"+3 xp",client, 240,240,240 )
			triggerClientEvent(client, "sleep:drawDXProgress", client, 5000,5000)
			setTimer(triggerClientEvent,5000,1,client, "sleep:stopDXProgress", client)
		end
	used=true
	
	elseif id=="Bolts" then 
		local itemcount1, slot1 = hasPlayerItem("Wood", client)
		local itemcount2, slot2 = hasPlayerItem("Scrap Metal", client)
		if itemcount1 and itemcount2 then 
			setPedAnimation ( client, "INT_HOUSE", "wash_up", 2500, true, false, false, false)		
			setTimer(createwateritsamiracle, 2500, 1,"Bolts",client) 
			outputStatusInfo("[ crafting "..id.."... ]",client, 240,240,240 ) 
			PlayersItens[client][slot1] = "Empty"
			PlayersItens[client][slot2] = "Empty"
			setPlayerExp(client,xp+2)
			setTimer(outputStatusInfo, 2500, 1,"+2 xp",client, 240,240,240 )
			triggerClientEvent(client, "sleep:drawDXProgress", client, 2500,2500)
			setTimer(triggerClientEvent,2500,1,client, "sleep:stopDXProgress", client)
		end
	used=true
	
	elseif id=="Molotov" then 
		local itemcount1, slot1 = hasPlayerItem("Alcohol Bottle", client)
		local itemcount2, slot2 = hasPlayerItem("Rags", client)
		if itemcount1 and itemcount2 then 
			setPedAnimation ( client, "INT_HOUSE", "wash_up", 2500, true, false, false, false)		
			setTimer(createwateritsamiracle, 2500, 1,"Molotov",client) 
			outputStatusInfo("[ crafting "..id.."... ]",client, 240,240,240 )
			local x,y,z = getElementPosition(client)
			setTimer(createObjectItem, 2500, 1,"Empty Bottle", x, y, z-0.95, 97.3,120, math.random(0,359))
			PlayersItens[client][slot1] = "Empty"
			PlayersItens[client][slot2] = "Empty"
			setPlayerExp(client,xp+2)
			setTimer(outputStatusInfo, 2500, 1,"+2 xp",client, 240,240,240 )
			triggerClientEvent(client, "sleep:drawDXProgress", client, 2500,2500)
			setTimer(triggerClientEvent,2500,1,client, "sleep:stopDXProgress", client)
		end
	used=true
	
	elseif id=="Bandage" then 
		local itemcount1, slot1 = hasPlayerItem("Alcohol Bottle", client)
		local itemcount2, slot2 = hasPlayerItem("Rags", client)
		if itemcount1 and itemcount2 then 
			setPedAnimation ( client, "INT_HOUSE", "wash_up", 2500, true, false, false, false)		
			setTimer(createwateritsamiracle, 2500, 1,"Bandage",client) 
			outputStatusInfo("[ crafting "..id.."... ]",client, 240,240,240 ) 
			local x,y,z = getElementPosition(client)
			setTimer(createObjectItem, 2500, 1, "Empty Bottle", x, y, z-0.95, 97.3,120, math.random(0,359))
			PlayersItens[client][slot1] = "Empty"
			PlayersItens[client][slot2] = "Empty"
			setPlayerExp(client,xp+2)
			setTimer(outputStatusInfo, 2500, 1,"+2 xp",client, 240,240,240 )
			triggerClientEvent(client, "sleep:drawDXProgress", client, 2500,2500)
			setTimer(triggerClientEvent,2500,1,client, "sleep:stopDXProgress", client)
		end
	used=true
	
	elseif id=="Splint" then 
		local itemcount1, slot1 = hasPlayerItem("Bandage", client)
		local itemcount2, slot2 = hasPlayerItem("Wood", client)
		if itemcount1 and itemcount2 then 
			setPedAnimation ( client, "INT_HOUSE", "wash_up", 2500, true, false, false, false)		
			setTimer(createwateritsamiracle, 2500, 1,"Splint",client) 
			outputStatusInfo("[ crafting "..id.."... ]",client, 240,240,240 ) 
			local x,y,z = getElementPosition(client)
			--setTimer(createObjectItem, 2500, 1, "Empty Bottle", x, y, z-0.95, 97.3,120, math.random(0,359))
			PlayersItens[client][slot1] = "Empty"
			PlayersItens[client][slot2] = "Empty"
			setPlayerExp(client,xp+2)
			setTimer(outputStatusInfo, 2500, 1,"+2 xp",client, 240,240,240 )
			triggerClientEvent(client, "sleep:drawDXProgress", client, 2500,2500)
			setTimer(triggerClientEvent,2500,1,client, "sleep:stopDXProgress", client)
		end
	used=true
	
	elseif id=="Water Bottle" then 
	local itemcount, slot = hasPlayerItem("Dirty Water", client)
		if itemcount then 
			setPedAnimation ( client, "INT_HOUSE", "wash_up", 2500, true, false, false, false)		
			setTimer(createwateritsamiracle, 2500, 1,"Water Bottle",client) 
			PlayersItens[client][slot] = "Empty"
			outputStatusInfo("[ boiling water... ]",client, 240,240,240 )
			setPlayerExp(client,xp+1)
			setTimer(outputStatusInfo, 2500, 1,"+1 xp",client, 240,240,240 )
			triggerClientEvent(client, "sleep:drawDXProgress", client, 2500,2500)
			setTimer(triggerClientEvent,2500,1,client, "sleep:stopDXProgress", client)
		end
	used=true
	
	elseif id=="Broken Bottle" then 
	local itemcount, slot = hasPlayerItem("Empty Bottle", client)
		if itemcount then 
			setPedAnimation ( client, "INT_HOUSE", "wash_up", 1000, true, false, false, false)
			setTimer(createwateritsamiracle, 1000, 1, "Broken Bottle", client) 
			PlayersItens[client][slot] = "Empty"
			outputStatusInfo("[ breaking bottle... ]",client, 240,240,240 )
			setTimer(playSound3DToElement, 1000, 1, client,client,"sounds/bottlebreak.mp3")
			setPlayerExp(client,xp+1)
			setTimer(outputStatusInfo, 1000, 1,"+1 xp",client, 240,240,240 )
			triggerClientEvent(client, "sleep:drawDXProgress", client, 1000,1000)
			setTimer(triggerClientEvent,1000,1,client, "sleep:stopDXProgress", client)
		end
	used=true
	
	elseif id=="Roasted Meat" then 
	local itemcount, slot = hasPlayerItem("Raw Meat", client)
		if itemcount then
			setPedAnimation ( client, "INT_HOUSE", "wash_up", 2500, true, false, false, false)		
			setTimer(createwateritsamiracle, 2500, 1,"Roasted Meat",client) 
			PlayersItens[client][slot] = "Empty" 
			outputStatusInfo("[ roasting meat... ]",client, 240,240,240 )
			setPlayerExp(client,xp+1)
			setTimer(outputStatusInfo, 2500, 1,"+1 xp",client, 240,240,240 )
			triggerClientEvent(client, "sleep:drawDXProgress", client, 2500,2500)
			setTimer(triggerClientEvent,2500,1,client, "sleep:stopDXProgress", client)

		end
		used=true
	
	elseif id=="Roasted Human Meat" then 
	local itemcount, slot = hasPlayerItem("Raw Human Meat", client)
		if itemcount then 
			setPedAnimation ( client, "INT_HOUSE", "wash_up", 2500, true, false, false, false)		
			setTimer(createwateritsamiracle, 2500, 1,"Roasted Human Meat",client) 
			PlayersItens[client][slot] = "Empty"
			outputStatusInfo("[ roasting meat... ]",client, 240,240,240 )
			setPlayerExp(client,xp+1)
			setTimer(outputStatusInfo, 2500, 1,"+1 xp",client, 240,240,240 )
			triggerClientEvent(client, "sleep:drawDXProgress", client, 2500,2500)
			setTimer(triggerClientEvent,2500,1,client, "sleep:stopDXProgress", client)
		end
	used=true
	
	elseif id=="Stockpile" then 
	local itemcount, slot = hasPlayerItem("Plastic Foil", client)
	local wire, wire_slot = hasPlayerItem("Wire", client)
		if itemcount and wire then 
			setPedWeaponSlot(client,0)
			triggerEvent ("onBuildAStockpile", client)
			PlayersItens[client][slot] = "Empty" 
			PlayersItens[client][wire_slot] = "Empty" 
			setPlayerExp(client,xp+1)
			outputStatusInfo("+1 xp",client, 240,240,240 )
			--triggerClientEvent(client, "sleep:drawDXProgress", client, 2500,2500)
			--setTimer(triggerClientEvent,2500,1,client, "sleep:stopDXProgress", client)
			end
	used=true
	
	elseif id=="Barricade" then 
	local itemcount, slot = hasPlayerItem("Wood", client)
		if itemcount >= 2 then 
			setPedWeaponSlot(client,0)
			triggerEvent ("onBuildABarricade", client)
			PlayersItens[client][slot] = "Empty" 
			local itemcount, slot = hasPlayerItem("Wood", client)
			PlayersItens[client][slot] = "Empty"
			local player = client
			setTimer(function() local rags, rags_slot = hasPlayerItem("Wood", player) if rags then PlayersItens[player][rags_slot] = "Empty" end end,1000,1)
			setPlayerExp(client,xp+1)
			outputStatusInfo("+1 xp",client, 240,240,240 )
		end
	used=true
	
	elseif id=="Wire Fence" then
	local metal, metal_slot = hasPlayerItem("Scrap Metal", client)
	local wire, wire_slot = hasPlayerItem("Wire", client)
		if metal and metal>=2 and wire then 
			setPedWeaponSlot(client,0)
			triggerEvent ("onBuildAWireFence", client)
			--setPedAnimation ( client, "INT_HOUSE", "wash_up", 2500, true, false, false, false)		
			--setTimer(createwateritsamiracle, 2500, 1,"Raider Sword",client)
			--PlayersItens[client][metal_slot] = "Empty" 
			PlayersItens[client][wire_slot] = "Empty"
			local player = client
				setTimer(function() local metal, metal_slot = hasPlayerItem("Scrap Metal", player) if metal then PlayersItens[player][metal_slot] = "Empty" end end,1000,1)
				setTimer(function() local metal, metal_slot = hasPlayerItem("Scrap Metal", player) if metal then PlayersItens[player][metal_slot] = "Empty" end end,2000,1)
			setPlayerExp(client,xp+1)
			outputStatusInfo("+1 xp",client, 240,240,240 )
			--outputStatusInfo("Crafting Raider Sword...",client, 240,240,240 )
		end
	used = true
	
	elseif id=="Shelter" then
	local metal, metal_slot = hasPlayerItem("Scrap Metal", client)
	local wood, wood_slot = hasPlayerItem("Wood", client)
		if wood and wood>=4 and metal and metal>=2 then 
			setPedWeaponSlot(client,0)
			triggerEvent ("onBuildAShelter", client)
			--setPedAnimation ( client, "INT_HOUSE", "wash_up", 2500, true, false, false, false)		
			--setTimer(createwateritsamiracle, 2500, 1,"Raider Sword",client)
			--PlayersItens[client][metal_slot] = "Empty" 
			for i = 1,4 do
			local wood, wood_slot = hasPlayerItem("Wood", client)
			if wood_slot then PlayersItens[client][wood_slot] = "Empty" end
			end
			for i = 1,2 do
			local metal, metal_slot = hasPlayerItem("Scrap Metal", client)
			if metal_slot then PlayersItens[client][metal_slot] = "Empty" end
			end
			
			setPlayerExp(client,xp+2)
			outputStatusInfo("+2 xp",client, 240,240,240 )

		end
	used = true
	
	elseif id=="Bed" then
	local metal, metal_slot = hasPlayerItem("Scrap Metal", client)
	local rags, rags_slot = hasPlayerItem("Rags", client)
		if rags and rags>=2 and metal and metal>=3 then 
			setPedWeaponSlot(client,0)
			triggerEvent ("onBuildABed", client)
			--setPedAnimation ( client, "INT_HOUSE", "wash_up", 2500, true, false, false, false)		
			--setTimer(createwateritsamiracle, 2500, 1,"Raider Sword",client)
			--PlayersItens[client][metal_slot] = "Empty" 
			for i = 1,2 do
			local rags, rags_slot = hasPlayerItem("Rags", client)
			if rags_slot then PlayersItens[client][rags_slot] = "Empty" end
			end
			for i = 1,3 do
			local metal, metal_slot = hasPlayerItem("Scrap Metal", client)
			if metal_slot then PlayersItens[client][metal_slot] = "Empty" end
			end
			--[[local player = client
				setTimer(function() local metal, metal_slot = hasPlayerItem("Scrap Metal", player) if metal then PlayersItens[player][metal_slot] = "Empty" end end,1000,1)
				setTimer(function() local metal, metal_slot = hasPlayerItem("Scrap Metal", player) if metal then PlayersItens[player][metal_slot] = "Empty" end end,2000,1)]]
			setPlayerExp(client,xp+2)
			outputStatusInfo("+2 xp",client, 240,240,240 )
			--outputStatusInfo("Crafting Raider Sword...",client, 240,240,240 )
		end
	used = true
	
	elseif id=="Backpack" then 
	local rags, rags_slot = hasPlayerItem("Rags", client)
	local wire, wire_slot = hasPlayerItem("Wire", client)
		if rags and rags>=2 and wire then 
			setPedWeaponSlot(client,0)
			setPedAnimation ( client, "INT_HOUSE", "wash_up", 2500, true, false, false, false)		
			setTimer(createwateritsamiracle, 2500, 1,"Backpack",client)
			PlayersItens[client][rags_slot] = "Empty" 
			PlayersItens[client][wire_slot] = "Empty"
			local player = client
				setTimer(function() local rags, rags_slot = hasPlayerItem("Rags", player) if rags then PlayersItens[player][rags_slot] = "Empty" end end,1000,1)
				setTimer(function() local rags, rags_slot = hasPlayerItem("Rags", player) if rags then PlayersItens[player][rags_slot] = "Empty" end end,2000,1)
			setPlayerExp(client,xp+1)
			outputStatusInfo("+1 xp",client, 240,240,240 )
			outputStatusInfo("[ crafting "..id.."... ]",client, 240,240,240 )
			triggerClientEvent(client, "sleep:drawDXProgress", client, 2500,2500)
			setTimer(triggerClientEvent,2500,1,client, "sleep:stopDXProgress", client)
		end
	used=true
	
	elseif id=="Camouflage Suit" then 
	--[[local rags, rags_slot = hasPlayerItem("Rags", client)
			if rags>=3 then 
			setPedWeaponSlot(client,0)
			setPedAnimation ( client, "INT_HOUSE", "wash_up", 2500, true, false, false, false)		
			setTimer(createwateritsamiracle, 2500, 1,"Camouflage Suit",client)
			PlayersItens[client][rags_slot] = "Empty" 
			local player = client
				setTimer(function() local rags, rags_slot = hasPlayerItem("Rags", player) if rags then PlayersItens[player][rags_slot] = "Empty" end end,1000,1)
				setTimer(function() local rags, rags_slot = hasPlayerItem("Rags", player) if rags then PlayersItens[player][rags_slot] = "Empty" end end,2000,1)
			setPlayerExp(client,xp+1)
			outputStatusInfo("+1 xp",client, 240,240,240 )
			outputStatusInfo("[ crafting "..id.."... ]",client, 240,240,240 )
			triggerClientEvent(client, "sleep:drawDXProgress", client, 2500,2500)
			setTimer(triggerClientEvent,2500,1,client, "sleep:stopDXProgress", client)
		end
	used=true]]
	outputStatusInfo("[ work in progress ]",client, 240,240,240 )
	
	elseif id=="Raider Sword" then 
	local metal, metal_slot = hasPlayerItem("Scrap Metal", client)
	local rags, rags_slot = hasPlayerItem("Rags", client)
		if metal>=2 and rags then 
			setPedWeaponSlot(client,0)
			setPedAnimation ( client, "INT_HOUSE", "wash_up", 2500, true, false, false, false)		
			setTimer(createwateritsamiracle, 2500, 1,"Raider Sword",client)
			--PlayersItens[client][metal_slot] = "Empty" 
			PlayersItens[client][rags_slot] = "Empty"
			local player = client
				setTimer(function() local metal, metal_slot = hasPlayerItem("Scrap Metal", player) if metal then PlayersItens[player][metal_slot] = "Empty" end end,1000,1)
				setTimer(function() local metal, metal_slot = hasPlayerItem("Scrap Metal", player) if metal then PlayersItens[player][metal_slot] = "Empty" end end,2000,1)
			setPlayerExp(client,xp+1)
			outputStatusInfo("+1 xp",client, 240,240,240 )
			outputStatusInfo("[ crafting "..id.."... ]",client, 240,240,240 )
			triggerClientEvent(client, "sleep:drawDXProgress", client, 2500,2500)
			setTimer(triggerClientEvent,2500,1,client, "sleep:stopDXProgress", client)		
		end
	used=true
	
	elseif id=="Incendiary Trap" then  
	local itemcount1, slot1 = hasPlayerItem("Wood", client)
	local itemcount2, slot2 = hasPlayerItem("Fuel Canister", client)
	local itemcount3, slot3 = hasPlayerItem("Wire", client)
		if itemcount1 and itemcount2 and itemcount3 then 
			setPedAnimation ( client, "INT_HOUSE", "wash_up", 5000, true, false, false, false)		
			setTimer(createwateritsamiracle, 5000, 1,"Incendiary Trap",client) 
			outputStatusInfo("[ crafting "..id.."... ]",client, 240,240,240 ) 
			PlayersItens[client][slot1] = "Empty"
			PlayersItens[client][slot2] = "Empty"
			PlayersItens[client][slot3] = "Empty"
			setPlayerExp(client,xp+3)
			setTimer(outputStatusInfo, 5000, 1,"+3 xp",client, 240,240,240 )
			triggerClientEvent(client, "sleep:drawDXProgress", client, 5000,5000)
			setTimer(triggerClientEvent,5000,1,client, "sleep:stopDXProgress", client)
		end
	used=true
	
	elseif id=="Shards Trap" then  
	local itemcount1, slot1 = hasPlayerItem("Wood", client)
	local itemcount2, slot2 = hasPlayerItem("Broken Bottle", client)
	local itemcount3, slot3 = hasPlayerItem("Wire", client)
		if itemcount1 and itemcount2 and itemcount3 then 
			setPedAnimation ( client, "INT_HOUSE", "wash_up", 5000, true, false, false, false)		
			setTimer(createwateritsamiracle, 5000, 1,"Shards Trap",client) 
			outputStatusInfo("[ crafting "..id.."... ]",client, 240,240,240 ) 
			PlayersItens[client][slot1] = "Empty"
			PlayersItens[client][slot2] = "Empty"
			PlayersItens[client][slot3] = "Empty"
			setPlayerExp(client,xp+3)
			setTimer(outputStatusInfo, 5000, 1,"+3 xp",client, 240,240,240 )
			triggerClientEvent(client, "sleep:drawDXProgress", client, 5000,5000)
			setTimer(triggerClientEvent,5000,1,client, "sleep:stopDXProgress", client)
		end
	used=true
	
	elseif id=="Wood Objects" then  
	--set category to 1
	elseif id=="Metal Objects" then  
	--set category to 2
	elseif id=="Structures" then  
	--set category to 3
	elseif id=="Special" then  
	--set category to 4
	
	elseif id=="Wood Panel" then  
	create(client, command, 3260)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Wood Fence" then  
	create(client, command, 1407)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Wood Platform" then  
	create(client, command, 1482)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Wood Ladder" then  
	create(client, command, 1428)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Wood Steps" then  
	create(client, command, 1472)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Wood Chair" then  
	create(client, command, 2636)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Wood Table" then  
	create(client, command, 2115)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Wood Sign" then  
	create(client, command, 3927)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Wood Door" then  
	create(client, command, 1492)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )

	elseif id=="Metal Fence" then  
	create(client, command, 1447)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Metal Barbed Fence" then  
	create(client, command, 1411)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Metal Panel" then  
	create(client, command, 3302)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Metal Grate" then  
	create(client, command, 3280)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Metal Plank" then  
	create(client, command, 2937)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Metal Barrier" then  
	create(client, command, 1424)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Metal Strong Fence" then  
	create(client, command, 3049)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Metal Door" then  
	create(client, command, 1499)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Metal Wall" then  
	create(client, command, 5779)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	
	
	elseif id=="Gate" then  
	create(client, command, 16281)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Shelter" then  
	create(client, command, 1457)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Hut Structure" then  
	create(client, command, 16405)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Outhouse" then  
	create(client, command, 1452)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Scaffold" then  
	create(client, command, 1466)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Reinforced Scaffold" then  
	create(client, command, 1464)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Scaffold Tower" then  
	create(client, command, 1426)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Small Cabin" then  
	create(client, command, 12991)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Large Cabin" then  
	create(client, command, 18259)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	
	elseif id=="Fire Bin" then  
	create(client, command, 1362)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Bed" then  
	create(client, command, 1800)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Storage" then  
	create(client, command, 1271)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Workbench" then  
	create(client, command, 2451)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Large Storage" then  
	create(client, command, 1345)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Fish Trap" then  
	create(client, command, 16732)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Potato Farm" then  
	create(client, command, 3261)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Critter Pen" then  
	create(client, command, 1451)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	elseif id=="Trading Post" then  
	create(client, command, 1570)
	outputInteractInfo("[ Building "..id.."... ]",client, 240,240,240 )
	
	end

	if(used)then
	triggerClientEvent(client,"synchronizeCraft",client,PlayersCraftItems)
	triggerClientEvent(client,"synchronizeTables",client,PlayersItens)
	triggerClientEvent(client,"RefreshDraw",client)
	end

	

end
addEventHandler("onPlayerActivateCraftItem",root, activateCraftItem, id, index)-- this happens when you click on a craft inventory item
