setTimer (function() 
	
	local helpmain="HINT: Hold [F1] for help."
	local openinventoryhelp="HINT: Press [Q] to open inventory."
	local maphelp="HINT: Press [M] to display a map equipped in your belt."
	local gadgethelp="HINT: Press [X] to use current gadget."
	local interacthelp="HINT: Press keys [1] to [0] to use emotes and stances."
	--local cursorhelp="HINT: Press [/] to toggle the cursor."
	local animshelp="HINT: Press [4], [5] and [6] to change stance."
	local carryhelp="HINT: Press [H] to carry small loot boxes and fuel barrels."
	local waterhelp="HINT: Use Empty Bottle to get water from water sources."
	local invmousehelp="HINT: Use [LMB], [RMB] and [MMB] to interact with items in your inventory."
	local toolboxhelp="HINT: Use Toolbox to repair vehicles or scavenge car wrecks."
	local butcherhelp="HINT: Use bladed weapons to butcher bodies."
	local carloadhelp="HINT: When carrying an object, press [H] while standing on a suitable vehicle to load it."
	local refuelhelp="HINT: Use a Fuel Canister near a vehicle to refuel it."
	local carpartshelp="HINT: Use Vehicle Parts near a vehicle to install them."
	local firehealshelp="HINT: Stand next to a fire to cook and slowly regain health."
	local craftinghelp="HINT: Press [J] to open the crafting panel."
	local craftinghelp2="HINT: In the crafting panel you see only the objects you have materials for."
	local pickuphelp="HINT: Press [E] to pick up items."
	local lootinghelp="HINT: Find items by breaking loot boxes."
	local zombiehelp1="HINT: Zombie Brutes are stronger and can't be headshot, but are unable to jump."
	local zombiehelp2="HINT: Zombie Runners are fast and infect you more easily than the others."
	local zombiehelp3="HINT: Zombie Walkers become faster at night."
	local zombiehelp4="HINT: Shoot a zombie's legs to slow it down."
	local scanhelp1="HINT: Use [K], [-] and [+] to scan area when driving a Surveillance Van."
	local manualhelp1="HINT: Press [F9] to read the game manual."
	local weapchange="HINT: Hover over weapons in inventory to change current slot."
	local storage1="HINT: Press [Q] to open storage containers and use RMB to transfer items."
	local save="HINT: Press [F6] to save your player data."
	--local forums="Visit our forums: dystopia.gamingzone.ro"
	local dismantling="HINT: Press [Alt]+[H] to dismantle structures you built (toolbox required)."
	local NPCinteracthelp="HINT: Press [1] next to an NPC to initiate dialogue."
	local shadershelp="HINT: Toggle shaders with /shaders [on/off]"
	local shedshelp="HINT: Build a Wooden Shelter to have a custom safe area for your vehicles."
	--local climbhelp="HINT: Double-jump while facing a tall object to climb (consumes stamina)."
	
	local msgdice =  math.random(1,33)
	local msg
		if msgdice == 1 then msg = helpmain
			elseif msgdice == 2 then msg = openinventoryhelp
			elseif msgdice == 3 then msg = maphelp
			elseif msgdice == 4 then msg = gadgethelp
			elseif msgdice == 5 then msg = cursorhelp
			elseif msgdice == 6 then msg = animshelp
			elseif msgdice == 7 then msg = carryhelp
			elseif msgdice == 8 then msg = interacthelp
			elseif msgdice == 9 then msg = waterhelp
			elseif msgdice == 10 then msg = invmousehelp
			elseif msgdice == 11 then msg = toolboxhelp
			elseif msgdice == 12 then msg = butcherhelp
			elseif msgdice == 13 then msg = carloadhelp
			elseif msgdice == 14 then msg = refuelhelp
			elseif msgdice == 15 then msg = carpartshelp
			elseif msgdice == 16 then msg = firehealshelp
			elseif msgdice == 17 then msg = craftinghelp
			elseif msgdice == 18 then msg = pickuphelp
			elseif msgdice == 19 then msg = lootinghelp
			elseif msgdice == 20 then msg = zombiehelp1
			elseif msgdice == 21 then msg = zombiehelp2
			elseif msgdice == 22 then msg = zombiehelp3
			elseif msgdice == 23 then msg = zombiehelp4
			elseif msgdice == 24 then msg = scanhelp1
			elseif msgdice == 25 then msg = manualhelp1
			elseif msgdice == 26 then msg = weapchange
			elseif msgdice == 27 then msg = storage1
			elseif msgdice == 28 then msg = save
			elseif msgdice == 29 then msg = sleep
			elseif msgdice == 30 then msg = dismantling
			elseif msgdice == 31 then msg = NPCinteracthelp
			elseif msgdice == 32 then msg = shadershelp
			elseif msgdice == 33 then msg = shedshelp
			--elseif msgdice == 30 then msg = forums
		end
		
		outputTopBar( msg, root, 255,200,0)
	end
	,180000, 0) --shows a random help message every three minutes