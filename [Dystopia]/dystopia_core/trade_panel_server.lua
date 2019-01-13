addEvent("onPlayerBuyItem",true)
addEvent("synchronizeTradeServer",true)

ItemKit = {}

ItemKit["Cleaner Kit"] = true
ItemKit["Peacekeeper Kit"] = true
ItemKit["Assault Kit"] = true
ItemKit["Demolitions Kit"] = true
ItemKit["Recon Kit"] = true
ItemKit["Support Kit"] = true
ItemKit["Combat Medic Kit"]= true
ItemKit["Sniper Kit"] = true
ItemKit["Agent Kit"] = true

ItemKit["Roadrunner Kit"] = true	
ItemKit["Man Eater Kit"] = true
ItemKit["Unburnt Kit"] = true	
ItemKit["Pitdog Kit"] = true
ItemKit["Berserker Kit"] = true
ItemKit["Body Snatcher Kit"] = true
ItemKit["Greasemonkey Kit"] = true	
ItemKit["Mongrel Kit"] = true

ItemKit["Militia Kit"] = true		
ItemKit["Ranger Kit"] = true		
ItemKit["Survivalist Kit"] = true		
ItemKit["Medicine Man Kit"] = true		
ItemKit["Citizen Kit"] = true		
ItemKit["Vigilante Kit"] = true	

ItemKit["Robber Kit"] = true		
ItemKit["Highwayman Kit"] = true		
ItemKit["Veteran Kit"] = true		
ItemKit["Pirate Kit"] = true		
ItemKit["Infiltrator Kit"] = true		
ItemKit["Saboteur Kit"] = true		
ItemKit["Thug Kit"] = true

ItemKit["Survivor Kit"] = true	
ItemKit["Scavenger Kit"] = true	
ItemKit["Wastelander Kit"] = true	
ItemKit["Hunter Kit"] = true	
ItemKit["Medic Kit"] = true	
ItemKit["Traveler Kit"] = true	
ItemKit["Bounty Hunter Kit"] = true	

PlayersTradeItems = {"Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty"}

function Tradetablesynchronize_server(table_)
PlayersTradeItems = table_
end
addEventHandler("synchronizeTradeServer",root,Tradetablesynchronize_server)

function buyTradeItem(id,buyvalue) -- buy item function

	local itembought = false
	local playermoney = getPlayerMoney(client)

	if playermoney < buyvalue then
		outputInteractInfo("[ not enough money! ]",client,255,50,50)
		return
	elseif ItemKit[id] then
