-- server by manawydan
local PlayersAtualItem={} 
PlayersItens={} -- player items
PlayersBeltItens = {}

local elementBackpack = {}
local playerSt={}

local onJoin =  function()
PlayersAtualItem[source]=false
playerSt[source]=false
PlayersItens[source]={"Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty"}
PlayersBeltItens[source]={"Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty"}

triggerClientEvent(source,"synchronizeTables",source,PlayersItens)
triggerClientEvent(source,"synchronizeBelt",source,PlayersBeltItens)

triggerClientEvent(source,"ShowTitleImage",source)
triggerClientEvent(source,"RefreshDraw",source)

end
addEventHandler("onPlayerJoin",root,onJoin)

addEvent("AddTableToClient",true)
addEventHandler("AddTableToClient",root, 
function(p)

if(PlayersAtualItem[p] == nil)then
PlayersAtualItem[p]=false
playerSt[p]=false

--PlayersItens[p]= {"Broken Bottle","Binoculars","Raw Meat","Meat Can","Crossbow","Assault Ammo","Bolts","Rifle Ammo","Bolts"}
PlayersItens[p]= {"Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"}  
PlayersBeltItens[p]= {"Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty"}

triggerClientEvent(p,"synchronizeTables",p,PlayersItens)
triggerClientEvent(p,"synchronizeBelt",p,PlayersBeltItens)

end
end)

 local itensTable =  --list of all defined items
{                   -- item name, item object id, fix z
                   {"Pistol Ammo",  2039, 0}, -- ITEM ID: 1 
                   {"Shotgun Ammo",  2038, 0}, -- ITEM ID: 2
                   {"Assault Ammo",  2040, 0} , -- 3
                   {"SMG Ammo",  2041, 0}, -- 4
                   {"Chainsaw",  341, 0},  -- 5 --Weight: 4
                   {"Raider Sword",  339, 0}, -- 6 --Weight: 2
                   {"M4",  356, 0}, -- 7 --Weight: 3
                   {"AK 47",  355, 0}, -- 8 --Weight: 3 
                   {"Rocket Launcher",  359, 0}, -- 9 --Weight: 4
                   {"Knife",  335, 0}, -- 10 --Weight: 1
                   {"Rifle",  357, 0}, -- 11 --Weight: 3
                   {"Crossbow",  347, 0}, -- 12  --Weight: 3 
                   {"Sniper Rifle",  358, 0}, -- 13  --Weight: 3
                   {"Minigun",  362, 0}, --14  --Weight: 4
                   {"Uzi",  352, 0}, --15  --Weight: 2
                   {"Vehicle Minigun",  372, 0}, --16  --Weight: 1
                   {"Combat Shotgun",  351, 0}, --17  --Weight: 3
                   {"Sawn-off Shotgun",  350, 0}, --18  --Weight: 2
                   {"Satchel Charge",  363, 0}, --19  --Weight: 2
                   {"MP5",  353, 0}, --20  --Weight: 3
                   {"Grenade",  342, 0}, --21  --Weight: 1
                   {"Magnum Revolver",  348, 0}, --22 --Weight: 1
                   {"Stinger Launcher",  360, 0}, --23 --Weight: 4
                   {"Meat Can",2601, 0}, --24
                   {"Water Bottle",1668, 0}, --25 --1668
                   {"Raw Meat", 2804, 0}, --26
                   {"Machete",321, 0}, --27 --Weight: 2
                   {"Kitchen Knife",322, 0}, --28 --Weight: 1
                   {"Meatcleaver",323, 0}, --29 --Weight: 1
                   {"Broken Bottle",325, 0}, --30 --Weight: 2
                   {"Nail Bat",326, 0}, --31 --Weight: 2
                   {"Crowbar",337, 0}, --32 --Weight: 2
                   {"Sledgehammer",338, 0}, --33 --Weight: 3
                   {"Pistol",346, 0}, --34 --Weight: 1
                   {"Molotov",344, 0}, --35 --Weight: 1
                   {"Nightstick",334, 0}, --36 --Weight: 2
                   {"Baseball Bat",336, 0}, --37 --Weight: 2
                   {"Tactical Shield",331, 0}, --38 
                   {"Axe",333, 0}, --39 --Weight: 2
                   {"Binoculars",367, 0}, --40 --Weight: 1
                   {"Spray Can",365, 0}, --41 --Weight: 1
                   {"Pump Shotgun",349, 0}, --42 --Weight: 3
                   {"Body Armor",373, 0}, --43
                   {"Backpack",371, 0}, --44
                   {"Medikit",327, 0}, --45
                   {"Teargas",343, 0}, --46 --Weight: 1
                   {"Flamethrower",361, 0}, -- 47--Weight: 4
                   {"Bolts",328, 0}, --48 
                   {"Magnum Ammo",3082, 0}, --49  
                   {"Painkillers",2709, 0}, --50
                   {"Rifle Ammo",2042, 0}, --51 
				   {"Fuel Canister",1650, 0},
				   {"Empty Canister",1650, 0},
				   {"Scrap Metal",850, 0},
				   {"Ammo Box",3016, 0},
				   {"Toolbox",2969, 0},
				   {"Alcohol Bottle",1520, 0},
				   {"Rags",2844, 0},
				   {"Empty Bottle",1668, 0},
				   {"Map",3017, 0},
				   {"Survivor Map",3017, 0},
				   {"Military Map",3017, 0},
				   {"Raw Human Meat",2806, 0},
				   {"Roasted Meat",2804, 0},
				   {"Vehicle Parts",2711, 0},
				   {"Roasted Human Meat",2804, 0},
				   {"Plastic Foil",1901, 0},
				   {"Wire",933, 0},
				   {"Fish Can",2601, 0},
				   {"Water Canister",1650, 0},
				   
				   {"Headlamp",15060, 0},
				   {"Thermal Googles",369, 0},
				   {"Wood",1463, 0},
				   {"Laser Pointer",1463, 0},
				   {"Lighter",2351, 0},
				   {"Bandage",2384, 0},
				   {"Night Vision Googles", 368, -0.1},
				   {"Zip Line", 1955, -0.1},
				   
				   {"Dirty Water",1668, 0},
				   
				   {"Adrenaline",2709, 0},
				   {"ZomboKleen",2709, 0},
				   {"Splint",1279, 0},
				   {"Road Flare",1319, 0},
				   {"Hazmat Suit",1576, 0},
				   {"Camouflage Suit",1575, 0},
				   {"Scuba Gear", 1010, 0},
				   {"Watch", 2710, 0},
				   {"EM Scanner",1615, 0},
				   {"Radio",330, 0},
				   {"M37 Stomper",2033, 0},
				   {"Stomper Ammo",2972, 0},
				   {"Minigun Ammo",2358, 0},
				   {"Stinger Missile", 3790, 0},
				   {"Spikestrip", 2899, 0},
				   {"Timed Bomb",1654, 0},
				   {"Mine",1381, 0},
				   {"Incendiary Trap",2978, 0},
				   {"Shards Trap",2978, 0},
				   {"Agent Pale",366, 0},
				   {"Soup Can",2601, 0}
			   
				   --[[to add: 
				    
				   MRU, 
				   Antibiotics, 
				   Juice Can, 
				   Scuba Gear, 
				   Money, 
				   PPU Portable Power Unit, 
				   MonoPad, 
				   Handcuffs,
				   Tranquilizer Darts (as either rifle or crossbow ammo),
				   Thermal Scope, 
				   Gunk, 
				   Cigarettes,
				   Hide, 
				   Stew, 
				   Metal Can,
				   Improvised Vest,
				   Vest,
				   Gas Mask,
				   Assault Backpack
				   ]]
				   
}

addEvent("onPlayerUseItem",true) -- player left-clicked item
addEvent("CarScavCompleted",true) --adds scavenged items to inventory

function useItem(id,index) -- use item function (mouse 1)
local weapon = getPedWeapon(client)
local acc = getPlayerAccount(client)
local x, y, z = getElementPosition(client)

local weight = equippmentWeight(client)
local playerHasFreeEquipmentSlots = getElementData(client,"equipment_slots_free") or false
--iprint("Equipment bar is: "..tostring(playerHasFreeEquipmentSlots))
local weapon0 = getPedWeapon(client, 0)
local weapon1 = getPedWeapon(client, 1)
local weapon2 = getPedWeapon(client, 2)
local weapon3 = getPedWeapon(client, 3)
local weapon4 = getPedWeapon(client, 4)
local weapon5 = getPedWeapon(client, 5)
local weapon6 = getPedWeapon(client, 6)
local weapon7 = getPedWeapon(client, 7)
local weapon8 = getPedWeapon(client, 8)
local weapon9 = getPedWeapon(client, 9)
local weapon10 = getPedWeapon(client, 10)
local weapon11 = getPedWeapon(client, 11)

local ammo2 = getPedTotalAmmo(client,2)
local ammo3 = getPedTotalAmmo(client,3)
local ammo4 = getPedTotalAmmo(client,4)
local ammo5 = getPedTotalAmmo(client,5)
local ammo6 = getPedTotalAmmo(client,6)
local ammo7 = getPedTotalAmmo(client,7)
local ammo8 = getPedTotalAmmo(client,8)
local ammo9 = getPedTotalAmmo(client,9)

local pistolammo = getElementData(client,"pistolammo") or 1
local taserammo = getElementData(client,"taserammo") or 1
local crossbowammo = getElementData(client,"crossbowammo") or 1
local smgammo = getElementData(client,"smgammo") or 1
local shotgunammo = getElementData(client,"shotgunammo") or 1
local assaultammo = getElementData(client,"assaultammo") or 1
local rifleammo = getElementData(client,"rifleammo") or 1

local used = false
local health = getElementHealth(client)
local player = client

--triggerClientEvent(client,"ReopenTradePanel",client)

if(id=="Pistol Ammo" and weapon2 ~= nil and weapon2==22 and ammo2>0) then 
	
setPedWeaponSlot(client,2)
inventoryInteract(id, index)
--used=true										---next block of code and the return from below is a naive attempt to stop duping; do it more efficient
triggerEvent("RefreshDraw",client)
PlayersItens[client][index]="Empty"
triggerClientEvent(client,"RefreshDraw",client)
triggerClientEvent("synchronizeTables",client,PlayersItens)

setWeaponAmmo(client,weapon2,pistolammo+10)
toggleControl( client, "fire", true )
reloadPedWeapon(client)
return

elseif(id=="Bolts" and weapon2 ~= nil and weapon2==23 and ammo2>0)then 
setPedWeaponSlot(client,2)
inventoryInteract(id, index)
--used=true
triggerEvent("RefreshDraw",client)
PlayersItens[client][index]="Empty"
triggerClientEvent(client,"RefreshDraw",client)
triggerClientEvent("synchronizeTables",client,PlayersItens)

setWeaponAmmo(client,weapon2,crossbowammo+5)
toggleControl( client, "fire", true )
reloadPedWeapon(client)
return

elseif(id=="Magnum Ammo" and weapon2 ~= nil and weapon2==24 and ammo2>0)then 
setPedWeaponSlot(client,2)
inventoryInteract(id, index)
--used=true
triggerEvent("RefreshDraw",client)
PlayersItens[client][index]="Empty"
triggerClientEvent(client,"RefreshDraw",client)
triggerClientEvent("synchronizeTables",client,PlayersItens)

setWeaponAmmo(client,weapon2,taserammo+6)
toggleControl( client, "fire", true )
reloadPedWeapon(client)
return

elseif(id=="Shotgun Ammo" and weapon3 ~= nil and ammo3>0)then 
setPedWeaponSlot(client,3)
inventoryInteract(id, index)
--used=true
triggerEvent("RefreshDraw",client)
PlayersItens[client][index]="Empty"
triggerClientEvent(client,"RefreshDraw",client)
triggerClientEvent("synchronizeTables",client,PlayersItens)

setWeaponAmmo(client,weapon3,shotgunammo+8)
toggleControl( client, "fire", true )
reloadPedWeapon(client)
setPedAnimation( client, "RIFLE", "RIFLE_load",-1,false,false,true,false)
return

elseif(id=="Rifle Ammo" and weapon6 ~= nil and ammo6>0) then 
setPedWeaponSlot(client,6)
inventoryInteract(id, index)
--used=true
triggerEvent("RefreshDraw",client)
PlayersItens[client][index]="Empty"
triggerClientEvent(client,"RefreshDraw",client)
triggerClientEvent("synchronizeTables",client,PlayersItens)

setWeaponAmmo(client,weapon6, rifleammo+5)
toggleControl( client, "fire", true )
reloadPedWeapon(client)
setPedAnimation( client, "RIFLE", "RIFLE_load",-1,false,false,true,false)
return

elseif (id=="Assault Ammo" and weapon5 ~= nil and ammo5>0)then 
setPedWeaponSlot(client,5) 
inventoryInteract(id, index)
--used=true
triggerEvent("RefreshDraw",client)
PlayersItens[client][index]="Empty"
triggerClientEvent(client,"RefreshDraw",client)
triggerClientEvent("synchronizeTables",client,PlayersItens)

setWeaponAmmo(client,weapon5,assaultammo+30)
reloadPedWeapon(client)
toggleControl( client, "fire", true )
return

elseif(id=="SMG Ammo" and weapon4 ~= nil  and ammo4>0)then 
setPedWeaponSlot(client,4)
inventoryInteract(id, index)
--used=true
triggerEvent("RefreshDraw",client)
PlayersItens[client][index]="Empty"
triggerClientEvent(client,"RefreshDraw",client)
triggerClientEvent("synchronizeTables",client,PlayersItens)

setWeaponAmmo(client,weapon,smgammo+30)
toggleControl( client, "fire", true )
reloadPedWeapon(client)
return

elseif id=="Map" then
triggerClientEvent(client,"mapUsed",client,"Map")

elseif id=="Survivor Map" then
triggerClientEvent(client,"mapUsed",client,"Survivor Map")

elseif id=="Military Map" then
triggerClientEvent(client,"mapUsed",client,"Military Map")

elseif id=="Bandage" then
	if getElementData(client, "bleeding") == true then 
	triggerClientEvent(client,"StopBleedingBandage",client)
	triggerClientEvent(client, "sleep:drawDXProgress", client, 1000,1000)
	setTimer(triggerClientEvent,1000,1,client, "sleep:stopDXProgress", client)
	used = true
	else
	outputStatusInfo("[ not bleeding ]", client, 255,200,0)
	end


elseif id=="Headlamp"  and playerHasFreeEquipmentSlots then 
	
	if weight >= 6 then 
		----outputTopBar("HINT: Press [X] to unequip current weapon.", client, 255,200,0)
		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
		if getElementData(client,"headlampequipped") == true then 
		outputInteractInfo("[ already equipped! ]", client, 255,230,0)  
		return
		else
		triggerClientEvent(client,"HeadlampEquipped",client)
		used = true
		end
	end
	
elseif id=="EM Scanner" then 
	
	--triggerClientEvent(client,"ToggleScanner",client)

	
elseif id=="Zip Line"  and playerHasFreeEquipmentSlots then 
	
	if getPedWeapon(client,2) ~= 23 then 
		outputTopBar("HINT: Equip a Crossbow to use Zip Line.", client, 255,200,0)
		outputInteractInfo("[ equip suitable weapon first! ]", client, 255,200,0, 3000)
	else
		if getElementData(client,"zipline") == true then 
		outputInteractInfo("[ already equipped! ]", client, 255,230,0) 
		return
		else
		setElementData(client,"zipline",true,true)
		outputInteractInfo("> Zip Line", client, 255,200,0)
		used = true
		end
	end
	
elseif id=="M37 Stomper"  and playerHasFreeEquipmentSlots then 
	local weap = getPedWeapon(client,5)
	if weap ~= 30 and weap ~= 31 then 
		outputTopBar("HINT: Attach the Stomper to an assault rifle.", client, 255,200,0)
		outputInteractInfo("[ equip suitable weapon first! ]", client, 255,200,0, 3000)
	else
		if getElementData(client,"stomperequipped") == true then 
		outputInteractInfo("[ already equipped! ]", client, 255,230,0)  
		return
		else
		setElementData(client,"stomperequipped",true,true)
		outputInteractInfo("M37 Stomper attached", client, 255,200,0)
		used = true
		end
	end
	
elseif id=="Laser Pointer"  and playerHasFreeEquipmentSlots then 
	
	if not IsPlayerWeaponValidForLaser(client) then 
		outputTopBar("HINT: Attach the Laser Pointer to a ranged weapon.", client, 255,200,0)
		outputInteractInfo("[ equip suitable weapon first! ]", client, 255,200,0, 3000)
	else
		if getElementData(client,"laserpointer") == true then 
		outputInteractInfo("[ already equipped! ]", client, 255,230,0)  
		return
		else
		setElementData(client,"laserpointer",true,true)
		outputInteractInfo("Laser Pointer attached", client, 255,200,0)
		if IsLaserEnabled(client) then SetLaserEnabled(client,false) end
		used = true
		end
	end	

elseif id == "Mine"  then
	local explosivetraps = getElementData(client,"explosivetraps")
	createExplosiveTrap(client)
	outputStatusInfo("[ deploying mine...]", client, 255, 255, 255)
	setPedAnimation( client, "BOMBER", "BOM_Plant",1000,false,false,false,false)
	triggerClientEvent(client, "sleep:drawDXProgress", client, 1000,1000)
	setTimer(triggerClientEvent,1000,1,client, "sleep:stopDXProgress", client)	
	--used=true
	triggerEvent("RefreshDraw",client)
	PlayersItens[client][index]="Empty"
	triggerClientEvent(client,"RefreshDraw",client)
	triggerClientEvent("synchronizeTables",client,PlayersItens)
return
	
elseif id == "Timed Bomb"  then
	local timedbombs = getElementData(client,"timedbombs") or 0
	if timedbombs<0 then timedbombs = 0; setElementData(client,"timedbombs",0) end
	
	createTimedBomb(client)
	outputStatusInfo("[ deploying trap... ]", client, 255, 255, 255)
	setPedAnimation( client, "BOMBER", "BOM_Plant",1000,false,false,false,false)	
	triggerClientEvent(client, "sleep:drawDXProgress", client, 1000,1000)
	setTimer(triggerClientEvent,1000,1,client, "sleep:stopDXProgress", client)
	setElementData(client,"timedbombs",timedbombs-1)
--used=true
triggerEvent("RefreshDraw",client)
PlayersItens[client][index]="Empty"
triggerClientEvent(client,"RefreshDraw",client)
triggerClientEvent("synchronizeTables",client,PlayersItens)
return

	
elseif id == "Incendiary Trap"  then
	local incendiarytraps = getElementData(client,"incendiarytraps")
	createIncendiaryTrap(client)
	outputStatusInfo("[ deploying trap... ]", client, 255, 255, 255)
	setPedAnimation( client, "BOMBER", "BOM_Plant",1000,false,false,false,false)	
	triggerClientEvent(client, "sleep:drawDXProgress", client, 1000,1000)
	setTimer(triggerClientEvent,1000,1,client, "sleep:stopDXProgress", client)
--used=true
triggerEvent("RefreshDraw",client)
PlayersItens[client][index]="Empty"
triggerClientEvent(client,"RefreshDraw",client)
triggerClientEvent("synchronizeTables",client,PlayersItens)
return
	
		
	
elseif id == "Shards Trap"  then
	local glasstraps = getElementData(client,"glasstraps")
	--if glasstraps <= 0 then return end
	createGlassTrap(client)
	outputStatusInfo("[ deploying trap... ]", client, 255, 255, 255)
	setPedAnimation( client, "BOMBER", "BOM_Plant",1000,false,false,false,false)
	triggerClientEvent(client, "sleep:drawDXProgress", client, 1000,1000)
	setTimer(triggerClientEvent,1000,1,client, "sleep:stopDXProgress", client)	
--used=true
triggerEvent("RefreshDraw",client)
PlayersItens[client][index]="Empty"
triggerClientEvent(client,"RefreshDraw",client)
triggerClientEvent("synchronizeTables",client,PlayersItens)
return

--WEAPONS-------------------------------------------------------------------------------------------------------

--SLOT 0--FISTS
elseif(id=="Tactical Shield") and playerHasFreeEquipmentSlots then --weight: 1
	if weight > 5 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,0)
	if weapon == 1 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return 
	elseif weapon == 0 then
	used=true
	giveWeapon(client,1,1,true)
	end
	end
	
elseif id== "Watch"  and playerHasFreeEquipmentSlots then
	if getElementData(client,"watch")==true then  
	outputInteractInfo("[ already equipped! ]", client, 255,230,0) 
	else
	setElementData(client,"watch",true,true)
	outputInteractInfo("> Watch", client, 255,200,0)
	used=true
	end