--ESTAB KITS		
		if id == "Assault Kit" then
			
			giveWeapon(client,31,151,false)
			giveWeapon(client,22,31,false)
			giveWeapon(client,4,1,false)
			giveWeapon(client,16,2,false)
			setElementData(client,"backpackequipped", true,true)
			setElementData(client,"stomperequipped",true,true)
			setElementData(client,"stomperammo",5)
			setPedArmor(client,100)
			createwateritsamiracle("Soup Can",client)
			
			local kitBeltItems = {"Military Map","Painkillers","Bandage","Radio","Empty","Empty","Empty","Empty","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Military Map",true)
			setElementData(client,"headlampequipped",true,true)
			triggerClientEvent(client,"HeadlampEquipped",client)
			setElementData(client,"laserpointer",true,true)
			if IsLaserEnabled(client) then SetLaserEnabled(client,false) end
			setElementModel(client,277)	
		
		elseif id == "Demolitions Kit" then
		
			giveWeapon(client,27,37,false)
			giveWeapon(client,22,31,false)
			giveWeapon(client,6,1,false)
			giveWeapon(client,35,2,false)
			giveWeapon(client, 39,1,false)
			setElementData(client,"backpackequipped", true,true)
			
			setElementData(client,"toolboxequipped",true,true)
			setElementData(client,"explosivetraps",1,true)
			
			setPedArmor(client,50)
			
			local kitBeltItems = {"Military Map","Painkillers","Bandage","Radio","Empty","Empty","Empty","Empty","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Military Map",true)
			createwateritsamiracle("Soup Can",client)
			createwateritsamiracle("Timed Bomb",client)
			setElementData(client,"headlampequipped",true,true)
			triggerClientEvent(client,"HeadlampEquipped",client)
			setElementModel(client,287)	
			
		elseif id == "Recon Kit" then
			
			giveWeapon(client,29,151,false)
			giveWeapon(client,22,31,false)
			giveWeapon(client,4,1,false)
			giveWeapon(client,17,1,false)
			giveWeapon(client,43,1,false)
			setElementData(client,"backpackequipped", true,true)
			setPedArmor(client,25)
			
			local kitBeltItems = {"Military Map","Painkillers","Bandage","Adrenaline","Adrenaline","Lighter","Road Flare","Road Flare","Radio"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Military Map",true)
			setElementData(client,"headlampequipped",true,true)
			triggerClientEvent(client,"HeadlampEquipped",client)
			setElementData(client,"laserpointer",true,true)
			if IsLaserEnabled(client) then SetLaserEnabled(client,false) end
			createwateritsamiracle("Soup Can",client)
			setElementModel(client,155)	
		
		
		elseif id == "Sniper Kit" then
		
			giveWeapon(client,34,51,false)
			giveWeapon(client,22,31,false)
			giveWeapon(client,4,1,false)
			giveWeapon(client,17,1,false)
			giveWeapon(client,43,1,false)
			setElementData(client,"backpackequipped", true,true)

			local kitBeltItems = {"Military Map","Painkillers","Adrenaline","Radio","Road Flare","Lighter","Empty","Empty","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Military Map",true)
			createwateritsamiracle("Soup Can",client)
			setElementData(client,"explosivetraps",1,true)
			setElementModel(client,278)
		
		elseif id == "Agent Kit" then
		
			giveWeapon(client,29,151,false)
			giveWeapon(client,22,31,false)
			giveWeapon(client,4,1,false)
			giveWeapon(client,39,1,false)
			giveWeapon(client,43,1,false)
			setElementData(client,"backpackequipped", true,true)
			setPedArmor(client,50)
			
			local kitBeltItems = {"Military Map","Painkillers","Bandage","Adrenaline","Lighter","Road Flare","EM Scanner","Radio","ZomboKleen"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Military Map",true)
			triggerClientEvent(client,"ScannerEquipped",client)
			createwateritsamiracle("Soup Can",client)

			setElementData(client,"laserpointer",true,true)
			if IsLaserEnabled(client) then SetLaserEnabled(client,false) end
			setElementModel(client,164)	
		
		elseif id == "Cleaner Kit" then
			
			giveWeapon(client,25,37,false)
			giveWeapon(client,10,1,false)
			giveWeapon(client,18,2,false)
			setElementData(client,"backpackequipped", true,true)
			local kitBeltItems = {"Military Map","Painkillers","Bandage","Radio","Road Flare","ZomboKleen","Lighter","Empty","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Military Map",true)
			setElementData(client,"headlampequipped",true,true)
			triggerClientEvent(client,"HeadlampEquipped",client)
			createwateritsamiracle("Soup Can",client)
			setElementModel(client,281)	
		
		elseif id == "Peacekeeper Kit" then
			giveWeapon(client,25,37,false)
			giveWeapon(client,3,1,false)
			giveWeapon(client,17,2,false)
			setElementData(client,"backpackequipped", true,true)
			local kitBeltItems = {"Military Map","Painkillers","Bandage","Radio","Road Flare","Empty","Empty","Empty","Empty"}
			setElementData(client,"spikestrips",1,true)
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Military Map",true)
			setElementData(client,"headlampequipped",true,true)
			triggerClientEvent(client,"HeadlampEquipped",client)
			createwateritsamiracle("Soup Can",client)
			setElementModel(client,266)	
			setPedArmor(client,25)
		
		elseif id == "Support Kit" then
			giveWeapon(client,27,37,false)
			giveWeapon(client,22,31,false)
			giveWeapon(client,3,1,false)

			setElementData(client,"backpackequipped", true,true)
			
			setElementData(client,"toolboxequipped",true,true)
			setElementData(client,"timedbombs",1,true)
			createwateritsamiracle("Minigun",client)			
			createwateritsamiracle("Minigun Ammo",client)			
			createwateritsamiracle("Minigun Ammo",client)			
			setPedArmor(client,50)
			
			local kitBeltItems = {"Military Map","Painkillers","Bandage","Radio","Road Flare","Empty","Empty","Empty","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Military Map",true)
			setElementData(client,"headlampequipped",true,true)
			triggerClientEvent(client,"HeadlampEquipped",client)
			createwateritsamiracle("Soup Can",client)
			setElementModel(client,277)
		
		elseif id == "Combat Medic Kit" then
			
			giveWeapon(client,25,36,false)
			giveWeapon(client,22,31,false)
			setElementData(client,"backpackequipped", true,true)
			local kitBeltItems = {"Military Map","Painkillers","Bandage","Bandage","Splint","Adrenaline","Radio","Road Flare","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Military Map",true)
			setElementData(client,"medikitequipped",true,true)	
			createwateritsamiracle("Medikit",client)		
			createwateritsamiracle("Soup Can",client)			
			setPedArmor(client,25)
			setElementModel(client,287)
--RAIDER KITS			
		elseif id == "Mongrel Kit" then
			
			giveWeapon(client,25,37,false)
			giveWeapon(client,11,1,false)
			setElementData(client,"backpackequipped", true,true)
			local kitBeltItems = {"Survivor Map","Lighter","Road Flare","Empty","Empty","Empty","Empty","Empty","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Survivor Map",true)
			createwateritsamiracle("Dirty Water",client)		
			createwateritsamiracle("Roasted Human Meat",client)	
			createwateritsamiracle("Alcohol Bottle",client)
		
		elseif id == "Roadrunner Kit" then
			
			giveWeapon(client,24,37,false)
			giveWeapon(client,12,1,false)
			giveWeapon(client,6,1,false)
			giveWeapon(client,18,1,false)
			setElementData(client,"backpackequipped", true,true)
			setElementData(client,"toolboxequipped",true,true)
			setElementData(client,"explosivetraps",1,true)
			setElementData(client,"spikestrips",1,true)
			local kitBeltItems = {"Survivor Map","Lighter","Road Flare","Empty","Empty","Empty","Empty","Empty","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Survivor Map",true)
			createwateritsamiracle("Dirty Water",client)		
			createwateritsamiracle("Roasted Human Meat",client)	
			createwateritsamiracle("Alcohol Bottle",client)

		elseif id == "Greasemonkey Kit" then
			
			giveWeapon(client,26,17,false)
			giveWeapon(client,23,11,false)
			giveWeapon(client,11,1,false)
			giveWeapon(client,18,1,false)
			setElementData(client,"backpackequipped", true,true)
			setElementData(client,"toolboxequipped",true,true)
			setElementData(client,"explosivetraps",1,true)
			setElementData(client,"spikestrips",1,true)
			local kitBeltItems = {"Survivor Map","Lighter","Road Flare","Road Flare","Radio","Empty","Empty","Empty","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Survivor Map",true)
				
			createwateritsamiracle("Dirty Water",client)	
			createwateritsamiracle("Roasted Human Meat",client)	
			createwateritsamiracle("Alcohol Bottle",client)
			createwateritsamiracle("Zip Line",client)
			createwateritsamiracle("Zip Line",client)
			setPedArmor(client,25)
			
		elseif id == "Man Eater Kit" then
			
			giveWeapon(client,23,21,false)
			giveWeapon(client,10,1,false)
			giveWeapon(client,18,1,false)
			setElementData(client,"backpackequipped", true,true)
			setElementData(client,"glasstraps",2,true)
			setElementData(client,"spikestrips",2,true)
			local kitBeltItems = {"Survivor Map","Lighter","Road Flare","Painkillers","Radio","Empty","Empty","Empty","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Survivor Map",true)
				
			createwateritsamiracle("Dirty Water",client)	
			createwateritsamiracle("Roasted Human Meat",client)	
			createwateritsamiracle("Alcohol Bottle",client)

		elseif id == "Unburnt Kit" then
			
			giveWeapon(client,26,65,false)
			giveWeapon(client,8,1,false)
			giveWeapon(client,18,1,false)
			setElementData(client,"backpackequipped", true,true)
			setElementData(client,"incendiarytraps",2,true)
			local kitBeltItems = {"Survivor Map","Lighter","Road Flare","Painkillers","Radio","Empty","Empty","Empty","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Survivor Map",true)
				
			createwateritsamiracle("Dirty Water",client)	
			createwateritsamiracle("Roasted Human Meat",client)	
			createwateritsamiracle("Alcohol Bottle",client)
			createwateritsamiracle("Fuel Canister",client)

		elseif id == "Pitdog Kit" then
			
			giveWeapon(client,30,151,false)
			giveWeapon(client,8,1,false)
			giveWeapon(client,18,1,false)
			giveWeapon(client,24,37,false)
			setElementData(client,"backpackequipped", true,true)
			setElementData(client,"toolboxequipped",true,true)
			local kitBeltItems = {"Survivor Map","Lighter","Road Flare","Painkillers","Radio","Adrenaline","Empty","Empty","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Survivor Map",true)
				
			createwateritsamiracle("Dirty Water",client)	
			createwateritsamiracle("Roasted Human Meat",client)	
			createwateritsamiracle("Alcohol Bottle",client)
			setPedArmor(client,50)
			
		elseif id == "Berserker Kit" then
			
			giveWeapon(client,7,1,false)
			giveWeapon(client,10,1,false)
			giveWeapon(client,18,2,false)
			giveWeapon(client,28,181,false)
			setElementData(client,"backpackequipped", true,true)
			setElementData(client,"toolboxequipped",true,true)
			local kitBeltItems = {"Survivor Map","Lighter","Road Flare","Painkillers","Radio","Adrenaline","Adrenaline","Road Flare","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Survivor Map",true)
				
			createwateritsamiracle("Dirty Water",client)	
			createwateritsamiracle("Roasted Human Meat",client)	
			createwateritsamiracle("Alcohol Bottle",client)
			setElementData(client,"headlampequipped",true,true)
			triggerClientEvent(client,"HeadlampEquipped",client)
			setPedArmor(client,100)
			
		elseif id == "Body Snatcher Kit" then
			
			giveWeapon(client,5,1,false)
			giveWeapon(client,12,1,false)
			giveWeapon(client,18,1,false)
			giveWeapon(client,25,65,false)
			setElementData(client,"backpackequipped", true,true)
			local kitBeltItems = {"Survivor Map","Lighter","Road Flare","Painkillers","Radio","Adrenaline","Splint","Road Flare","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Survivor Map",true)
				
			createwateritsamiracle("Dirty Water",client)	
			createwateritsamiracle("Roasted Human Meat",client)	
			createwateritsamiracle("Bandage",client)
			createwateritsamiracle("Alcohol Bottle",client)
			setElementData(client,"headlampequipped",true,true)
			triggerClientEvent(client,"HeadlampEquipped",client)
			setElementData(client,"medikitequipped",true,true)
			setPedArmor(client,50)
-- CDF KITS			
		elseif id == "Militia Kit" then
			
			giveWeapon(client,22,31,false)
			giveWeapon(client,12,1,false)
			giveWeapon(client,16,1,false)
			giveWeapon(client,33,51,false)
			setElementData(client,"backpackequipped", true,true)
			local kitBeltItems = {"Survivor Map","Lighter","Road Flare","Painkillers","Radio","Adrenaline","Bandage","Road Flare","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Survivor Map",true)
			setElementData(client,"explosivetraps",1,true)
			setElementData(client,"spikestrips",1,true)			
			createwateritsamiracle("Water Bottle",client)	
			createwateritsamiracle("Meat Can",client)	
			setElementData(client,"headlampequipped",true,true)
			triggerClientEvent(client,"HeadlampEquipped",client)
			setPedArmor(client,50)
			
		elseif id == "Ranger Kit" then
			
			giveWeapon(client,24,25,false)
			giveWeapon(client,12,1,false)
			giveWeapon(client,16,1,false)
			giveWeapon(client,31,151,false)
			setElementData(client,"backpackequipped", true,true)
			local kitBeltItems = {"Survivor Map","Lighter","Road Flare","Painkillers","Radio","Adrenaline","Bandage","Road Flare","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Survivor Map",true)
			setElementData(client,"glasstraps",3,true)
				
			createwateritsamiracle("Water Bottle",client)	
			createwateritsamiracle("Roasted Meat",client)	
			setElementModel(client,278)
			setPedArmor(client,50)

		elseif id == "Survivalist Kit" then
			
			giveWeapon(client,23,11,false)
			giveWeapon(client,2,1,false)
			giveWeapon(client,16,1,false)
			giveWeapon(client,33,51,false)
			setElementData(client,"backpackequipped", true,true)
			local kitBeltItems = {"Survivor Map","Lighter","Splint","Painkillers","Radio","Adrenaline","Bandage","Road Flare","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Survivor Map",true)
			setElementData(client,"glasstraps",2,true)
			createwateritsamiracle("Water Canister",client)	
			createwateritsamiracle("Roasted Meat",client)
			createwateritsamiracle("Roasted Meat",client)
			setElementModel(client,278)
			setPedArmor(client,25)
			
		elseif id == "Medicine Man Kit" then
			
			giveWeapon(client,29,121,false)
			giveWeapon(client,4,1,false)
			giveWeapon(client,22,31,false)
			setElementData(client,"backpackequipped", true,true)
			local kitBeltItems = {"Survivor Map","Splint","Painkillers","Adrenaline","Bandage","Bandage","Radio","Empty","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Survivor Map",true)
			createwateritsamiracle("Soup Can",client)	
			createwateritsamiracle("Soup Can",client)
			setElementData(client,"medikitequipped",true,true)

		elseif id == "Citizen Kit" then

			giveWeapon(client,4,1,false)
			giveWeapon(client,22,31,false)
			setElementData(client,"backpackequipped", true,true)
			local kitBeltItems = {"Survivor Map","Lighter","Painkillers","Bandage","Radio","Empty","Empty","Empty","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Survivor Map",true)
			createwateritsamiracle("Meat Can",client)	
			createwateritsamiracle("Water Bottle",client)
			setElementData(client,"toolboxequipped",true,true)

		elseif id == "Vigilante Kit" then
			
			giveWeapon(client,24,25,false)
			giveWeapon(client,5,1,false)
			giveWeapon(client,18,1,false)
			giveWeapon(client,25,49,false)
			setElementData(client,"backpackequipped", true,true)
			local kitBeltItems = {"Survivor Map","Lighter","Painkillers","Radio","Adrenaline","Bandage","Road Flare","Empty","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Survivor Map",true)
			setElementData(client,"spikestrips",1,true)
			createwateritsamiracle("Water Bottle",client)	
			createwateritsamiracle("Roasted Meat",client)
			setPedArmor(client,25)
			
-- BANDIT KITS			
		elseif id == "Robber Kit" then
			
			giveWeapon(client,22,21,false)
			giveWeapon(client,15,1,false)
			giveWeapon(client,25,49,false)
			setElementData(client,"backpackequipped", true,true)
			local kitBeltItems = {"Map","Lighter","Road Flare","Painkillers","Bandage","Empty","Empty","Empty","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Map",true)
			setElementData(client,"spikestrips",1,true)
			createwateritsamiracle("Alcohol Bottle",client)	
			createwateritsamiracle("Fish Can",client)
			setElementData(client,"headlampequipped",true,true)
			triggerClientEvent(client,"HeadlampEquipped",client)

		elseif id == "Highwayman Kit" then
			
			giveWeapon(client,24,25,false)
			giveWeapon(client,10,1,false)
			giveWeapon(client,33,51,false)
			setElementData(client,"backpackequipped", true,true)
			local kitBeltItems = {"Map","Lighter","Road Flare","Road Flare","Painkillers","Bandage","Radio","Empty","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Map",true)
			setElementData(client,"spikestrips",2,true)
			createwateritsamiracle("Water Bottle",client)	
			createwateritsamiracle("Alcohol Bottle",client)	
			createwateritsamiracle("Roasted Meat",client)
			createwateritsamiracle("Fuel Canister",client)
			setElementData(client,"toolboxequipped",true,true)	
			setElementData(client,"headlampequipped",true,true)
			triggerClientEvent(client,"HeadlampEquipped",client)
			setPedArmor(client,25)
			
		elseif id == "Veteran Kit" then
			
			giveWeapon(client,22,31,false)
			giveWeapon(client,4,1,false)
			giveWeapon(client,30,151,false)
			setElementData(client,"backpackequipped", true,true)
			local kitBeltItems = {"Survivor Map","Lighter","Painkillers","Radio","Adrenaline","Bandage","Road Flare","Empty","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Survivor Map",true)
			setElementData(client,"spikestrips",2,true)
			createwateritsamiracle("Water Bottle",client)	
			createwateritsamiracle("Alcohol Bottle",client)	
			createwateritsamiracle("Roasted Meat",client)
			setElementData(client,"toolboxequipped",true,true)	
			setElementData(client,"headlampequipped",true,true)
			triggerClientEvent(client,"HeadlampEquipped",client)
			setPedArmor(client,50)	
			
		elseif id == "Pirate Kit" then
			
			giveWeapon(client,24,31,false)
			giveWeapon(client,10,1,false)
			giveWeapon(client,18,2,false)
			giveWeapon(client,30,151,false)
			setElementData(client,"backpackequipped", true,true)
			local kitBeltItems = {"Survivor Map","Lighter","Painkillers","Radio","Adrenaline","Bandage","Road Flare","Empty","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Survivor Map",true)
			createwateritsamiracle("Dirty Water",client)	
			createwateritsamiracle("Alcohol Bottle",client)	
			createwateritsamiracle("Roasted Meat",client)
			createwateritsamiracle("Fuel Canister",client)
			setElementData(client,"toolboxequipped",true,true)	
			setElementData(client,"headlampequipped",true,true)
			triggerClientEvent(client,"HeadlampEquipped",client)
			setElementModel(client,28)
			setPedArmor(client,50)	

		elseif id == "Infiltrator Kit" then
			
			giveWeapon(client,23,31,false)
			giveWeapon(client,4,1,false)
			giveWeapon(client,17,2,false)
			giveWeapon(client,29,151,false)
			setElementData(client,"backpackequipped", true,true)
			local kitBeltItems = {"Military Map","Lighter","Painkillers","Radio","Adrenaline","Bandage","Road Flare","Empty","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Military Map",true)
			createwateritsamiracle("Water Bottle",client)	
			createwateritsamiracle("Alcohol Bottle",client)	
			createwateritsamiracle("Zip Line",client)
			createwateritsamiracle("Zip Line",client)
			setElementData(client,"toolboxequipped",true,true)	
			setElementModel(client,155)
			setPedArmor(client,25)

		elseif id == "Saboteur Kit" then
			
			giveWeapon(client,26,33,false)
			giveWeapon(client,6,1,false)
			giveWeapon(client,10,1,false)
			setElementData(client,"backpackequipped", true,true)
			local kitBeltItems = {"Survivor Map","Lighter","Painkillers","Radio","Adrenaline","Bandage","Road Flare","Empty","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Survivor Map",true)
			createwateritsamiracle("Alcohol Bottle",client)	
			createwateritsamiracle("Satchel Charge",client)
			createwateritsamiracle("Spikestrip",client)	
			setElementData(client,"explosivetraps",1,true)
			setElementData(client,"incendiarytraps",1,true)
			setElementData(client,"glasstraps",1,true)
			setElementData(client,"timedbombs",1,true)
			setElementData(client,"toolboxequipped",true,true)	
			setPedArmor(client,25)

		elseif id == "Thug Kit" then
			
			giveWeapon(client,22,31,false)
			giveWeapon(client,5,1,false)
			giveWeapon(client,28,61,false)
			giveWeapon(client,18,1,false)
			setElementData(client,"backpackequipped", true,true)
			local kitBeltItems = {"Map","Lighter","Painkillers","Road Flare","Empty","Empty","Empty","Empty","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Map",true)
			createwateritsamiracle("Alcohol Bottle",client)	

-- SCAV KITS

		elseif id == "Survivor Kit" then
			
			giveWeapon(client,22,31,false)
			giveWeapon(client,11,1,false)

			setElementData(client,"backpackequipped", true,true)
			local kitBeltItems = {"Map","Lighter","Bandage","Empty","Empty","Empty","Empty","Empty","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Map",true)
			createwateritsamiracle("Water Bottle",client)
			createwateritsamiracle("Meat Can",client)
			
		elseif id == "Scavenger Kit" then
			
			giveWeapon(client,25,41,false)
			giveWeapon(client,10,1,false)
			giveWeapon(client,6,1,false)
			setElementData(client,"backpackequipped", true,true)
			local kitBeltItems = {"Map","Lighter","Painkillers","Bandage","Road Flare","Road Flare","Radio","Empty","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Map",true)
			createwateritsamiracle("Water Bottle",client)	
			createwateritsamiracle("Fish Can",client)
			setElementData(client,"toolboxequipped",true,true)	
			setPedArmor(client,25)
			
		elseif id == "Wastelander Kit" then
			
			giveWeapon(client,29,121,false)
			giveWeapon(client,10,1,false)
			giveWeapon(client,24,19,false)
			setElementData(client,"backpackequipped", true,true)
			local kitBeltItems = {"Survivor Map","Lighter","Splint","Road Flare","Painkillers","Bandage","Radio","Empty","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Survivor Map",true)
			createwateritsamiracle("Water Bottle",client)	
			createwateritsamiracle("Roasted Meat",client)
			createwateritsamiracle("Fuel Canister",client)
			setElementData(client,"toolboxequipped",true,true)	
			setElementData(client,"headlampequipped",true,true)
			triggerClientEvent(client,"HeadlampEquipped",client)
			setPedArmor(client,25)

		elseif id == "Hunter Kit" then
			
			giveWeapon(client,33,101,false)
			giveWeapon(client,10,1,false)
			giveWeapon(client,2,1,false)
			setElementData(client,"backpackequipped", true,true)
			local kitBeltItems = {"Survivor Map","Lighter","Splint","Bandage","Radio","Road Flare","Empty","Empty","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Survivor Map",true)
			createwateritsamiracle("Water Bottle",client)	
			createwateritsamiracle("Roasted Meat",client)
			createwateritsamiracle("Wood",client)
			createwateritsamiracle("Wood",client)
			setElementData(client,"toolboxequipped",true,true)	
			setElementData(client,"headlampequipped",true,true)
			triggerClientEvent(client,"HeadlampEquipped",client)
			
		elseif id == "Medic Kit" then
			
			giveWeapon(client,25,37,false)
			giveWeapon(client,4,1,false)
			setElementData(client,"backpackequipped", true,true)
			local kitBeltItems = {"Map","Painkillers","Bandage","Bandage","Splint","Adrenaline","Radio","Road Flare","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Map",true)
			setElementData(client,"medikitequipped",true,true)	
			createwateritsamiracle("Fish Can",client)			
			createwateritsamiracle("Water Bottle",client)	

		elseif id == "Traveler Kit" then
			
			giveWeapon(client,25,37,false)
			giveWeapon(client,24,19,false)
			setElementData(client,"backpackequipped", true,true)
			local kitBeltItems = {"Survivor Map","Painkillers","Lighter","Road Flare","Splint","Adrenaline","Radio","Road Flare","Empty"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Survivor Map",true)
			createwateritsamiracle("Meat Can",client)			
			createwateritsamiracle("Water Bottle",client)
			setElementData(client,"toolboxequipped",true,true)	
			setElementData(client,"headlampequipped",true,true)
			triggerClientEvent(client,"HeadlampEquipped",client)

		elseif id == "Bounty Hunter Kit" then
			
			giveWeapon(client,30,151,false)
			giveWeapon(client,24,19,false)
			giveWeapon(client,4,1,false)
			setElementData(client,"backpackequipped", true,true)
			local kitBeltItems = {"Survivor Map","Painkillers","Lighter","Road Flare","Road Flare","Splint","Adrenaline","Adrenaline","Radio"}
			PlayersBeltItens[client]= kitBeltItems
			triggerClientEvent("synchronizeBelt",client,PlayersBeltItens)
			triggerClientEvent(client,"RefreshDraw",client)
			setElementData(client,"currentmap","Survivor Map",true)
			createwateritsamiracle("Roasted Meat",client)			
			createwateritsamiracle("Water Bottle",client)
			setElementData(client,"toolboxequipped",true,true)	
			setElementData(client,"headlampequipped",true,true)
			triggerClientEvent(client,"HeadlampEquipped",client)			
			setPedArmor(client,50)
			setElementModel(client,26)
		end
		
		takePlayerMoney(client,buyvalue)
		outputInteractInfo(id.." < -"..tostring(buyvalue).."$",client,255,100,100 )
		itembought = true
		
	else
	
		createwateritsamiracle(id,client)
		takePlayerMoney(client,buyvalue)
		outputInteractInfo(id.." < -"..tostring(buyvalue).."$",client,255,100,100 )
		itembought = true
	end

	if(itembought)then
	--triggerClientEvent(client,"synchronizeTrade",client,PlayersTradeItems)
	--triggerClientEvent(client,"ReopenTradePanel",client)
	triggerClientEvent(client,"synchronizeTables",client,PlayersItens)
	--triggerClientEvent(client,"RefreshDrawTrade",client)
	end

end
addEventHandler("onPlayerBuyItem",root, buyTradeItem, id,buyvalue)-- this happens when you click on a Trade panel item