--SLOT 1--MELEE
elseif(id=="Raider Sword") and playerHasFreeEquipmentSlots then --weight: 2
setPedWeaponSlot(client,1)
	if weight > 4 and getPedWeapon (client,1) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,1)
	if (weapon == 4 and weight+2-1<=6) or (weapon ~= 4) or weight <=4 then
		if weapon == 2 and isInventoryFull(client) == false then addPlayerItem(client, "Axe") elseif weapon == 2 and isInventoryFull(client) == true then createObjectItem("Axe", x, y, z-0.95, 97.3,120, 0) end 
		if weapon == 3 and isInventoryFull(client) == false then addPlayerItem(client, "Nightstick") elseif weapon == 3 and isInventoryFull(client) == true then createObjectItem("Nightstick", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 4 and isInventoryFull(client) == false then addPlayerItem(client, "Knife") elseif weapon == 4 and isInventoryFull(client) == true then createObjectItem("Knife", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 5 and isInventoryFull(client) == false then addPlayerItem(client, "Baseball Bat") elseif weapon == 5 and isInventoryFull(client) == true then createObjectItem("Baseball Bat", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 6 and isInventoryFull(client) == false then addPlayerItem(client, "Crowbar") elseif weapon == 6 and isInventoryFull(client) == true then createObjectItem("Crowbar", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 7 and isInventoryFull(client) == false then addPlayerItem(client, "Sledgehammer") elseif weapon == 7 and isInventoryFull(client) == true then createObjectItem("Sledgehammer", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 9 and isInventoryFull(client) == false then addPlayerItem(client, "Chainsaw") elseif weapon == 9 and isInventoryFull(client) == true then createObjectItem("Chainsaw", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 8 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	used=true
	giveWeapon(client,8,1,true)
	outputInteractInfo("> Raider Sword", client, 255,200,0, 3000)
	else

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	end
	end

elseif(id=="Knife") and playerHasFreeEquipmentSlots then --weight: 1
setPedWeaponSlot(client,1)
	if weight >= 6 and getPedWeapon (client,1) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,1)
	if weight <=6 then
		if weapon == 2 and isInventoryFull(client) == true then createObjectItem("Axe", x, y, z-0.95, 97.3,120, 0) elseif weapon == 2 and isInventoryFull(client) == false then addPlayerItem(client, "Axe") end
		if weapon == 3 and isInventoryFull(client) == true then createObjectItem("Nightstick", x, y, z-0.95, 97.3,120, 0) elseif weapon == 3 and isInventoryFull(client) == false then addPlayerItem(client, "Nightstick") end
		if weapon == 8 and isInventoryFull(client) == true then createObjectItem("Raider Sword", x, y, z-0.95, 97.3,120, 0) elseif weapon == 8 and isInventoryFull(client) == false then addPlayerItem(client, "Raider Sword") end
		if weapon == 5 and isInventoryFull(client) == true then createObjectItem("Baseball Bat", x, y, z-0.95, 97.3,120, 0) elseif weapon == 5 and isInventoryFull(client) == false then addPlayerItem(client, "Baseball Bat") end
		if weapon == 6 and isInventoryFull(client) == true then createObjectItem("Crowbar", x, y, z-0.95, 97.3,120, 0) elseif weapon == 6 and isInventoryFull(client) == false then addPlayerItem(client, "Crowbar") end
		if weapon == 7 and isInventoryFull(client) == true then createObjectItem("Sledgehammer", x, y, z-0.95, 97.3,120, 0) elseif weapon == 7 and isInventoryFull(client) == false then addPlayerItem(client, "Sledgehammer") end
		if weapon == 9 and isInventoryFull(client) == true then createObjectItem("Chainsaw", x, y, z-0.95, 97.3,120, 0) elseif weapon == 9 and isInventoryFull(client) == false then addPlayerItem(client, "Chainsaw") end
		if weapon == 4 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	used=true
	giveWeapon(client,4,1,true)
	outputInteractInfo("> Knife", client, 255,200,0, 3000)
	else

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	end--test part
	end

elseif(id=="Crowbar") and playerHasFreeEquipmentSlots then --weight: 2
setPedWeaponSlot(client,1)
	if weight > 4 and getPedWeapon (client,1) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,1)
	if (weapon == 4 and weight+2-1<=6) or (weapon ~= 4) or weight <=4 then
		if weapon == 2 and isInventoryFull(client) == false then addPlayerItem(client, "Axe") elseif weapon == 2 and isInventoryFull(client) == true then createObjectItem("Axe", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 3 and isInventoryFull(client) == false then addPlayerItem(client, "Nightstick") elseif weapon == 3 and isInventoryFull(client) == true then createObjectItem("Nightstick", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 8 and isInventoryFull(client) == false then addPlayerItem(client, "Raider Sword") elseif weapon == 8 and isInventoryFull(client) == true then createObjectItem("Raider Sword", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 5 and isInventoryFull(client) == false then addPlayerItem(client, "Baseball Bat") elseif weapon == 5 and isInventoryFull(client) == true then createObjectItem("Baseball Bat", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 4 and isInventoryFull(client) == false then addPlayerItem(client, "Knife") elseif weapon == 4 and isInventoryFull(client) == true then createObjectItem("Knife", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 7 and isInventoryFull(client) == false then addPlayerItem(client, "Sledgehammer") elseif weapon == 7 and isInventoryFull(client) == true then createObjectItem("Sledgehammer", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 9 and isInventoryFull(client) == false then addPlayerItem(client, "Chainsaw") elseif weapon == 9 and isInventoryFull(client) == true then createObjectItem("Chainsaw", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 6 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	used=true
	giveWeapon(client,6,1,true)
	outputInteractInfo("> Crowbar", client, 255,200,0, 3000)
	else

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	end--test part
	end

elseif(id=="Sledgehammer") and playerHasFreeEquipmentSlots then --weight: 3
setPedWeaponSlot(client,1)
	if weight > 3 and getPedWeapon (client,1) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,1)
	if (weapon >= 2 and weapon <= 9 and weapon ~= 4 and weapon ~= 9 and weight+3-2 <= 6) or (weapon == 4 and weight+3-1<=6) or (weapon == 9 and weight+3-4<=6) or weight <=3 then
		if weapon == 2 and isInventoryFull(client) == false then addPlayerItem(client, "Axe") elseif weapon == 2 and isInventoryFull(client) == true then createObjectItem("Axe", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 3 and isInventoryFull(client) == false then addPlayerItem(client, "Nightstick") elseif weapon == 3 and isInventoryFull(client) == true then createObjectItem("Nightstick", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 8 and isInventoryFull(client) == false then addPlayerItem(client, "Raider Sword") elseif weapon == 8 and isInventoryFull(client) == true then createObjectItem("Raider Sword", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 5 and isInventoryFull(client) == false then addPlayerItem(client, "Baseball Bat") elseif weapon == 5 and isInventoryFull(client) == true then createObjectItem("Baseball Bat", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 4 and isInventoryFull(client) == false then addPlayerItem(client, "Knife") elseif weapon == 4 and isInventoryFull(client) == true then createObjectItem("Knife", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 6 and isInventoryFull(client) == false then addPlayerItem(client, "Crowbar") elseif weapon == 6 and isInventoryFull(client) == true then createObjectItem("Crowbar", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 9 and isInventoryFull(client) == false then addPlayerItem(client, "Chainsaw") elseif weapon == 9 and isInventoryFull(client) == true then createObjectItem("Chainsaw", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 7 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	used=true
	giveWeapon(client,7,1,true)
	outputInteractInfo("> Sledgehammer", client, 255,200,0, 3000)
	else

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	end--test part
	end

elseif(id=="Nightstick") and playerHasFreeEquipmentSlots then --weight: 2
setPedWeaponSlot(client,1)
	if weight > 4 and getPedWeapon (client,1) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,1)
	if (weapon == 4 and weight+2-1<=6) or (weapon ~= 4) or weight <=4 then
		if weapon == 2 and isInventoryFull(client) == false then addPlayerItem(client, "Axe") elseif weapon == 2 and isInventoryFull(client) == true then createObjectItem("Axe", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 7 and isInventoryFull(client) == false then addPlayerItem(client, "Sledgehammer") elseif weapon == 7 and isInventoryFull(client) == true then createObjectItem("Sledgehammer", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 8 and isInventoryFull(client) == false then addPlayerItem(client, "Raider Sword") elseif weapon == 8 and isInventoryFull(client) == true then createObjectItem("Raider Sword", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 5 and isInventoryFull(client) == false then addPlayerItem(client, "Baseball Bat") elseif weapon == 5 and isInventoryFull(client) == true then createObjectItem("Baseball Bat", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 4 and isInventoryFull(client) == false then addPlayerItem(client, "Knife") elseif weapon == 4 and isInventoryFull(client) == true then createObjectItem("Knife", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 6 and isInventoryFull(client) == false then addPlayerItem(client, "Crowbar") elseif weapon == 6 and isInventoryFull(client) == true then createObjectItem("Crowbar", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 9 and isInventoryFull(client) == false then addPlayerItem(client, "Chainsaw") elseif weapon == 9 and isInventoryFull(client) == true then createObjectItem("Chainsaw", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 3 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	used=true
	giveWeapon(client,3,1,true)
	outputInteractInfo("> Nightstick", client, 255,200,0, 3000)
	else

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	end
	end

elseif(id=="Baseball Bat") and playerHasFreeEquipmentSlots then --weight: 2
setPedWeaponSlot(client,1)
	if weight > 4 and getPedWeapon (client,1) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,1)
	if (weapon == 4 and weight+2-1<=6) or (weapon ~= 4) or weight <=4 then
		if weapon == 2 and isInventoryFull(client) == false then addPlayerItem(client, "Axe") elseif weapon == 2 and isInventoryFull(client) == true then createObjectItem("Axe", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 7 and isInventoryFull(client) == false then addPlayerItem(client, "Sledgehammer") elseif weapon == 7 and isInventoryFull(client) == true then createObjectItem("Sledgehammer", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 8 and isInventoryFull(client) == false then addPlayerItem(client, "Raider Sword") elseif weapon == 8 and isInventoryFull(client) == true then createObjectItem("Raider Sword", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 3 and isInventoryFull(client) == false then addPlayerItem(client, "Nightstick") elseif weapon == 3 and isInventoryFull(client) == true then createObjectItem("Nightstick", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 4 and isInventoryFull(client) == false then addPlayerItem(client, "Knife") elseif weapon == 4 and isInventoryFull(client) == true then createObjectItem("Knife", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 6 and isInventoryFull(client) == false then addPlayerItem(client, "Crowbar") elseif weapon == 6 and isInventoryFull(client) == true then createObjectItem("Crowbar", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 9 and isInventoryFull(client) == false then addPlayerItem(client, "Chainsaw") elseif weapon == 9 and isInventoryFull(client) == true then createObjectItem("Chainsaw", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 5 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	used=true
	giveWeapon(client,5,1,true)
	outputInteractInfo("> Baseball Bat", client, 255,200,0, 3000)
	else

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
		end
	end

elseif(id=="Axe") and playerHasFreeEquipmentSlots then --weight: 2
setPedWeaponSlot(client,1)
	if weight > 4 and getPedWeapon (client,1) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,1)
	if (weapon == 4 and weight+2-1<=6) or (weapon ~= 4) or weight <=4 then
		if weapon == 5 and isInventoryFull(client) == false then addPlayerItem(client, "Baseball Bat") elseif weapon == 5 and isInventoryFull(client) == true then createObjectItem("Baseball Bat", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 7 and isInventoryFull(client) == false then addPlayerItem(client, "Sledgehammer") elseif weapon == 7 and isInventoryFull(client) == true then createObjectItem("Sledgehammer", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 8 and isInventoryFull(client) == false then addPlayerItem(client, "Raider Sword") elseif weapon == 8 and isInventoryFull(client) == true then createObjectItem("Raider Sword", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 3 and isInventoryFull(client) == false then addPlayerItem(client, "Nightstick") elseif weapon == 3 and isInventoryFull(client) == true then createObjectItem("Nightstick", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 4 and isInventoryFull(client) == false then addPlayerItem(client, "Knife") elseif weapon == 4 and isInventoryFull(client) == true then createObjectItem("Knife", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 6 and isInventoryFull(client) == false then addPlayerItem(client, "Crowbar") elseif weapon == 6 and isInventoryFull(client) == true then createObjectItem("Crowbar", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 9 and isInventoryFull(client) == false then addPlayerItem(client, "Chainsaw") elseif weapon == 9 and isInventoryFull(client) == true then createObjectItem("Chainsaw", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 2 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	used=true
	giveWeapon(client,2,1,true)
	outputInteractInfo("> Axe", client, 255,200,0, 3000)
	else

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
		end
	end

--SLOT 2-- PISTOLS

elseif(id=="Crossbow") and playerHasFreeEquipmentSlots then --weight: 3
setPedWeaponSlot(client,2)
	if weight > 3 and getPedWeapon (client,2) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,2)
	if ((weapon == 22  or weapon == 24) and weight+3-2<=6) or weight <= 3 then
		if weapon == 22 and isInventoryFull(client) == false then addPlayerItem(client, "Pistol") elseif weapon == 22 and isInventoryFull(client) == true then createObjectItem("Pistol", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 24 and isInventoryFull(client) == false then addPlayerItem(client, "Magnum Revolver") elseif weapon == 24 and isInventoryFull(client) == true then createObjectItem("Magnum Revolver", x, y, z-0.95, 97.3,120, 0)end
		if weapon == 23 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	used=true
		if crossbowammo >= 1 then giveWeapon(client,23,crossbowammo,true) else giveWeapon(client,23,1,true) ; setElementData(client,"crossbowammo",1) end
	setWeaponAmmo(client,weapon2,crossbowammo)
	outputInteractInfo("> Crossbow", client, 255,200,0, 3000)
	else

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
		end
	end

elseif(id=="Magnum Revolver") and playerHasFreeEquipmentSlots then --weight: 2
setPedWeaponSlot(client,2)
	if weight > 4 and getPedWeapon (client,2) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,2)
		if weapon == 22 and isInventoryFull(client) == false then addPlayerItem(client, "Pistol") elseif weapon == 22 and isInventoryFull(client) == true then createObjectItem("Pistol", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 23 and isInventoryFull(client) == false then addPlayerItem(client, "Crossbow") elseif weapon == 23 and isInventoryFull(client) == true then createObjectItem("Crossbow", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 24 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	used=true
	if taserammo >= 1 then giveWeapon(client,24,taserammo,true) else giveWeapon(client,22,1,true) ; setElementData(client,"taserammo",1) end
	setWeaponAmmo(client,weapon2,taserammo)
	outputInteractInfo("> Magnum Revolver", client, 255,200,0, 3000)
	end

elseif(id=="Pistol") and playerHasFreeEquipmentSlots then --weight: 2
setPedWeaponSlot(client,2)
	if weight > 4 and getPedWeapon (client,2) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,2)
		if weapon == 24 and isInventoryFull(client) == false then addPlayerItem(client, "Magnum Revolver") elseif weapon == 24 and isInventoryFull(client) == true then createObjectItem("Magnum Revolver", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 23 and isInventoryFull(client) == false then addPlayerItem(client, "Crossbow") elseif weapon == 23 and isInventoryFull(client) == true then createObjectItem("Crossbow", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 22 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	used=true
	if pistolammo >= 1 then giveWeapon(client,22,pistolammo,true) else giveWeapon(client,22,1,true) ; setElementData(client,"pistolammo",1) end
	setWeaponAmmo(client,weapon2,pistolammo)
	outputInteractInfo("> Pistol", client, 255,200,0, 3000)
	end

--SLOT 3-- SHOTGUNS

elseif(id=="Pump Shotgun") and playerHasFreeEquipmentSlots then --weight: 3
setPedWeaponSlot(client,3)
	if weight > 3 and getPedWeapon (client,3) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,3)
	if (weapon == 26 and weight+3-2<=6) or weight <= 3 or weapon ~= 26 then
		if weapon == 26 and isInventoryFull(client) == false then addPlayerItem(client, "Sawn-off Shotgun") elseif weapon == 26 and isInventoryFull(client) == true then createObjectItem("Sawn-off Shotgun", x, y, z-0.95, 97.3,120, 0) end 
		if weapon == 27 and isInventoryFull(client) == false then addPlayerItem(client, "Combat Shotgun") elseif weapon == 27 and isInventoryFull(client) == true then createObjectItem("Combat Shotgun", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 25 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	used=true
	if shotgunammo >= 1 then giveWeapon(client,25,shotgunammo,true) else giveWeapon(client,25,1,true) ; setElementData(client,"shotgunammo",1) end
	setWeaponAmmo(client,weapon3,shotgunammo)
	outputInteractInfo("> Pump Shotgun", client, 255,200,0, 3000)
	else

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	end
	end

elseif(id=="Combat Shotgun") and playerHasFreeEquipmentSlots then --weight: 3
setPedWeaponSlot(client,3)
	if weight > 3 and getPedWeapon (client,3) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,3)
	if (weapon == 26 and weight+3-2<=6) or weight <= 3 or weapon ~= 26 then
		if weapon == 25 and isInventoryFull(client) == false then addPlayerItem(client, "Pump Shotgun") elseif weapon == 25 and isInventoryFull(client) == true then createObjectItem("Pump Shotgun", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 26 and isInventoryFull(client) == false then addPlayerItem(client, "Sawn-off Shotgun") elseif weapon == 26 and isInventoryFull(client) == true then createObjectItem("Sawn-off Shotgun", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 27 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	used=true
	if shotgunammo >= 1 then giveWeapon(client,27,shotgunammo,true) else giveWeapon(client,27,1,true) ; setElementData(client,"shotgunammo",1) end
	setWeaponAmmo(client,weapon3,shotgunammo)
	outputInteractInfo("> Combat Shotgun", client, 255,200,0, 3000)
	else

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	end
	end

elseif(id=="Sawn-off Shotgun") and playerHasFreeEquipmentSlots then --weight: 2
setPedWeaponSlot(client,3)
	if weight > 4 and getPedWeapon (client,3) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,3)
		if weapon == 25 and isInventoryFull(client) == false then addPlayerItem(client, "Pump Shotgun") elseif weapon == 25 and isInventoryFull(client) == true then createObjectItem("Pump Shotgun", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 27 and isInventoryFull(client) == false then addPlayerItem(client, "Combat Shotgun") elseif weapon == 27 and isInventoryFull(client) == true then createObjectItem("Combat Shotgun", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 26 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	used=true
	if shotgunammo >= 1 then giveWeapon(client,26,shotgunammo,true) else giveWeapon(client,26,1,true) ; setElementData(client,"shotgunammo",1) end
	setWeaponAmmo(client,weapon3,shotgunammo)
	outputInteractInfo("> Sawn-off Shotgun", client, 255,200,0, 3000)
	end

--SLOT 4-- SMG

elseif(id=="Uzi") and playerHasFreeEquipmentSlots then --weight: 2
setPedWeaponSlot(client,4)
	if weight > 4 and getPedWeapon (client,4) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,4)
		if weapon == 29 and isInventoryFull(client) == false then addPlayerItem(client, "MP5") elseif weapon == 29 and isInventoryFull(client) == true then createObjectItem("MP5", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 32 and isInventoryFull(client) == false then addPlayerItem(client, "Vehicle Minigun") elseif weapon == 32 and isInventoryFull(client) == true then createObjectItem("Vehicle Minigun", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 28 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	used=true
	if smgammo >= 1 then giveWeapon(client,28,smgammo,true) else giveWeapon(client,28,1,true) ; setElementData(client,"smgammo",1) end
	setWeaponAmmo(client,weapon4,smgammo)
	outputInteractInfo("> Uzi", client, 255,200,0, 3000)
	end

elseif(id=="Vehicle Minigun") and playerHasFreeEquipmentSlots then --weight: 2
setPedWeaponSlot(client,4)
	if weight > 4 and getPedWeapon (client,4) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,4)
		if weapon == 29 and isInventoryFull(client) == false then addPlayerItem(client, "MP5") elseif weapon == 29 and isInventoryFull(client) == true then createObjectItem("MP5", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 28 and isInventoryFull(client) == false then addPlayerItem(client, "Uzi") elseif weapon == 28 and isInventoryFull(client) == true then createObjectItem("Uzi", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 32 then outputInteractInfo("[ already equipped! ]", client, 255,230,0) return end
	used=true
	if smgammo >= 1 then giveWeapon(client,32,smgammo,true) else giveWeapon(client,32,1,true) ; setElementData(client,"smgammo",1) end
	setWeaponAmmo(client,weapon4,smgammo)
	outputInteractInfo("> Auto Pistol", client, 255,200,0, 3000)
	end

elseif(id=="MP5")  and playerHasFreeEquipmentSlots then --weight: 3
setPedWeaponSlot(client,4)
	if weight > 3 and getPedWeapon (client,4) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,4)
	if ((weapon == 32  or weapon == 28) and weight+3-2<=6) or weight <= 3 then
		if weapon == 32 and isInventoryFull(client) == false then addPlayerItem(client, "Vehicle Minigun") elseif weapon == 32 and isInventoryFull(client) == true then createObjectItem("Vehicle Minigun", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 28 and isInventoryFull(client) == false then addPlayerItem(client, "Uzi") elseif weapon == 28 and isInventoryFull(client) == true then createObjectItem("Uzi", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 29 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	used=true
	if smgammo >= 1 then giveWeapon(client,29,smgammo,true) else giveWeapon(client,29,1,true) ; setElementData(client,"smgammo",1) end
	setWeaponAmmo(client,weapon4,smgammo)
	outputInteractInfo("> MP5", client, 255,200,0, 3000)
	else

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
		end
	end

--SLOT 5-- ASSAULT RIFLES

elseif(id=="M4") and playerHasFreeEquipmentSlots then --weight: 3 
setPedWeaponSlot(client,5)
	if weight > 3 and getPedWeapon (client,5) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	used=true
	local weapon = getPedWeapon(client,5)
		if weapon == 30 and isInventoryFull(client) == true then createObjectItem("AK 47", x, y, z-0.95, 97.3,120, 0) elseif weapon == 30 and isInventoryFull(client) == false then addPlayerItem(client, "AK 47") end
		if weapon == 31 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	if assaultammo >= 1 then giveWeapon(client,31,assaultammo,true) else giveWeapon(client,31,1,true) ; setElementData(client,"assaultammo",1) end
	setWeaponAmmo(client,weapon5,assaultammo)
	--reloadPedWeapon(client)
	outputInteractInfo("> M4", client, 255,200,0, 3000)
	end

elseif(id=="AK 47") and playerHasFreeEquipmentSlots then --weight: 3 
setPedWeaponSlot(client,5)
	if weight > 3 and getPedWeapon (client,5) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	used=true
	local weapon = getPedWeapon(client,5)
		if weapon == 31 and isInventoryFull(client) == true then createObjectItem("M4", x, y, z-0.95, 97.3,120, 0) elseif weapon == 31 and isInventoryFull(client) == false then addPlayerItem(client, "M4") end
		if weapon == 30 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	if assaultammo >= 1 then giveWeapon(client,30,assaultammo,true) else giveWeapon(client,30,1,true) ; setElementData(client,"assaultammo",1) end
	setWeaponAmmo(client,weapon5,assaultammo)
	outputInteractInfo("> AK 47", client, 255,200,0, 3000)
	end

--SLOT 6-- RIFLES

elseif(id=="Rifle") and playerHasFreeEquipmentSlots then --weight: 3 
setPedWeaponSlot(client,6)
	if weight > 3 and getPedWeapon (client,6) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,6)
		if weapon == 34 and isInventoryFull(client) == false then addPlayerItem(client, "Sniper Rifle") elseif weapon == 34 and isInventoryFull(client) == true then createObjectItem("Sniper Rifle", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 33 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	used=true
	if rifleammo >= 1 then giveWeapon(client,33,rifleammo,true) else giveWeapon(client,33,1,true) ; setElementData(client,"rifleammo",1) end
	setWeaponAmmo(client,weapon6,rifleammo)
	outputInteractInfo("> Rifle", client, 255,200,0, 3000)
	end

elseif(id=="Sniper Rifle") and playerHasFreeEquipmentSlots then --weight: 3 
setPedWeaponSlot(client,6)
	if weight > 3 and getPedWeapon (client,6) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,6)
		if weapon == 33 and isInventoryFull(client) == false then addPlayerItem(client, "Rifle") elseif weapon == 33 and isInventoryFull(client) == true then createObjectItem("Rifle", x, y, z-0.95, 97.3,120, 0) end 
		if weapon == 34 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	used=true
	if rifleammo >= 1 then giveWeapon(client,34,rifleammo,true) else giveWeapon(client,34,1,true) ; setElementData(client,"rifleammo",1) end
	setWeaponAmmo(client,weapon6,rifleammo)
	outputInteractInfo("> Sniper Rifle", client, 255,200,0, 3000)
	end

--SLOT 7-- HEAVY WEAPS            !!!!!!!!!!NEED AMMO applied; FLAMETHROWER SHOULD USE FUEL CANISTERS, SO NEEDS A SEPARATE AMMO SYSTEM. STINGER LAUNCHER WORKS LIKE THE RIFLE, BUT ONE SHOT ONLY, WITH A LONG RELOAD ANIMATION FORCED INBETWEEN. ROCKET LAUNCHER BECOMES L.A.W. LAUNCHER AND IS DISPOSABLE AFER USE; MAYBE I CAN NERF MINIGUN TO BE A SUITABLE LIGHT MACHINEGUN

elseif(id=="Flamethrower") and playerHasFreeEquipmentSlots then --weight: 4
setPedWeaponSlot(client,7)
	if weight > 2 and getPedWeapon (client,7) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,7)
		if weapon == 35 and isInventoryFull(client) == false then addPlayerItem(client, "Rocket Launcher") elseif weapon == 35 and isInventoryFull(client) == true then createObjectItem("Rocket Launcher", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 36 and isInventoryFull(client) == false then addPlayerItem(client, "Stinger Launcher") elseif weapon == 36 and isInventoryFull(client) == true then createObjectItem("Stinger Launcher", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 38 and isInventoryFull(client) == false then addPlayerItem(client, "Minigun") elseif weapon == 38 and isInventoryFull(client) == true then createObjectItem("Minigun", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 37 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	used=true
	giveWeapon(client,37,1,true)
	outputInteractInfo("> Flamethrower", client, 255,200,0, 3000)
	end

elseif(id=="Rocket Launcher") and playerHasFreeEquipmentSlots then --weight: 4 
setPedWeaponSlot(client,7)
	if weight > 2 and getPedWeapon (client,7) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,7)
		if weapon == 36 and isInventoryFull(client) == true then createObjectItem("Stinger Launcher", x, y, z-0.95, 97.3,120, 0) elseif weapon == 36 and isInventoryFull(client) == false then addPlayerItem(client, "Stinger Launcher") end 
		if weapon == 37 and isInventoryFull(client) == true then createObjectItem("Flamethrower", x, y, z-0.95, 97.3,120, 0) elseif weapon == 37 and isInventoryFull(client) == false then addPlayerItem(client, "Flamethrower") end
		if weapon == 38 and isInventoryFull(client) == true then createObjectItem("Minigun", x, y, z-0.95, 97.3,120, 0) elseif weapon == 38 and isInventoryFull(client) == false then addPlayerItem(client, "Minigun") end
		if weapon == 35 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	used=true
	giveWeapon(client,35,2,true)
	outputInteractInfo("> Rocket Launcher", client, 255,200,0, 3000)
	end

elseif(id=="Minigun") then --weight: 4
	local nearby_vehicle = getElementData(client, "veh_col_veh")
	local has_nearby_vehicle_mounted_mini
	if nearby_vehicle then  has_nearby_vehicle_mounted_mini = getElementData(nearby_vehicle, "mountedminigun_vehweapon_miniobj") end
	if nearby_vehicle and not has_nearby_vehicle_mounted_mini then
	triggerEvent("sv_createWeapon",client,"Minigun",nearby_vehicle)
	used=true
	elseif nearby_vehicle and has_nearby_vehicle_mounted_mini then
	outputInteractInfo("[ Minigun already mounted! ]", client, 255,100,0, 3000)
	else
	outputInteractInfo("[ No suitable vehicle! ]", client, 255,100,0, 3000)
	end

elseif(id=="Minigun Ammo") then 
	local nearby_vehicle = getElementData(client, "veh_col_veh")
	local nearby_vehicle_mounted_mini = getElementData(nearby_vehicle, "mountedminigun_vehweapon_miniBaseObj")
	local mini_ammo = getElementData(nearby_vehicle_mounted_mini, "mountedminigun_vehweapon_ammo") or 0
	if nearby_vehicle and nearby_vehicle_mounted_mini then
		setElementData(nearby_vehicle_mounted_mini,"mountedminigun_vehweapon_ammo",mini_ammo+500)
		outputInteractInfo("> +500 Minigun Ammo", client, 255,200,0, 3000)
		used=true 
	else
		outputInteractInfo("[ No minigun nearby! ]", client, 255,100,0, 3000)
	end

elseif(id=="Stinger Launcher") and playerHasFreeEquipmentSlots then --weight: 4
setPedWeaponSlot(client,7)
	if weight > 2 and getPedWeapon (client,7) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,7)
		if weapon == 35 and isInventoryFull(client) == false then addPlayerItem(client, "Rocket Launcher") elseif weapon == 35 and isInventoryFull(client) == true then createObjectItem("Rocket Launcher", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 37 and isInventoryFull(client) == false then addPlayerItem(client, "Flamethrower") elseif weapon == 37 and isInventoryFull(client) == true then createObjectItem("Flamethrower", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 38 and isInventoryFull(client) == false then addPlayerItem(client, "Minigun") elseif weapon == 38 and isInventoryFull(client) == true then createObjectItem("Minigun", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 36 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	used=true
	giveWeapon(client,36,1,true)
	outputInteractInfo("> Stinger Launcher", client, 255,200,0, 3000)
	end
	
	

--SLOT 8-- PROJECTILES

elseif(id=="Teargas") and playerHasFreeEquipmentSlots then --weight: 1
setPedWeaponSlot(client,8)
	if weight >= 6 and getPedWeapon (client,8) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,8)
	local thrwammo = getPedTotalAmmo(client,8)
	for i=1,thrwammo do
		if weapon == 39 and isInventoryFull(client) == false then addPlayerItem(client, "Satchel Charge") elseif weapon == 39 and isInventoryFull(client) == true then createObjectItem("Satchel Charge", x, y, z-0.95, 97.3,120, 0) outputInteractInfo("- Satchel Charge", client, 255, 92, 38, 3000) end
		if weapon == 16 and isInventoryFull(client) == false then addPlayerItem(client, "Grenade") elseif weapon == 16 and isInventoryFull(client) == true then createObjectItem("Grenade", x, y, z-0.95, 97.3,120, 0) outputInteractInfo("- Grenade", client, 255, 92, 38, 3000) end
		if weapon == 18 and isInventoryFull(client) == false then addPlayerItem(client, "Molotov") elseif weapon == 18 and isInventoryFull(client) == true then createObjectItem("Molotov", x, y, z-0.95, 97.3,120, 0) outputInteractInfo("- Molotov", client, 255, 92, 38, 3000) end
	end
	used=true
	giveWeapon(client,17,1,true)
	outputInteractInfo("> Teargas", client, 255,200,0, 3000)
	end

elseif(id=="Satchel Charge") and playerHasFreeEquipmentSlots then --weight: 1
setPedWeaponSlot(client,8)
	if weight >= 6 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,8)
	local thrwammo = getPedTotalAmmo(client,8)
	for i=1,thrwammo do 
		local thrwammo = getPedTotalAmmo(client,8)
		if weapon == 16 and isInventoryFull(client) == false then addPlayerItem(client, "Grenade") elseif weapon == 16 and isInventoryFull(client) == true then createObjectItem("Grenade", x, y, z-0.95, 97.3,120, 0) outputInteractInfo("- Grenade", client, 255, 92, 38, 3000) end
		if weapon == 18 and isInventoryFull(client) == false then addPlayerItem(client, "Molotov") elseif weapon == 18 and isInventoryFull(client) == true then createObjectItem("Molotov", x, y, z-0.95, 97.3,120, 0) outputInteractInfo("- Molotov", client, 255, 92, 38, 3000) end
		if weapon == 17 and isInventoryFull(client) == false then addPlayerItem(client, "Teargas") elseif weapon == 17 and isInventoryFull(client) == true then createObjectItem("Teargas", x, y, z-0.95, 97.3,120, 0) outputInteractInfo("- Teargas", client, 255, 92, 38, 3000)end
	end
	used=true
	giveWeapon(client,39,1,true)
	outputInteractInfo("> Satchel Charge", client, 255,200,0, 3000)
	end

elseif(id=="Grenade") and playerHasFreeEquipmentSlots then --weight: 0.5
setPedWeaponSlot(client,8)
	if weight >= 6  then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,8)
	local thrwammo = getPedTotalAmmo(client,8)
	for i=1,thrwammo do 
		local thrwammo = getPedTotalAmmo(client,8)
		if weapon == 39 and isInventoryFull(client) == false then addPlayerItem(client, "Satchel Charge") elseif weapon == 39 and isInventoryFull(client) == true then createObjectItem("Satchel Charge", x, y, z-0.95, 97.3,120, 0) outputInteractInfo("- Satchel Charge", client, 255, 92, 38, 3000) end
		if weapon == 18 and isInventoryFull(client) == false then addPlayerItem(client, "Molotov") elseif weapon == 18 and isInventoryFull(client) == true then createObjectItem("Molotov", x, y, z-0.95, 97.3,120, 0)  outputInteractInfo("- Molotov", client, 255, 92, 38, 3000) end
		if weapon == 17 and isInventoryFull(client) == false then addPlayerItem(client, "Teargas") elseif weapon == 17 and isInventoryFull(client) == true then createObjectItem("Teargas", x, y, z-0.95, 97.3,120, 0) outputInteractInfo("- Teargas", client, 255, 92, 38, 3000) end
		
	end
	used=true
	giveWeapon(client,16,1,true)
	outputInteractInfo("> Grenade", client, 255,200,0, 3000)
	end

elseif(id=="Molotov") and playerHasFreeEquipmentSlots then --weight: 0.5
setPedWeaponSlot(client,8)

	if weight >= 6 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,8)
	local thrwammo = getPedTotalAmmo(client,8)
	for i=1,thrwammo do
	local thrwammo = getPedTotalAmmo(client,8)
		if weapon == 39 and isInventoryFull(client) == false then addPlayerItem(client, "Satchel Charge") elseif weapon == 39 and isInventoryFull(client) == true then createObjectItem("Satchel Charge", x, y, z-0.95, 97.3,120, 0) outputInteractInfo("- Satchel Charge", client, 255, 92, 38, 3000)  end
		if weapon == 16 and isInventoryFull(client) == false then addPlayerItem(client, "Grenade") elseif weapon == 16 and isInventoryFull(client) == true then createObjectItem("Grenade", x, y, z-0.95, 97.3,120, 0) outputInteractInfo("- Grenade", client, 255, 92, 38, 3000) end
		if weapon == 17 and isInventoryFull(client) == false then addPlayerItem(client, "Teargas") elseif weapon == 17 and isInventoryFull(client) == true then createObjectItem("Teargas", x, y, z-0.95, 97.3,120, 0) outputInteractInfo("- Teargas", client, 255, 92, 38, 3000) end
		
	end
	used=true
	giveWeapon(client,18,1,true)
	outputInteractInfo("> Molotov", client, 255,200,0, 3000)
	end

--SLOT 9-- TOOLS/EQUIPMENT

elseif(id=="Binoculars") and playerHasFreeEquipmentSlots then --weight: 1
setPedWeaponSlot(client,9)
	if weight >= 6 and getPedWeapon (client,9) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
		if weapon == 41 and isInventoryFull(client) == false then addPlayerItem(client, "Spray Can") elseif weapon == 41 and isInventoryFull(client) == true then createObjectItem("Spray Can", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 42 and isInventoryFull(client) == false then addPlayerItem(client, "Agent Pale") elseif weapon == 42 and isInventoryFull(client) == true then createObjectItem("Agent Pale", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 43 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	used=true
	giveWeapon(client,43,1,true)
	outputInteractInfo("> Binoculars", client, 255,200,0, 3000)
	end

elseif(id=="Spray Can") and playerHasFreeEquipmentSlots then --weight: 1
setPedWeaponSlot(client,9)
	if weight >= 6 and getPedWeapon (client,9) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
		if weapon == 43 and isInventoryFull(client) == false then addPlayerItem(client, "Binoculars") elseif weapon == 43 and isInventoryFull(client) == true then createObjectItem("Binoculars", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 42 and isInventoryFull(client) == false then addPlayerItem(client, "Agent Pale") elseif weapon == 42 and isInventoryFull(client) == true then createObjectItem("Agent Pale", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 41 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	used=true
	giveWeapon(client,41,301,true)
	outputInteractInfo("> Spray Can", client, 255,200,0, 3000)
	end
	
elseif(id=="Agent Pale") and playerHasFreeEquipmentSlots then --weight: 1
setPedWeaponSlot(client,9)
	if weight > 4 and getPedWeapon (client,9) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
		if weapon == 43 and isInventoryFull(client) == false then addPlayerItem(client, "Binoculars") elseif weapon == 43 and isInventoryFull(client) == true then createObjectItem("Binoculars", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 41 and isInventoryFull(client) == false then addPlayerItem(client, "Spray Can") elseif weapon == 41 and isInventoryFull(client) == true then createObjectItem("Spray Can", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 42 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	used=true
	giveWeapon(client,42,501,true)
	outputInteractInfo("> Agent Pale", client, 255,200,0, 3000)
	end

--SLOT 10-- MELEE 2

elseif(id=="Machete") and playerHasFreeEquipmentSlots then --weight: 2
setPedWeaponSlot(client,10)
	if weight > 4 and getPedWeapon (client,10) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,10)
	if weapon > 11 or weapon == 10 or weight <= 4 then 
		if weapon == 11 and isInventoryFull(client) == false then addPlayerItem(client, "Kitchen Knife") elseif weapon == 11 and isInventoryFull(client) == true then createObjectItem("Kitchen Knife", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 12 and isInventoryFull(client) == false then addPlayerItem(client, "Meatcleaver") elseif weapon == 12 and isInventoryFull(client) == true then createObjectItem("Meatcleaver", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 14 and isInventoryFull(client) == false then addPlayerItem(client, "Broken Bottle") elseif weapon == 14 and isInventoryFull(client) == true then createObjectItem("Broken Bottle", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 15 and isInventoryFull(client) == false then addPlayerItem(client, "Nail Bat") elseif weapon == 15 and isInventoryFull(client) == true then createObjectItem("Nail Bat", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 10 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	used=true
	giveWeapon(client,10,1,true)
	outputInteractInfo("> Machete", client, 255,200,0, 3000)
	else

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
		end
	end

elseif(id=="Kitchen Knife") and playerHasFreeEquipmentSlots then --weight: 1
setPedWeaponSlot(client,10)
	if weight >= 6 and getPedWeapon (client,10) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,10)
		if weapon == 10 and isInventoryFull(client) == false then addPlayerItem(client, "Machete") elseif weapon == 10 and isInventoryFull(client) == true then createObjectItem("Machete", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 12 and isInventoryFull(client) == false then addPlayerItem(client, "Meatcleaver") elseif weapon == 12 and isInventoryFull(client) == true then createObjectItem("Meatcleaver", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 14 and isInventoryFull(client) == false then addPlayerItem(client, "Broken Bottle") elseif weapon == 14 and isInventoryFull(client) == true then createObjectItem("Broken Bottle", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 15 and isInventoryFull(client) == false then addPlayerItem(client, "Nail Bat") elseif weapon == 15 and isInventoryFull(client) == true then createObjectItem("Nail Bat", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 11 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	used=true
	giveWeapon(client,11,1,true)
	outputInteractInfo("> Kitchen Knife", client, 255,200,0, 3000)
	end

elseif(id=="Meatcleaver") and playerHasFreeEquipmentSlots then --weight: 2
setPedWeaponSlot(client,10)
	if weight > 5 and getPedWeapon (client,10) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,10)
	if weapon > 11 or weapon == 10 or weight <= 4 then 
		if weapon == 10 and isInventoryFull(client) == false then addPlayerItem(client, "Machete") elseif weapon == 10 and isInventoryFull(client) == true then createObjectItem("Machete", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 11 and isInventoryFull(client) == false then addPlayerItem(client, "Kitchen Knife") elseif weapon == 11 and isInventoryFull(client) == true then createObjectItem("Kitchen Knife", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 14 and isInventoryFull(client) == false then addPlayerItem(client, "Broken Bottle") elseif weapon == 14 and isInventoryFull(client) == true then createObjectItem("Broken Bottle", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 15 and isInventoryFull(client) == false then addPlayerItem(client, "Nail Bat") elseif weapon == 15 and isInventoryFull(client) == true then createObjectItem("Nail Bat", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 12 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	used=true
	giveWeapon(client,12,1,true)
	outputInteractInfo("> Meatcleaver", client, 255,200,0, 3000)
	else

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
		end
	end

elseif(id=="Broken Bottle") and playerHasFreeEquipmentSlots then --weight: 2
setPedWeaponSlot(client,10)
	if weight >= 5.5 and getPedWeapon (client,10) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,10)
	if weapon > 11 or weapon == 10 or weight <= 5.5 then 
		if weapon == 10 and isInventoryFull(client) == false then addPlayerItem(client, "Machete") elseif weapon == 10 and isInventoryFull(client) == true then createObjectItem("Machete", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 11 and isInventoryFull(client) == false then addPlayerItem(client, "Kitchen Knife") elseif weapon == 11 and isInventoryFull(client) == true then createObjectItem("Kitchen Knife", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 12 and isInventoryFull(client) == false then addPlayerItem(client, "Meatcleaver") elseif weapon == 12 and isInventoryFull(client) == true then createObjectItem("Meatcleaver", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 15 and isInventoryFull(client) == false then addPlayerItem(client, "Nail Bat") elseif weapon == 15 and isInventoryFull(client) == true then createObjectItem("Nail Bat", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 14 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	used=true
	giveWeapon(client,14,1,true)
	outputInteractInfo("> Broken Bottle", client, 255,200,0, 3000)
	else

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
		end
	end

elseif(id=="Nail Bat") and playerHasFreeEquipmentSlots then --weight: 2
setPedWeaponSlot(client,10)
	if weight > 4 and getPedWeapon (client,10) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	local weapon = getPedWeapon(client,10)
	if weapon > 11 or weapon == 10 or weight <= 4 then 
		if weapon == 10 and isInventoryFull(client) == false then addPlayerItem(client, "Machete") elseif weapon == 10 and isInventoryFull(client) == true then createObjectItem("Machete", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 11 and isInventoryFull(client) == false then addPlayerItem(client, "Kitchen Knife") elseif weapon == 11 and isInventoryFull(client) == true then createObjectItem("Kitchen Knife", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 12 and isInventoryFull(client) == false then addPlayerItem(client, "Meatcleaver") elseif weapon == 12 and isInventoryFull(client) == true then createObjectItem("Meatcleaver", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 14 and isInventoryFull(client) == false then addPlayerItem(client, "Broken Bottle") elseif weapon == 14 and isInventoryFull(client) == true then createObjectItem("Broken Bottle", x, y, z-0.95, 97.3,120, 0) end
		if weapon == 15 then outputInteractInfo("[ already equipped! ]", client, 255,230,0)  return end
	used=true
	giveWeapon(client,15,1,true)
	outputInteractInfo("> Nail Bat", client, 255,200,0, 3000)
	else

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
		end
	end

elseif (id=="Body Armor") then
    if getPedArmor(client)>=70 then 
    outputInteractInfo("[ already equipped! ]", client, 255,200,0, 3000) 
    else
    used=true
    setPedArmor(client,100) end
    outputInteractInfo("> Body Armor", client, 255,200,0, 3000)
  

elseif(id=="Backpack") and playerHasFreeEquipmentSlots then
   if getElementData(client,"backpackequipped") == true then
   outputInteractInfo("[ already equipped! ]", client, 255,230,0) 
   else
   used=true
   setElementData(client,"backpackequipped", true)
   outputInteractInfo("> Backpack", client, 255,200,0, 3000)
	end
	
elseif(id=="Hazmat Suit") and playerHasFreeEquipmentSlots then
   if getElementData(client,"hazmatequipped") == true then
   outputInteractInfo("[ already equipped! ]", client, 255,230,0) 
   elseif getElementData(client,"camoequipped") == true then
	   if isInventoryFull(client) == false then 
	   addPlayerItem(client, "Camouflage Suit") 
	   setAccountData(acc,"camoequipped",false,true)
		
	   elseif isInventoryFull(client) == true then 
	   createObjectItem("Camouflage Suit", x, y, z-0.95, 97.3,120, 0) 
	   setAccountData(acc,"camoequipped",false,true)
	   end
		used=true
		setElementData(client,"camoequipped", false,true)
		setElementData(client,"hazmatequipped", true,true)
		outputInteractInfo("> Hazmat Suit", client, 255,200,0, 3000)
		setAccountData(acc,"hazmatequipped",true,true)
   else
   used=true
   setElementData(client,"hazmatequipped", true,true)
   outputInteractInfo("> Hazmat Suit", client, 255,200,0, 3000)
   setAccountData(acc,"hazmatequipped",true,true)
	end
	
elseif(id=="Camouflage Suit") and playerHasFreeEquipmentSlots then
   if getElementData(client,"camoequipped") == true then
   outputInteractInfo("[ already equipped! ]", client, 255,230,0) 
   elseif getElementData(client,"hazmatequipped") == true then
	   if isInventoryFull(client) == false then 
	   addPlayerItem(client, "Hazmat Suit") 
	   setAccountData(acc,"hazmatequipped",false,true)
	   elseif isInventoryFull(client) == true then 
	   createObjectItem("Hazmat Suit", x, y, z-0.95, 97.3,120, 0) 
	   setAccountData(acc,"hazmatequipped",false,true)
	   end
		used=true
		setElementData(client,"hazmatequipped", false,true)
		setElementData(client,"camoequipped", true,true)
		setAccountData(acc,"camoequipped",true,true)
		outputInteractInfo("> Camouflage Suit", client, 255,200,0, 3000)
   else
   used=true
   setAccountData(acc,"camoequipped",true,true)
   setElementData(client,"camoequipped", true,true)
   outputInteractInfo("> Camouflage Suit", client, 255,200,0, 3000)
	end

elseif (id=="Meat Can") or (id=="Fish Can") then
used=true
setPedWeaponSlot(client,0)
    setPedAnimation( client, "FOOD", "EAT_Burger",-1,false,false,true,false)
    if(health>=90) then
    setElementHealth(client,100)
    triggerClientEvent (client, "eatFood", client)
	
	setTimer(function() outputStatusInfo("+10 hp", player, 0,255,0) end, 500,1)
    outputInteractInfo("<> "..id, client, 255,200,0)
    else
    setElementHealth(client,health+10)
    triggerClientEvent (client, "eatFood", client)
    outputInteractInfo("<> "..id, client, 255,200,0)
    setTimer(function() outputStatusInfo("+10 hp", player, 0,255,0) end, 500,1)
    end
	triggerClientEvent(client, "sleep:drawDXProgress", client, 3000,3000)
	setTimer(triggerClientEvent,3000,1,client, "sleep:stopDXProgress", client)
	
elseif (id=="Soup Can") then
used=true
setPedWeaponSlot(client,0)
    setPedAnimation( client, "VENDING", "VEND_Drink2_P",-1,false,false,true,false)
    if(health>=85) then
    setElementHealth(client,100)
    triggerClientEvent (client, "eatFood", client)
	triggerClientEvent (client, "drinkWater", client)
	triggerClientEvent (client, "drinkRestoreStamina", client,500)
	
	setTimer(function() outputStatusInfo("+15 hp", player, 0,255,0) end, 500,1)
    outputInteractInfo("<> "..id, client, 255,200,0)
    else
    setElementHealth(client,health+15)
    triggerClientEvent (client, "eatFood", client)
	triggerClientEvent (client, "drinkWater", client)
	triggerClientEvent (client, "drinkRestoreStamina", client,500)
    outputInteractInfo("<> "..id, client, 255,200,0)
    setTimer(function() outputStatusInfo("+15 hp", player, 0,255,0) end, 500,1)
    end
	triggerClientEvent(client, "sleep:drawDXProgress", client, 3000,3000)
	setTimer(triggerClientEvent,3000,1,client, "sleep:stopDXProgress", client)
	

elseif(id=="Water Bottle")then
used=true
setPedWeaponSlot(client,0)
setPedAnimation( client, "VENDING", "VEND_Drink2_P",-1,false,false,true,false)
    if(health>=95)then
    setElementHealth(client,100)
    triggerClientEvent (client, "drinkWater", client)
    triggerClientEvent (client, "drinkRestoreStamina", client,500)
    setTimer(function() outputStatusInfo("+500 stamina", player, 0,190,255) end, 500,1)
	outputInteractInfo("<> "..id, client, 255,200,0)
	setTimer ( function() createObjectItem("Empty Bottle", x, y, z-0.95, 97.3,120, 0); outputInteractInfo("- Empty Bottle", player, 255, 92, 38) end, 3200, 1)
    else
    setElementHealth(client,health+5)
    triggerClientEvent (client, "drinkWater", client)
    triggerClientEvent (client, "drinkRestoreStamina", client,500)
    outputInteractInfo("<> "..id, client, 255,200,0)
    setTimer(function() outputStatusInfo("+500 stamina", player, 0,190,255) end, 500,1)
	setTimer ( function() createObjectItem("Empty Bottle", x, y, z-0.95, 97.3,120, 0); outputInteractInfo("- Empty Bottle", player, 255, 92, 38, 3000) end, 3200, 1)
	end
    setTimer(function() outputStatusInfo("+5 hp", player, 0,255,0) end, 500,1)
	triggerClientEvent(client, "sleep:drawDXProgress", client, 3000,3000)
	setTimer(triggerClientEvent,3000,1,client, "sleep:stopDXProgress", client)


elseif(id=="Water Canister")then
used=true
setPedWeaponSlot(client,0)
setPedAnimation( client, "VENDING", "VEND_Drink2_P",-1,false,false,true,false)
    if(health>=95)then
    setElementHealth(client,100)
    triggerClientEvent (client, "drinkWater", client,"canister")
    triggerClientEvent (client, "drinkRestoreStamina", client,1000)
    setTimer(function() outputStatusInfo("+1000 stamina", player, 0,190,255) end, 500,1)  
	outputInteractInfo("<> "..id, client, 255,200,0)
	setTimer ( function() createObjectItem("Empty Canister", x, y, z-0.95, 97.3,120, 0); outputInteractInfo("- Empty Canister", player, 255, 92, 38) end, 3200, 1)
    else
    setElementHealth(client,health+5)
    triggerClientEvent (client, "drinkWater", client,"canister")
    triggerClientEvent (client, "drinkRestoreStamina", client,1000)
    outputInteractInfo("<> "..id, client, 255,200,0)
    setTimer(function() outputStatusInfo("+1000 stamina", player, 0,190,255) end, 500,1)  
	setTimer ( function() createObjectItem("Empty Canister", x, y, z-0.95, 97.3,120, 0); outputInteractInfo("- Empty Canister", player, 255, 92, 38) end, 3200, 1)
	end
	setTimer(function() outputStatusInfo("+5 hp", player, 0,255,0) end, 500,1)
	triggerClientEvent(client, "sleep:drawDXProgress", client, 3000,3000)
	setTimer(triggerClientEvent,3000,1,client, "sleep:stopDXProgress", client)


elseif(id=="Dirty Water")then
used=true
setPedWeaponSlot(client,0)
setPedAnimation( client, "VENDING", "VEND_Drink2_P",-1,false,false,true,false)
    if(health<=5)then
    setElementHealth(client,1)
    triggerClientEvent (client, "drinkWater", client)
	outputInteractInfo("<> "..id, client, 255,200,0)
	setTimer ( function() createObjectItem("Empty Bottle", x, y, z-0.95, 97.3,120, 0); outputInteractInfo("- Empty Bottle", client, 255, 92, 38) end, 3200, 1)
    else
    setElementHealth(client,health-5)
    triggerClientEvent (client, "drinkWater", client)
    outputInteractInfo("<> "..id, client, 255,200,0)
	setTimer ( function() createObjectItem("Empty Bottle", x, y, z-0.95, 97.3,120, 0); outputInteractInfo("- Empty Bottle", client, 255, 92, 38) end, 3200, 1)
	end
	setTimer(function() outputStatusInfo("-5 hp", player, 200,0,0) end, 500,1)
	triggerClientEvent(client, "sleep:drawDXProgress", client, 3000,3000)
	setTimer(triggerClientEvent,3000,1,client, "sleep:stopDXProgress", client)

	
elseif(id=="Alcohol Bottle")then
used=true
setPedWeaponSlot(client,0)
setPedAnimation( client, "VENDING", "VEND_Drink2_P",-1,false,false,true,false)
    if(health>=2)then
    setElementHealth(client,health-1)
	outputStatusInfo("-1 hp", client, 250,100,0)
    triggerClientEvent (client, "Drunk", client)
	triggerClientEvent (client, "AlcoholDrainsStamina", client)
    outputInteractInfo("<> "..id, client, 255,200,0)
	setTimer(function() outputStatusInfo("-1000 stamina", player, 250,100,0) end, 500,1)  
	setTimer ( function() createObjectItem("Empty Bottle", x, y, z-0.95, 97.3,120, 0); outputInteractInfo("- Empty Bottle", player, 255, 92, 38) end, 3300, 1)
    else
    triggerClientEvent (client, "Drunk", client)
    triggerClientEvent (client, "AlcoholDrainsStamina", client)
    outputInteractInfo("<> "..id, client, 255,200,0)
    setTimer ( function() createObjectItem("Empty Bottle", x, y, z-0.95, 97.3,120, 0); outputInteractInfo("- Empty Bottle", player, 255, 92, 38) end, 3300, 1)
	end
	setTimer(function() outputStatusInfo("-1 hp", player, 200,0,0) end, 500,1)
	triggerClientEvent(client, "sleep:drawDXProgress", client, 3000,3000)
	setTimer(triggerClientEvent,3000,1,client, "sleep:stopDXProgress", client)


elseif(id=="Medikit") then --USE
setPedWeaponSlot(client,0)
    if(health<100) then
    setElementHealth(client,100)
    used=true
    setPedAnimation( client, "BOMBER", "BOM_Plant",5000,false,false,false,false) 
    outputStatusInfo("[ healing... ]", client, 0,240,0)
    outputInteractInfo("> Medikit", client, 255,200,0)
	triggerClientEvent(client, "sleep:drawDXProgress", client, 4000,4000)
	setTimer(triggerClientEvent,4000,1,client, "sleep:stopDXProgress", client)
	local xp = getPlayerExp(client)
	setPlayerExp(client,xp+5)
	outputStatusInfo("+5 xp",client, 240,240,240 )
    else
    outputInteractInfo("[ full health! ]", client, 255, 255, 255)
    end
    
elseif(id=="Painkillers")then

setPedWeaponSlot(client,0)
    if (health == 100) then
    outputInteractInfo("[ healthy! ]", client, 255, 255, 255)
    used=true
	triggerClientEvent(client,"PainkillersTaken",client)
    end
    if(health>=90) and (health<100) then
    setElementHealth(client,100)
    outputStatusInfo("+10 hp", client, 0,240,0)
    outputInteractInfo("<> Painkillers", client, 255,200,0)
    used=true
    setPedAnimation( client, "VENDING", "VEND_Drink2_P",-1,false,false,true,false)
	triggerClientEvent(client,"PainkillersTaken",client)
    else
    setElementHealth(client,health+10)
	outputStatusInfo("+10 hp", client, 0,240,0)
	outputInteractInfo("<> Painkillers", client, 255,200,0)
    setPedAnimation( client, "VENDING", "VEND_Drink2_P",-1,false,false,true,false)
    used=true
	triggerClientEvent(client,"PainkillersTaken",client)
    end
	triggerClientEvent(client, "sleep:drawDXProgress", client, 4000,4000)
	setTimer(triggerClientEvent,4000,1,client, "sleep:stopDXProgress", client)

        
elseif(id=="Splint")then

setPedWeaponSlot(client,0)
local fractured
if getElementData(client,"minorfracture")== true or getElementData(client,"majorfracture")== true then fractured = true else fractured = false end
   
   if not fractured  then
    outputInteractInfo("[ no fracture! ]", client, 255, 255, 255)
    else
    setElementData(client,"minorfracture",false)
    setElementData(client,"majorfracture",false)
    outputStatusInfo("[ reducing fracture... ]", client, 255,255,255)
	outputInteractInfo("<> "..id, client, 255,200,0)
	setPedAnimation( client, "BOMBER", "BOM_Plant",5000,false,false,false,false) 
	setTimer(outputInteractInfo,4000,1,"Fracture reduced", client, 0,240,0)
	triggerClientEvent(client, "sleep:drawDXProgress", client, 5000,5000)
	setTimer(triggerClientEvent,5000,1,client, "sleep:stopDXProgress", client)
    used=true
    end

elseif id == "Road Flare" then
		setPedWeaponSlot(client,0)
		setPedAnimation( client, "BOMBER", "BOM_Plant",1000,false,false,false,false)
		outputStatusInfo("[ deploying... ]", client, 255,255,255)
		outputInteractInfo("<> "..id, client, 255,200,0)
		triggerClientEvent(client, "sleep:drawDXProgress", client, 1000,1000)
		setTimer(triggerClientEvent,1000,1,client, "sleep:stopDXProgress", client)
		local x,y,z = getElementPosition(client)
		local object = createObject(354,x,y,z-2.5)
		setTimer(destroyElement,300000,1,object)
		used=true

elseif id == "Adrenaline" then 
		setPedWeaponSlot(client,0)
		setPedAnimation( client, "VENDING", "VEND_Drink2_P",-1,false,false,true,false)
	triggerClientEvent(client, "sleep:drawDXProgress", client, 4000,4000)
	setTimer(triggerClientEvent,4000,1,client, "sleep:stopDXProgress", client)
	outputInteractInfo("<> "..id, client, 255,200,0)
		triggerClientEvent(client,"AdrenalineUsed",client)
		used=true
		
elseif id == "ZomboKleen" then
		setPedWeaponSlot(client,0)
		setPedAnimation( client, "VENDING", "VEND_Drink2_P",-1,false,false,true,false)
		outputInteractInfo("<> "..id, client, 255,200,0)
		local randcurechance = math.random(0,10)
		local health = getElementHealth(client)
		if randcurechance >5 then 
			if getElementData(client,"infection") ~= "uninfected" then
			setElementData(client,"infection","uninfected",true)
			outputStatusInfo("[ ZomboKleen: infection cured! ]", client, 0,240,0)
			triggerClientEvent(client,"clearInfectionEffects",client)
			end
		elseif randcurechance == 0 then 
				if health <= 10 then 
						killPed(client)
				else 
						setElementHealth(client,health-10)
				end
				outputStatusInfo("[ ZomboKleen: -10 hp ]", client, 255,0,0)
				local newrand = math.random(1,2)
				if newrand == 1 then
					if getElementData(client,"infection") ~= "uninfected" then
						setElementData(client,"infection","uninfected",true)
						outputStatusInfo("[ ZomboKleen: infection cured! ]", client, 0,240,0)
						triggerClientEvent(client,"clearInfectionEffects",client)
					else
						outputStatusInfo("[ ZomboKleen: no effect! ]", client, 255,255,255)
					end
				else
					outputStatusInfo("[ ZomboKleen: no effect! ]", client, 255,255,255)
				end
		
		elseif randcurechance <=5 and randcurechance ~= 0 then 
			outputStatusInfo("[ ZomboKleen: no effect! ]", client, 255,255,255)
		end
	triggerClientEvent(client, "sleep:drawDXProgress", client, 4000,4000)
	setTimer(triggerClientEvent,4000,1,client, "sleep:stopDXProgress", client)
		used=true
	
			

elseif(id=="Raw Meat")then

setPedWeaponSlot(client,0)
    setPedAnimation( client, "FOOD", "EAT_Burger",-1,false,false,true,false)
    if(health==1) then
    triggerClientEvent (client, "eatFood", client)
    outputInteractInfo("<> Raw Meat", client, 255,200,0)
	outputStatusInfo("-1 hp", client, 200,0,0)
	used=true
    else
    setElementHealth(client,health-1)
    triggerClientEvent (client, "eatFood", client)
    outputInteractInfo("<> Raw Meat", client, 255,200,0)
	outputStatusInfo("-1 hp", client, 200,0,0)
	used=true
    end
triggerClientEvent(client, "sleep:drawDXProgress", client, 4000,4000)
setTimer(triggerClientEvent,4000,1,client, "sleep:stopDXProgress", client)
	


elseif(id=="Raw Human Meat")then

setPedWeaponSlot(client,0)
    setPedAnimation( client, "FOOD", "EAT_Burger",-1,false,false,true,false)
    if(health==1) then
    triggerClientEvent (client, "eatFood", client)
    outputInteractInfo("<> Raw Human Meat", client, 255,200,0)
	outputStatusInfo("-1 hp", client, 200,0,0)
	used=true
    else
    setElementHealth(client,health-1)
    triggerClientEvent (client, "eatFood", client)
    outputInteractInfo("<> Raw Human Meat", client, 255,200,0)
	outputStatusInfo("-1 hp", client, 200,0,0)
	used=true
    end
	
	local teamcheck = getPlayerTeam(client)
	if teamcheck == Raiders then 
		 
	else
		local acc = getPlayerAccount(client)
		setPlayerTeam(client,Raiders)
					local faction = getTeamName(getPlayerTeam(client))
					local image = faction and ":dystopia_core/images/"..string.lower(faction).."_logo.png" 
					setElementData(client, "    ", image and {type = "image", src =  image, height = 20, width = 20} or " ",true)
		setTimer(changeSkinOnFactionChange,5000,1,client,Raiders)
		setTimer(outputInteractInfo,5000,1,"> Raiders",client,255,200,0)
		setAccountData(acc,"team", "Raiders")
	end
triggerClientEvent(client, "sleep:drawDXProgress", client, 4000,4000)
setTimer(triggerClientEvent,4000,1,client, "sleep:stopDXProgress", client)	
	
elseif(id=="Roasted Meat")then

setPedWeaponSlot(client,0)
    setPedAnimation( client, "FOOD", "EAT_Burger",-1,false,false,true,false)
    if(health>=80) then
    setElementHealth(client,100) 
    triggerClientEvent (client, "eatFood", client)
    outputInteractInfo("<> Roasted Meat", client, 255,200,0)
	outputStatusInfo("+20 hp", client, 0,200,0)
	used=true
    else
    setElementHealth(client,health+20)
    triggerClientEvent (client, "eatFood", client)
    outputInteractInfo("<> Roasted Meat", client, 255,200,0)
	outputStatusInfo("+20 hp", client, 0,200,0)
	used=true
    end
triggerClientEvent(client, "sleep:drawDXProgress", client, 4000,4000)
setTimer(triggerClientEvent,4000,1,client, "sleep:stopDXProgress", client)

elseif(id=="Roasted Human Meat")then

setPedWeaponSlot(client,0)
    setPedAnimation( client, "FOOD", "EAT_Burger",-1,false,false,true,false)
    if(health>=80) then
    setElementHealth(client,100) 
    triggerClientEvent (client, "eatFood", client)
    outputInteractInfo("<> Roasted Human Meat", client, 255,200,0)
	outputStatusInfo("+20 hp", client, 200,0,0)
	used=true
    else
    setElementHealth(client,health+20)
    triggerClientEvent (client, "eatFood", client)
    outputInteractInfo("<> Roasted Human Meat", client, 255,200,0)
	outputStatusInfo("+20 hp", client, 200,0,0)
	used=true
    end
local teamcheck = getPlayerTeam(client)
	if teamcheck == Raiders then 
		 
	else
		local acc = getPlayerAccount(client)
		setPlayerTeam(client,Raiders)
					local faction = getTeamName(getPlayerTeam(client))
					local image = faction and ":dystopia_core/images/"..string.lower(faction).."_logo.png" 
					setElementData(client, "    ", image and {type = "image", src =  image, height = 20, width = 20} or " ",true)
		setTimer(changeSkinOnFactionChange,5000,1,client,Raiders)
		setTimer(outputInteractInfo,5000,1,"> Raiders",client,255,200,0)
		setAccountData(acc,"team", "Raiders")
	end
triggerClientEvent(client, "sleep:drawDXProgress", client, 4000,4000)
setTimer(triggerClientEvent,4000,1,client, "sleep:stopDXProgress", client)	
	
elseif(id=="Toolbox")then --USE
setPedWeaponSlot(client,0)
    triggerClientEvent (client, "RepairingVehicle", client) -- in vehicles_client script
	triggerClientEvent (client, "ScavengingVehicle", client)

elseif(id=="Empty Bottle")then
	
	local x,y,z = getElementPosition(client)
	
	if isElementInWater(client) then
		setPedWeaponSlot(client,0)
		used = true
		setPedAnimation ( client, "INT_HOUSE", "wash_up", 2500, true, false, false, false)
		setTimer(createwateritsamiracle, 3000, 1, "Dirty Water", client)
		triggerClientEvent(client, "sleep:drawDXProgress", client, 2500,2500)
		setTimer(triggerClientEvent,2500,1,client, "sleep:stopDXProgress", client)	
		local xp = getPlayerExp(client)
		setPlayerExp(client,xp+1)
		outputStatusInfo("+1 xp",client, 240,240,240 )
	
	elseif z<0.9 then
		setPedWeaponSlot(client,0)
		used = true
		setPedAnimation ( client, "BOMBER","BOM_Plant", 2500, true, false, false, false)
		setTimer(createwateritsamiracle, 3000, 1, "Dirty Water", client)
				triggerClientEvent(client, "sleep:drawDXProgress", client, 2500,2500)
		setTimer(triggerClientEvent,2500,1,client, "sleep:stopDXProgress", client)	
		local xp = getPlayerExp(client)
		setPlayerExp(client,xp+1)
		outputStatusInfo("+1 xp",client, 240,240,240 )
		
	else
		triggerClientEvent (client, "OpenCraft", client)
		outputTopBar("You need to be in a body of water to refill!", client, 255,255,255)
	end

elseif id=="Lighter" then
setPedWeaponSlot(client,0)
triggerEvent ("onMakeAFire", client)

elseif id=="Plastic Foil" then
triggerClientEvent(client,"OpenCraft",client)
		
elseif (id=="Empty Canister") then
	
	if getElementData(client,"insideFuelCol") ~= nil then
		local barrel = getElementData(client,"insideFuelCol")
		local fuelQuant = getElementData(barrel,"fuel")
		
		if fuelQuant >= 1 then
			setPedWeaponSlot(client,0)
			used = true
			local x,y,z = getElementPosition( barrel )
			local px, py, pz = getElementPosition( client )
			local pedangle = ( 360 - math.deg ( math.atan2 ( ( x - px ), ( y - py ) ) ) ) % 360
			setPedRotation( client, pedangle )
			setPedAnimation ( client, "INT_HOUSE", "wash_up", 4000, true, false, false, false)
			setTimer(createwateritsamiracle, 4500, 1, "Fuel Canister", client)
			setElementData(barrel,"fuel", fuelQuant-1 )
			local xp = getPlayerExp(client)
			setPlayerExp(client,xp+1)
			outputStatusInfo("+1 xp",client, 240,240,240 )
		else
			outputInteractInfo("[ empty ]", client, 240,240,240)
		end
	else
		return
	end
 
elseif (id=="Fuel Canister") then
	local vehicle
	local fuelQuant
	local refueltime = 4000
		
	if getElementData(client, "veh_col_veh") then 
		vehicle =  getElementData(client, "veh_col_veh")
		fuelQuant = getCarFuel(vehicle)
	end
	
	if vehicle then
	
	local model = getElementModel(vehicle)
	local maxFuel = carFuelData[model] or carFuelData[0];
	
		if getElementHealth(vehicle) <= 0 then outputDebugString("car is blown") return end
	
		if fuelQuant < maxFuel then
		
			local x,y,z = getElementPosition( vehicle )
			local px, py, pz = getElementPosition( client )
			local pedangle = ( 360 - math.deg ( math.atan2 ( ( x - px ), ( y - py ) ) ) ) % 360
			setPedAnimation ( client, "PED", "WALK_player", 1000, false, true, true) --make him walk towards it for a second to make sure it is right next to the vehicle
			
			setTimer( function (ped,interval) 
				setPedAnimation ( ped, "INT_HOUSE", "wash_up", interval, true, false, false, false) 
				outputStatusInfo("[ refueling... ]", ped, 255,255,255)
			end, 1000, 1, client, refueltime)
			
			setTimer( function (msg_recipient)
		
						if fuelQuant >= maxFuel - 20 then 
							addCarFuel(vehicle, (maxFuel - fuelQuant))
							outputInteractInfo("[ gas tank full ]", msg_recipient, 0,255,0)
							
						elseif fuelQuant < maxFuel - 20 then 
							addCarFuel(vehicle, 20)
							outputInteractInfo("[ vehicle refueled: +10 lt ]", msg_recipient, 0,255,0)
							
							
						end 
						
						local xp = getPlayerExp(msg_recipient)
						setPlayerExp(msg_recipient,xp+1)
						outputStatusInfo("+1 xp",msg_recipient, 240,240,240 )
						
					end, refueltime, 1, client)
		used = true
		setTimer(createwateritsamiracle,4300,1,"Empty Canister", client) --Dystopia facts#1: createwateritsamiracle(string item, element player) actually adds an item to the inventory or drops it if full; named like this out of enthusiasm over making the river water thingy work
		triggerClientEvent(client, "sleep:drawDXProgress", client, 4300,4300)
		setTimer(triggerClientEvent,4300,1,client, "sleep:stopDXProgress", client)
		
		elseif fuelQuant >= maxFuel then
			outputInteractInfo("[ gas tank full ]", client, 0,255,0)
			used = false
		
		end
		
	end	

elseif (id == "Vehicle Parts")	 then
	local vehicle
	local partsMissing
	
	if getElementData(client, "veh_col_veh") then 
		vehicle =  getElementData(client, "veh_col_veh")
		partsMissing = assessVehicleCondition(vehicle)
	end
	
	if not vehicle then  --[[outputTopBar("No suitable vehicle nearby", client, 255,255,255)]] return end
	
	if partsMissing == 0 then outputInteractInfo("[ vehicle intact ]", client, 255,255,255) return 
		
		elseif partsMissing > 0 then

			local x,y,z = getElementPosition( vehicle )
			local px, py, pz = getElementPosition( client )
			local pedangle = ( 360 - math.deg ( math.atan2 ( ( x - px ), ( y - py ) ) ) ) % 360
			
			setPedAnimation ( client, "PED", "WALK_player", 1000, false, true, true)
			
			setTimer( function (ped,interval) 
				setPedAnimation ( ped, "INT_HOUSE", "wash_up", interval, true, false, false, false) 
				outputStatusInfo("[ installing part... ]", ped, 255,255,255)
			end, 1000, 1, client, 4000)
			setTimer( installVehPart, 4000,1,vehicle,client)
			triggerClientEvent(client, "sleep:drawDXProgress", client, 6000,1)
			setTimer(triggerClientEvent,6000,1,client, "sleep:stopDXProgress", client)
	
			used = true
	end

elseif(id=="Night Vision Googles") and playerHasFreeEquipmentSlots then --weight: 0.5 
setPedWeaponSlot(client,11)
	if weight >= 6 and getPedWeapon (client,11) == 0 then 

		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	used=true
	local weapon = getPedWeapon(client)
		if weapon == 45 and isInventoryFull(client) == true then createObjectItem("Thermal Googles", x, y, z-0.95, 97.3,120, 0) elseif weapon == 45 and isInventoryFull(client) == false then addPlayerItem(client, "Thermal Googles") end
		if weapon == 44 then outputInteractInfo("[ already equipped! ]", client, 255,230,0) return end
	giveWeapon(client,44,1,true) 
	outputInteractInfo("> Night Vision Googles", client, 255,200,0, 3000)
	end

elseif(id=="Thermal Googles") and playerHasFreeEquipmentSlots then --weight: 0.5 
setPedWeaponSlot(client,11)
	if weight >= 6 and getPedWeapon (client,11) == 0 then 
	------------outputTopBar("HINT: Press [X] to unequip current weapon.", client, 255,200,0)
		outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
	else
	used=true
	local weapon = getPedWeapon(client)
		if weapon == 44 and isInventoryFull(client) == true then createObjectItem("Night Vision Googles", x, y, z-0.95, 97.3,120, 0) elseif weapon == 44 and isInventoryFull(client) == false then addPlayerItem(client, "Night Vision Googles") end
		if weapon == 45 then outputInteractInfooutputInteractInfo("[ already equipped! ]", client, 255,230,0) return end
	giveWeapon(client,45,1,true) 
	outputInteractInfo("> Thermal Googles", client, 255,200,0, 3000)
	end	
	
	
elseif(id=="Ammo Box") then
	used=true
	setPedWeaponSlot(client,0)
	setPedAnimation( client, "BOMBER", "BOM_plant", 3200, true, false, false, false)
	triggerClientEvent(client, "sleep:drawDXProgress", client, 3200,3200)
	setTimer(triggerClientEvent,3200,1,client, "sleep:stopDXProgress", client)
	setTimer(function() outputStatusInfo("Opening Ammo Box...", player, 250,250,250) end, 500,1)
	local ply = client
	setTimer ( function() 
	local ammoItem = table.random(ammoBoxContents)
	createwateritsamiracle(ammoItem,ply); 
	local ammoItem = table.random(ammoBoxContents)
	createwateritsamiracle(ammoItem,ply); 
	local ammoItem = table.random(ammoBoxContents)
	createwateritsamiracle(ammoItem,ply); 
	outputInteractInfo("[ ammo box opened ]", player, 255, 200, 0) 
	end, 
	3200, 1)

elseif(id=="Scrap Metal")then	
triggerClientEvent(client,"OpenCraft",client)

elseif(id=="Wood")then	
triggerClientEvent(client,"OpenCraft",client)  

elseif(id=="Wire")then	
triggerClientEvent(client,"OpenCraft",client)  

elseif(id=="Rags")then	
triggerClientEvent(client,"OpenCraft",client)  

elseif(id=="Spikestrip")then  --useItem
setPedWeaponSlot(client,0)
setPedAnimation(client,"BOMBER", "BOM_plant", 1000, true, false, false, false)
triggerClientEvent(client, "sleep:drawDXProgress", client, 4000,4000)
setTimer(triggerClientEvent,1000,1,client, "sleep:stopDXProgress", client)
outputStatusInfo("[ deploying... ]", client, 255,255,255, 3000)
setTimer(deploySpikestrip,1000,1,client)
used=true  
  
end -- the big end

	if(used)then
		triggerEvent("RefreshDraw",client)
		PlayersItens[client][index]="Empty"
		triggerClientEvent(client,"RefreshDraw",client)
		triggerClientEvent("synchronizeTables",client,PlayersItens)
		--savePlayer(client)
	end
	
end

addEventHandler("onPlayerUseItem",root, useItem, id, index)-- this happens when you click on an inventory item

addEvent("onPlayerDropItem",true) -- event drop item

function dropItem (name,index) -- mouse2 - drops an item on the ground
local x,y,z = getElementPosition(client)
local r = getPedRotation(client)
local model = getModelFromString(name)
createObjectItem( name, x, y, z-0.95, 97.3,120, math.random(0,359))
outputInteractInfo("- "..name.."", client, 255, 92, 38, 3000)
PlayersItens[client][index]="Empty"
if name == "Map" then triggerClientEvent(client,"closeMapOnDropped",client) --closes map if you drop it while open
	elseif name == "Survivor Map" then triggerClientEvent(client,"closeMapOnDropped",client)
	elseif name == "Military Map" then triggerClientEvent(client,"closeMapOnDropped",client)
	elseif name == "EM Scanner" then setElementData(client,"scannerequipped",false,true); triggerClientEvent(client,"CloseScanner",client)
end
triggerClientEvent(client,"RefreshDraw",client)
triggerClientEvent(client,"synchronizeTables",client,PlayersItens)
--savePlayer(client)
end
addEventHandler("onPlayerDropItem",root, dropItem, name, index) 

addEvent("onPlayerInteractInventoryItem",true) -- event move item
addEvent("onPlayerActivateBeltItem",true) -- event activate item
addEvent("onPlayerRetrieveBeltItem",true) -- event retrieve belt item
addEvent("onPlayerActivateEquippedItem",true) -- event activate item
addEvent("onPlayerRetrieveEquippedItem",true) -- event retrieve belt item
addEvent("onPlayerToggleEquippedItem",true) -- event retrieve belt item

addEvent("onPlayerToggleBeltItem",true) -- event toggle item ; not sure this will be needed, 'activate' one might suffice
addEvent("SynchronizeAll",true)

function synchroAll(inv_tab,belt_tab) --attempt to synchro all item tables, triggered from client
if source == client then
PlayersItens = inv_tab
PlayersBeltItens = belt_tab

end
end
addEventHandler("SynchronizeAll", root, synchroAll, inv_tab, belt_tab)

function retrieveBeltItem (itemname, index) --remove item from belt, add it to inventory

--[[local pistolammo = getElementData(client,"pistolammo") or 1
local taserammo = getElementData(client,"taserammo") or 1
local crossbowammo = getElementData(client,"crossbowammo") or 1
local smgammo = getElementData(client,"smgammo") or 1
local shotgunammo = getElementData(client,"shotgunammo") or 1
local assaultammo = getElementData(client,"assaultammo") or 1
local rifleammo = getElementData(client,"rifleammo") or 1
local stomperammo = getElementData(client,"stomperammo") or 0]]
local x,y,z = getElementPosition(client)
local rx, ry, rz = getElementRotation(client)
local used = false

	
	if itemname == "Map" then
		if isInventoryFull(client) == true then
					 createObjectItem(itemname,x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					 
		elseif	isInventoryFull(client) == false then
					 addPlayerItem(client,itemname)
					 
		end
		setElementData(client,"currentmap",false)
		PlayersBeltItens[client][index] = "Empty"
		syncronizePlayerItens(client)
		syncronizePlayerBeltItens(client)
		triggerEvent("RefreshDraw",client)
		triggerClientEvent("closeMapOnDropped",client) --closes map if you remove it while open
	end	
	
	if itemname == "Survivor Map" then
		if isInventoryFull(client) == true then
					 createObjectItem(itemname,x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					 
		elseif	isInventoryFull(client) == false then
					 addPlayerItem(client,itemname)
					 
		end
		setElementData(client,"currentmap",false)
		--outputDebugString("map = false")
		PlayersBeltItens[client][index] = "Empty"
		syncronizePlayerItens(client)
		syncronizePlayerBeltItens(client)
		triggerEvent("RefreshDraw",client)
		triggerClientEvent("closeMapOnDropped",client)
	end	

	if itemname == "Military Map" then
		if isInventoryFull(client) == true then
					 createObjectItem(itemname,x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					 
		elseif	isInventoryFull(client) == false then
					 addPlayerItem(client,itemname)
					
		end
		setElementData(client,"currentmap",false)
		PlayersBeltItens[client][index] = "Empty"
		syncronizePlayerItens(client)
		syncronizePlayerBeltItens(client)
		triggerEvent("RefreshDraw",client)
		triggerClientEvent("closeMapOnDropped",client)
	end		
--[[	
		if itemname == "Toolbox" then
		if isInventoryFull(client) == true then
					 createObjectItem(itemname,x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					 
		elseif	isInventoryFull(client) == false then
					 addPlayerItem(client,itemname)
					 
		end
		PlayersBeltItens[client][index] = "Empty"
		syncronizePlayerItens(client)
		syncronizePlayerBeltItens(client)
		triggerEvent("RefreshDraw",client)
	end	]]
	
		if itemname == "Painkillers" then
		if isInventoryFull(client) == true then
					 createObjectItem(itemname,x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					 
		elseif	isInventoryFull(client) == false then
					 addPlayerItem(client,itemname)
					 
		end
		PlayersBeltItens[client][index] = "Empty"
		syncronizePlayerItens(client)
		syncronizePlayerBeltItens(client)
		triggerEvent("RefreshDraw",client)
	end	
	
	if itemname == "Bandage" then
		if isInventoryFull(client) == true then
					 createObjectItem(itemname,x,y,z-0.95, 97.3,120, 0)
					 outputStatusInfo("- "..itemname, client, 255, 92, 38)
					 
		elseif	isInventoryFull(client) == false then
					 addPlayerItem(client,itemname)
					 
		end
		PlayersBeltItens[client][index] = "Empty"
		syncronizePlayerItens(client)
		syncronizePlayerBeltItens(client)
		triggerEvent("RefreshDraw",client)
	end
	
	if itemname == "Lighter" then
		if isInventoryFull(client) == true then
					 createObjectItem(itemname,x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					 
		elseif	isInventoryFull(client) == false then
					 addPlayerItem(client,itemname)
					 
		end
		PlayersBeltItens[client][index] = "Empty"
		syncronizePlayerItens(client)
		syncronizePlayerBeltItens(client)
		triggerEvent("RefreshDraw",client)
	end
	
	if itemname == "EM Scanner" then
		if isInventoryFull(client) == true then
					 createObjectItem(itemname,x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					 
		elseif	isInventoryFull(client) == false then
					 addPlayerItem(client,itemname)
					 
		end
		PlayersBeltItens[client][index] = "Empty"
		syncronizePlayerItens(client)
		syncronizePlayerBeltItens(client)
		triggerEvent("RefreshDraw",client)
		triggerClientEvent(client,"CloseScanner",client)
		triggerClientEvent(client,"ScannerUnequipped",client)
	end
	
	
	if itemname == "Road Flare" or itemname == "Adrenaline" or itemname == "Splint" or itemname == "ZomboKleen" or itemname == "Radio" or itemname == "Stinger Missile" then
		if isInventoryFull(client) == true then
					 createObjectItem(itemname,x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					 
		elseif	isInventoryFull(client) == false then
					 addPlayerItem(client,itemname)
					 
		end
		
		PlayersBeltItens[client][index] = "Empty"
		syncronizePlayerItens(client)
		syncronizePlayerBeltItens(client)
		triggerEvent("RefreshDraw",client)
	end

--savePlayer(client)	

end
addEventHandler("onPlayerRetrieveBeltItem",root, retrieveBeltItem)

function useBeltItem (itemname, index) --use Belt item
local health = getElementHealth(client)
local x,y,z = getElementPosition(client)
local rx, ry, rz = getElementRotation(client)
local used = false
	
	if itemname == "Map" then
		triggerClientEvent(client,"mapUsed",client,"Map")
		
		 
	end

	if itemname == "Survivor Map" then
		triggerClientEvent(client,"mapUsed",client,"Survivor Map")
		
		 
	end
	
	if itemname == "Military Map" then
		triggerClientEvent(client,"mapUsed",client,"Military Map")
		 
	end
	
	if itemname == "Toolbox" then
		setPedWeaponSlot(client,0)
		triggerClientEvent (client, "RepairingVehicle", client)
		triggerClientEvent (client, "ScavengingVehicle", client)
	end	
	
	if itemname == "Painkillers" then
		setPedWeaponSlot(client,0)
    if (health == 100) then
    outputInteractInfo("You are healthy", client, 0, 0, 0, 3000)
    used=true
	triggerClientEvent(client,"PainkillersTaken",client)
    end
    if(health>=90) and (health<100) then
    setElementHealth(client,100)
    outputStatusInfo("+10 hp", client, 0,255,0)
    outputInteractInfo("You used Painkillers", client, 255,200,0)
    used=true
    setPedAnimation( client, "VENDING", "VEND_Drink2_P",-1,false,false,true,false)
	triggerClientEvent(client,"PainkillersTaken",client)
    else
    setElementHealth(client,health+10)
	outputStatusInfo("+10 hp", client, 0,255,0)
	outputInteractInfo("You used Painkillers", client, 255,200,0)
    setPedAnimation( client, "VENDING", "VEND_Drink2_P",-1,false,false,true,false)
    used=true
	triggerClientEvent(client,"PainkillersTaken",client)
    end
		PlayersBeltItens[client][index] = "Empty"
		syncronizePlayerItens(client)
		syncronizePlayerBeltItens(client)
		triggerEvent("RefreshDraw",client)
	end	
	
	if itemname == "Lighter" then
		setPedWeaponSlot(client,0)
		triggerEvent ("onMakeAFire", client)
	end	
	
	if itemname == "Road Flare" then
		setPedWeaponSlot(client,0)
		setPedAnimation( client, "BOMBER", "BOM_Plant",1000,false,false,false,false)
		outputStatusInfo("Deploying flare...", client, 255,255,255)
		local x,y,z = getElementPosition(client)
		local object = createObject(354,x,y,z-2.5)
		setTimer(destroyElement,300000,1,object)
		used=true
	end	
	
	if itemname == "ZomboKleen" then
	setPedWeaponSlot(client,0)
		setPedAnimation( client, "VENDING", "VEND_Drink2_P",-1,false,false,true,false)
		local randcurechance = math.random(0,10)
		local health = getElementHealth(client)
		if randcurechance >5 then 
			if getElementData(client,"infection") ~= "uninfected" then
			setElementData(client,"infection","uninfected",true)
			outputStatusInfo("ZomboKleen: Infection cured!", client, 0,240,0)
			triggerClientEvent(client,"clearInfectionEffects",client)

			end
		elseif randcurechance == 0 then 
				if health <= 10 then 
						killPed(client)
				else 
						setElementHealth(client,health-10)
				end
				outputStatusInfo("ZomboKleen: -10 hp", client, 255,0,0)
				local newrand = math.random(1,2)
				if newrand == 1 then
					if getElementData(client,"infection") ~= "uninfected" then
						setElementData(client,"infection","uninfected",true)
						outputStatusInfo("ZomboKleen: Infection cured!", client, 0,240,0)
						triggerClientEvent(client,"clearInfectionEffects",client)
					else
						outputStatusInfo("ZomboKleen: No effect!", client, 255,255,255)
					end
				else
					outputStatusInfo("ZomboKleen: No effect!", client, 255,255,255)
				end
		
		elseif randcurechance <=5 and randcurechance ~= 0 then 
			outputStatusInfo("ZomboKleen: No effect!", client, 255,255,255)
		end
		used=true
		end
	
	if itemname=="Splint"then

		setPedWeaponSlot(client,0)
		local fractured
		if getElementData(client,"minorfracture")== true or getElementData(client,"majorfracture")== true then fractured = true else fractured = false end
	   
	   if not fractured  then
		outputInteractInfo("You have no fracture!", client, 255, 255, 255)
		else
		setElementData(client,"minorfracture",false)
		setElementData(client,"majorfracture",false)
		outputStatusInfo("Reducing fracture...", client, 255,255,255)
		setPedAnimation( client, "BOMBER", "BOM_Plant",5000,false,false,false,false)
		triggerClientEvent(client, "sleep:drawDXProgress", client, 5000,5000)
		setTimer(triggerClientEvent,5000,1,client, "sleep:stopDXProgress", client)		
		setTimer(outputInteractInfo,4000,1,"Fracture reduced", client, 0,200,0)
		used=true
		end
	end
	
	if itemname == "Bandage" then
		if getElementData(client, "bleeding") == true then 
		triggerClientEvent("StopBleedingBandage",client)
		used = true
		else
		outputStatusInfo("You are not bleeding", client, 255,200,0)
		end
	end
	
--[[	if itemname == "Spikestrip" then 
		setPedWeaponSlot(client,0)
		setPedAnimation(client,"BOMBER", "BOM_plant", 4000, true, false, false, false)
		outputStatusInfo("Deploying Spikestrip...", client, 255,255,255, 3000)
		setTimer(deploySpikestrip,4000,1,client)
		used=true
	end]]
	
	if itemname == "Adrenaline" then 
		setPedWeaponSlot(client,0)
		setPedAnimation( client, "VENDING", "VEND_Drink2_P",-1,false,false,true,false)
		triggerClientEvent(client,"AdrenalineUsed",client)
		used=true
	end
	
	if itemname == "EM Scanner" then 
		--triggerClientEvent(client,"ToggleScanner",client)
	end
	
if(used)then
	PlayersBeltItens[client][index]="Empty"
	triggerClientEvent(client,"RefreshDraw",client)
	triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
	--savePlayer(client)
end
end

addEventHandler("onPlayerActivateBeltItem",root, useBeltItem)	

function useEquippedItem (itemname, index) --use equipped item
local x,y,z = getElementPosition(client)
local rx, ry, rz = getElementRotation(client)
local used = false
	
	if itemname == "Headlamp" then
		triggerClientEvent (client, "ToggleHeadlamp", client)
		
	elseif itemname == "Spray Can" then
		exports.drawtag:setPlayerSprayMode(client, "draw")
		triggerClientEvent(client,"ShowDrawingWindow",client) --in drawtag_bc resource
		outputInteractInfo("Create a drawing and press 'Done'", client, 240, 240, 240)
	end
	
	if itemname == "Toolbox" then      				
		setPedWeaponSlot(client,0)
		triggerClientEvent (client, "RepairingVehicle", client)
		triggerClientEvent (client, "ScavengingVehicle", client)
	end	
	
	if itemname == "Medikit" then      				
		local x,y,z = getElementPosition(client)
		local colshape =  createColSphere(x,y,z,1)
		local blabla = attachElements(colshape,client,0,0.5,0)
		local peds = getElementsWithinColShape(colshape,"ped")
		local players = getElementsWithinColShape(colshape,"player")
		local amounthealed = 20 -- this must be corellated with player's MED level
		
		for _,ped in ipairs(peds) do
			local pedhealth = getElementHealth(ped)
			if 	pedhealth < 100 then 
				setPedAnimation(client,"INT_HOUSE", "wash_up", 5000, true, false, false, false)
				setTimer(function() setElementHealth(ped, pedhealth+amounthealed)
				outputInteractInfo("[ "..getElementData(ped,"name").." healed]", client, 255,255,255)
				end, 5000,1)
		triggerClientEvent(client, "sleep:drawDXProgress", client, 5000,5000)
		setTimer(triggerClientEvent,5000,1,client, "sleep:stopDXProgress", client)
				------------ Add +5 MED points here
			else
			outputInteractInfo("[ nobody is hurt ]", client, 255,255,255)
			end
		end
		
		for _,player in ipairs(players) do
			local pedhealth = getElementHealth(player)
			if 	pedhealth < 100 then 
				setPedAnimation(client,"INT_HOUSE", "wash_up", 5000, true, false, false, false)
				setTimer(function() setElementHealth(player, pedhealth+amounthealed)
				outputTopBar("[ "..getPlayerName(player).." healed ]", client, 255,255,255)
				end, 5000,1)
		triggerClientEvent(client, "sleep:drawDXProgress", client, 5000,5000)
		setTimer(triggerClientEvent,5000,1,client, "sleep:stopDXProgress", client)					
				------------ Add +5 MED points here
			else
			outputInteractInfo("[ nobody is hurt ]", client, 255,255,255)
			end
		end
		
		destroyElement(colshape)
	end	

	if itemname == "Laser Pointer" then  
		local player = client
		if IsLaserEnabled(client) then 
			triggerClientEvent(client,"EnableDisableLaserPointer",client,player,false)
		else 
			triggerClientEvent(client,"EnableDisableLaserPointer",client,player,true)
		end
	end	

if itemname == "Mine" then
	local explosivetraps = getElementData(client,"explosivetraps")
	createExplosiveTrap(client)
	if not explosivetraps then explosivetraps = 0 end
	setElementData(client,"explosivetraps",explosivetraps-1)
	if getElementData(client,"explosivetraps") < 0 then setElementData(client,"explosivetraps",0) end
	outputStatusInfo("[ deploying... ]", client, 255, 255, 255)
	setPedAnimation( client, "BOMBER", "BOM_Plant",1000,false,false,false,false)
		triggerClientEvent(client, "sleep:drawDXProgress", client, 1000,1000)
		setTimer(triggerClientEvent,1000,1,client, "sleep:stopDXProgress", client)	
	
end

if itemname == "Incendiary Trap" then
	local incendiarytraps = getElementData(client,"incendiarytraps")
	createIncendiaryTrap(client)
	if not incendiarytraps then incendiarytraps = 0 end
	setElementData(client,"incendiarytraps",incendiarytraps-1)
	if getElementData(client,"incendiarytraps") < 0 then setElementData(client,"incendiarytraps",0) end
	outputStatusInfo("[ deploying... ]", client, 255, 255, 255)
	setPedAnimation( client, "BOMBER", "BOM_Plant",1000,false,false,false,false)
		triggerClientEvent(client, "sleep:drawDXProgress", client, 1000,1000)
		setTimer(triggerClientEvent,1000,1,client, "sleep:stopDXProgress", client)	
end	

if itemname == "Shards Trap" then
	local glasstraps = getElementData(client,"glasstraps")
	createGlassTrap(client)
	if not glasstraps then glasstraps = 0 end
	setElementData(client,"glasstraps",glasstraps-1)
	if getElementData(client,"glasstraps") < 0 then setElementData(client,"glasstraps",0) end
	outputStatusInfo("[ deploying... ]", client, 255, 255, 255)
	setPedAnimation( client, "BOMBER", "BOM_Plant",1000,false,false,false,false)
		triggerClientEvent(client, "sleep:drawDXProgress", client, 1000,1000)
		setTimer(triggerClientEvent,1000,1,client, "sleep:stopDXProgress", client)	
	
end	

if itemname == "Spikestrip" then --useEquippedItem
	local spikestrips = getElementData(client,"spikestrips")
	setTimer(deploySpikestrip,1000,1,client)
	if not spikestrips then spikestrips = 0 end
	setElementData(client,"spikestrips",spikestrips-1)
	if getElementData(client,"spikestrips") < 0 then setElementData(client,"spikestrips",0) end
	outputStatusInfo("[ deploying... ]", client, 255, 255, 255)
	setPedAnimation( client, "BOMBER", "BOM_Plant",1000,true,false,false,false)
	triggerClientEvent(client, "sleep:drawDXProgress", client, 1000,1000)
	setTimer(triggerClientEvent,1000,1,client, "sleep:stopDXProgress", client)	
	
end	

if itemname == "Timed Bomb" then
	local timedbombs = getElementData(client,"timedbombs") or 0
	if timedbombs<0 then timedbombs = 0; setElementData(client,"timedbombs",0) end
	createTimedBomb(client)
	outputStatusInfo("Deploying Timed Bomb...", client, 255, 255, 255)
	setPedAnimation( client, "BOMBER", "BOM_Plant",3000,false,false,false,false)	
	setElementData(client,"timedbombs",timedbombs-1)
		triggerClientEvent(client, "sleep:drawDXProgress", client, 3000,3000)
		setTimer(triggerClientEvent,3000,1,client, "sleep:stopDXProgress", client)	

end
	
--savePlayer(client)	

end
addEventHandler("onPlayerActivateEquippedItem",root, useEquippedItem)	

function toggleEquippedItem (itemname, index) --use equipped item

local x,y,z = getElementPosition(client)
local rx, ry, rz = getElementRotation(client)
local used = false

	
	if itemname == "Headlamp" then
		triggerClientEvent (client, "ToggleHeadlamp", client)
		
	end
	
	if itemname == "Spray Can" then
		exports.drawtag:setPlayerSprayMode(client, "draw")
		triggerClientEvent(client,"ShowDrawingWindow",client) --in drawtag_bc resource
		outputInteractInfo("Create a drawing and press 'Done'", client, 240, 240, 240)
	end
	
	if itemname == "Toolbox" then      				
		setPedWeaponSlot(client,0)
		triggerClientEvent (client, "RepairingVehicle", client)
		triggerClientEvent (client, "ScavengingVehicle", client)
	end	
	
	if itemname == "Medikit" then      				
		setPedWeaponSlot(client,0)
	local health = getElementHealth(client)
    if(health<100) then
    setElementHealth(client,100)
    used=true
    setPedAnimation( client, "BOMBER", "BOM_Plant",5000,false,false,false,false) 
    outputStatusInfo("Health restored", client, 0,255,0)
    outputInteractInfo("You used a Medikit", client, 0, 0, 0, 3000)
    else
    outputInteractInfo("You are already at full health", client, 240, 240, 240)
    end
	end
end
addEventHandler("onPlayerToggleEquippedItem",root, toggleEquippedItem)	

function retrieveEquippedItem (itemname, index) --remove item from equipment, add it to inventory. only ammo added for now; other belt items: flashlight, map, gps, lighter, compass, zipline(?), battery

local pistolammo = getElementData(client,"pistolammo") or 1
local taserammo = getElementData(client,"taserammo") or 1
local crossbowammo = getElementData(client,"crossbowammo") or 1
local smgammo = getElementData(client,"smgammo") or 1
local shotgunammo = getElementData(client,"shotgunammo") or 1
local assaultammo = getElementData(client,"assaultammo") or 1
local rifleammo = getElementData(client,"rifleammo") or 1
local stomperammo = getElementData(client,"stomperammo") or 1
local x,y,z = getElementPosition(client)
local rx, ry, rz = getElementRotation(client)
local used = false

	if itemname == "SMG Ammo" then
	local weapon = getPedWeapon(client,4)
		if smgammo-30 > 1 then -- if the client has enough ammo for a full clip...
			if isInventoryFull(client) == true then -- ...drop a clip if inventory is full...
					 takeWeapon(client, weapon,30)
					 createObjectItem("SMG Ammo",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					 setElementData(client,"smgammo",smgammo-30)
			elseif isInventoryFull(client) == false then -- ...or add a clip to inventory if there's room
					 addPlayerItem(client,itemname)
					 takeWeapon(client, weapon,30)
					 setElementData(client,"smgammo",smgammo-30)
					 triggerEvent("RefreshDraw",client)
			end
			
		elseif smgammo < 31 and smgammo > 1 then -- if there's not enough ammo for a clip...
		elseif smgammo-30 == 1 then 
		used = true
			if isInventoryFull(client) == true then 
				takeWeapon(client, weapon,30)
				createObjectItem("SMG Ammo",x,y,z-0.95, 97.3,120, 0)
				outputInteractInfo("- "..itemname, client, 255, 92, 38)
				setElementData(client,"smgammo",smgammo-30)
			elseif isInventoryFull(client) == false then addPlayerItem(client,itemname)
				takeWeapon(client, weapon,30)
					 setElementData(client,"smgammo",smgammo-30)
					 triggerEvent("RefreshDraw",client)
			end
		end	
	end
	
	if itemname == "Pistol Ammo" then
	local weapon = getPedWeapon(client,2)
		if pistolammo-10 >= 1 then -- if the client has enough ammo for a full clip...
			if isInventoryFull(client) == true then -- ...drop a clip if inventory is full...
					 takeWeapon(client, weapon,10)
					 createObjectItem("Pistol Ammo",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					 setElementData(client,"pistolammo",pistolammo-10)
			elseif isInventoryFull(client) == false then -- ...or add a clip to inventory if there's room
					 addPlayerItem(client,itemname)
					 takeWeapon(client, weapon,10)
					 setElementData(client,"pistolammo",pistolammo-10)
					 triggerEvent("RefreshDraw",client)
			end
			
		elseif pistolammo < 31 and pistolammo > 1 then -- if there's not enough ammo for a clip...
		elseif pistolammo-10 == 1 then 
			if isInventoryFull(client) == true then 
				takeWeapon(client, weapon,10)
				createObjectItem("Pistol Ammo",x,y,z-0.95, 97.3,120, 0)
				outputStatusInfo("- "..itemname, client,255, 92, 38)
				setElementData(client,"pistolammo",pistolammo-10)
			elseif isInventoryFull(client) == false then addPlayerItem(client,itemname)
				takeWeapon(client, weapon,10)
					 setElementData(client,"pistolammo",pistolammo-10)
					 triggerEvent("RefreshDraw",client)
			end
		end	
	end
	
	if itemname == "Bolts" then
	local weapon = getPedWeapon(client,2)
		if crossbowammo-5 > 1 then -- if the client has enough ammo for a full clip...
			if isInventoryFull(client) == true then -- ...drop a clip if inventory is full...
					 takeWeapon(client, weapon,5)
					 createObjectItem(itemname,x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client,255, 92, 38)
					 setElementData(client,"crossbowammo",crossbowammo-5)
			elseif isInventoryFull(client) == false then -- ...or add a clip to inventory if there's room
					 addPlayerItem(client,itemname)
					 takeWeapon(client, weapon,5)
					 setElementData(client,"crossbowammo",crossbowammo-5)
					 triggerEvent("RefreshDraw",client)
			end
			
		elseif crossbowammo < 6 and crossbowammo > 1 then -- if there's not enough ammo for a clip...
		elseif crossbowammo-5 == 1 then 
		used = true
			if isInventoryFull(client) == true then 
				takeWeapon(client, weapon,5)
				createObjectItem(itemname,x,y,z-0.95, 97.3,120, 0)
				outputInteractInfo("- "..itemname, client, 255, 92, 38)
				setElementData(client,"crossbowammo",crossbowammo-5)
			elseif isInventoryFull(client) == false then addPlayerItem(client,itemname)
				takeWeapon(client, weapon,5)
					 setElementData(client,"crossbowammo",crossbowammo-5)
					 triggerEvent("RefreshDraw",client)
			end
		end	
	end

if itemname == "Stomper Ammo" then
	
		if stomperammo-5 > 0 then -- if the client has enough ammo for a full box...
			if isInventoryFull(client) == true then -- ...drop a clip if inventory is full...
					 setElementData(client, "stomperammo",stomperammo-5)
					 createObjectItem(itemname,x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client,255, 92, 38)
					 
			elseif isInventoryFull(client) == false then -- ...or add a clip to inventory if there's room
					 addPlayerItem(client,itemname)
					 setElementData(client, "stomperammo",stomperammo-5)
					 triggerEvent("RefreshDraw",client)
			end
			
		elseif stomperammo-5 == 0 then 
		used = true
			if isInventoryFull(client) == true then 
				createObjectItem(itemname,x,y,z-0.95, 97.3,120, 0)
				outputInteractInfo("- "..itemname, client, 255, 92, 38)
				setElementData(client,"stomperammo",stomperammo-5)
			elseif isInventoryFull(client) == false then addPlayerItem(client,itemname)
				
					 setElementData(client,"stomperammo",stomperammo-5)
					 triggerEvent("RefreshDraw",client)
			end
		end	
	end
	
	
	if itemname == "Magnum Ammo" then
	local weapon = getPedWeapon(client,2)
		if taserammo-6 >= 1 then -- if the client has enough ammo for a full clip...
			if isInventoryFull(client) == true then -- ...drop a clip if inventory is full...
					 takeWeapon(client, weapon,6)
					 createObjectItem(itemname,x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					 setElementData(client,"taserammo",taserammo-6)
			elseif isInventoryFull(client) == false then -- ...or add a clip to inventory if there's room
					 addPlayerItem(client,itemname)
					 takeWeapon(client, weapon,6)
					 setElementData(client,"taserammo",taserammo-6)
					 triggerEvent("RefreshDraw",client)
			end
	
		elseif taserammo-6 == 1 then 
			if isInventoryFull(client) == true then 
				takeWeapon(client, weapon,6)
				createObjectItem(itemname,x,y,z-0.95, 97.3,120, 0)
				outputInteractInfo("- "..itemname, client, 255, 92, 38)
				setElementData(client,"taserammo",taserammo-6)
			elseif isInventoryFull(client) == false then addPlayerItem(client,itemname)
				takeWeapon(client, weapon,6)
					 setElementData(client,"taserammo",taserammo-6)
					 triggerEvent("RefreshDraw",client)
			end
		end	
	end
	
	if itemname == "Shotgun Ammo" then
	local weapon = getPedWeapon(client,3)
		if shotgunammo-8 > 1 then -- if the client has enough ammo for a full clip...
			if isInventoryFull(client) == true then -- ...drop a clip if inventory is full...
					 takeWeapon(client, weapon,8)
					 createObjectItem(itemname,x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					 setElementData(client,"shotgunammo",shotgunammo-8)
			elseif isInventoryFull(client) == false then -- ...or add a clip to inventory if there's room
					 addPlayerItem(client,itemname)
					 takeWeapon(client, weapon,8)
					 setElementData(client,"shotgunammo",shotgunammo-8)
					 triggerEvent("RefreshDraw",client)
			end
			
		elseif shotgunammo < 9 and shotgunammo > 1 then -- if there's not enough ammo for a clip...
		elseif shotgunammo-8 == 1 then 
			if isInventoryFull(client) == true then 
				takeWeapon(client, weapon,8)
				createObjectItem(itemname,x,y,z-0.95, 97.3,120, 0)
				outputInteractInfo("- "..itemname, client, 255, 92, 38)
				setElementData(client,"shotgunammo",shotgunammo-8)
			elseif isInventoryFull(client) == false then addPlayerItem(client,itemname)
				takeWeapon(client, weapon,8)
					 setElementData(client,"shotgunammo",shotgunammo-8)
					 triggerEvent("RefreshDraw",client)
			end
		end	
	end
	
	if itemname == "Assault Ammo" then
	local weapon = getPedWeapon(client,5)
		if assaultammo-30 > 1 then -- if the client has enough ammo for a full clip...
			if isInventoryFull(client) == true then -- ...drop a clip if inventory is full...
					 takeWeapon(client, weapon,30)
					 createObjectItem(itemname,x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					 setElementData(client,"assaultammo",assaultammo-30)
			elseif isInventoryFull(client) == false then -- ...or add a clip to inventory if there's room
					 addPlayerItem(client,itemname)
					 takeWeapon(client, weapon,30)
					 setElementData(client,"assaultammo",assaultammo-30)
					 triggerEvent("RefreshDraw",client)
			end
			
		elseif assaultammo < 31 and assaultammo > 1 then -- if there's not enough ammo for a clip...
		elseif assaultammo-30 == 1 then 
			if isInventoryFull(client) == true then 
				takeWeapon(client, weapon,30)
				createObjectItem(itemname,x,y,z-0.95, 97.3,120, 0)
				outputInteractInfo("- "..itemname, client, 255, 92, 38)
				setElementData(client,"assaultammo",assaultammo-30)
			elseif isInventoryFull(client) == false then addPlayerItem(client,itemname)
				takeWeapon(client, weapon,30)
					 setElementData(client,"assaultammo",assaultammo-30)
					 triggerEvent("RefreshDraw",client)
			end
		end	
	end
	
	if itemname == "Rifle Ammo" then
	local weapon = getPedWeapon(client,6)
		if rifleammo-5 > 1 then -- if the client has enough ammo for a full clip...
			if isInventoryFull(client) == true then -- ...drop a clip if inventory is full...
					 takeWeapon(client, weapon,5)
					 createObjectItem(itemname,x,y,z-0.95, 97.3,120, 0)
					outputInteractInfo("- "..itemname, client, 255, 92, 38)
					 setElementData(client,"rifleammo",rifleammo-5)
			elseif isInventoryFull(client) == false then -- ...or add a clip to inventory if there's room
					 addPlayerItem(client,itemname)
					 takeWeapon(client, weapon,5)
					 setElementData(client,"rifleammo",rifleammo-5)
					 triggerEvent("RefreshDraw",client)
			end
			
		elseif rifleammo < 6 and rifleammo > 1 then -- if there's not enough ammo for a clip...
		elseif rifleammo-5 == 1 then 
			if isInventoryFull(client) == true then 
				takeWeapon(client, weapon,5)
				createObjectItem(itemname,x,y,z-0.95, 97.3,120, 0)
				outputInteractInfo("- "..itemname, client, 255, 92, 38)
				setElementData(client,"rifleammo",rifleammo-5)
			elseif isInventoryFull(client) == false then addPlayerItem(client,itemname)
				takeWeapon(client, weapon,5)
					 setElementData(client,"rifleammo",rifleammo-5)
					 triggerEvent("RefreshDraw",client)
			end
		end	
	end

	if itemname == "Watch" then
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 
					 createObjectItem("Watch",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 
					 triggerEvent("RefreshDraw",client)
			end
		setElementData(client,"watch",false,true)
	end

	if itemname == "Sledgehammer" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 7)
					 createObjectItem("Sledgehammer",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 7)
					 triggerEvent("RefreshDraw",client)
			end
			
	triggerClientEvent ("CleanWeap", client, client, getSlotFromWeapon(7))	
	end
	
	if itemname == "Knife" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 4)
					 createObjectItem("Knife",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client,255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 4)
					 triggerEvent("RefreshDraw",client)
			end
			
	triggerClientEvent ("CleanWeap", client, client, getSlotFromWeapon(4))	
	end
	
	if itemname == "Axe" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 2)
					 createObjectItem("Axe",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 2)
					 triggerEvent("RefreshDraw",client)
			end
			
	triggerClientEvent ("CleanWeap", client, client, getSlotFromWeapon(2))	
	end
	
	if itemname == "Nightstick" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 3)
					 createObjectItem("Nightstick",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 3)
					 triggerEvent("RefreshDraw",client)
			end
			
	triggerClientEvent ("CleanWeap", client, client, getSlotFromWeapon(3))	
	end	
	
	if itemname == "Baseball Bat" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 5)
					 createObjectItem("Baseball Bat",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 5)
					 triggerEvent("RefreshDraw",client)
			end
			
	triggerClientEvent ("CleanWeap", client, client, getSlotFromWeapon(5))	
	end		

	if itemname == "Crowbar" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 6)
					 createObjectItem("Crowbar",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 6)
					 triggerEvent("RefreshDraw",client)
			end
			
	triggerClientEvent ("CleanWeap", client, client, getSlotFromWeapon(6))	
	end	
	
	if itemname == "Raider Sword" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 8)
					 createObjectItem("Raider Sword",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 8)
					 triggerEvent("RefreshDraw",client)
			end
			
	triggerClientEvent ("CleanWeap", client, client, getSlotFromWeapon(8))	
	end		

	if itemname == "Chainsaw" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 9)
					 createObjectItem("Chainsaw",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 9)
					 triggerEvent("RefreshDraw",client)
			end
			
	triggerClientEvent ("CleanWeap", client, client, getSlotFromWeapon(9))	
	end	
	
	if itemname == "Pistol" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 22)
					 createObjectItem("Pistol",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 22)
					 triggerEvent("RefreshDraw",client)
			end
			
	triggerClientEvent ("CleanWeap", client, client, getSlotFromWeapon(22))	
	end		

	if itemname == "Crossbow" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 23)
					 createObjectItem("Crossbow",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					 if getElementData(client,"zipline") then createObjectItem("Zip Line",x,y,z-0.95, 97.3,120, 0); outputInteractInfo("- Zip Line", client, 255, 92, 38); setElementData(client,"zipline",false)  end
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 23)
					 if getElementData(client,"zipline") then addPlayerItem(client,"Zip Line"); outputInteractInfo("Zip Line detached", client, 255, 200, 0);setElementData(client,"zipline",false) end
					 triggerEvent("RefreshDraw",client)
			end
			
	triggerClientEvent ("CleanWeap", client, client, getSlotFromWeapon(23))	
	end	
	
	if itemname == "Magnum Revolver" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 24)
					 createObjectItem("Magnum Revolver",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 24)
					 triggerEvent("RefreshDraw",client)
			end
			
	triggerClientEvent ("CleanWeap", client, client, getSlotFromWeapon(24))	
	end	
	
	if itemname == "Pump Shotgun" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 25)
					 createObjectItem("Pump Shotgun",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 25)
					 triggerEvent("RefreshDraw",client)
			end
			
	triggerClientEvent ("CleanWeap", client, client, getSlotFromWeapon(25))	
	end		

	if itemname == "Sawn-off Shotgun" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 26)
					 createObjectItem("Sawn-off Shotgun",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 26)
					 triggerEvent("RefreshDraw",client)
			end
			
	triggerClientEvent ("CleanWeap", client, client, getSlotFromWeapon(26))	
	end	

	if itemname == "Combat Shotgun" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 27)
					 createObjectItem("Combat Shotgun",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 27)
					 triggerEvent("RefreshDraw",client)
			end
			
	triggerClientEvent ("CleanWeap", client, client, getSlotFromWeapon(27))	
	end		
	
	if itemname == "Uzi" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 28)
					 createObjectItem("Uzi",x,y,z-0.95, 97.3,120, 0)
					outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 28)
					 triggerEvent("RefreshDraw",client)
			end
			
	triggerClientEvent ("CleanWeap", client, client, getSlotFromWeapon(28))	
	end	

	if itemname == "MP5" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 29)
					 createObjectItem("MP5",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 29)
					 triggerEvent("RefreshDraw",client)
			end
			
	triggerClientEvent ("CleanWeap", client, client, getSlotFromWeapon(29))	
	end	
	
	if itemname == "Vehicle Minigun" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 32)
					 createObjectItem("Vehicle Minigun",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 32)
					 triggerEvent("RefreshDraw",client)
			end
			
	triggerClientEvent ("CleanWeap", client, client, getSlotFromWeapon(32))	
	end	
	
	if itemname == "AK 47" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 30)
					 createObjectItem("AK 47",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, 255, 92, 38)
					 if getElementData(client,"stomperequipped") then createObjectItem("M37 Stomper",x,y,z-0.95, 97.3,120, 0); outputInteractInfo("- M37 Stomper", client, 255, 92, 38); setElementData(client,"stomperequipped",false)  end

					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 30)
					 if getElementData(client,"stomperequipped") then addPlayerItem(client,"M37 Stomper"); outputStatusInfo("M37 Stomper unequipped", client, 255, 92, 38); setElementData(client,"stomperequipped",false)  end

					 triggerEvent("RefreshDraw",client)
			end
			
	triggerClientEvent ("CleanWeap", client, client, getSlotFromWeapon(30))	
	end

	if itemname == "M4" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 31)
					 createObjectItem("M4",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					if getElementData(client,"stomperequipped") then createObjectItem("M37 Stomper",x,y,z-0.95, 97.3,120, 0); outputInteractInfo("- M37 Stomper", client, 255, 92, 38); setElementData(client,"stomperequipped",false)  end

			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 31)
					if getElementData(client,"stomperequipped") then addPlayerItem(client,"M37 Stomper"); outputStatusInfo("M37 Stomper unequipped", client, 255, 92, 38); setElementData(client,"stomperequipped",false)  end
					 triggerEvent("RefreshDraw",client)
			end
	triggerClientEvent ("CleanWeap", client, client, getSlotFromWeapon(31))		
		
	end	
	
	if itemname == "M37 Stomper" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					createObjectItem("M37 Stomper",x,y,z-0.95, 97.3,120, 0); 
					outputInteractInfo("- M37 Stomper", client, 255, 92, 38); 
					setElementData(client,"stomperequipped",false)

			elseif isInventoryFull(client) == false then 
					addPlayerItem(client,itemname)
					--outputStatusInfo("< M37 Stomper", client, 255, 92, 38); 
					setElementData(client,"stomperequipped",false)  
					triggerEvent("RefreshDraw",client)
			
	end	
	end
	
	if itemname == "Rifle" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 33)
					 createObjectItem("Rifle",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 33)
					 triggerEvent("RefreshDraw",client)
			end
			
	triggerClientEvent ("CleanWeap", client, client, getSlotFromWeapon(33))	
	end	
	
	if itemname == "Sniper Rifle" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 34)
					 createObjectItem("Sniper Rifle",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 34)
					 triggerEvent("RefreshDraw",client)
			end
			
	triggerClientEvent ("CleanWeap", client, client, getSlotFromWeapon(34))	
	end

	if itemname == "Rocket Launcher" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 35)
					 createObjectItem("Rocket Launcher",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 35)
					 triggerEvent("RefreshDraw",client)
			end
			
	triggerClientEvent ("CleanWeap", client, client, getSlotFromWeapon(35))	
	end	
	
	if itemname == "Stinger Launcher" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 36)
					 createObjectItem("Stinger Launcher",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 36)
					 triggerEvent("RefreshDraw",client)
			end
			
	triggerClientEvent ("CleanWeap", client, client, getSlotFromWeapon(36))	
	end	

	if itemname == "Flamethrower" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 37)
					 createObjectItem("Flamethrower",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client,255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 37)
					 triggerEvent("RefreshDraw",client)
			end
			
	triggerClientEvent ("CleanWeap", client, client, getSlotFromWeapon(37))	
	end	

	if itemname == "Grenade" then
			local ammo = getPedTotalAmmo(client,8)
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 setWeaponAmmo(client,16,ammo-1)
					 createObjectItem("Grenade",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 setWeaponAmmo(client,16,ammo-1)
					 triggerEvent("RefreshDraw",client)
			end
	end		
	
	if itemname == "Teargas" then
			local ammo = getPedTotalAmmo(client,8)
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 setWeaponAmmo(client,17,ammo-1)
					 createObjectItem("Teargas",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 setWeaponAmmo(client,17,ammo-1)
					 triggerEvent("RefreshDraw",client)
			end
	end	
	
	if itemname == "Molotov" then
			local ammo = getPedTotalAmmo(client,8)
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 setWeaponAmmo(client,18,ammo-1)
					 createObjectItem("Molotov",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 setWeaponAmmo(client,18,ammo-1)
					 triggerEvent("RefreshDraw",client)
			end
	end	
	
	if itemname == "Satchel Charge" then
			local ammo = getPedTotalAmmo(client,8)
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 setWeaponAmmo(client,39,ammo-1)
					 createObjectItem("Satchel Charge",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 setWeaponAmmo(client,39,ammo-1)
					 triggerEvent("RefreshDraw",client)
			end
	end	
	
	if itemname == "Spray Can" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 41)
					 createObjectItem("Spray Can",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 41)
					 triggerEvent("RefreshDraw",client)
			end
	end	
	
	if itemname == "Agent Pale" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 42)
					 createObjectItem("Agent Pale",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 42)
					 triggerEvent("RefreshDraw",client)
			end
	end	
	
	if itemname == "Binoculars" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 43)
					 createObjectItem("Binoculars",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 43)
					 triggerEvent("RefreshDraw",client)
			end
	end		
	
	if itemname == "Machete" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 10)
					 createObjectItem("Machete",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 10)
					 triggerEvent("RefreshDraw",client)
			end
	end		

	if itemname == "Kitchen Knife" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 11)
					 createObjectItem("Kitchen Knife",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 11)
					 triggerEvent("RefreshDraw",client)
			end
	end		

	if itemname == "Meatcleaver" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 12)
					 createObjectItem("Meatcleaver",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 12)
					 triggerEvent("RefreshDraw",client)
			end
	end	
	
	if itemname == "Broken Bottle" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 14)
					 createObjectItem("Broken Bottle",x,y,z-0.95, 97.3,120, 0)
					outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 14)
					 triggerEvent("RefreshDraw",client)
			end
	end	
	
	if itemname == "Nail Bat" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 15)
					 createObjectItem("Nail Bat",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client,255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 15)
					 triggerEvent("RefreshDraw",client)
			end
	end

	if itemname == "Thermal Googles" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 45)
					 createObjectItem("Thermal Googles",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 45)
					 triggerEvent("RefreshDraw",client)
			end
	end
	
	if itemname == "Night Vision Googles" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 takeWeapon(client, 44)
					 createObjectItem("Night Vision Googles",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 takeWeapon(client, 44)
					 triggerEvent("RefreshDraw",client)
			end
	end
	
	if itemname == "Headlamp" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 
					 createObjectItem("Headlamp",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client,255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 
					 triggerEvent("RefreshDraw",client)
			end
			
			if isFlon[client] then --turn lamp off before unequip
				triggerClientEvent (client, "ToggleHeadlamp", client)
			end
			
				triggerClientEvent (client, "UnequipHeadlamp", client)
				triggerClientEvent (client, "ToggleHeadlampObj", client)
			
	setElementData(client,"headlampequipped",false)
	end
	
	if itemname == "Medikit" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 
					 createObjectItem("Medikit",x,y,z-0.95, 97.3,120, 0)
					outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 
					 triggerEvent("RefreshDraw",client)
			end
			
		setElementData(client,"medikitequipped",false)
	end
	
	if itemname == "Mine" then
	
	local explosivetraps = getElementData(client,"explosivetraps")
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 
					 createObjectItem("Mine",x,y,z-0.95, 97.3,120, 0)
					outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 
					 triggerEvent("RefreshDraw",client)
			end
			setElementData(client,"explosivetraps",explosivetraps-1)
	end
	
	if itemname == "Incendiary Trap" then
	
	local incendiarytraps = getElementData(client,"incendiarytraps")
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 
					 createObjectItem("Incendiary Trap",x,y,z-0.95, 97.3,120, 0)
					outputInteractInfo("- "..itemname, client, 255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 
					 triggerEvent("RefreshDraw",client)
			end
			setElementData(client,"incendiarytraps",incendiarytraps-1)
	end
	
	if itemname == "Shards Trap" then
	
	local glasstraps = getElementData(client,"glasstraps")
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 
					 createObjectItem("Shards Trap",x,y,z-0.95, 97.3,120, 0)
					outputInteractInfo("- "..itemname, client,255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 
					 triggerEvent("RefreshDraw",client)
			end
			setElementData(client,"glasstraps",glasstraps-1)
	end
	
	if itemname == "Timed Bomb" then
	
	local timedbombs = getElementData(client,"timedbombs")
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 
					 createObjectItem(itemname,x,y,z-0.95, 97.3,120, 0)
					outputInteractInfo("- "..itemname, client,255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 
					 triggerEvent("RefreshDraw",client)
			end
			setElementData(client,"timedbombs",timedbombs-1)
	end
	
	if itemname == "Spikestrip" then --retrieveEquippedItem
	
	local spikestrips = getElementData(client,"spikestrips")
	
		if isInventoryFull(client) == true then -- drop item if inventory is full
				createObjectItem(itemname,x,y,z-0.95, 97.3,120, 0); 
				outputInteractInfo("- "..itemname, client, 255, 92, 38); 
				
		elseif isInventoryFull(client) == false then 
				addPlayerItem(client,itemname)
				triggerEvent("RefreshDraw",client)
				--outputStatusInfo("< Spikestrip", client, 255, 92, 38); 
		
		end	
		setElementData(client,"spikestrips",spikestrips-1)
	end
	
	if itemname == "Toolbox" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 
					 createObjectItem("Toolbox",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client,255, 92, 38)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 
					 triggerEvent("RefreshDraw",client)
			end
		setElementData(client,"toolboxequipped",false)

	end	

	if itemname == "Zip Line" then
	
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 
					 createObjectItem("Zip Line",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					 outputInteractInfo(""..itemname.." detached", client, 255, 200, 0)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 outputInteractInfo(""..itemname.." detached", client, 255, 200, 0)
					 triggerEvent("RefreshDraw",client)
			end
		setElementData(client,"zipline",false)

	end	
	
	if itemname == "Laser Pointer" then
		local player = client
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 
					 createObjectItem("Laser Pointer",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					 outputInteractInfo(""..itemname.." detached", client, 255, 200, 0)
					 triggerClientEvent(client,"EnableDisableLaserPointer",client,player,false)
					
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 outputInteractInfo(""..itemname.." detached", client, 255, 200, 0)
					 triggerEvent("RefreshDraw",client)
					 triggerClientEvent(client,"EnableDisableLaserPointer",client,player,false)
			end
		setElementData(client, "laserpointer", false, true)
	end
	
	if itemname == "Backpack" then
	
			if isBackpackPopulated (client) then
				outputStatusInfo("Empty Backpack first!", client, 255, 0, 0)
				return
			end
			
			if isInventoryFull(client) == true then -- drop backpack if inventory is full (this necessary?) 
					 
					 createObjectItem("Backpack",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
					 
			elseif isInventoryFull(client) == false then-- drop backpack if the first three inventory slots are full, otherwise you'll add it to the inventory but won't be able to access it without equipping another backpack
			local d1 = PlayersItens[client][1] or false
			local d2 = PlayersItens[client][2] or false
			local d3 = PlayersItens[client][3] or false
			
				if d1 and d2 and d3 then 
					createObjectItem("Backpack",x,y,z-0.95, 97.3,120, 0)
					outputInteractInfo("- "..itemname, client, 255, 92, 38)
				end
			else
		
					 addPlayerItem(client,itemname)
				     triggerEvent("RefreshDraw",client)
			end
			
		setElementData(client,"backpackequipped",false)
		triggerClientEvent(client,"hideInventorySlots",client)
		
			if elementBackpack[client] then --clean backpack-on-back object
				exports.bone_attach:detachElementFromBone(elementBackpack[client])
				destroyElement(elementBackpack[client])
				elementBackpack[client] = false
			end
	end	
	
	if itemname == "Hazmat Suit" then
		local player = client
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 createObjectItem("Hazmat Suit",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 outputInteractInfo(""..itemname.." unequipped", client, 255, 200, 0)
					 triggerEvent("RefreshDraw",client)
			end
		setElementData(client,"hazmatequipped",false,true)

	end
	
	if itemname == "Camouflage Suit" then
		local player = client
			if isInventoryFull(client) == true then -- drop item if inventory is full
					 createObjectItem("Camouflage Suit",x,y,z-0.95, 97.3,120, 0)
					 outputInteractInfo("- "..itemname, client, 255, 92, 38)
			elseif isInventoryFull(client) == false then 
					 addPlayerItem(client,itemname)
					 outputInteractInfo(""..itemname.." unequipped", client, 255, 200, 0)
					 triggerEvent("RefreshDraw",client)
			end
		setElementData(client,"camoequipped",false,true)
	end
	--savePlayer(client)
end
addEventHandler("onPlayerRetrieveEquippedItem",root, retrieveEquippedItem)

function inventoryInteract (name,index) -- moves an item to belt/equipment - mouse3

local moved = false
local pistolammo = getElementData(client,"pistolammo") or false
local taserammo = getElementData(client,"taserammo") or false
local crossbowammo = getElementData(client,"crossbowammo") or false
local smgammo = getElementData(client,"smgammo") or false
local shotgunammo = getElementData(client,"shotgunammo") or false
local assaultammo = getElementData(client,"assaultammo") or false
local rifleammo = getElementData(client,"rifleammo") or false
local stomperammo = getElementData(client,"stomperammo") or 0
local belt_full = isBeltFull(client)
local playerHasFreeEquipmentSlots = getElementData(client,"equipment_slots_free") or false
local weight = equippmentWeight(client)

--triggerClientEvent(client,"ReopenTradePanel",client)

--[[if belt_full == true and hasPlayerBeltItem(name,client)== true then -- case 1, belt full, ammo item had]]


if name=="Shotgun Ammo" then 
	outputInteractInfo("> Shotgun Ammo", client,255,200,0) 
	if getPedWeapon(client,3) == 25 then giveWeapon(client,25,8) elseif getPedWeapon(client,3) == 26 then giveWeapon(client,26,8) elseif getPedWeapon(client,3) == 27 then giveWeapon(client,27,8) else setElementData(client,"shotgunammo",shotgunammo+8) end
	moved=true
	
elseif name=="SMG Ammo" then 
	outputInteractInfo("> SMG Ammo", client,255,200,0) 
	if getPedWeapon(client,4) == 28 then giveWeapon(client,28,30) elseif getPedWeapon(client,4) == 29  then giveWeapon(client,29,30) elseif getPedWeapon(client,4) == 32 then giveWeapon(client,32,30) else setElementData(client,"smgammo",smgammo+30) end
	moved=true
	
elseif name=="Pistol Ammo" then 
	outputInteractInfo("> Pistol Ammo", client,255,200,0) 
	if getPedWeapon(client,2) == 22 then giveWeapon(client,22,10) else setElementData(client,"pistolammo",pistolammo+10) end
	moved=true
	
elseif name=="Assault Ammo" then 
	outputInteractInfo("> Assault Ammo", client,255,200,0) 
	if getPedWeapon(client,5) == 30 then giveWeapon(client,30,30) elseif getPedWeapon(client,5) == 31 then giveWeapon(client,31,30) else setElementData(client,"assaultammo",assaultammo+30) end
	moved=true
	
elseif name=="Rifle Ammo" then 
	outputInteractInfo("> Rifle Ammo", client,255,200,0) 
	if getPedWeapon(client,6) == 33 then giveWeapon(client,33,5) elseif getPedWeapon(client,6) == 34 then giveWeapon(client,34,5) else	setElementData(client,"rifleammo",rifleammo+5) end
	moved=true
	
elseif name=="Magnum Ammo" then 
	outputInteractInfo("> Magnum Ammo", client,255,200,0) 
	if getPedWeapon(client,2) == 24 then giveWeapon(client,24,6) else setElementData(client,"taserammo",taserammo+6) end 
	moved=true
	
elseif name=="Bolts" then 
	if getPedWeapon(client,2) == 23 then giveWeapon(client,23,5) else setElementData(client,"crossbowammo",crossbowammo+5) end
	outputInteractInfo("> Bolts", client,255,200,0) 
	moved=true	
	
elseif name=="Stomper Ammo" then 
	outputInteractInfo("> Stomper Ammo", client,255,200,0) 
	if stomperammo then setElementData(client,"stomperammo",stomperammo+5) end
	moved=true

elseif name =="Map" then
	if hasPlayerBeltItem ("Map", client)  or hasPlayerBeltItem ("Survivor Map", client) or hasPlayerBeltItem ("Military Map", client) then 
		outputInteractInfo("[ already equipped! ]", client, 255,230,0)
	else  
		addPlayerBeltItem(client,"Map"); 
		moved=true; 
		setElementData(client,"currentmap","Map")
		outputTopBar("Use [M] to open "..name.."", client, 255,200,0, 3000);
		outputInteractInfo("> "..name.."", client, 255,200,0, 3000);
	end

elseif name =="Military Map" then
	if hasPlayerBeltItem ("Map", client)  or hasPlayerBeltItem ("Survivor Map", client) or hasPlayerBeltItem ("Military Map", client) then 
		outputInteractInfo("[ already equipped! ]", client, 255,230,0)
	else  
		addPlayerBeltItem(client,"Military Map"); 
		moved=true; 
		setElementData(client,"currentmap","Military Map")
		outputTopBar("Use [M] to open "..name.."", client, 255,200,0, 3000);
		outputInteractInfo("> "..name.."", client, 255,200,0, 3000);
	end

elseif name =="Survivor Map" then
	if hasPlayerBeltItem ("Map", client)  or hasPlayerBeltItem ("Survivor Map", client) or hasPlayerBeltItem ("Military Map", client) then 
		outputInteractInfo("[ already equipped! ]", client, 255,230,0)
	else  
		addPlayerBeltItem(client,"Survivor Map"); 
		moved=true; 
		setElementData(client,"currentmap","Survivor Map")
		outputTopBar("Use [M] to open "..name.."", client, 255,200,0, 3000);
		outputInteractInfo("> "..name.."", client, 255,200,0, 3000);
	end
	
elseif name =="Medikit" and playerHasFreeEquipmentSlots then 
	if weight > 5 then 
		
		outputInteractInfo("[ + weight! ]", client, 255,200,0, 3000)
	else
		if getElementData(client,"medikitequipped") == true then 
			outputInteractInfo("[ already equipped! ]", client, 255,230,0) 
			return
		else
			triggerClientEvent("MedikitEquipped",client)
			outputInteractInfo("> Medikit", client, 255,200,0)
			moved = true
		end
	end	
	
elseif name=="Toolbox" and playerHasFreeEquipmentSlots then 
	if weight > 5 then 
		
	outputInteractInfo("[ + weight! ]", client, 255,200,0, 3000)
	else
		if getElementData(client,"toolboxequipped") == true then 
		outputInteractInfo("[ already equipped! ]", client, 255,230,0) 
		return
		else
		triggerClientEvent("ToolboxEquipped",client)
		outputInteractInfo("> Toolbox", client, 255,200,0)
		moved = true
		end
	end
	
elseif name=="Mine" and playerHasFreeEquipmentSlots then
	--if weight > 5.5 then 
	--	outputInteractInfo("[ + weight! ]", client, 255,200,0, 3000)
	--else
		local explosivetraps = getElementData(client,"explosivetraps") or 0
		if getElementData(client,"explosivetraps") < 0 then explosivetraps = 0 end
		setElementData(client,"explosivetraps",explosivetraps+1)
		outputInteractInfo("> Mine", client, 255,200,0)
		moved = true
	--end
	
elseif name=="Zip Line" and playerHasFreeEquipmentSlots then
	if getPedWeapon(client,2) ~= 23 then 
			outputTopBar("HINT: Equip a Crossbow to use Zip Line.", client, 255,200,0)
			outputInteractInfo("[ equip suitable weapon first! ]", client, 255,200,0, 3000)
	else
			if getElementData(client,"zipline") == true then 
			outputInteractInfo("[ already equipped! ]", client, 255,200,0) 
			return
			else
			setElementData(client,"zipline",true,true)
			outputInteractInfo("> Zip Line", client, 255,200,0)
			moved = true
			end
	end
	
	
elseif name=="Incendiary Trap" and playerHasFreeEquipmentSlots then 
	--if weight > 5.5 then 
	--	outputInteractInfo("[ + weight! ]", client, 255,200,0, 3000)
	--else
		local incendiarytraps = getElementData(client,"incendiarytraps") or 0
		if getElementData(client,"incendiarytraps") < 0 then incendiarytraps = 0 end
		setElementData(client,"incendiarytraps",incendiarytraps+1)
		outputInteractInfo("> Incendiary Trap", client, 255,200,0)
		moved = true
	--end
	
elseif name=="Shards Trap" and playerHasFreeEquipmentSlots then
	--if weight > 5.5 then 
	--	outputInteractInfo("[ +weight! ]", client, 255,200,0, 3000)
	--else
		local glasstraps = getElementData(client,"glasstraps") or 0
		if getElementData(client,"glasstraps") < 0 then glasstraps = 0 end
		setElementData(client,"glasstraps",glasstraps+1)
		outputInteractInfo("> Shards Trap", client, 255,200,0)
		moved = true
	--end
	
elseif name=="Timed Bomb" and playerHasFreeEquipmentSlots then
	--if weight > 5.5 then 
	--	outputInteractInfo("[ +weight! ]", client, 255,200,0, 3000)
	--else
		local timedbombs = getElementData(client,"timedbombs") or 0
		if (not timedbombs) or (timedbombs <0) then timedbombs = 0; setElementData(client,"timedbombs",0) end
		setElementData(client,"timedbombs",timedbombs+1)
		outputInteractInfo("> Timed Bomb", client, 255,200,0)
		moved = true
	--end

elseif name=="Painkillers"  and not belt_full then 
	outputInteractInfo("> Painkillers", client,255,200,0) 
	addPlayerBeltItem(client,"Painkillers")
	moved=true

elseif name=="Bandage" and not belt_full then 
	outputInteractInfo("> Bandage", client,255,200,0) 
	addPlayerBeltItem(client,"Bandage")
	moved=true
	
elseif name=="Adrenaline" and not belt_full  then 
 
	addPlayerBeltItem(client,"Adrenaline") 
	triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
	moved=true
	outputInteractInfo("> "..name.."", client,255,200,0)

elseif name=="ZomboKleen" and not belt_full  then 
 
	addPlayerBeltItem(client,"ZomboKleen") 
	triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
	moved=true
	outputInteractInfo("> "..name.."", client,255,200,0)

elseif name=="Splint" and not belt_full  then 
 
	addPlayerBeltItem(client,"Splint") 
	triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
	moved=true
	outputInteractInfo("> "..name.."", client,255,200,0)
	
elseif name=="Road Flare" and not belt_full  then 
 
	addPlayerBeltItem(client,"Road Flare") 
	triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
	moved=true
	outputInteractInfo("> "..name.."", client,255,200,0)

elseif name=="Lighter" and not belt_full  then 
 
	addPlayerBeltItem(client,"Lighter") 
	triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
	moved=true
	outputInteractInfo("> "..name.."", client,255,200,0)
	
elseif name=="EM Scanner" and not belt_full  then 
 
	addPlayerBeltItem(client,"EM Scanner") 							
	triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
	triggerClientEvent(client,"ScannerEquipped",client)
	moved=true
	outputInteractInfo("> "..name.."", client,255,200,0)

elseif name=="Radio" and not belt_full  then 
 
	addPlayerBeltItem(client,"Radio") 
	triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
	moved=true
	outputInteractInfo("> "..name.."", client,255,200,0)

elseif name=="Stinger Missile" and not belt_full  then 
 
	addPlayerBeltItem(client,"Stinger Missile") 
	triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
	moved=true
	outputInteractInfo(""..name.."", client,255,200,0)

elseif name=="Spikestrip" and playerHasFreeEquipmentSlots  then --inventoryInteract
	-- if weight > 5.5 then 
	--		outputInteractInfo("[ +weight! ]", client, 255,200,0, 3000)
	--	else
			local spikestrips = getElementData(client,"spikestrips") or 0
			if (not spikestrips) or (spikestrips <0) then spikestrips = 0; setElementData(client,"spikestrips",0) end
			setElementData(client,"spikestrips",spikestrips+1)
			outputInteractInfo("> Spikestrip", client, 255,200,0)
			moved = true
	--	end
	--[[addPlayerBeltItem(client,"Spikestrip") 
	triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
	moved=true
	outputInteractInfo(""..name.."", client,255,200,0)]]

else 
	if belt_full or not playerHasFreeEquipmentSlots then 
	outputInteractInfo("[ no free slot! ]", client, 250, 200, 0)
	else
	outputInteractInfo("[ undefined error ]", client, 250, 200, 0)
	end
end 
	
--[[elseif belt_full == true and hasPlayerBeltItem(name,client) == false then	-- case 2, belt full, item not had
				if name=="Shotgun Ammo" then 
					outputInteractInfo("Slugs \n[ stashed ]", client,255,200,0) 
					if getPedWeapon(client,3) == 25 then giveWeapon(client,25,8) elseif getPedWeapon(client,3) == 26 then giveWeapon(client,26,8) elseif getPedWeapon(client,3) == 27 then giveWeapon(client,27,8) else setElementData(client,"shotgunammo",shotgunammo+8) end
					moved=true
					
				elseif name=="SMG Ammo" then 
					outputInteractInfo("SMG Ammo \n[ stashed ]", client,255,200,0) 
					if getPedWeapon(client,4) == 28 then giveWeapon(client,28,30) elseif getPedWeapon(client,4) == 29  then giveWeapon(client,29,30) elseif getPedWeapon(client,4) == 32 then giveWeapon(client,32,30) else setElementData(client,"smgammo",smgammo+30) end
					moved=true
					
				elseif name=="Pistol Ammo" then 
					outputInteractInfo("Pistol Ammo \n[ stashed ]", client,255,200,0) 
					if getPedWeapon(client,2) == 22 then giveWeapon(client,22,10) else setElementData(client,"pistolammo",pistolammo+10) end
					moved=true
					
				elseif name=="Assault Ammo" then 
					outputInteractInfo("Assault Ammo \n[ stashed ]", client,255,200,0) 
					if getPedWeapon(client,5) == 30 then giveWeapon(client,30,30) elseif getPedWeapon(client,5) == 31 then giveWeapon(client,31,30) else setElementData(client,"assaultammo",assaultammo+30) end
					moved=true
					
				elseif name=="Rifle Ammo" then 
					outputInteractInfo("Rifle Ammo \n[ stashed ]", client,255,200,0) 
					if getPedWeapon(client,6) == 33 then giveWeapon(client,33,5) elseif getPedWeapon(client,6) == 34 then giveWeapon(client,34,5) else	setElementData(client,"rifleammo",rifleammo+5) end
					moved=true
					
				elseif name=="Magnum Ammo" then 
					outputInteractInfo("Magnum Ammo \n[ stashed ]", client,255,200,0) 
					if getPedWeapon(client,2) == 24 then giveWeapon(client,24,6) else setElementData(client,"taserammo",taserammo+6) end 
					moved=true
					
				elseif name=="Bolts" then 
					outputInteractInfo("Bolts \n[ stashed ]", client,255,200,0) 
					if getPedWeapon(client,2) == 23 then giveWeapon(client,23,5) else setElementData(client,"crossbowammo",crossbowammo+5) end
					moved=true
				else
				outputStatusInfo("Utility belt full", client, 200, 0, 0)
				end

elseif 	belt_full == false and hasPlayerBeltItem(name,client) == false then -- case 3, belt empty, item not had 

				if name=="Shotgun Ammo"  then --and isBeltFull(client) == false
					if getPedWeapon(client,3) == 25 then giveWeapon(client,25,8) elseif getPedWeapon(client,3) == 26 then giveWeapon(client,26,8) elseif getPedWeapon(client,3) == 27 then giveWeapon(client,27,8) else	setElementData(client,"shotgunammo",shotgunammo+8) end
					--addPlayerBeltItem(client,"Shotgun Ammo")
					moved=true
					outputInteractInfo(""..name.." \n[ stashed ]", client,255,200,0)

				elseif name=="SMG Ammo" then -- --and isBeltFull(client) == false  BUG HERE IF BELT FULL YOU CANNOT ADD MORE BULLETS TO A STACK YOU ALREADY HAVE
					if getPedWeapon(client,4) == 28 then giveWeapon(client,28,30) elseif getPedWeapon(client,4) == 29  then giveWeapon(client,29,30) elseif getPedWeapon(client,4) == 32 then giveWeapon(client,32,30) else	setElementData(client,"smgammo",smgammo+30) end 
					--addPlayerBeltItem(client,"SMG Ammo") 
					moved=true
					outputInteractInfo(""..name.." \n[ stashed ]", client,255,200,0)

				elseif name=="Pistol Ammo"  then -- --and isBeltFull(client) == false BUG HERE IF BELT FULL YOU CANNOT ADD MORE BULLETS TO A STACK YOU ALREADY HAVE
					if getPedWeapon(client,2) == 22 then giveWeapon(client,22,10) else	setElementData(client,"pistolammo",pistolammo+10) end
					--addPlayerBeltItem(client,"Pistol Ammo")  
					moved=true
					outputInteractInfo(""..name.." \n[ stashed ]", client,255,200,0)

				elseif name=="Assault Ammo"  then -- --and isBeltFull(client) == false  BUG HERE IF BELT FULL YOU CANNOT ADD MORE BULLETS TO A STACK YOU ALREADY HAVE
					if getPedWeapon(client,5) == 30 then giveWeapon(client,30,30) ; setElementData(client,"assaultammo",assaultammo+30)	elseif getPedWeapon(client,5) == 31 then giveWeapon(client,31,30) ; setElementData(client,"assaultammo",assaultammo+30)	else setElementData(client,"assaultammo",assaultammo+30) end
					--addPlayerBeltItem(client,"Assault Ammo") 
					moved=true
					outputInteractInfo(""..name.." \n[ stashed ]", client,255,200,0)

				elseif name=="Rifle Ammo"  then -- --and isBeltFull(client) == false BUG HERE IF BELT FULL YOU CANNOT ADD MORE BULLETS TO A STACK YOU ALREADY HAVE
					if getPedWeapon(client,6) == 33 then giveWeapon(client,33,5) elseif getPedWeapon(client,6) == 34 then giveWeapon(client,34,5) else	setElementData(client,"rifleammo",rifleammo+5) end
					--addPlayerBeltItem(client,"Rifle Ammo") 
					moved=true
					outputInteractInfo(""..name.." \n[ stashed ]", client,255,200,0)

				elseif name=="Bolts" then --and isBeltFull(client) == false  BUG HERE IF BELT FULL YOU CANNOT ADD MORE BULLETS TO A STACK YOU ALREADY HAVE
					if getPedWeapon(client,2) == 23 then giveWeapon(client,23,5) else setElementData(client,"crossbowammo",crossbowammo+5) end
					--addPlayerBeltItem(client,"Bolts") 
					moved=true
					outputInteractInfo(""..name.." \n[ stashed ]", client,255,200,0)
				
				elseif name=="Stomper Ammo" then 
					outputInteractInfo("Stomper Ammo moved to belt", client,255,200,0) 
					if stomperammo then setElementData(client,"stomperammo",stomperammo+5) end
					addPlayerBeltItem(client,"Stomper Ammo") 
					moved=true
					
				elseif name=="Magnum Ammo" then --and isBeltFull(client) == false  BUG HERE IF BELT FULL YOU CANNOT ADD MORE BULLETS TO A STACK YOU ALREADY HAVE
					if getPedWeapon(client,2) == 24 then giveWeapon(client,24,6) else setElementData(client,"taserammo",taserammo+6) end 
					--addPlayerBeltItem(client,"Magnum Ammo")
					moved=true
					outputInteractInfo(""..name.." \n[ stashed ]", client,255,200,0)

				elseif name=="Map" and isBeltFull(client) == false then
					if hasPlayerBeltItem ("Map", client)  or hasPlayerBeltItem ("Survivor Map", client) or hasPlayerBeltItem ("Military Map", client) then 
						outputInteractInfo("Map already equipped!", client, 255,200,0)
					else  
						addPlayerBeltItem(client,"Map"); 
						moved=true; 
						setElementData(client,"currentmap","Map")
			  
						outputInteractInfo("[M] "..name.."", client, 255,200,0, 3000);
						triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
					end
					
				elseif name=="Survivor Map" and isBeltFull(client) == false then
					if hasPlayerBeltItem ("Map", client)  or hasPlayerBeltItem ("Survivor Map", client) or hasPlayerBeltItem ("Military Map", client) then  
						outputInteractInfo("Map already equipped!", client, 255,200,0)
					else  
						addPlayerBeltItem(client,"Survivor Map"); 
						moved=true; 
						setElementData(client,"currentmap","Survivor Map")

						outputInteractInfo("[M] "..name.."", client, 255,200,0, 3000);
						triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
					end

				elseif name=="Military Map" and isBeltFull(client) == false then
					if hasPlayerBeltItem ("Map", client)  or hasPlayerBeltItem ("Survivor Map", client) or hasPlayerBeltItem ("Military Map", client) then  
						outputInteractInfo("Map already equipped!", client, 255,200,0)
					else  
						addPlayerBeltItem(client,"Military Map"); 
						moved=true; 
						setElementData(client,"currentmap","Military Map")

						outputInteractInfo("[M] "..name.."", client, 255,200,0, 3000);
						triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
					end

				elseif name =="Medikit" then 
					if weight > 5 then 
					
						outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
					else
						if getElementData(client,"medikitequipped") == true then 
						outputInteractInfo("Medikit already equipped!", client, 255,200,0) 
						return
						else
						triggerClientEvent("MedikitEquipped",client)
						moved = true
						end
					end	
					
				elseif name=="Toolbox" then --and isBeltFull(client) == false 
				if weight > 5 then 
				
					outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
				else
					if getElementData(client,"toolboxequipped") == true then 
					outputInteractInfo("Toolbox already equipped!", client, 255,200,0) 
					return
					else
					triggerClientEvent("ToolboxEquipped",client)
					moved = true
					end
				end	

				elseif name=="Painkillers" and isBeltFull(client) == false then 
				addPlayerBeltItem(client,"Painkillers") 
				triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
				moved=true
				outputInteractInfo(""..name.." moved to belt", client,255,200,0)
				
				elseif name=="Lighter" and isBeltFull(client) == false then 
				addPlayerBeltItem(client,"Lighter") 
				triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
				moved=true
				outputInteractInfo(""..name.." moved to belt", client,255,200,0)
				
				elseif name=="Bandage" and isBeltFull(client) == false then 
				 
				addPlayerBeltItem(client,"Bandage") 
				triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
				moved=true
				outputInteractInfo(""..name.." moved to belt", client,255,200,0)
				
				elseif name=="Adrenaline" and isBeltFull(client) == false then 
				 
				addPlayerBeltItem(client,"Adrenaline") 
				triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
				moved=true
				outputInteractInfo(""..name.." moved to belt", client,255,200,0)
				
				elseif name=="ZomboKleen" and isBeltFull(client) == false then 
				 
				addPlayerBeltItem(client,"ZomboKleen") 
				triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
				moved=true
				outputInteractInfo(""..name.." moved to belt", client,255,200,0)
				
				elseif name=="Splint" and isBeltFull(client) == false then 
				 
				addPlayerBeltItem(client,"Splint") 
				triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
				moved=true
				outputInteractInfo(""..name.." moved to belt", client,255,200,0)
				
				elseif name=="Road Flare" and isBeltFull(client) == false then 
				 
				addPlayerBeltItem(client,"Road Flare") 
				triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
				moved=true
				outputInteractInfo(""..name.." moved to belt", client,255,200,0)
				
				elseif name=="EM Scanner" and isBeltFull(client) == false then 
				 
				addPlayerBeltItem(client,"EM Scanner") 
				triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
				triggerClientEvent(client,"ScannerEquipped",client)
				moved=true
				outputInteractInfo("Use [K] to toggle EM Scanner", client,255,200,0)
				
				elseif name=="Radio" and isBeltFull(client) == false then 
				 
				addPlayerBeltItem(client,"Radio") 
				triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
				moved=true
				outputInteractInfo(""..name.." moved to belt", client,255,200,0)
				
				elseif name=="Stinger Missile" and isBeltFull(client) == false then 
				 
				addPlayerBeltItem(client,"Stinger Missile") 
				triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
				moved=true
				outputInteractInfo(""..name.." moved to belt", client,255,200,0)
				
				elseif name=="Spikestrip" and isBeltFull(client) == false then 
				 
				addPlayerBeltItem(client,"Spikestrip") 
				triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
				moved=true
				outputInteractInfo(""..name.." moved to belt", client,255,200,0)
				
				elseif name=="Mine" then 
					if weight > 5.5 then 
						outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
					else
						local explosivetraps = getElementData(client,"explosivetraps") or 0
						setElementData(client,"explosivetraps",explosivetraps+1)
						outputInteractInfo("Mine equipped", client, 255,200,0)
						moved = true
					end
					
				elseif name=="Incendiary Trap" then 
					if weight > 5.5 then 
						outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
					else
						local incendiarytraps = getElementData(client,"incendiarytraps") or 0
						setElementData(client,"incendiarytraps",incendiarytraps+1)
						outputInteractInfo("Incendiary Trap equipped", client, 255,200,0)
						moved = true
					end
					
				elseif name=="Shards Trap" then 
					if weight > 5.5 then 
						outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
					else
						local glasstraps = getElementData(client,"glasstraps") or 0
						setElementData(client,"glasstraps",glasstraps+1)
						outputInteractInfo("Shards Trap equipped", client, 255,200,0)
						moved = true
					end
				elseif name=="Timed Bomb" then 
					if weight > 5.5 then 
						outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
					else
						local timedbombs = getElementData(client,"timedbombs") or 0
						if (not timedbombs) or (timedbombs <0) then timedbombs = 0; setElementData(client,"timedbombs",0) end
						setElementData(client,"timedbombs",timedbombs+1)
						outputInteractInfo("Timed Bomb equipped", client, 255,200,0)
						moved = true
					end
				
				else
				end

elseif 	belt_full == false and hasPlayerBeltItem(name,client) ~= false then -- case 4, belt empty, item had
	
				if name=="Shotgun Ammo" then 
					outputInteractInfo("Shotgun Ammo moved to belt", client,255,200,0) 
					if getPedWeapon(client,3) == 25 then giveWeapon(client,25,8) elseif getPedWeapon(client,3) == 26 then giveWeapon(client,26,8) elseif getPedWeapon(client,3) == 27 then giveWeapon(client,27,8) else setElementData(client,"shotgunammo",shotgunammo+8) end
					moved=true
					
				elseif name=="SMG Ammo" then 
					outputInteractInfo("SMG Ammo moved to belt", client,255,200,0) 
					if getPedWeapon(client,4) == 28 then giveWeapon(client,28,30) elseif getPedWeapon(client,4) == 29  then giveWeapon(client,29,30) elseif getPedWeapon(client,4) == 32 then giveWeapon(client,32,30) else setElementData(client,"smgammo",smgammo+30) end
					moved=true
					
				elseif name=="Pistol Ammo" then 
					outputInteractInfo("Pistol Ammo moved to belt", client,255,200,0) 
					if getPedWeapon(client,2) == 22 then giveWeapon(client,22,10) else setElementData(client,"pistolammo",pistolammo+10) end
					moved=true
					
				elseif name=="Assault Ammo" then 
					outputInteractInfo("Assault Ammo moved to belt", client,255,200,0) 
					if getPedWeapon(client,5) == 30 then giveWeapon(client,30,30) elseif getPedWeapon(client,5) == 31 then giveWeapon(client,31,30) else setElementData(client,"assaultammo",assaultammo+30) end
					moved=true
					
				elseif name=="Rifle Ammo" then 
					outputInteractInfo("Rifle Ammo moved to belt", client,255,200,0) 
					if getPedWeapon(client,6) == 33 then giveWeapon(client,33,5) elseif getPedWeapon(client,6) == 34 then giveWeapon(client,34,5) else	setElementData(client,"rifleammo",rifleammo+5) end
					moved=true
					
				elseif name=="Magnum Ammo" then 
					outputInteractInfo("Magnum Ammo moved to belt", client,255,200,0) 
					if getPedWeapon(client,2) == 24 then giveWeapon(client,24,6) else setElementData(client,"taserammo",taserammo+6) end 
					moved=true
					
				elseif name=="Bolts" then 
					outputInteractInfo("Bolts moved to belt", client,255,200,0) 
					if getPedWeapon(client,2) == 23 then giveWeapon(client,23,5) else setElementData(client,"crossbowammo",crossbowammo+5) end
					moved=true
				
				elseif name=="Stomper Ammo" then 
					outputInteractInfo("Stomper Ammo moved to belt", client,255,200,0) 
					if stomperammo then setElementData(client,"stomperammo",stomperammo+5) end
					moved=true
				
				elseif name=="Painkillers" then 
					outputInteractInfo("Painkillers moved to belt", client,255,200,0) 
					addPlayerBeltItem(client,"Painkillers")
					moved=true
				
				elseif name =="Map" then
					if hasPlayerBeltItem ("Map", client)  or hasPlayerBeltItem ("Survivor Map", client) or hasPlayerBeltItem ("Military Map", client) then 
						outputInteractInfo("Map already equipped!", client, 255,200,0)
					else  
						addPlayerBeltItem(client,"Map"); 
						moved=true; 
						setElementData(client,"currentmap","Map")
						outputInteractInfo("[M] "..name.."", client, 255,200,0, 3000);
					end
				
				elseif name =="Military Map" then
					if hasPlayerBeltItem ("Map", client)  or hasPlayerBeltItem ("Survivor Map", client) or hasPlayerBeltItem ("Military Map", client) then 
						outputInteractInfo("Map already equipped!", client, 255,200,0)
					else  
						addPlayerBeltItem(client,"Military Map"); 
						moved=true; 
						setElementData(client,"currentmap","Military Map")
						outputInteractInfo("[M] "..name.."", client, 255,200,0, 3000);
					end
				
				elseif name =="Survivor Map" then
					if hasPlayerBeltItem ("Map", client)  or hasPlayerBeltItem ("Survivor Map", client) or hasPlayerBeltItem ("Military Map", client) then 
						outputInteractInfo("Map already equipped!", client, 255,200,0)
					else  
						addPlayerBeltItem(client,"Survivor Map"); 
						moved=true; 
						setElementData(client,"currentmap","Survivor Map")
						outputInteractInfo("[M] "..name.."", client, 255,200,0, 3000);
					end
				
				elseif name =="Medikit" then 
					if weight >= 6 then 
					
						outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
					else
						if getElementData(client,"medikitequipped") == true then 
						outputInteractInfo("Medikit already equipped!", client, 255,200,0) 
						return
						else
						triggerClientEvent("MedikitEquipped",client)
						moved = true
						end
					end	
					
				elseif name=="Toolbox" then --and isBeltFull(client) == false 
					if weight > 5 then 
					
						outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
					else
						if getElementData(client,"toolboxequipped") == true then 
						outputInteractInfo("Toolbox already equipped!", client, 255,200,0) 
						return
						else
						triggerClientEvent("ToolboxEquipped",client)
						moved = true
						end
					end
				
				elseif name=="Lighter" and isBeltFull(client) == false then 
					addPlayerBeltItem(client,"Lighter") 
					triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
					moved=true
					outputInteractInfo(""..name.." moved to belt", client,255,200,0)
				
				elseif name=="Bandage" and isBeltFull(client) == false then 
				 
					addPlayerBeltItem(client,"Bandage") 
					triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
					moved=true
					outputInteractInfo(""..name.." moved to belt", client,255,200,0)
				
				elseif name=="Adrenaline" and isBeltFull(client) == false then 
				 
					addPlayerBeltItem(client,"Adrenaline") 
					triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
					moved=true
					outputInteractInfo(""..name.." moved to belt", client,255,200,0)
				
				elseif name=="ZomboKleen" and isBeltFull(client) == false then 
				 
					addPlayerBeltItem(client,"ZomboKleen") 
					triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
					moved=true
					outputInteractInfo(""..name.." moved to belt", client,255,200,0)
				
				elseif name=="Splint" and isBeltFull(client) == false then 
				 
					addPlayerBeltItem(client,"Splint") 
					triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
					moved=true
					outputInteractInfo(""..name.." moved to belt", client,255,200,0)
				
				elseif name=="Road Flare" and isBeltFull(client) == false then 
				 
					addPlayerBeltItem(client,"Road Flare") 
					triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
					moved=true
					outputInteractInfo(""..name.." moved to belt", client,255,200,0)
				
				elseif name=="EM Scanner" and isBeltFull(client) == false then 

					outputInteractInfo("EM Scanner already equipped", client,255,200,0)
				
				elseif name=="Radio" and isBeltFull(client) == false then 
				 
					addPlayerBeltItem(client,"Radio") 
					triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
					moved=true
					outputInteractInfo(""..name.." moved to belt", client,255,200,0)
				
				elseif name=="Stomper Ammo" and isBeltFull(client) == false then 
				 
					addPlayerBeltItem(client,"Stomper Ammo") 
					triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
					moved=true
					outputInteractInfo(""..name.." moved to belt", client,255,200,0)
				
				elseif name=="Stinger Missile" and isBeltFull(client) == false then 
				 
					addPlayerBeltItem(client,"Stinger Missile") 
					triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
					moved=true
					outputInteractInfo(""..name.." moved to belt", client,255,200,0)
				
				elseif name=="Spikestrip" and isBeltFull(client) == false then 
				 
					addPlayerBeltItem(client,"Spikestrip") 
					triggerClientEvent("synchronizeBelt",client,PlayersBeltItens); 
					moved=true
					outputInteractInfo(""..name.." moved to belt", client,255,200,0)
				
				elseif name=="Mine" then 
					if weight > 5.5 then 
						outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
					else
						local explosivetraps = getElementData(client,"explosivetraps") or 0
						setElementData(client,"explosivetraps",explosivetraps+1)
						outputInteractInfo("Mine equipped", client, 255,200,0)
						moved = true
					end
					
				elseif name=="Incendiary Trap" then 
					if weight > 5.5 then 
						outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
					else
						local incendiarytraps = getElementData(client,"incendiarytraps") or 0
						setElementData(client,"incendiarytraps",incendiarytraps+1)
						outputInteractInfo("Incendiary Trap equipped", client, 255,200,0)
						moved = true
					end
					
				elseif name=="Shards Trap" then 
					if weight > 5.5 then 
						outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
					else
						local glasstraps = getElementData(client,"glasstraps") or 0
						setElementData(client,"glasstraps",glasstraps+1)
						outputInteractInfo("Shards Trap equipped", client, 255,200,0)
						moved = true
					end
				
				elseif name=="Timed Bomb" then 
					if weight > 5.5 then 
						outputInteractInfo("[ overweight! ]", client, 255,200,0, 3000)
					else
						local timedbombs = getElementData(client,"timedbombs") or 0
						if (not timedbombs) or (timedbombs <0) then timedbombs = 0; setElementData(client,"timedbombs",0) end
						setElementData(client,"timedbombs",timedbombs+1)
						outputInteractInfo("Timed Bomb equipped", client, 255,200,0)
						moved = true
					end
				
				else 
					outputInteractInfo("Utility Belt full", client, 240, 0, 0)
				end ]]
--end

if (moved == true) then
PlayersItens[client][index]="Empty"
triggerClientEvent(client,"RefreshDraw",client)
triggerClientEvent("synchronizeTables",client,PlayersItens)
--triggerClientEvent("synchronizeStrongbox",client,StrongboxItems)
triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
--triggerClientEvent(client,"synchronizeStrongboxTables",client,StrongboxItems)
triggerClientEvent(client, "sleep:drawDXProgress", client, 1000,1000)
setTimer(triggerClientEvent,1000,1,client, "sleep:stopDXProgress", client)

end
end
addEventHandler("onPlayerInteractInventoryItem",root, inventoryInteract, name, index) 

function getNerestId(p)  --finds the first empty slot in the inventory
	if isInventoryFull(p) then
		return false
	end
	for i=1, 9 do
		if PlayersItens[p][i] and PlayersItens[p][i] == "Empty" then
			return i
		end
									  
									  
									  
				
												
		
													
		
													
		
													
		
													
		
													
		
													
		
													
		
													
		
	end
	return false
end

function getNerestBeltId(p)  --finds the first empty slot in the belt
	if isBeltFull(p) then
		return false
	end
	for i=1, 9 do
		if PlayersBeltItens[p][i] and PlayersBeltItens[p][i] == "Empty" then
			return i
		end
	end
										  
										  
										  
										  
				
												
		
													
		
													
		
	return false
		
													
		
													
		
													
		
													
		
													
		
end
			 
function isInventoryFull(p) --checks if the inventory is full
local d1 = PlayersItens[p][1] or false
local d2 = PlayersItens[p][2] or false
local d3 = PlayersItens[p][3] or false
local d4 = PlayersItens[p][4] or false
local d5 = PlayersItens[p][5] or false
local d6 = PlayersItens[p][6] or false
local d7 = PlayersItens[p][7] or false
local d8 = PlayersItens[p][8] or false
local d9 = PlayersItens[p][9] or false

	if getElementData(p,"backpackequipped") == true then
		if(d1 and d1~="Empty")and(d2 and d2~="Empty")and(d3 and d3~="Empty")and(d4 and d4~="Empty")and(d5 and d5~="Empty")and(d6 and d6~="Empty")and(d7 and d7~="Empty")and(d8 and d8~="Empty")and(d9 and d9~="Empty") then
			return true
			else
			return false
		end
	elseif getElementData(p,"backpackequipped") == false then
		if(d1 and d1~="Empty")and(d2 and d2~="Empty")and(d3 and d3~="Empty") then
			return true
			else
			return false
		end
	end

end

function isBackpackPopulated (p)

local d4 = PlayersItens[p][4] or false
local d5 = PlayersItens[p][5] or false
local d6 = PlayersItens[p][6] or false
local d7 = PlayersItens[p][7] or false
local d8 = PlayersItens[p][8] or false
local d9 = PlayersItens[p][9] or false
	if (d4 and d4 ~= "Empty") or (d5 and d5 ~= "Empty") or (d6 and d6 ~= "Empty") or (d7 and d7 ~= "Empty") or (d8 and d8 ~= "Empty") or (d9 and d9 ~= "Empty") then 
		return true
	else
		return false
	end
end

function isBeltFull(p) --checks if the belt is full; returns true or false
local b1 = PlayersBeltItens[p][1] or false
local b2 = PlayersBeltItens[p][2] or false
local b3 = PlayersBeltItens[p][3] or false
local b4 = PlayersBeltItens[p][4] or false
local b5 = PlayersBeltItens[p][5] or false
local b6 = PlayersBeltItens[p][6] or false
local b7 = PlayersBeltItens[p][7] or false
local b8 = PlayersBeltItens[p][8] or false
local b9 = PlayersBeltItens[p][9] or false
if(b1 and b1~="Empty")and(b2 and b2~="Empty")and(b3 and b3~="Empty")and(b4 and b4~="Empty")and(b5 and b5~="Empty")and(b6 and b6~="Empty")and(b7 and b7~="Empty")and(b8 and b8~="Empty")and(b9 and b9~="Empty") then
return true
else
return false
end
end

function hasPlayerItem (item, p) --returns number of (certain) items and slot, takes a string: "item name"

local itemcount = 0
local slot = nil
local d1 = PlayersItens[p][1] or false
local d2 = PlayersItens[p][2] or false
local d3 = PlayersItens[p][3] or false
local d4 = PlayersItens[p][4] or false
local d5 = PlayersItens[p][5] or false
local d6 = PlayersItens[p][6] or false
local d7 = PlayersItens[p][7] or false
local d8 = PlayersItens[p][8] or false
local d9 = PlayersItens[p][9] or false

if d1 == item then itemcount = itemcount + 1; slot = 1 end
if d2 == item then itemcount = itemcount + 1; slot = 2 end
if d3 == item then itemcount = itemcount + 1; slot = 3  end
if d4 == item then itemcount = itemcount + 1; slot = 4  end
if d5 == item then itemcount = itemcount + 1; slot = 5  end
if d6 == item then itemcount = itemcount + 1; slot = 6  end
if d7 == item then itemcount = itemcount + 1; slot = 7  end
if d8 == item then itemcount = itemcount + 1; slot = 8  end
if d9 == item then itemcount = itemcount + 1; slot = 9  end

if itemcount > 0 then  
return itemcount, slot  
end
					  
if itemcount == 0  then return false end 

end

function hasPlayerBeltItem (item, p) --returns number of (certain) items or false, takes a string: "item name" and player element

local itemcount = 0
local b1 = PlayersBeltItens[p][1] or false
local b2 = PlayersBeltItens[p][2] or false
local b3 = PlayersBeltItens[p][3] or false
local b4 = PlayersBeltItens[p][4] or false
local b5 = PlayersBeltItens[p][5] or false
local b6 = PlayersBeltItens[p][6] or false
local b7 = PlayersBeltItens[p][7] or false
local b8 = PlayersBeltItens[p][8] or false
local b9 = PlayersBeltItens[p][9] or false

if b1 == item then itemcount = itemcount + 1 end
if b2 == item then itemcount = itemcount + 1 end
if b3 == item then itemcount = itemcount + 1 end
if b4 == item then itemcount = itemcount + 1 end
if b5 == item then itemcount = itemcount + 1 end
if b6 == item then itemcount = itemcount + 1 end
if b7 == item then itemcount = itemcount + 1 end
if b8 == item then itemcount = itemcount + 1 end
if b9 == item then itemcount = itemcount + 1 end

if itemcount > 0 then  return itemcount end -- and
					  
if itemcount == 0  then return false end 

end

function addPlayerItem(p,itemName) -- add item to player inventory
if isInventoryFull(p) then 
outputInteractInfo("Inventory full", p, 240, 0, 0) return 
else
local index = getNerestId(p)
PlayersItens[p][index] = itemName
syncronizePlayerItens(p,PlayersItens)
outputInteractInfo("+ "..itemName.."", p, 255,200,0)
--savePlayer(p)
end
end

function addPlayerBeltItem(p,itemName) -- add item to player belt
if isBeltFull(p) then 
    local msg = outputInteractInfo("Belt full", p, 255, 0, 0) return end
local index = getNerestBeltId(p)
PlayersBeltItens[p][index] = itemName
syncronizePlayerBeltItens(p,PlayersBeltItens)
outputInteractInfo("+ "..itemName.."", p, 255,200,0)
--savePlayer(p)
end

function getModelFromString(itemName) -- returns the object model id based on the friendly string name 
if(itemName=="Pistol Ammo")then
model = 2039
elseif(itemName=="Shotgun Ammo")then
model = 2038
elseif(itemName=="Assault Ammo")then
model = 2040
elseif(itemName=="SMG Ammo")then
model = 2041
elseif(itemName=="Chainsaw")then
model = 341
elseif(itemName=="Raider Sword")then
model = 339
elseif(itemName=="M4")then
model = 356
elseif(itemName=="AK 47")then
model = 355
elseif(itemName=="Rocket Launcher")then
model = 359
elseif(itemName=="Knife")then
model = 335
elseif(itemName=="Rifle")then
model = 357
elseif(itemName=="Crossbow")then
model = 347
elseif(itemName=="Sniper Rifle")then
model = 358
elseif(itemName=="Minigun")then 
model = 362
elseif(itemName=="Uzi")then
model = 352
elseif(itemName=="Vehicle Minigun")then
model = 372
elseif(itemName=="Combat Shotgun")then
model = 351
elseif(itemName=="Sawn-off Shotgun")then
model = 350
elseif(itemName=="Satchel Charge")then
model = 363
elseif(itemName=="MP5")then
model = 353
elseif(itemName=="Grenade")then
model = 342
elseif(itemName=="Magnum Revolver")then
model = 348
elseif(itemName=="Stinger Launcher")then
model = 360
elseif(itemName=="Meat Can")then
model = 2601
elseif(itemName=="Water Bottle")then
model = 1668
elseif(itemName=="Raw Meat")then
model = 2804
elseif(itemName=="Machete")then
model = 321
elseif(itemName=="Kitchen Knife")then
model = 322
elseif(itemName=="Meatcleaver")then
model = 323
elseif(itemName=="Broken Bottle")then
model = 325
elseif(itemName=="Nail Bat")then
model = 326
elseif(itemName=="Crowbar")then
model = 337
elseif(itemName=="Sledgehammer")then
model = 338
elseif(itemName=="Pistol")then
model = 346
elseif(itemName=="Molotov")then
model = 344
elseif(itemName=="Nightstick")then
model = 334
elseif(itemName=="Baseball Bat")then
model = 336
elseif(itemName=="Tactical Shield")then
model = 331
elseif(itemName=="Axe")then
model = 333
elseif(itemName=="Binoculars")then
model = 367
elseif(itemName=="Spray Can")then
model = 365
elseif(itemName=="Pump Shotgun")then
model = 349
elseif(itemName=="Body Armor")then
model = 373
elseif(itemName=="Backpack")then
model = 371
elseif(itemName=="Medikit")then
model = 327
elseif(itemName=="Teargas")then
model = 343
elseif(itemName=="Flamethrower")then
model = 361
elseif(itemName=="Bolts")then
model = 328 
elseif(itemName=="Magnum Ammo")then
model = 3082 
elseif(itemName=="Painkillers")then 
model = 2709
elseif(itemName=="Rifle Ammo")then
model = 2042 
elseif(itemName=="Fuel Canister")then
model = 1650
elseif(itemName=="Empty Canister")then
model = 1650
elseif(itemName=="Scrap Metal")then
model = 850
elseif(itemName=="Ammo Box")then
model = 3016
elseif(itemName=="Toolbox")then
model = 2969
elseif(itemName=="Alcohol Bottle")then
model = 1520
elseif(itemName=="Rags")then
model = 2844
elseif(itemName=="Empty Bottle")then
model = 1668
elseif(itemName=="Map")then
model = 3017
elseif(itemName=="Raw Human Meat")then
model = 2806
elseif(itemName=="Roasted Meat")then
model = 2804
elseif(itemName=="Vehicle Parts")then
model = 2711
elseif(itemName=="Roasted Human Meat")then
model = 2804
elseif(itemName=="Plastic Foil")then
model = 1901
elseif(itemName=="Wire")then
model = 933
elseif(itemName=="Fish Can")then
model = 2601
elseif(itemName=="Water Canister")then
model = 1650
elseif(itemName=="Dirty Water")then
model = 1668
elseif(itemName=="Survivor Map")then
model = 3017
elseif(itemName=="Military Map")then
model = 3017
elseif(itemName=="Headlamp")then
model = 15060
elseif(itemName=="Thermal Googles")then
model = 369
elseif(itemName=="Laser Pointer")then
model = 1549
elseif(itemName=="Wood")then
model = 1463
elseif(itemName=="Lighter")then
model = 2351
elseif(itemName=="Bandage")then
model = 2384
elseif(itemName=="Night Vision Googles")then
model = 368
elseif(itemName=="Zip Line")then
model = 1955
elseif(itemName=="Adrenaline")then
model = 2709
elseif(itemName=="ZomboKleen")then
model = 2709
elseif(itemName=="Splint")then
model = 1279
elseif(itemName=="Road Flare")then
model = 1319
elseif(itemName=="Hazmat Suit")then
model = 1576
elseif(itemName=="Camouflage Suit")then
model = 1575
elseif(itemName=="Scuba Gear")then
model = 1010
elseif(itemName=="Watch")then
model = 2710
elseif(itemName=="EM Scanner")then
model = 1615
elseif(itemName=="Radio")then
model = 330
elseif(itemName=="M37 Stomper")then
model = 2033
elseif(itemName=="Stomper Ammo")then
model = 2972
elseif(itemName=="Minigun Ammo")then
model = 2358
elseif(itemName=="Stinger Missile")then
model = 3790
elseif(itemName=="Spikestrip")then
model = 2899
elseif(itemName=="Timed Bomb")then
model = 1654
elseif(itemName=="Mine")then
model = 1381
elseif(itemName=="Incendiary Trap")then
model = 2978
elseif(itemName=="Shards Trap")then
model = 2978
elseif(itemName=="Agent Pale")then
model = 366
elseif(itemName=="Soup Can")then
model = 2601
end
return model
end

function createObjectItem(itemName,x,y,z,rx,ry,rz) -- create world item 
local model = getModelFromString(itemName)
local rx,ry,rz = rx,ry,rz 

if model == 327 then rx,ry,rz = 0, 0, math.random(0,359) end   ----------object rotation corrections
if model == 2039 then rx,ry,rz = 0, 0, math.random(0,359) end
if model == 2038 then rx,ry,rz = 0, 0, math.random(0,359) end
if model == 2040 then rx,ry,rz = 0, 0, math.random(0,359) end
if model == 2041 then rx,ry,rz = 0, 0, math.random(0,359) end
if model == 2709 then rx,ry,rz = 0, 0, math.random(0,359) end
if model == 2042 then rx,ry,rz = 0, 0, math.random(0,359) end
if model == 367 then rx,ry,rz = 0, 0, math.random(0,359) end --bin
if model == 325 then rx,ry,rz = 0, 270, math.random(0,359) end --broken bottle
if model == 2804 then rx,ry,rz = 0, 0, math.random(0,359) end --rawmeat
if model == 2601 then rx,ry,rz = 0, 0, math.random(0,359) end --meatcan
if model == 347 then rx,ry,rz = 0, 0, math.random(0,359) end --crossbow
if model == 328 then rx,ry,rz = 270, 270, math.random(0,359) end --bolts
if model == 850 then rx,ry,rz = 0, 0, math.random(0,359) end --scrap metal
if model == 3082 then rx,ry,rz = 270, 270, math.random(0,359) end --taser cartridge
if model == 1650 then rx,ry,rz = 270, 0, math.random(0,359) end --canister
if model == 3016 then rx,ry,rz = 0, 0, math.random(0,359) end --ammbox
if model == 2969 then rx,ry,rz = 0, 0, math.random(0,359) end --toolbox
if model == 331 then rx,ry,rz = 270, 0, math.random(0,359) end --tactical shield
if model == 2844 then rx,ry,rz = 0, 0, math.random(0,359) end --rags
if model == 3017 then rx,ry,rz = 0, 0, math.random(0,359) end --maps
if model == 2806 then rx,ry,rz = 0, 0, math.random(0,359) end
if model == 2804 then rx,ry,rz = 0, 0, math.random(0,359) end --Roasted Meat
if model == 2711 then rx,ry,rz = 270, 270, math.random(0,359) end --Vehicle Parts
if model == 2806 then rx,ry,rz = 0, 0, math.random(0,359) end --"Roasted Human Meat"
if model == 1901 then rx,ry,rz = 0, 270, math.random(0,359) end --"Plastic Foil
if model == 933 then rx,ry,rz = 0, 0, math.random(0,359) end --Wire
if model == 2601 then rx,ry,rz = 0, 0, math.random(0,359) end --Fish Can
if model == 15060 then rx,ry,rz = 0, 270, math.random(0,359) end --Headlamp
if model == 369 then rx,ry,rz = 0, 270, math.random(0,359) end --Thermal Googles
if model == 368 then rx,ry,rz = 0, 270, math.random(0,359) end --NV Googles
if model == 1549 then rx,ry,rz = 0, 270, math.random(0,359) end --Laser Pointer
if model == 1463 then rx,ry,rz = 0, 0, math.random(0,359) end --Wood
if model == 2351 then rx,ry,rz = 0, 0, math.random(0,359) end --Lighter
if model == 2384 then rx,ry,rz = 0, 0, math.random(0,359) end --Bandage
if model == 1955 then rx,ry,rz = 0, 0, math.random(0,359) end --Zip Line
if model == 1576 then rx,ry,rz = 0, 0, math.random(0,359) end --Hazmat
if model == 1575 then rx,ry,rz = 0, 0, math.random(0,359) end --Camo
if model == 1615 then rx,ry,rz = 0, 90, math.random(0,359) end --GPS
if model == 330 then rx,ry,rz = 90, 270, math.random(0,359) end --Radio
if model == 366 then rx,ry,rz = 90, 0, math.random(0,359) end --Fire Extinguisher
if model == 1319 then rx,ry,rz = 0, 270, math.random(0,359) end --Road Flare
if model == 2899 then rx,ry,rz = 0, 0, math.random(0,359) end --spikestrip
if model == 1654 then rx,ry,rz = 0, 90, math.random(0,359) end --timed bomb
if model == 2972 then rx,ry,rz = 0, 0, math.random(0,359) end --stomper ammo
if model == 2358 then rx,ry,rz = 0, 0, math.random(0,359) end --minigun ammo
if model == 1010 then rx,ry,rz = 0, 0, math.random(0,359) end --scuba gear
if model == 2710 then rx,ry,rz = 0, 0, math.random(0,359) end --
if model == 2033 then rx,ry,rz = 0, 0, math.random(0,359) end --
if model == 2978 then rx,ry,rz = 0, 0, math.random(0,359) end -- mine
if model == 1381 then rx,ry,rz = 0, 0, math.random(0,359) end -- trap

local ob = createObject(model,x,y,z,rx,ry,rz)
local sphereob = createColSphere(x,y,z+0.5,0.7) 
setElementData(sphereob,"item_inventory",itemName,true)
setElementDoubleSided (ob, true)
--attachElements(ob,sphereob)
setElementParent(ob,sphereob)
setElementCollisionsEnabled(ob,false)
setElementDoubleSided (ob, true)
if model == 327 then setObjectScale(ob, 1.5)			---------- object scales
elseif model == 2039 then setObjectScale(ob, 1.6) -- ammo start
elseif model == 2038 then setObjectScale(ob, 1.6)
elseif model == 2040 then setObjectScale(ob, 1.6)
elseif model == 2041 then setObjectScale(ob, 1.6)
elseif model == 2709 then setObjectScale(ob, 2.0)
elseif model == 2042 then setObjectScale(ob, 1.6) --ammo end
elseif model == 850 then setObjectScale(ob, 0.2) --scrap metal
elseif model == 1650 then setObjectScale(ob, 1.5) --canister
elseif model == 3082 then setObjectScale(ob, 0.1) --taser cartridge
elseif model == 3016 then setObjectScale(ob, 0.8) --ammo box
elseif model == 2969 then setObjectScale(ob, 0.7) --ammo box
elseif model == 2844 then setObjectScale(ob, 0.5) --rags
elseif model == 1520 then setObjectScale(ob, 0.8) --alcohol
elseif model == 3017 then setObjectScale(ob, 0.4) --maps
elseif model == 2806 then setObjectScale(ob, 0.6)
elseif model == 2804 then setObjectScale(ob, 0.6)--Roasted Meat
elseif model == 2711 then setObjectScale(ob, 3.3)--Vehicle Parts
elseif model == 2804 then setObjectScale(ob, 0.6)--Roasted Human Meat
elseif model == 1901 then setObjectScale(ob, 3)--Plastic Foil
elseif model == 933 then setObjectScale(ob, 0.15)--Wire
elseif model == 1650 then setObjectScale(ob, 1.5)--Water Canister
elseif model == 15060 then setObjectScale(ob, 1)  --Headlamp
elseif model == 368 then setObjectScale(ob, 1)  --night googs
elseif model == 369 then setObjectScale(ob, 1)  --Thermal Googles
elseif model == 1549 then setObjectScale(ob, 0.2)  --Laser Pointer
elseif model == 1463 then setObjectScale(ob, 0.3)  --Wood
elseif model == 2351 then setObjectScale(ob, 0.25)  --Lighter
elseif model == 2384 then setObjectScale(ob, 0.4)  --Bandage
elseif model == 1955 then setObjectScale(ob, 1)  --Zip Line
elseif model == 1279 then setObjectScale(ob, 0.3)  --Splint
elseif model == 1615 then setObjectScale(ob, 0.2)  --GPS
elseif model == 2972 then setObjectScale(ob, 0.2)  --Stomper Ammo
elseif model == 3790 then setObjectScale(ob, 0.2)  --Stinger missile
elseif model == 2899 then setObjectScale(ob, 0.2)  --spikestrip
elseif model == 1319 then setObjectScale(ob, 0.2)  --road flare
elseif model == 2358 then setObjectScale(ob, 0.8)  --minigun ammo
elseif model == 1381 then setObjectScale(ob, 0.09)  -- Mine
elseif model == 2978 then setObjectScale(ob, 0.2)  -- Trap
 end
return ob
end

busyPlayers = {} -- create a table of busy players so you cannot pick up something multiple times
addEvent("pickupItemFromGroundButton",true)
function takeItemC(p,k,ks) -- this happens when you pick up a world item
if getElementData(p, "carriedObject") then outputInteractInfo("Drop object first!\n[H]", p, 240, 240, 0) return end
if busyPlayers[p] then return end
local itemPlayer = PlayersAtualItem[p]
if(itemPlayer)and isElement(itemPlayer)then
busyPlayers[p] = true
setPedAnimation(p,"BOMBER","BOM_Plant")
setTimer(function()setPedAnimation(p); busyPlayers[p] = nil end,800,1)

triggerClientEvent(p, "sleep:drawDXProgress", p, 1000,1000)
setTimer(triggerClientEvent,1000,1,p, "sleep:stopDXProgress", p)

addPlayerItem(p,playerSt[p])
--outputCurrentWorldItem( "", p,false )
attachedElements = getAttachedElements ( p ) 
destroyElement(itemPlayer)
triggerClientEvent(root,"synchronizeTables",p,PlayersItens)
end
end
addCommandHandler("Pickup item",takeItemC)

function takeItemCfromGround(itemcol) 
if getElementData(source, "carriedObject") then outputInteractInfo("Drop object first!\n[H]", source, 240, 240, 0) return end
if isInventoryFull(source) then outputInteractInfo("Inventory full", source, 240, 0, 0) return end
if busyPlayers[source] then return end
local itemName = getElementData(itemcol,"item_inventory")
local itemPlayer = itemcol
if(itemPlayer)and isElement(itemPlayer)then
busyPlayers[source] = true
setPedAnimation(source,"BOMBER","BOM_Plant")
local ped = source
setTimer(function()setPedAnimation(ped); busyPlayers[ped] = nil end,800,1)

triggerClientEvent(source, "sleep:drawDXProgress", source, 1000,1000)
setTimer(triggerClientEvent,1000,1,source, "sleep:stopDXProgress", source)

addPlayerItem(source,itemName)
--outputCurrentWorldItem( "", p,false )
local attachedElements = getAttachedElements ( itemcol ) 
for i,v in ipairs(attachedElements) do destroyElement(v) end
destroyElement(itemcol)
triggerClientEvent(root,"synchronizeTables",source,PlayersItens)
end
end
addEventHandler("pickupItemFromGroundButton",root,takeItemCfromGround)

function getObjCoronaColor(itemName) --determines item corona color based on item name
local r,g,b 
if itemName == "Water Bottle" or itemName == "Alcohol Bottle" or itemName == "Dirty Water" or itemName == "Water Canister" 
then r,g,b = 33,163,181
elseif itemName == "Pistol" or itemName == "Magnum Revolver" or itemName == "Pump Shotgun" or itemName == "Sawn-off Shotgun" or itemName == "Combat Shotgun" or itemName == "MP5" or itemName == "Uzi" or itemName == "Vehicle Minigun" or itemName == "M4" or itemName == "AK 47" or itemName == "Rifle" or itemName == "Sniper Rifle" or itemName == "Crossbow" or itemName == "Minigun" or itemName == "Laser Pointer" or itemName == "Zip Line" or itemName == "M37 Stomper" 
then r,g,b = 214,54,54 
elseif itemName == "Knife" or itemName == "Raider Sword" or itemName == "Baseball Bat" or itemName == "Chainsaw" or itemName == "Crowbar" or itemName == "Kitchen Knife" or itemName == "Machete" or itemName == "Axe" or itemName == "Meatcleaver" or itemName == "Nail Bat" or itemName == "Nightstick" or itemName == "Broken Bottle" or itemName == "Sledgehammer" 
then r,g,b = 247,105,27  
elseif itemName == "Medikit" or itemName == "Painkillers" or itemName == "Bandage" or itemName == "Splint" or itemName == "Adrenaline" or itemName == "ZomboKleen"
then r,g,b = 54,214,150  
elseif itemName == "Map" or itemName == "Survivor Map" or itemName == "Military Map" or itemName == "Toolbox" or itemName == "Fuel Canister" or itemName == "Agent Pale" or itemName == "Binoculars" or itemName == "Backpack" or itemName == "Body Armor" or itemName == "Tactical Shield" or itemName == "Night Vision Googles" or itemName == "Thermal Googles" or itemName == "Spray Can" or itemName == "Lighter" or itemName == "Headlamp" or itemName == "Road Flare" or itemName == "Hazmat Suit" or itemName == "Camouflage Suit" or itemName == "Scuba Gear" or itemName == "Watch" or itemName == "EM Scanner" or itemName == "Radio" or itemName == "Agent Pale"
then r,g,b = 60,153,47 
elseif itemName == "Meat Can" or itemName == "Raw Meat" or itemName == "Raw Human Meat" or itemName == "Roasted Human Meat" or itemName == "Roasted Meat" or itemName == "Fish Can" or itemName == "Soup Can"
then r,g,b = 252,226,23 
elseif itemName == "Empty Bottle" or itemName == "Rags" or itemName == "Scrap Metal" or itemName == "Vehicle Parts" or itemName == "Plastic Foil" or itemName == "Wire" or itemName == "Empty Canister" or itemName == "Wood"
then r,g,b = 255,255,255 
elseif itemName == "Grenade" or itemName == "Teargas" or itemName == "Molotov" or itemName == "Satchel Charge" or itemName == "Stinger Launcher" or itemName == "Rocket Launcher" or itemName == "Flamethrower" or itemName == "Timed Bomb" or itemName == "Mine" or itemName == "Incendiary Trap" or itemName == "Shards Trap" or itemName == "Spikestrip"
then r,g,b = 170,36,214 
elseif itemName == "Assault Ammo" or itemName == "Bolts" or itemName == "Rifle Ammo" or itemName == "Pistol Ammo" or itemName == "Shotgun Ammo" or itemName == "SMG Ammo" or itemName == "Magnum Ammo" or itemName == "Ammo Box" or itemName == "Minigun Ammo" or itemName == "Stinger Missile" or itemName == "Stomper Ammo"
then r,g,b = 41,78,227 
else r,g,b = 0,0,0 
end 
return r,g,b
end

local onHitItem = function(e) -- this happens when you enter a world item colshape
local itemName = getElementData(source,"item_inventory")
if getElementData(e, "carriedObject") and itemName then outputInteractInfo(""..itemName.."", e, 255, 255, 255) return end
local x,y,z = getElementPosition(source)
local t = getElementType(e)
local r,g,b = getObjCoronaColor(itemName) 
if(itemName) and t=="player" then 
local objcorona = createMarker(x, y, z-1.2, "cylinder", 1, r, g, b, 200, e)

setTimer(function () if isElement(objcorona) then destroyElement(objcorona)end end,1500,1) --object corona deletion timer

--triggerClientEvent(e,"ShowItemWorldInfo",root,source,itemName)

if isPedInVehicle(e) then
outputInteractInfo(""..itemName.."", e, 255, 255, 255)
return
elseif isInventoryFull(e)  then 
outputStatusInfo("Inventory full", e, 240, 0, 0) 
--outputCurrentWorldItem( itemName, e, true )
return 

end
PlayersAtualItem[e]=source
playerSt[e] = itemName
bindKey(e,"e","down",takeItemC) ----------- PICKUP KEY HERE
bindKey(e,"e","down","Pickup item") -- works only after hitting your first colshape
bindKey(e,"pgdn","down",takeItemC)
--outputInteractInfo(""..itemName.."\n[E]", e, 255, 255, 255)
--outputCurrentWorldItem( itemName, e,false )
end
end
addEventHandler("onColShapeHit",root,onHitItem)

local onLeaveItem = function(elem) -- this happens when you leave a world item colshape
local itemName = getElementData(source,"item_inventory")
local elemtype = getElementType(elem)
if(itemName)and(elemtype=="player"or elemtype=="player") then 
unbindKey(elem,"e","down",takeItemC)
unbindKey(elem,"pgdn","down",takeItemC)
--clearCurrentWorldItem(elem)
PlayersAtualItem[elem]=false
playerSt[elem] = false
end
end
addEventHandler("onColShapeLeave",root,onLeaveItem)

function getPlayerItens(player) --returns a table of the player items
local tab = nil
if(PlayersItens[player])then
tab=PlayersItens[player]
else
tab={"Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty"}
end
return tab
end

function getPlayerBeltItens(player) --returns a table of the player belt items
local tab = nil
if(PlayersBeltItens[player])then
tab=PlayersBeltItens[player]
else
tab={"Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty"}
end
return tab
end

function setPlayerItens(player,t)
if  not(PlayersItens[player])then
PlayersItens[player] = {}
end
for i=1,9
do
PlayersItens[player][i] = t[i]
end
end

function setPlayerBeltItens(player,t)
if  not(PlayersBeltItens[player])then
PlayersBeltItens[player] = {}
end
for i=1,9
do
PlayersBeltItens[player][i] = t[i]
end
end

function syncronizePlayerItens(player)
return triggerClientEvent(player,"synchronizeTables",player,PlayersItens)
end

function syncronizePlayerBeltItens(player)
return triggerClientEvent(player,"synchronizeBelt",player,PlayersBeltItens)
end

function clearInventorySandBox(player)
if(PlayersItens[player])then
PlayersItens[player] = nil
end
PlayersAtualItem[player]=nil
playerSt[player]=nil
end

function clearBeltSandBox(player)
if(PlayersBeltItens[player])then
PlayersBeltItens[player] = nil
end
PlayersAtualItem[player]=nil
playerSt[player]=nil
end

 local ItemInventoryToSpawn ={ -- example to create items in the world on startup. format is: item x,y,z,int,dim
{"Radio",-2080.06,-188.35,35.32,0,0},
{"Radio",-2082.06,-188.35,35.32,0,0},
{"Watch",-2084.06,-188.35,35.32,0,0},
{"ZomboKleen",-2084.06,-190.35,35.32,0,0},
{"ZomboKleen",-2084.06,-192.35,35.32,0,0},
{"ZomboKleen",-2084.06,-194.35,35.32,0,0},
{"Scrap Metal",-2084.06,-196.35,35.32,0,0},
{"Scrap Metal",-2084.06,-198.35,35.32,0,0},
{"Scrap Metal",-2083,-198.35,35.32,0,0},
{"Magnum Revolver",-2084.06,-199.35,35.32,0,0},
{"Fuel Canister",-2082.06,-200.35,35.32,0,0},
{"Fuel Canister",-2084.06,-202.35,35.32,0,0},
{"Timed Bomb",-2084.06,-204.35,35.32,0,0},
{"Timed Bomb",-2085.06,-204.35,35.32,0,0},
{"Timed Bomb",-2083.06,-205.35,35.32,0,0},
{"Agent Pale",-2083.06,-204.35,35.32,0,0},
{"Mine",-2082.06,-204.35,35.32,0,0},
{"M37 Stomper",-2081.06,-202.35,35.32,0,0},
{"M4",-2081.06,-200.35,35.32,0,0},
{"Incendiary Trap",-2081.06,-199.35,35.32,0,0},
{"Agent Pale",-2082.06,-204.35,35.32,0,0}

} 

function RefreshDropedItens() -- deletes all items spawned in the world and respawns the ones from the "ItemInventoryToSpawn" table (above)
local it_ = getElementsByType("colshape")
for k,v in ipairs(it_)do
if(getElementData(v,"item_inventory"))then
destroyElement(v)
end
end
setTimer(function()
for i=1,#ItemInventoryToSpawn do
local item = createObjectItem(ItemInventoryToSpawn[i][1],ItemInventoryToSpawn[i][2],ItemInventoryToSpawn[i][3],ItemInventoryToSpawn[i][4]-0.92)
setElementInterior(item,ItemInventoryToSpawn[i][5])
setElementDimension(item,(ItemInventoryToSpawn[i][6] or 0))
end
end,2500,1)
end
addCommandHandler ("refreshitems", RefreshDropedItens )

RefreshDropedItens() -- to spawn the items at resource start

setTimer(function() outputTopBar("Warning: World items refresh in 5 minutes",root,255,240,0) end,3300000,0) --BUG: Warnings only work properly the first time!!!
setTimer(function() outputTopBar("Warning: World items refresh in 1 minute",root,255,240,0) end,3540000,0)
setTimer(function() outputTopBar("Warning: World items were refreshed.",root,255,240,0) end,3600000,0)
setTimer(RefreshDropedItens,3600000,0) -- dropped items are cleared from the world every hour

addEventHandler("onPlayerQuit",root, -- save inventory and stats ; they are loaded in spawn_server script
function()
local acc = getPlayerAccount(source)
if isGuestAccount(acc) then return end

local tableItem = getPlayerItens(source)
local tableBeltItem = getPlayerBeltItens(source)

local pistolammo = getElementData(source,"pistolammo") or 1
local crossbowammo = getElementData(source,"crossbowammo") or 1
local taserammo = getElementData(source,"taserammo") or 1
local shotgunammo = getElementData(source,"shotgunammo") or 1
local smgammo = getElementData(source,"smgammo") or 1
local assaultammo = getElementData(source,"assaultammo") or 1
local rifleammo = getElementData(source,"rifleammo") or 1
local stomperammo = getElementData(source,"stomperammo") or 0
local incendiarytraps = getElementData(source,"incendiarytraps") or 0
local glasstraps = getElementData(source,"glasstraps") or 0
local explosivetraps = getElementData(source,"explosivetraps") or 0
local timedbombs = getElementData(source,"timedbombs") or 0

local weapslot0 = getPedWeapon(source, 0)
local weapslot1 = getPedWeapon(source, 1)
local weapslot2 = getPedWeapon(source, 2)
local weapslot3 = getPedWeapon(source, 3)
local weapslot4 = getPedWeapon(source, 4)
local weapslot5 = getPedWeapon(source, 5)
local weapslot6 = getPedWeapon(source, 6)
local weapslot7 = getPedWeapon(source, 7)
local weapslot8 = getPedTotalAmmo(source, 8)
	if (getPedWeapon(source,8) == 16) then
		setElementData(source,"projectiletype","grenade") 
		elseif (getPedWeapon(source,8) == 17) then
		setElementData(source,"projectiletype","Teargas")
		elseif (getPedWeapon(source,8) == 18) then
		setElementData(source,"projectiletype","molotov")
		elseif (getPedWeapon(source,8) == 39) then
		setElementData(source,"projectiletype","satchel") 
	end
local projectiletype = getElementData(source,"projectiletype")
local weapslot9 = getPedWeapon(source, 9)
local weapslot10 = getPedWeapon(source, 10)
local weapslot11 = getPedWeapon(source, 11)
--local weapslot12 = getPedWeapon(source, 12) --not needed, gets reapplied when you throw a satchel
local minorfracture = getElementData(source,"minorfracture")
local majorfracture = getElementData(source,"majorfracture")
local currentSkin = getElementModel(source)
local armor = getPedArmor(source)
local teamelement = getPlayerTeam(source)
local team = getTeamName(teamelement)
local onFire = isPedOnFire(source)
local x, y, z = getElementPosition(source)
local rotation = getElementRotation(source)
local fightingStyle = getPedFightingStyle(source)
local walkingStyle = getPedWalkingStyle(source)
local thirst = getElementData(source, "thirst")
local hunger = getElementData(source, "hunger")
local headlamp = getElementData(source, "headlampequipped")
local medikit = getElementData(source, "medikitequipped")
local toolbox = getElementData(source, "toolboxequipped")
local backpack = getElementData(source, "backpackequipped")
local health = getElementHealth(source)
local bleeding = getElementData( source, "bleeding")
local zipline = getElementData( source, "zipline")
local stomper = getElementData( source, "stomperequipped")
local laser = getElementData( source, "laserpointer")
local infection = getElementData(source,"infection") or "uninfected"
local money = getPlayerMoney(source)
--local pain
--local lives

--local MIL = getElementData(source,"MILSkill")
--local TECH = getElementData(source,"TECHSkill")
--local MED = getElementData(source,"MEDSkill")
--local SURV = getElementData(source,"SURVSkill")
--local baseSkin = getElementData(source,"baseskin") -- need to implement a "baseskin" attribute, the skin the player choses during character creation
for i=1,9 do --write inventory and belt data
setAccountData(acc,"ItensInventory_"..i,(tableItem[i] or "Empty"))
setAccountData(acc,"ItemsBelt_"..i,(tableBeltItem[i] or "Empty"))
end
clearInventorySandBox(source)
clearBeltSandBox(source)
	
setAccountData(acc,"positionx", x)
setAccountData(acc,"positiony", y)
setAccountData(acc,"positionz", z)
setAccountData(acc,"rotation", rotation)
setAccountData(acc,"team", team)
setAccountData(acc,"armor", armor)
setAccountData(acc,"currentSkin", currentSkin)
setAccountData(acc,"currentMap", currentmap)
setAccountData(acc,"hunger", hunger)
setAccountData(acc,"thirst", thirst)
setAccountData(acc,"pistolammo", pistolammo)
setAccountData(acc,"crossbowammo", crossbowammo)
setAccountData(acc,"taserammo", taserammo)
setAccountData(acc,"shotgunammo", shotgunammo)
setAccountData(acc,"smgammo", smgammo)
setAccountData(acc,"assaultammo", assaultammo)
setAccountData(acc,"rifleammo", rifleammo)
setAccountData(acc,"weapslot0", weapslot0)
setAccountData(acc,"weapslot1", weapslot1)
setAccountData(acc,"weapslot2", weapslot2)
setAccountData(acc,"weapslot3", weapslot3)
setAccountData(acc,"weapslot4", weapslot4)
setAccountData(acc,"weapslot5", weapslot5)
setAccountData(acc,"weapslot6", weapslot6)
setAccountData(acc,"weapslot7", weapslot7)
setAccountData(acc,"weapslot8", weapslot8)
setAccountData(acc,"weapslot9", weapslot9)
setAccountData(acc,"weapslot10", weapslot10)
setAccountData(acc,"weapslot11", weapslot11)
--setAccountData(acc,"weapslot12", weapslot12)
setAccountData(acc,"minorfracture", minorfracture)
setAccountData(acc,"majorfracture", majorfracture)
setAccountData(acc,"onFire", onFire)
setAccountData(acc,"fightingStyle", fightingStyle)
if walkingStyle == 68 then setAccountData(acc,"walkingStyle", 0) else setAccountData(acc,"walkingStyle", walkingStyle) end
setAccountData(acc,"health", health)
setAccountData(acc,"projectiletype",projectiletype)
setAccountData(acc,"headlampequipped",headlamp)
setAccountData(acc,"medikitequipped",medikit)
setAccountData(acc,"toolboxequipped",toolbox)
setAccountData(acc,"backpackequipped",backpack)
setAccountData(acc,"bleeding",bleeding)
setAccountData(acc,"laserequipped",laser)
setAccountData(acc,"ziplineequipped",zipline)
setAccountData(acc,"stomperequipped",stomper)
setAccountData(acc,"stomperammo",stomperammo)
setAccountData(acc,"timedbombs",timedbombs)
setAccountData(acc,"incendiarytraps",incendiarytraps)
setAccountData(acc,"explosivetraps",explosivetraps)
setAccountData(acc,"glasstraps",glasstraps)
setAccountData(acc,"infection",infection)
setAccountData(acc,"money",money)

end)

function savePlayer (player)
if getCameraTarget(player) ~= player then return end -- to make sure players cannot save after they died
outputDebugString(tostring(getPlayerName(player)).." saved.")
local acc = getPlayerAccount(player)
if isGuestAccount(acc) then outputDebugString("guest, return") return end

local tableItem = getPlayerItens(player)
local tableBeltItem = getPlayerBeltItens(player)

local pistolammo = getElementData(player,"pistolammo") or 1
local crossbowammo = getElementData(player,"crossbowammo") or 1
local taserammo = getElementData(player,"taserammo") or 1
local shotgunammo = getElementData(player,"shotgunammo") or 1
local smgammo = getElementData(player,"smgammo") or 1
local assaultammo = getElementData(player,"assaultammo") or 1
local rifleammo = getElementData(player,"rifleammo") or 1
local stomperammo = getElementData(player,"stomperammo") or 0
local incendiarytraps = getElementData(player,"incendiarytraps") or 0
local glasstraps = getElementData(player,"glasstraps") or 0
local explosivetraps = getElementData(player,"explosivetraps") or 0
local timedbombs = getElementData(player,"timedbombs") or 0
--local watch = getElementData(player,"watch") or false

local weapslot0 = getPedWeapon(player, 0)
local weapslot1 = getPedWeapon(player, 1)
local weapslot2 = getPedWeapon(player, 2)
local weapslot3 = getPedWeapon(player, 3)
local weapslot4 = getPedWeapon(player, 4)
local weapslot5 = getPedWeapon(player, 5)
local weapslot6 = getPedWeapon(player, 6)
local weapslot7 = getPedWeapon(player, 7)
local weapslot8 = getPedTotalAmmo(player, 8)--getPedWeapon(player, 8) --setElementData(player,"projectiletype","grenade", getPedTotalAmmo(player, 8))
	if (getPedWeapon(player,8) == 16) then
		setElementData(player,"projectiletype","grenade") 
		elseif (getPedWeapon(player,8) == 17) then
		setElementData(player,"projectiletype","Teargas")
		elseif (getPedWeapon(player,8) == 18) then
		setElementData(player,"projectiletype","molotov")
		elseif (getPedWeapon(player,8) == 39) then
		setElementData(player,"projectiletype","satchel") -- getPedTotalAmmo(player, 8)
	end
	
	--local rocketequipped = false 
	--if weapslot7 == 35 then rocketequipped = true end
	
local projectiletype = getElementData(player,"projectiletype")
local weapslot9 = getPedWeapon(player, 9)
local weapslot10 = getPedWeapon(player, 10)
local weapslot11 = getPedWeapon(player, 11)

local armor = getPedArmor(player)

--local weapslot12 = getPedWeapon(player, 12) --not needed, gets reapplied when you throw a satchel
local minorfracture = getElementData(player,"minorfracture")
local majorfracture = getElementData(player,"majorfracture")
local currentSkin = getElementModel(player)

--[[	if currentSkin == 288 then 
		setAccountData(acc,"hazmatequipped",true)
		currentSkin = getAccountData(acc,"currentSkin")
	elseif currentSkin == 278 then 
		setAccountData(acc,"camoequipped",true)
		currentSkin = getAccountData(acc,"currentSkin")
	end]]


local teamelement = getPlayerTeam(player)
local team = getTeamName(teamelement)
local onFire = isPedOnFire(player)
local x, y, z = getElementPosition(player)
local rotation = getElementRotation(player)
local fightingStyle = getPedFightingStyle(player)
local walkingStyle = getPedWalkingStyle(player)
local thirst = getElementData(player, "thirst")
local hunger = getElementData(player, "hunger")
local headlamp = getElementData(player, "headlampequipped")
local medikit = getElementData(player, "medikitequipped")
local toolbox = getElementData(player, "toolboxequipped")
local backpack = getElementData(player, "backpackequipped")
local watch = getElementData(player, "watch")
local health = getElementHealth(player)
local bleeding = getElementData( player, "bleeding")
--local currentmap = getElementData(client,"currentmap")
local infection = getElementData(player,"infection") or "uninfected"
local radiation = getElementData(player,"radiationDamage") or 0
--local pain
local lives = getElementData (player,"lives")
local karma = getElementData (player,"karma")
local zipline = getElementData( player, "zipline")
local stomper = getElementData( player, "stomperequipped")
local laser = getElementData( player, "laserpointer")
--local MIL = getElementData(player,"MILSkill")
--local TECH = getElementData(player,"TECHSkill")
--local MED = getElementData(player,"MEDSkill")
--local SURV = getElementData(player,"SURVSkill")
--local baseSkin = getElementData(player,"baseskin") -- need to implement a "baseskin" attribute, the skin the player choses during character creation; will come eventually
local money = getPlayerMoney(player)

for i=1,9 do --write inventory and belt data
setAccountData(acc,"ItensInventory_"..i,(tableItem[i] or "Empty"))
setAccountData(acc,"ItemsBelt_"..i,(tableBeltItem[i] or "Empty"))
end
--clearInventorySandBox(player)
--clearBeltSandBox(player)

setAccountData(acc,"positionx", x)
setAccountData(acc,"positiony", y)
setAccountData(acc,"positionz", z)
setAccountData(acc,"rotation", rotation)
setAccountData(acc,"team", team)
setAccountData(acc,"armor", armor)
setAccountData(acc,"currentSkin", currentSkin)
setAccountData(acc,"currentMap", currentmap)
setAccountData(acc,"hunger", hunger)
setAccountData(acc,"thirst", thirst)
setAccountData(acc,"pistolammo", pistolammo)
setAccountData(acc,"crossbowammo", crossbowammo)
setAccountData(acc,"taserammo", taserammo)
setAccountData(acc,"shotgunammo", shotgunammo)
setAccountData(acc,"smgammo", smgammo)
setAccountData(acc,"assaultammo", assaultammo)
setAccountData(acc,"rifleammo", rifleammo)
setAccountData(acc,"stomperammo", stomperammo)
setAccountData(acc,"weapslot0", weapslot0)
setAccountData(acc,"weapslot1", weapslot1)
setAccountData(acc,"weapslot2", weapslot2)
setAccountData(acc,"weapslot3", weapslot3)
setAccountData(acc,"weapslot4", weapslot4)
setAccountData(acc,"weapslot5", weapslot5)
setAccountData(acc,"weapslot6", weapslot6)
setAccountData(acc,"weapslot7", weapslot7)
setAccountData(acc,"weapslot8", weapslot8)
setAccountData(acc,"weapslot9", weapslot9)
setAccountData(acc,"weapslot10", weapslot10)
setAccountData(acc,"weapslot11", weapslot11)
--setAccountData(acc,"weapslot12", weapslot12)
setAccountData(acc,"minorfracture", minorfracture)
setAccountData(acc,"majorfracture", majorfracture)
setAccountData(acc,"onFire", onFire)
setAccountData(acc,"fightingStyle", fightingStyle)
if walkingStyle == 68 then setAccountData(acc,"walkingStyle", 0) else setAccountData(acc,"walkingStyle", walkingStyle) end
setAccountData(acc,"health", health)
setAccountData(acc,"projectiletype",projectiletype)
setAccountData(acc,"headlampequipped",headlamp)
setAccountData(acc,"medikitequipped",medikit)
setAccountData(acc,"toolboxequipped",toolbox)
setAccountData(acc,"backpackequipped",backpack)
setAccountData(acc,"bleeding",bleeding)
setAccountData(acc,"lives",lives)
setAccountData(acc,"karma",karma)
setAccountData(acc,"laserequipped",laser)
setAccountData(acc,"ziplineequipped",zipline)
setAccountData(acc,"stomperequipped",stomper)
setAccountData(acc,"timedbombs",timedbombs)
setAccountData(acc,"incendiarytraps",incendiarytraps)
setAccountData(acc,"explosivetraps",explosivetraps)
setAccountData(acc,"glasstraps",glasstraps)
setAccountData(acc,"stomperammo",stomperammo)
setAccountData(acc,"watch",watch)
setAccountData(acc,"infection",infection)
setAccountData(acc,"radiation",radiation)
setAccountData(acc,"money",money)

outputTopBar("Saving...", player, 255,255,255)

end
addCommandHandler("savechar", savePlayer)

addEvent ( "weaponRetrieve", true )
addEvent("unequipKeyPressed", true)  

function weaponUnequip (player, weapon, ammo)  -- this unequips a weapon and attempts to add it to inventory or drop it if inventory is full 

local pistolammo = getElementData(player,"pistolammo") or false
local taserammo = getElementData(player,"taserammo") or false
local crossbowammo = getElementData(player,"crossbowammo") or false
local smgammo = getElementData(player,"smgammo") or false
local shotgunammo = getElementData(player,"shotgunammo") or false
local assaultammo = getElementData(player,"assaultammo") or false
local rifleammo = getElementData(player,"rifleammo") or false

local ammo2 = getPedTotalAmmo(player,2)
local ammo3 = getPedTotalAmmo(player,3)					-----SHOULD MAKE ALL THESE VARIABLES GLOBAL??? IT WOULD SURE SAVE SOME SPACE AND WOULD PROBABLY MAKE THE SCRIPT RUN FASTER
local ammo4 = getPedTotalAmmo(player,4)
local ammo5 = getPedTotalAmmo(player,5)
local ammo6 = getPedTotalAmmo(player,6)
local ammo7 = getPedTotalAmmo(player,7)
local ammo8 = getPedTotalAmmo(player,8)
local ammo9 = getPedTotalAmmo(player,9)

local itemName = nil
local x,y,z = getElementPosition(player)

    if weapon == 24 then --... all handheld items below
    itemName = "Magnum Revolver"
	elseif weapon == 22 then
    itemName = "Pistol"
	elseif weapon == 1 then
    itemName = "Tactical Shield"
    elseif weapon == 2 then
    itemName = "Axe"
    elseif weapon == 3 then
    itemName = "Nightstick"
    elseif weapon == 4 then
    itemName = "Knife"
    elseif weapon == 5 then
    itemName = "Baseball Bat"
    elseif weapon == 6 then
    itemName = "Crowbar"
    elseif weapon == 7 then
    itemName = "Sledgehammer"
    elseif weapon == 8 then
    itemName = "Raider Sword"
    elseif weapon == 9 then
    itemName = "Chainsaw"
    elseif weapon == 10 then
    itemName = "Machete"
    elseif weapon == 11 then
    itemName = "Kitchen Knife"
    elseif weapon == 12 then
    itemName = "Meatcleaver"
    elseif weapon == 14 then
    itemName = "Broken Bottle"
    elseif weapon == 15 then
    itemName = "Nail Bat"
    elseif weapon == 16 then
    itemName = "Grenade"
    elseif weapon == 17 then
    itemName = "Teargas"
    elseif weapon == 18 then
    itemName = "Molotov"
    elseif weapon == 23 then
    itemName = "Crossbow"
	setElementData(player,"crossbowammo",ammo)
    elseif weapon == 25 then
    itemName = "Pump Shotgun"
	setElementData(player,"shotgunammo",ammo)
    elseif weapon == 26 then
    itemName = "Sawn-off Shotgun"
	setElementData(player,"shotgunammo",ammo)
    elseif weapon == 27 then
    itemName = "Combat Shotgun"
	setElementData(player,"shotgunammo",ammo)
    elseif weapon == 28 then
    itemName = "Uzi"
	setElementData(player,"smgammo",ammo)
    elseif weapon == 29 then
    itemName = "MP5"
	setElementData(player,"smgammo",ammo)
    elseif weapon == 30 then
    itemName = "AK 47"
	setElementData(player,"assaultammo",ammo)
    elseif weapon == 31 then
    itemName = "M4"
	setElementData(player,"assaultammo",ammo)
    elseif weapon == 32 then
    itemName = "Vehicle Minigun"
	setElementData(player,"smgammo",ammo)
    elseif weapon == 33 then
    itemName = "Rifle"
	setElementData(player,"rifleammo",ammo)
    elseif weapon == 34 then
    itemName = "Sniper Rifle"
	setElementData(player,"rifleammo",ammo)
    elseif weapon == 35 then
    itemName = "Rocket Launcher"
    elseif weapon == 36 then
    itemName = "Stinger Launcher"
    elseif weapon == 37 then
    itemName = "Flamethrower"
    elseif weapon == 38 then
    itemName = "Minigun"
    elseif weapon == 39 then
    itemName = "Satchel Charge"
    elseif weapon == 41 then
    itemName = "Spray Can"
    elseif weapon == 42 then
    itemName = "Agent Pale"
    elseif weapon == 43 then
    itemName = "Binoculars"
    elseif weapon == 44 then
    itemName = "Night Vision Googles"
    elseif weapon == 45 then
    itemName = "Thermal Googles"
    elseif weapon == 46 then
    itemName = "Backpack"
    elseif weapon == 17 then
    itemName = "Teargas"
    elseif weapon == 0 then return
    --itemName = "Empty"
    end
    
    if isInventoryFull(player) == true then 
		createObjectItem(itemName, x, y, z-0.95, 97.3,120, 0)
		takeWeapon( player, weapon )
		if getSlotFromWeapon(getPedWeapon(player))~= 8 and getSlotFromWeapon(getPedWeapon(player))~= 9 and getSlotFromWeapon(getPedWeapon(player))~= 10 then
			triggerClientEvent ("CleanWeap", player, player, getSlotFromWeapon(weapon)) -- event in 'armed' script
		end
    elseif isInventoryFull(player) == false then 
        addPlayerItem(player,itemName) 
        takeWeapon( player, weapon )
		
	if weapon == 22 then setElementData(player,"pistolammo",ammo) end
	if weapon == 24 then setElementData(player,"taserammo",ammo) end
	if weapon == 23 then setElementData(player,"crossbowammo",ammo) end
	if (weapon == 25 or weapon == 26 or weapon == 27 or weapon == 32) then setElementData(player,"smgammo",ammo) end
	if (weapon == 28 or weapon == 29) then setElementData(player,"shotgunammo",ammo) end
	if (weapon == 30 or weapon == 31) then setElementData(player,"assaultammo",ammo) end
	if (weapon == 33 or weapon == 34) then setElementData(player,"rifleammo",ammo) end
		if getSlotFromWeapon(getPedWeapon(player))~= 8 and getSlotFromWeapon(getPedWeapon(player))~= 9 and getSlotFromWeapon(getPedWeapon(player))~= 10 then
        triggerClientEvent ("CleanWeap", player, player, getSlotFromWeapon(weapon))
		end
    end

--savePlayer(player)	
	
end
addEventHandler("weaponRetrieve", resourceRoot, weaponUnequip)
addEventHandler("unequipKeyPressed", resourceRoot, weaponUnequip)

addEventHandler ( "onElementDataChange", getRootElement(), --triggers 'infected' message in 'spawnmessages_client' script

function ( dataName )
if not source then return end
    if getElementType ( source ) == "player" and dataName == "infection" then
		if getElementData ( source, "infection" ) ==  "stage1" then 
		triggerClientEvent(source,"onInfected", source)
		--[[elseif getElementData ( source, "infection" ) ==  "stage2" then 
		triggerClientEvent(source,"onInfected2", source)]]
		end
	end
	end) 

function equippmentWeight (player) --retrievs the equipped items weight for a player (there's an identical one on the client)

local weight = 0
local slot1 =  getPedWeapon (player,1)
local slot2 =  getPedWeapon (player,2)
local slot3 =  getPedWeapon (player,3)
local slot4 =  getPedWeapon (player,4)
local slot5 =  getPedWeapon (player,5)
local slot6 =  getPedWeapon (player,6)
local slot7 =  getPedWeapon (player,7) 
local slot8 =  getPedWeapon (player,8) 
local slot9 =  getPedWeapon (player,9) 
local slot10 =  getPedWeapon (player,10)
local slot11 =  getPedWeapon (player,11)

if slot1 == 0 then weight = weight 
elseif slot1 == 4 then weight = weight+0.5
elseif slot1 == 7 then weight = weight+3
elseif slot1 == 9 then weight = weight+4
else weight = weight+2
end  

if slot2 == 0 then weight = weight 
elseif slot2 == 23 then weight = weight+3
else weight = weight+2
end

if slot3 == 0 then weight = weight 
elseif slot3 == 26 then weight = weight+2
else weight = weight+3
end

if slot4 == 0 then weight = weight 
elseif slot4 == 29 then weight = weight+3
else weight = weight+2
end

if slot5 == 0 then weight = weight 
else weight = weight+3
end

if slot6 == 0 then weight = weight 
else weight = weight+3
end

if slot7 == 0 then weight = weight 
else weight = weight+4
end

if slot8 == 0 then weight = weight 
--elseif not getPedTotalAmmo(player,8) then weight = weight
else weight = weight+getPedTotalAmmo(player,8)*0.5
end

if slot9 == 0 then weight = weight 
elseif slot9 == 42 then weight = weight+2
else weight = weight+0.5
end

if slot10 == 0 then weight = weight 
elseif slot10 == 11 then weight = weight+0.5
elseif slot10 == 12 then weight = weight+1
elseif slot10 == 14 then weight = weight+0.5
else weight = weight+2
end

if slot11 == 0 then weight = weight 
elseif slot11 == 44 then weight = weight+0.5
elseif slot11 == 45 then weight = weight+0.5
else weight = weight --this is the 'parachute' case, 0 weight for now
end

if getElementData(player,"medikitequipped") == true then 
weight = weight+1
end

if getElementData(player,"toolboxequipped") == true then 
weight = weight+1
end

return weight

end
addCommandHandler("weight", equippmentWeight )

local handsUp = false
local siting = false
local lying = false
local pointing = false

function funcBindCarry(player, key, keyState) -- if you push around dynamic objects, they won't update position, so you won't be able to pick them up anymore, except if you try in their original spot. exactly, even if they are not there anymore! to circumvent, I froze all of them in the lootspawn_server script
	-- try to use getElementVelocity to determine when a dropped box stops moving to freeze it
	if getElementData(player, "isPressingAlt") then return end
	if getElementData(player, "sleeping")== true then return end
	if isPedInVehicle(player) then return end
	setPedWeaponSlot(player,0)
	triggerClientEvent(player, "sleep:drawDXProgress", player, 1000,1)
	setTimer(triggerClientEvent,1000,1,player, "sleep:stopDXProgress", player) 


	local carriedObject = getElementData(player, "carriedObject")
	local x,y,z = getElementPosition(player)
	local colshapex =  createColSphere(x,y,z,1.5)
	attachElements(colshapex,player,0,1,0)
	local colxobjects = getElementsWithinColShape(colshapex,"object")

	setTimer(function() 
		if isElement(colshapex) then 
			destroyElement(colshapex) 
		else 
			outputDebugString("no carry col to destroy") --debug
		end 
	end, 1000, 1)

	if carriedObject then
	
					if getPedContactElement(player) then 
						local standingOnObject = getPedContactElement(player)
						if getElementType(standingOnObject) == "vehicle" then
							if getVehicleName(standingOnObject) == "Walton" 
							or getVehicleName(standingOnObject) == "Utility Van"
							or getVehicleName(standingOnObject) == "Club"
							or getVehicleName(standingOnObject) == "Picador"
							or getVehicleName(standingOnObject) == "Bobcat"
							or getVehicleName(standingOnObject) == "Sadler"
							or getVehicleName(standingOnObject) == "Yosemite"
							or getVehicleName(standingOnObject) == "Bravura"
							or getVehicleName(standingOnObject) == "Patriot" then
								local vehloaded = getElementData(standingOnObject, "vehloaded")
								if not vehloaded then
									setTimer(function() 
										attachElements(carriedObject,standingOnObject, 0,-1,0.5) 
										setElementData(standingOnObject,"vehloaded",carriedObject) 
									end, 1000, 1 )

								else
									outputTopBar("Unload vehicle first!", player, 250,0,0)
									return
								end
							end
					end
				end
	

				
				setPedAnimation(player, "CARRY", "putdwn", 500, false, true, true, false)
				setPedWalkingStyle(player, 0)
				setElementFrozen(carriedObject,false) -- unfroze it so it goes down
				detachElements(carriedObject,player)
				setElementCollisionsEnabled(carriedObject,true)
				setTimer(triggerClientEvent, 300, 1, player, "DisarmZeBall", root) -- remove the ability to throw it
				setElementHealth(carriedObject,10000)
				setTimer(triggerClientEvent, 1500, 1, player, "carry.fixPosition", player, carriedObject)
				
				if getElementData(carriedObject, "id") then
					setTimer(dynamic_savePositions, 3000, 1, carriedObject)		
				elseif getElementData(carriedObject, "lootbox_id") then
					setTimer(loot_savePositions, 3000, 1, carriedObject)		
					outputDebugString("saving loot pos from carry")			
				end	
				
				setTimer(
					function()
						setElementFrozen(carriedObject,true); 
						setElementData(player,"carriedObject", false); 
						setElementHealth(carriedObject,1) 
					end, 1000, 1 ) --froze it again so you can't move it 
					
					if getPedContactElement(player) then 
						local standingOnObject = getPedContactElement(player)
						if getElementType(standingOnObject) == "vehicle" then
						if getVehicleName(standingOnObject) == "Walton" 
						or getVehicleName(standingOnObject) == "Utility Van" 
						or getVehicleName(standingOnObject) == "Patriot" 
						or getVehicleName(standingOnObject) == "Sadler" 
						or getVehicleName(standingOnObject) == "Bravura"
						or getVehicleName(standingOnObject) == "Picador"
						or getVehicleName(standingOnObject) == "Yosemite"
						or getVehicleName(standingOnObject) == "Club"
						or getVehicleName(standingOnObject) == "Bobcat" then
							local vehloaded = getElementData(standingOnObject, "vehloaded")
							if not vehloaded then
								setTimer(function() attachElements(carriedObject,standingOnObject, 0,-1.2,0.5); setElementData(standingOnObject,"vehloaded",carriedObject) end, 1000, 1 )
							else
								outputTopBar("Unload vehicle first!", player, 255,255,255)
							end
						end
					end
				end		

				local model = getElementModel(carriedObject)
				local cx,cy,cz = getElementPosition(carriedObject)
				
				if model == 1217 then  -- if it's a brown barrel
					local fuelcolshape =  createColSphere(cx,cy,cz+0.5,1.3)
					local fuelamount = getElementData(carriedObject,"fuel") or 0
					attachElements(fuelcolshape,carriedObject,0,0,0.5)
					setElementData(fuelcolshape, "fuel", fuelamount)
					setElementData(carriedObject, "fuelcolshape", fuelcolshape)
					setElementData(fuelcolshape, "fuelcolshape_barrel", carriedObject)
					detachElements(fuelcolshape,carriedObject)
				elseif model == 1225 then  -- if it's a red barrel
					local fuelcolshape =  createColSphere(cx,cy,cz+0.5,1.3)
					local fuelamount = getElementData(carriedObject,"fuel") or 0
					attachElements(fuelcolshape,carriedObject,0,0,0.5)
					setElementData(fuelcolshape, "fuel", fuelamount)
					setElementData(carriedObject, "fuelcolshape", fuelcolshape)
					setElementData(fuelcolshape, "fuelcolshape_barrel", carriedObject)
					detachElements(fuelcolshape,carriedObject)
				end
				
				setControlState(player,"walk",false)
				toggleControl(player,"walk",true)
				toggleControl(player,"sprint",true)
				toggleControl(player,"fire",true)
				toggleControl(player,"enter_exit",true)
				toggleControl(player,"crouch",true)
				toggleControl(player,"aim_weapon",true)
				toggleControl(player,"next_weapon",true)
				toggleControl(player,"previous_weapon",true)

				setTimer(function() 
					setElementData(player, "carriedObject", false) 
				end, 1000,1)
			

	elseif (not carriedObject) or (carriedObject == false) then

				if #colxobjects == 0  or getElementData(colxobjects[1],"itemsspawned")==true or getElementData(colxobjects[1],"destroyed")==true then
					triggerClientEvent(player,"sleep:stopDXProgress", player); 
					outputInteractInfo("[ nothing to pick up ]", player, 240, 240, 240); 
					setPedAnimation( player, "PLAYIDLES", "stretch",500, false, false, true, false); 
					setPedWalkingStyle(player, 0) 
				else 
					setPedAnimation(player,"BOMBER","BOM_Plant")
					setTimer(function() setPedAnimation(player) end,1000,1) 
				end --debug: how many obj in colshape

				if colxobjects == (false or nil) then outputDebugString("carry obj table error") end --debug: there's no table

				setTimer(function() -- set a timer to allow the pickup anim to play (attaching stops anim)
					for _,obj in ipairs(colxobjects) do
						local carriedObject = getElementData(player,"carriedObject")
						if (carriedObject ~= nil) and (carriedObject ~= false) then 
						--outputDebugString("You are already carrying something"
							return 
						else
							if getElementAttachedTo(obj) then
								if getElementType(getElementAttachedTo(obj)) == "vehicle" then
									setElementData(getElementAttachedTo(obj), "vehloaded", false)
									--outputDebugString("vehicle cleaned of attachments")
								end
							end

							if getElementModel(obj) == 1224  and getElementData(obj,"itemsspawned")==false then attachElements(obj,player,0,0.8,0.5); setElementCollisionsEnabled(obj,false); setElementData(player,"carriedObject", obj,true) setPedWalkingStyle(player, 68) --triggerClientEvent(player,"ArmZeBall",root)--big wooden crate
							elseif getElementModel(obj) == 2900 and getElementData(obj,"itemsspawned")==false then attachElements(obj,player,0,0.7,-0.3); setElementCollisionsEnabled(obj,false); setElementData(player,"carriedObject", obj,true) setPedWalkingStyle(player, 68) --triggerClientEvent(player,"ArmZeBall",root)--big cardboard box
							elseif getElementModel(obj) == 1217 then --brown barrel
								attachElements(obj,player,0,0.5,0.5); 
								setElementCollisionsEnabled(obj,false); 
								setElementData(player,"carriedObject", obj,true) 
								setPedWalkingStyle(player, 68); 
								local objfuelcol = getElementData(obj,"fuelcolshape") 
								local fuelleft = getElementData(objfuelcol,"fuel") 
								setElementData(obj,"fuel",fuelleft)  
								destroyElement(objfuelcol) 
							elseif getElementModel(obj) == 1225 then --red barrel
								attachElements(obj,player,0,0.5,0.5); 
								setElementCollisionsEnabled(obj,false); 
								setElementData(player,"carriedObject", obj,true) 
								setPedWalkingStyle(player, 68)
								local objfuelcol = getElementData(obj,"fuelcolshape") 
								local fuelleft = getElementData(objfuelcol,"fuel") 
								setElementData(obj,"fuel",fuelleft)  
								destroyElement(objfuelcol) 
							elseif getElementModel(obj) == 1370 then attachElements(obj,player,0,0.5,0.5); setElementCollisionsEnabled(obj,false); setElementData(player,"carriedObject", obj,true) setPedWalkingStyle(player, 68)--blue gas canister

							elseif getElementModel(obj) == 2968  and getElementData(obj,"itemsspawned")==false then attachElements(obj,player,0,0.6,0.3); setElementCollisionsEnabled(obj,false); setElementData(player,"carriedObject", obj,true) setPedWalkingStyle(player, 68) --triggerClientEvent(player, "ArmZeBall", root)--cardbox
							elseif getElementModel(obj) == 1220  and getElementData(obj,"itemsspawned")==false then attachElements(obj,player,0,0.6,0.3); setElementCollisionsEnabled(obj,false); setElementData(player,"carriedObject", obj,true) setPedWalkingStyle(player, 68) --triggerClientEvent(player, "ArmZeBall", root)--cardbox
							elseif getElementModel(obj) == 1221  and getElementData(obj,"itemsspawned")==false then attachElements(obj,player,0,0.6,0.3); setElementCollisionsEnabled(obj,false); setElementData(player,"carriedObject", obj,true) setPedWalkingStyle(player, 68) --triggerClientEvent(player, "ArmZeBall", root)--cardbox
							elseif getElementModel(obj) == 1230  and getElementData(obj,"itemsspawned")==false then attachElements(obj,player,0,0.6,0.3); setElementCollisionsEnabled(obj,false); setElementData(player,"carriedObject", obj,true) setPedWalkingStyle(player, 68) --triggerClientEvent(player, "ArmZeBall", root)--cardbox
							elseif getElementModel(obj) == 1264  and getElementData(obj,"itemsspawned")==false then attachElements(obj,player,0,0.5,0.2); setElementCollisionsEnabled(obj,false); setElementData(player,"carriedObject", obj,true) setPedWalkingStyle(player, 68) --triggerClientEvent(player, "ArmZeBall", root)--blackbag stockpile
							--elseif getElementModel(obj) == 1265 then attachElements(obj,player,0,0.5,0.2); setElementCollisionsEnabled(obj,false); setElementData(player,"carriedObject", obj) setPedWalkingStyle(player, 68)--blackbag
							else 
								setPedWalkingStyle(player, 0)
								setElementData(player,"carriedObject",nil)
							end
							--outputDebugString("You picked up an object") 
						end
					end	

					if getElementData(player,"carriedObject") then --block some controls when hauling boxes'n'stuff
						setPedWalkingStyle(player, 68) -- change walking style with another one with hands extended a bit
						toggleControl(player,"sprint", false)
						toggleControl(player,"walk",false)
						toggleControl(player,"fire",false)
						toggleControl(player,"enter_exit",false)
						toggleControl(player,"crouch",false)
						toggleControl(player,"aim_weapon",false)
						toggleControl(player,"next_weapon",false)
						toggleControl(player,"previous_weapon",false)
						setControlState(player,"walk",true)
					end
					colxobjects = nil
					end,1000,1)
	end
end

function resolveCarriedObject()
	if getElementData(source,"carriedObject") then
		local carriedObject = getElementData(source, "carriedObject")
		
			setElementFrozen(carriedObject,false) -- unfroze it so it goes down
			detachElements(carriedObject,source)
			setElementVelocity(carriedObject,0, 0, 0)
			setElementCollisionsEnabled(carriedObject,true)
			setElementHealth(carriedObject,10000)
			setTimer(function() setElementFrozen(carriedObject,true); setElementData(source,"carriedObject", false) end, 1000, 1 ) --froze it again so you can't move it 
			
		setControlState(source,"walk",false)
		
		toggleControl(source,"walk",true)
		toggleControl(source,"sprint",true)
		toggleControl(source,"fire",true)
		toggleControl(source,"enter_exit",true)
		toggleControl(source,"crouch",true)
		toggleControl(source,"aim_weapon",true)
		toggleControl(source,"next_weapon",true)
		toggleControl(source,"previous_weapon",true)
		triggerClientEvent(source, "carry.fixPosition", source, carriedObject)																
		setTimer(function(carriedObject) 
				setElementData(source, "carriedObject", false) 
				end
			, 1000,1,carriedObject)
	end
end
addEventHandler("onPlayerWasted", root, resolveCarriedObject)
addEventHandler("onPlayerQuit", root, resolveCarriedObject)

addEvent("carry.fixPosition_pong", true)
addEventHandler("carry.fixPosition_pong", root,
	function (object, x, y, z)
		setElementPosition(object, x, y, z)
	end
)

function funcBindHandsup(player, key, keyState)
	if getElementData(player, "sleeping")== true then return end
	if getElementData(player, "carriedObject") then outputInteractInfo("Drop object first!\n[H]", player, 255, 255, 255, 3000) return end

  if handsUp then
    setPedAnimation(player, false)
    handsUp = false
  else
    if isPedInVehicle(player) then
      return
    end
    setPedAnimation(player, "BEACH", "ParkSit_M_loop", 6000, true, false, false, true)
	handsUp = true
	siting = false
	lying = false
	pointing = false

  end
end

function funcBindSit(player, key, keyState)
  if getElementData(player, "sleeping")== true then return end
  if getElementData(player, "carriedObject") then outputInteractInfo("Drop object first!\n[H]", player, 255, 255, 255, 3000) return end

  if siting then
    setPedAnimation(player, false)
    siting = false
  else
    if isPedInVehicle(player) then
      return
    end
    setPedAnimation(player, "SHOP", "SHP_Rob_HandsUp", 6000, true, true, false, true)
    siting = true
	lying = false
	pointing = false
	handsUp = false
  end
end

function funcBindLie(player, key, keyState)
 if getElementData(player, "sleeping")== true then return end
 if getElementData(player, "carriedObject") then outputInteractInfo("Drop object first!\n[H]", player, 255, 255, 255, 3000) return end

 if lying then
    setPedAnimation(player, false)
    lying = false
  else
    if isPedInVehicle(player) then
      return
    end
    setPedAnimation(player, "WUZI", "CS_Dead_Guy", 500, false, false, true, true)
	setPedAnimationProgress(player,"CS_Dead_Guy",0.7)
    lying = true
	pointing = false
	siting = false
	handsUp = false
  end
end

function funcBindPoint(player, key, keyState)
 if getElementData(player, "sleeping")== true then return end
 if getElementData(player, "carriedObject") then outputInteractInfo("Drop object first!\n[H]", player, 255, 255, 255, 3000) return end
 
 if pointing then
    setPedAnimation(player, false)
    pointing = false
  else
    if isPedInVehicle(player) then
      return
    end
    setPedAnimation(player, "ped", "gang_gunstand", 7000, false, false, true, true)
	pointing = true
	lying = false
	siting = false
	handsUp = false
  end
end

function createwateritsamiracle(id,player) -- func originaly gave bottle of water when empty bottle used in a river; I use it now for giving any kind of item. kept the name yeah
		
		if isInventoryFull(player) == true then
			local x,y,z = getElementPosition(player)
			createObjectItem(id,x,y,z-0.95, 97.3,120, 0)
			outputInteractInfo("- "..id, player, 255, 92, 38)
			outputStatusInfo("Inventory full", player, 255, 92, 38)
						 
		else addPlayerItem(player,id)
						
		end
end
		
addCommandHandler("item", 
	function (player, _, ...)
		if isPlayerInACL(player, "Admin") or isPlayerInACL(player, "Moderator") or isPlayerInACL(player, "SuperModerator") then
			itemName = table.concat({...}, " ")
			if itemName then
				createwateritsamiracle(itemName, player)
			end
		else
		
		outputTopBar("Access denied!",player,240,0,0)
		
		end
	end
)

addEventHandler("CarScavCompleted", resourceRoot,

function(wrecktype) 

local player = client
local item

	if wrecktype == "object" then
	item = table.random(wreckscavengerandomtable)
	createwateritsamiracle(item, player) 
	elseif wrecktype == "vehicle" then
	item = table.random(vehiclescavengerandomtable)
	createwateritsamiracle(item, player) 
	end
	
	local xp = getPlayerExp(client)
	setPlayerExp(client,xp+1)
	outputStatusInfo("+1 xp",client, 240,240,240 )
	
end
)	

--fire objects: 3524 skull, 3461 tiki, 3525 exbr

function setupFireNodes() --create fire nodes in the world, based on torch objects placed by the map

local allObjects = getElementsByType("object")
outputDebugString("loading fire nodes...")	
	for _,obj in ipairs(allObjects) do

		if getElementModel(obj) == 3524  then
			createFireNode(obj)
		elseif getElementModel(obj) == 3461 then
			createFireNode(obj)
		elseif getElementModel(obj) == 3525 then 
			createFireNode(obj)
		elseif getElementModel(obj) == 1222 then 
			createFireNode(obj)
			setElementFrozen(obj,true)
		end
	
	end
end	

function createFireNode (obj)
		local x,y,z = getElementPosition(obj)
		local fireCol = createColSphere(x,y,z+1, 2)
		--local fireBurnCol = createColSphere(x,y,z+1, 1) -- no burncols to prevent cooking accidents in bases :)
		--setElementData(fireBurnCol, "burncol", true)
		setElementData(fireCol, "firecol", true)
		setElementData(fireCol, "firecolobj", obj,true)
		setElementData(obj, "firecolsphere", fireCol,true)
end

addEventHandler( "onResourceStart", resourceRoot,setupFireNodes )
addCommandHandler("fireobj",setupFireNodes)

function makeAFire() -- original by Marwin
  
  if hasPlayerItem ("Wood", source) ~= false then 
  
	  local itemcount, slot = hasPlayerItem ("Wood", source)
	  PlayersItens[source][slot]="Empty"
	  --local x, y, z = getElementPosition(source)
	  local xr, yr, zr = getElementRotation(source)
	  local px, py, pz = getElementPosition(source)
	  local prot = getPedRotation(source)
	  local offsetRot = math.rad(prot + 90)
	  local vx = px + 1 * math.cos(offsetRot)
	  local vy = py + 1 * math.sin(offsetRot)
	  local vz = pz + 2
	  local vrot = prot + 90
	  local wood = createObject(1463, vx, vy, pz - 0.85, xr, yr, vrot)
	  setObjectScale(wood, 0.3)
	  setElementCollisionsEnabled(wood,false)
	  
	  setElementFrozen(wood, true)
	  local fire = createObject(3525, vx, vy, pz - 0.75, xr, yr, vrot)
	  setObjectScale(fire, 0)
	  setElementCollisionsEnabled(fire, false)
	  local fireCol = createColSphere(vx, vy, pz - 0.75, 2)
	  local fireBurnCol = createColSphere(vx, vy, pz - 0.75, 1)
	  setElementData(fireCol, "firecol", true)
	  setElementData(fireBurnCol, "burncol", true)
	  setPedAnimation(source, "BOMBER", "BOM_Plant", 4000, false, false, nil, false)
	  triggerClientEvent(source, "sleep:drawDXProgress", source, 4000,4000)
	  setTimer(triggerClientEvent,4000,1,source, "sleep:stopDXProgress", source)	
	  
	  setTimer(function()
	  
		local plytabl = getElementsWithinColShape(fireCol,"player")
		for _,pl in ipairs (plytabl) do
		setElementData(pl,"infirecol",false)
		end
		
		destroyElement(fireCol)
		destroyElement(fireBurnCol)
		destroyElement(fire)
		destroyElement(wood)
	  end, 120000, 1)
	local player = source 
	setTimer(function()	outputStatusInfo("Building fire...", player, 240,240,240) end, 500,1)
	
	local xp = getPlayerExp(source)
	setPlayerExp(source,xp+1)
	outputStatusInfo("+1 xp",source, 240,240,240 )
	
	triggerClientEvent(source,"RefreshDraw",source)
	triggerClientEvent(source,"synchronizeTables",source,PlayersItens)
	else
	outputInteractInfo("You need Wood for this.", source, 240,240,240)
end
end

function buildAStockpile() -- 1265 , 1264 - blackbag object 
  if hasPlayerItem ("Plastic Foil", source) ~= false then 
	  
	  outputStatusInfo("Building Stockpile...", source, 240,240,240)
	  local itemcount, slot = hasPlayerItem ("Plastic Foil", source)
	  PlayersItens[source][slot]="Empty"
	  --local x, y, z = getElementPosition(source)
	  local xr, yr, zr = getElementRotation(source)
	  local px, py, pz = getElementPosition(source)
	  local prot = getPedRotation(source)
	  local offsetRot = math.rad(prot + 90)
	  local vx = px + 1 * math.cos(offsetRot)
	  local vy = py + 1 * math.sin(offsetRot)
	  local vz = pz + 2
	  local vrot = prot + 90
	  local stockpile = createObject(1264, vx, vy, pz-0.65 , xr, yr, vrot)
	  setElementFrozen(stockpile, true)
	  --local stockpileCol = createColSphere(vx, vy, pz - 0.75, 1)
	  --setElementData(stockpileCol, "stockpilecol", true)
	  --attachElements(stockpile,stockpileCol)
	  setPedAnimation(source, "BOMBER", "BOM_Plant", 4000, false, false, nil, false)
	  triggerClientEvent(source, "sleep:drawDXProgress", source, 4000,4000)
	  local player = source  
	  setTimer(triggerClientEvent,4000,1,source, "sleep:stopDXProgress", source)	
	setTimer(function()outputStatusInfo("Building Stockpile...", player, 255,255,255) end, 500,1)
	
	local xp = getPlayerExp(source)
	setPlayerExp(source,xp+1)
	outputStatusInfo("+1 xp",source, 240,240,240 )
	
	triggerClientEvent(source,"RefreshDraw",source)
	triggerClientEvent(source,"synchronizeTables",source,PlayersItens)
	setElementAsContainer(stockpile, "stockpile")										  
	else
	outputDebugScript("something went wrong with a stockpile creation")
end
end

function buildABarricade(vx, vy, pz, xr, yr, vrot) -- 1265 , 1264 - blackbag object 
	if isElement(source) then
		has_the_items = hasPlayerItem ("Wood", source)
	end

	if (has_the_items or vx) then
		has_the_items = nil
		if isElement(source) then
			outputStatusInfo("Building Barricade...", source, 240,240,240)
			local itemcount, slot = hasPlayerItem ("Wood", source)
			PlayersItens[source][slot]="Empty"
			--local x, y, z = getElementPosition(source)
			xr, yr, zr = getElementRotation(source)
			px, py, pz = getElementPosition(source)
			prot = getPedRotation(source)
			offsetRot = math.rad(prot + 90)
			vx = px + 1 * math.cos(offsetRot)
			vy = py + 1 * math.sin(offsetRot)
			vz = pz + 2
			vrot = prot + 180
			pz = pz-0.45
		end

		local barricade = createObject(1449, vx, vy, pz , xr, yr, vrot)

		if isElement(source) then
			--setElementHealth(barricade, 20000)
			--setElementFrozen(barricade, true)
			--local stockpileCol = createColSphere(vx, vy, pz - 0.75, 1)
			--setElementData(stockpileCol, "stockpilecol", true)
			--attachElements(stockpile,stockpileCol)
			setPedAnimation(source, "BOMBER", "BOM_Plant", 4000, false, false, nil, false)
			triggerClientEvent(source, "sleep:drawDXProgress", source, 4000,4000)
			local player = source  
			setTimer(triggerClientEvent,4000,1,source, "sleep:stopDXProgress", source)	
			setTimer(function()outputStatusInfo("Building Barricade...", player, 255,255,255) end, 500,1)

			local xp = getPlayerExp(source)
			setPlayerExp(source,xp+1)
			outputStatusInfo("+1 xp",source, 240,240,240 )

			triggerClientEvent(source,"RefreshDraw",source)
			triggerClientEvent(source,"synchronizeTables",source,PlayersItens)
			--setElementAsContainer(stockpile, "stockpile")
			setPersistent(barricade, "barricade", vx, vy, pz, xr, yr, vrot)
		end
		return barricade
	else
		outputDebugScript("something went wrong with a barricade creation")
	end
end

function buildAWireFence(vx, vy, pz, xr, yr, vrot) -- 1265 , 1264 - blackbag object 
	if isElement(source) then
		has_the_items = hasPlayerItem ("Scrap Metal", source)
	end

	if (has_the_items or vx) then 
		has_the_items = nil
		if isElement(source) then
			outputStatusInfo("Building Wire Fence...", source, 240,240,240)
			itemcount, slot = hasPlayerItem ("Scrap Metal", source)
			PlayersItens[source][slot]="Empty"
			itemcount, slot = hasPlayerItem ("Wire", source)
			PlayersItens[source][slot]="Empty"
			itemcount, slot = hasPlayerItem ("Scrap Metal", source)
			PlayersItens[source][slot]="Empty"
			--local x, y, z = getElementPosition(source)
			xr, yr, zr = getElementRotation(source)
			px, py, pz = getElementPosition(source)
			prot = getPedRotation(source)
			offsetRot = math.rad(prot + 90)
			vx = px + 1 * math.cos(offsetRot)
			vy = py + 1 * math.sin(offsetRot)
			vz = pz + 2
			vrot = prot-- + 180
			pz = pz-1.2
		end

		local barricade = createObject(1411, vx, vy, pz , xr, yr, vrot)
		--setElementHealth(barricade, 20000)
		--setElementFrozen(barricade, true)
		--local stockpileCol = createColSphere(vx, vy, pz - 0.75, 1)
		--setElementData(stockpileCol, "stockpilecol", true)
		--attachElements(stockpile,stockpileCol)
		if isElement(source) then
			setPedAnimation(source, "BOMBER", "BOM_Plant", 4000, false, false, nil, false)
			triggerClientEvent(source, "sleep:drawDXProgress", source, 4000,4000)
			local player = source  
			setTimer(triggerClientEvent,4000,1,source, "sleep:stopDXProgress", source)	
			setTimer(function()outputStatusInfo("Building Wire Fence...", player, 255,255,255) end, 500,1)

			local xp = getPlayerExp(source)
			setPlayerExp(source,xp+1)
			outputStatusInfo("+1 xp",source, 240,240,240 )

			triggerClientEvent(source,"RefreshDraw",source)
			triggerClientEvent(source,"synchronizeTables",source,PlayersItens)
			--setElementAsContainer(stockpile, "stockpile")	
			setPersistent(barricade, "wirefence", vx, vy, pz, xr, yr, vrot)
		end				  
		return barricade
	else
		outputDebugString("something went wrong with a barricade creation")
	end
end

function buildASShelter(vx, vy, vz, xr, yr, vrot)  
	if isElement(source) then
		has_the_items = hasPlayerItem ("Scrap Metal", source) ~= false and hasPlayerItem ("Wood", source) ~= false
	end

	if (has_the_items or vx) then 
		has_the_items = nil

		if isElement(source) then
			outputStatusInfo("Building Shelter...", source, 240,240,240)

			for i = 1,2 do
				local itemcount, slot = hasPlayerItem ("Scrap Metal", source)
				PlayersItens[source][slot]="Empty"
			end
			for i = 1,4 do
				local itemcount, slot = hasPlayerItem ("Wood", source)
				PlayersItens[source][slot]="Empty"
			end

			--local x, y, z = getElementPosition(source)
			xr, yr, zr = getElementRotation(source)
			px, py, pz = getElementPosition(source)
			prot = getPedRotation(source)
			offsetRot = math.rad(prot + 90)
			vx = px + 1 * math.cos(offsetRot)
			vy = py + 1 * math.sin(offsetRot)
			vz = pz + 0.6
			vrot = prot-- + 180
		end
		local shelter = createObject(1457, vx, vy, vz , xr, yr, vrot)
		--setElementHealth(barricade, 20000)
		--setElementFrozen(barricade, true)
		--local stockpileCol = createColSphere(vx, vy, pz - 0.75, 1)
		--setElementData(stockpileCol, "stockpilecol", true)
		--attachElements(stockpile,stockpileCol)
		if isElement(source) then
			setPedAnimation(source, "BOMBER", "BOM_Plant", 4000, false, false, nil, false)
			triggerClientEvent(source, "sleep:drawDXProgress", source, 4000,4000)
			local player = source  
			setTimer(triggerClientEvent,4000,1,source, "sleep:stopDXProgress", source)	
			setTimer(function()outputStatusInfo("Building Shelter...", player, 255,255,255) end, 500,1)
			local xp = getPlayerExp(source)
			setPlayerExp(source,xp+3)
			outputStatusInfo("+3 xp",source, 240,240,240 )
			triggerClientEvent(source,"RefreshDraw",source)
			triggerClientEvent(source,"synchronizeTables",source,PlayersItens)
			setPersistent(shelter, "shelter", vx, vy, vz, xr, yr, vrot)
		end

		local zone = createRadarArea(vx-32, vy-32, 64, 64) 
		setElementData(zone,"safeAreas",true)
		setElementData(shelter,"area",zone)
		return shelter
	else
		outputDebugString("something went wrong with a shelter creation")
	end
end

function buildABed(vx, vy, vz, xr, yr, vrot)  
	--outputDebugString("bed called")
	if source then
		has_the_items = hasPlayerItem ("Scrap Metal", source) ~= false and hasPlayerItem ("Rags", source) ~= false
	end

	if ( has_the_items or vx ) then 
		has_the_items = nil
		--outputDebugString("if passed")
		if isElement(source) then
			outputStatusInfo("Building Bed...", source, 240,240,240)
			for i = 1,3 do
				local itemcount, slot = hasPlayerItem ("Scrap Metal", source)
				if slot then 
					PlayersItens[source][slot]="Empty" 
				end
			end
			for i = 1,2 do
				local itemcount, slot = hasPlayerItem ("Rags", source)
				if slot then
					PlayersItens[source][slot]="Empty"
				end
			end
		end

		if isElement(source) then
			xr, yr, zr = getElementRotation(source)
			px, py, pz = getElementPosition(source)
			prot = getPedRotation(source)
			offsetRot = math.rad(prot + 90)
			vx = px +1 * math.cos(offsetRot)
			vy = py +1 * math.sin(offsetRot)
			vz = pz -1.1
			vrot = prot+270
		end

		--outputDebugString("creating bed! position: "..table.concat({vx, vy, vz, xr, yr, vrot}))
		local bed = createObject(1800, vx, vy, vz, xr, yr, vrot)
		if isElement(source) then
			--outputChatBox("Created: "..table.concat({vx,vy,vz,xr,yr,vrot}, ","))

			local vxx, vyy, vzz = getElementPosition(bed)
			local xrr, yrr, vrott = getElementRotation(bed)
			--outputChatBox("Position: "..table.concat({vxx, vyy, vzz, xrr, yrr, vrott}, ","))

			local bedposX, bedposY, bedposZ = getElementPosition(bed)
			--moveObject(bed,50,bedposX-0.3, bedposY-2.25, bedposZ)
			--local bedrotX, bedrotY, bedrotZ = getElementRotation(bed)
			attachElements(bed,source,-2.25,1.1,-1.1, xr, yr, vrot+270)
			detachElements(bed,source)
		end

		createBed(bed)

		if isElement(source) then
			setPedAnimation(source, "BOMBER", "BOM_Plant", 4000, false, false, nil, false)
			triggerClientEvent(source, "sleep:drawDXProgress", source, 4000,4000)
			local player = source  
			setTimer(triggerClientEvent,4000,1,source, "sleep:stopDXProgress", source)	
			setTimer(function()outputStatusInfo("Building Bed...", player, 255,255,255) end, 500,1)

			local xp = getPlayerExp(source)
			setPlayerExp(source,xp+3)
			outputStatusInfo("+3 xp",source, 240,240,240 )

			triggerClientEvent(source,"RefreshDraw",source)
			triggerClientEvent(source,"synchronizeTables",source,PlayersItens)

			local vx, vy, vz = getElementPosition(bed)
			local xr, yr, vrot = getElementRotation(bed)
			setPersistent(bed, "bed", vx, vy, vz, xr, yr, vrot)
		end								  
		return bed
	else
		outputDebugString("something went wrong with a bed creation")
	end
end

addEvent("onMakeAFire", true)
addEvent("onBuildAStockpile", true)
addEvent("onBuildAShelter", true)
addEvent("onBuildABed", true)
addEvent("onBuildABarricade", true)
addEvent("onBuildAWireFence", true)
addEvent("ClearBackpackObject", true)

addEventHandler("onMakeAFire", getRootElement(), makeAFire)
addEventHandler("onBuildAStockpile", getRootElement(), buildAStockpile)
addEventHandler("onBuildAShelter", getRootElement(), buildASShelter)
addEventHandler("onBuildABed", getRootElement(), buildABed)
addEventHandler("onBuildABarricade", getRootElement(), buildABarricade)
addEventHandler("onBuildAWireFence", getRootElement(), buildAWireFence)

function BackpackOnBack( dataName, oldDataValue )
if not source then return end
    if getElementType ( source ) == "player" and dataName == "backpackequipped" then
		if getElementData ( source, "backpackequipped" ) ==  true then 
		
		 local x, y, z = getElementPosition(source)
		elementBackpack[source] = createObject(371, x, y, z)
		exports.bone_attach:attachElementToBone(elementBackpack[source], source, 3, 0, -0.225, 0.05, 0, 0, 0)
		end
	end
end

addEventHandler("onElementDataChange", getRootElement(), BackpackOnBack)

function BackpackOnBackRemove( dataName, oldDataValue )
if not source then return end
    if getElementType ( source ) == "player" and dataName == "backpackequipped" then
		if getElementData ( source, "backpackequipped" ) ==  false then 
		
			 if elementBackpack[source] then
				exports.bone_attach:detachElementFromBone(elementBackpack[source])
				destroyElement(elementBackpack[source])
				elementBackpack[source] = false
			 end
		end
	end
end

addEventHandler("onElementDataChange", getRootElement(), BackpackOnBackRemove)

function backpackRemoveOnQuit()
  if elementBackpack[source] then
    exports.bone_attach:detachElementFromBone(elementBackpack[source])
    destroyElement(elementBackpack[source])
	elementBackpack[source] = false
  end
 
end
addEventHandler("onPlayerQuit", getRootElement(), backpackRemoveOnQuit)

addEvent("ChangePlayerTeam",true)
function changePlayerTeam (team)

setPlayerTeam(client, team)

end
addEventHandler("ChangePlayerTeam", resourceRoot, changePlayerTeam)

function clearHeadlamp (dataname,oldvalue)
if not source then return end
if dataname == "headlampequipped" and oldvalue == true then
triggerClientEvent (source, "UnequipHeadlamp", source)
end
end

addEventHandler("onElementDataChange",root,clearHeadlamp)

function equipUnequipSuits (dataname,oldvalue)
	
	if not source or getElementType(source)~= "player" then return end
	
	if dataname == "hazmatequipped" then
		if oldvalue ~= true then
	
			local acc = getPlayerAccount(source)
			local nosuitskin = getElementModel(source)
		
			if nosuitskin == 278 then 
				nosuitskin = getAccountData(acc,"currentSkin")
			end
			
			if nosuitskin then 
			setAccountData(acc,"currentSkin",nosuitskin)
			setPedAnimation(source,"BOMBER","BOM_Plant")
			triggerClientEvent(source, "sleep:drawDXProgress", source, 1500,1500)
			setTimer(triggerClientEvent,1500,1,source, "sleep:stopDXProgress", source)				
			local player = source
			setTimer(function()
			setPedAnimation(player); 
			setElementModel(player,288)
			end,1500,1)
			outputInteractInfo("Hazmat Suit equipped",source,255,200,0)
			end
			
		elseif oldvalue == true then
			local acc = getPlayerAccount(source)
			local nosuitskin = getAccountData(acc,"currentSkin")
			
			if nosuitskin then 
			setPedAnimation(source,"BOMBER","BOM_Plant")
			triggerClientEvent(source, "sleep:drawDXProgress", source, 1500,1500)
			setTimer(triggerClientEvent,1500,1,source, "sleep:stopDXProgress", source)
				local player = source
				
				setTimer(function()
				setPedAnimation(player); 
				setElementModel(player,nosuitskin)
				end,1500,1)
			outputInteractInfo("Hazmat Suit unequipped",source,255,200,0)
			end
		end
	
	end
	
	if dataname == "camoequipped" then
		if oldvalue ~= true then
	
			local acc = getPlayerAccount(source)
			local nosuitskin = getElementModel(source)
		
			if nosuitskin == 288 then 
				nosuitskin = getAccountData(acc,"currentSkin")
			end
			
			if nosuitskin then 
			setAccountData(acc,"currentSkin",nosuitskin)
			setPedAnimation(source,"BOMBER","BOM_Plant")
			triggerClientEvent(source, "sleep:drawDXProgress", source, 1500,1500)
			setTimer(triggerClientEvent,1500,1,source, "sleep:stopDXProgress", source)
			local player = source
			setTimer(function()
			setPedAnimation(player); 
			setElementModel(player,278)
			end,1500,1)
			outputInteractInfo("Camouflage Suit equipped",source,255,200,0)
			end
			
		elseif oldvalue == true then
			local acc = getPlayerAccount(source)
			local nosuitskin = getAccountData(acc,"currentSkin")
			
			if nosuitskin then 
			setPedAnimation(source,"BOMBER","BOM_Plant")
			triggerClientEvent(source, "sleep:drawDXProgress", source, 1500,1500)
			setTimer(triggerClientEvent,1500,1,source, "sleep:stopDXProgress", source)
				local player = source
				setTimer(function()
				setPedAnimation(player); 
				setElementModel(player,nosuitskin)
				end,1500,1)
			outputInteractInfo("Camouflage Suit unequipped",source,255,200,0)
			end
		end
	
	end
	
end

addEventHandler("onElementDataChange",root,equipUnequipSuits)

function clearTables() --empties tables on player wasted
PlayersItens[source] = {"Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty"}
PlayersBeltItens[source] = {"Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty"}
end
addEventHandler("onPlayerWasted", root, clearTables)

function manageFracturesOnDeath ()
local acc = getPlayerAccount(source)
local minorfracture = getAccountData(acc,"minorfracture") or false
local majorfracture = getAccountData(acc,"majorfracture") or false
	if majorfracture then 
		setElementData(source,"majorfracture",false,true)
		setElementData(source,"minorfracture",true,true)
		setAccountData(acc,"majorfracture",false)
		setAccountData(acc,"minorfracture",true)
	elseif minorfracture then
		setElementData(source,"majorfracture",false,true)
		setElementData(source,"minorfracture",false,true)
		setAccountData(acc,"majorfracture",false)
		setAccountData(acc,"minorfracture",false)
	end
end
addEventHandler("onPlayerWasted", root, manageFracturesOnDeath)

function checkWireFenceBleeding (prevelem,currelem)
	if currelem then 
		local model = getElementModel(currelem)
		if model ~= 1411 then 
			return
		else
			triggerClientEvent(source,"setPlayerBleeding",source)
			--triggerClientEvent(source,"onClientPlayerDamage",source,_,23)
		end
	end
end
addEventHandler("onPlayerContact",root,checkWireFenceBleeding)

-- addEvent("carry.syncThrowing", true)
-- addEventHandler("carry.syncThrowing", root,
-- 	function (object, part)
-- 		if part == 1 then
-- 			detachElements(object, client)
-- 			setElementFrozen(object, false)
-- 			setElementCollisionsEnabled(object, false)
-- 			setPedAnimation(client,"RYDER", "Van_Throw", -1, false)
-- 			triggerClientEvent("carry.syncThrowing", root, client, object)
-- 		else
-- 			setPedAnimation(client)
-- 			setPedWalkingStyle(client, 0)
-- 			setElementData(client, "carriedObject", nil)

-- 			controls = {"walk", "sprint", "fire", "enter_exit", "crouch", "aim_weapon", "next_weapon", "previous_weapon"}

-- 			for i, ct in ipairs(controls) do
-- 				toggleControl(client, ct, true)
-- 			end

-- 			setTimer(function()
-- 				setElementFrozen(object, true)
-- 				setElementCollisionsEnabled(object, true)
-- 			end, 400, 1)

-- 		end
-- 	end
-- )

-- addEvent("carry.fixVelocity", true)
-- addEventHandler("carry.fixVelocity", root,
-- 	function (object, x, y, z)
-- 		setElementVelocity(object, x, y, z)
-- 		setElementFrozen(object,true);
-- 		setElementData(client,"carriedObject", false);
-- 		setElementHealth(object,1)
-- 	end
-- )

-- addEvent("sync.throwDetach", true)
-- addEventHandler("sync.throwDetach", root,
-- 	function (object)
-- 		outputChatBox("attached els: "..tostring(#getAttachedElements(client)))
-- 		detachElements(object, client)
-- 		outputChatBox("attached els: "..tostring(#getAttachedElements(client)))
-- 		triggerClientEvent(client, "sync.detached", client, object)
-- 	end
-- )

addEvent("throwObject", true)
addEventHandler("throwObject", root,
	function (object)
			local matrix = client.matrix
			local new = matrix:transformPosition(Vector3(0, 5, 0))
			local ox, oy, oz = new.x, new.y, new.z

			--local _, _, rotz = getElementRotation(client)

			triggerClientEvent(client, "throwObject.getGround", client, object, ox, oy, oz)
	end
)

addEvent("throwObject.gotGround", true)
addEventHandler("throwObject.gotGround", root,
	function (object, _oz)
		local matrix = client.matrix
		local new = matrix:transformPosition(Vector3(0, 5, 0))
		local ox, oy, oz = new.x, new.y, _oz

		removeElementData(client, "carriedObject")
		setPedAnimation(client,"RYDER", "Van_Throw", -1, false)
		setTimer(setPedAnimation, 500, 1, client)

		detachElements(object, client)

		local px, py, pz = getElementPosition(client)
		setElementPosition(object, px, py, pz+1)

		setTimer(moveObject, 100, 1, object, 250, ox, oy, oz, 0, 0, 0, "Linear", 0, 0, 1)

		setTimer(setElementFrozen, 200, 1, object, false)
		setTimer(setElementCollisionsEnabled, 200, 1, object, true)

		setTimer(triggerClientEvent, 1000, 1, root, "throwObject.fall", client, object)
	end
)

addEvent("throwObject.update", true)
addEventHandler("throwObject.update", root,
	function (object, x, y, z)
		setElementPosition(object, x, y, z)
	end
)

addEventHandler("onResourceStart", resourceRoot,
	function ()
		for i,v in ipairs(getElementsByType("player")) do
			bindKey(v, "h", "down", dismantleObject)
		end
	end
)

addEventHandler("onPlayerLogin", root,
	function ()
		bindKey(source, "h", "down", dismantleObject)
	end
)

local craftableItems = {
	["Crossbow"] = {"Scrap Metal", "Wood", "Wire"},
	["Raider Sword"] =  {"Scrap Metal", "Scrap Metal", "Rags"},
	["Nail Bat"] = {"Scrap Metal", "Wood"},
	["Molotov"] = {"Rags", "Alcohol"},
	["Broken Bottle"] = {"Empty Bottle"},
	["Bandage"] = {"Rags", "Alcohol"},
	["Shards Trap"] = {"Broken Bottle", "Wood", "Wire"},
	["Backpack"] = {"Rags", "Rags", "Wire"},
	["Bolts"] = {"Wood", "Scrap Metal"},
	["Splint"] = {"Wood", "Bandages"},
	["Incendiary"] = {"Wood", "Fuel Canister", "Wire"},
	["Camouflage"] = {"Rags", "Rags", "Rags"},
	["Stockpile"] = {"Plastic Foil", "Wire"},
	["Barricade"] = {"Wood", "Wood"},
	["Wire Fence"] = {"Scrap Metal", "Scrap Metal"},
	["Shelter"] = {"Wood", "Wood", "Wood", "Wood", "Scrap Metal", "Scrap Metal"},
	["Bed"] = {"Scrap Metal", "Scrap Metal", "Scrap Metal", "Rags", "Rags"}
}

local model_to_item = {
	[347] = "Crossbow",
	[339] = "Raider Sword",
	[326] = "Nail Bait",
	[344] = "Molotov",
	[325] = "Broken Bottle",
	[2384] = "Bandage",
	[2978] = "Shards Trap",
	[371] = "Backpack",
	[328] = "Bolts",
	[1279] = "Splint",
	[2978] = "Incendiary",
	[1575] = "Camouflage",
	[1264] = "Stockpile",
	[1449] = "Barricade",
	[1411] = "Wire Fence",
	[1457] = "Shelter",
	[1800] = "Bed",
	[2985] = "Minigun"
}

function getItemNameFromModel(model)
	return model_to_item[model]
end

function getIngredients(craft)
	if craft and not craftableItems[craft] then
		outputDebugString("@getIngredients failed to get ingredients for "..craft)
		return
	end

	return craftableItems[craft]
end

function dismantleObject(player, key, keyState)
	if not getElementData(player, "isPressingAlt") then return end
	if getElementData(player, "sleeping")== true then return end
	if isPedInVehicle(player) then return end
--[[	setPedWeaponSlot(player,0)
	triggerClientEvent(player, "sleep:drawDXProgress", player, 1000,1)
	setTimer(triggerClientEvent,1000,1,player, "sleep:stopDXProgress", player) ]]

	local x,y,z = getElementPosition(player)
	local colshapex =  createColSphere(x,y,z,3)
	attachElements(colshapex,player,0,1,0)
	local colxobjects = getElementsWithinColShape(colshapex,"object")

	setTimer(function() 
		if isElement(colshapex) then 
			destroyElement(colshapex) 
		else 
			outputDebugString("no carry col to destroy") --debug
		end 
	end, 1000, 1)

	outputDebugString(#colxobjects)
	if #colxobjects == 0 then
		triggerClientEvent(player,"sleep:stopDXProgress", player); 
		outputInteractInfo("[nothing to dismantle]", player, 240, 240, 240); 
		setPedAnimation( player, "PLAYIDLES", "stretch",500, false, false, true, false); 
		setPedWalkingStyle(player, 0) 
	else 
		setPedAnimation(player,"BOMBER","BOM_Plant")
		setTimer(function() setPedAnimation(player) end,1000,1) 
	end --debug: how many obj in colshape

	for _, object in ipairs(colxobjects) do
		if model_to_item[getElementModel(object)] then
			if getElementModel(object) == 2985 then -- is a minigun
			setPedWeaponSlot(player,0)
			triggerClientEvent(player, "sleep:drawDXProgress", player, 1000,1)
			setTimer(triggerClientEvent,1000,1,player, "sleep:stopDXProgress", player) 
				return dismantle(player,object)
			else
				if getElementData(player, "toolboxequipped") then
				setPedWeaponSlot(player,0)
				triggerClientEvent(player, "sleep:drawDXProgress", player, 1000,1)
				setTimer(triggerClientEvent,1000,1,player, "sleep:stopDXProgress", player) 
					return dismantle(player,object)
				else
					setPedAnimation( player, "PLAYIDLES", "stretch",500, false, false, true, false);
					outputInteractInfo("[ no toolbox ]", player, 240, 240, 240)
					return 
				end
			end
		end
	end

	outputInteractInfo("[nothing to dismantle]", player, 240, 240, 240); 
end

function dismantle(player, object)
	local itemModel = getElementModel(object)
	local itemName = getItemNameFromModel(itemModel)

	if not itemName then
		outputDebugString("no item name, model: "..tostring(itemModel))
		return
	end

	if itemModel ~= 2985 and not craftableItems[itemName] then -- isn't a minigun nor a craftable object
		outputInteractInfo("[can't dismantle " ..itemName.."]", player, 240, 240, 240)
		return
	end

	local x, y, z = getElementPosition(player)
	if itemName ~= "Minigun" then
		for _, item in ipairs(getIngredients(itemName)) do
			createObjectItem(item, x+math.random(0, 1.5),y+math.random(0, 1.5),z-0.95, 0, 0, 0)
		end

		local persistent_id = getElementData(object, "persistent_id")
		if persistent_id then
			removePersistentObjectFromDatabase(persistent_id)
		end
	else
		local items = getStockpileItems(player) or {}
		for _, item in ipairs(items) do
			createObjectItem(item, x+math.random(0, 1.5),y+math.random(0, 1.5),z-0.95, 0, 0, 0)
			outputDebugString(item)
		end

		createObjectItem("Minigun", x+math.random(0, 1.5),y+math.random(0, 1.5),z-0.95, 0, 0, 0)

		if not isElementAttached(object) then -- stand minigun
			local minigun_id = getElementData(object, "minigun_id")
			if not minigun_id then
				outputDebugString("couldn't get minigun_id")
				--return
			else
				removeStandMinigunFromDatabase(minigun_id)
			end
		else
			local rcbaron = getElementAttachedTo(object)
			local vehicle = getElementAttachedTo(rcbaron)
			outputDebugString(isElement(vehicle))
			outputDebugString(getVehicleName(vehicle))

			local vehicle_id = getElementData(vehicle, "id")
			if not vehicle_id then
				outputDebugString("couldn't get vehicle_id")
				--return
			else
				removeVehicleMinigunFromDatabase(vehicle_id)
				destroyElement(rcbaron)
				setElementData(vehicle, "has_minigun", nil)
			end
		end
	end

	for _, attached in ipairs(getAttachedElements(object)) do
		destroyElement(attached)
	end

	destroyElement(object)
end