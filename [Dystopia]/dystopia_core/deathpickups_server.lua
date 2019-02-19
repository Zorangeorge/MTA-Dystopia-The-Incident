local timers = {} -- timers for existing pickups

addEventHandler ( "onPlayerWasted", getRootElement (),
	function ( source_ammo, killer, killer_weapon, bodypart )
		local pX, pY, pZ = getElementPosition ( source )
		local timeout = 60000--get("timeout")
		local player = source
		
		
		local maininv = {}--PlayersItens[player]
		local beltinv = {}--PlayersBeltItens[player]
		local equippinv = {}
		
		local acc = getPlayerAccount(player)
		
		for i=1,9 do
		local invvalue =  getAccountData(acc,"ItensInventory_"..i) or "Empty"
		local beltvalue = getAccountData(acc,"ItemsBelt_"..i) or "Empty"
		table.insert(maininv,invvalue)
		table.insert(beltinv,beltvalue)
		end

		for i=1,9 do --empty inventory and belt data
		
		setAccountData(acc,"ItensInventory_"..i,"Empty")
		setAccountData(acc,"ItemsBelt_"..i,"Empty")
		
		end
		
		--[[if getElementData(player,"hazmatequipped") == true then 
		table.insert(equippinv,"Hazmat Suit")
		end
		
		if getElementData(player,"camoequipped") == true then 
		table.insert(equippinv,"Camouflage Suit")
		end]]
		
		if getElementData(player,"backpackequipped") == true then 
		table.insert(equippinv,"Backpack")
		end	
		
		if getElementData(player,"toolboxequipped") == true then 
		table.insert(equippinv,"Toolbox")
		end

		if getElementData(player,"medikitequipped") == true then 
		table.insert(equippinv,"Medikit")
		end	

		if getElementData(player,"headlampequipped") == true then 
		table.insert(equippinv,"Headlamp")
		end
		
		if getElementData(player,"headlampequipped") == true then 
		table.insert(equippinv,"Headlamp")
		end

		if getElementData(player,"zipline") == true then 
		table.insert(equippinv,"Zip Line")
		end	

		if getElementData(player,"laserpointer") == true then 
		table.insert(equippinv,"Laser Pointer")
		end	
		
		if getElementData(player,"stomperequipped") == true then 
		table.insert(equippinv,"M37 Stomper")
		end	
			
		if getElementData(player,"watch") == true then 
		table.insert(equippinv,"Watch")
		end
		
		if getElementData(player,"incendiarytraps") and getElementData(player,"incendiarytraps") > 0 then
		local trapsno = getElementData(player,"incendiarytraps")
			for i = 1,trapsno do
			table.insert(equippinv,"Incendiary Trap")
			end
		end
		
		if getElementData(player,"spikestrips") and getElementData(player,"spikestrips") > 0 then
		local trapsno = getElementData(player,"spikestrips")
			for i = 1,trapsno do
			table.insert(equippinv,"Spikestrip")
			end
		end
		
		if getElementData(player,"explosivetraps") and getElementData(player,"explosivetraps") > 0 then
		local trapsno = getElementData(player,"explosivetraps")
			for i = 1,trapsno do
			table.insert(equippinv,"Mine")
			end
		end
		
		if getElementData(player,"timedbombs") and getElementData(player,"timedbombs") > 0 then
		local trapsno = getElementData(player,"timedbombs")
			for i = 1,trapsno do
			table.insert(equippinv,"Timed Bomb")
			end
		end
		
		if getElementData(player,"glasstraps") and getElementData(player,"glasstraps") > 0 then
		local trapsno = getElementData(player,"glasstraps")
			for i = 1,trapsno do
			table.insert(equippinv,"Shards Trap")
			end
		end

		local droppedWeapons = {}

		for slot=0, 12 do

			if (getPedWeapon(source,slot) ~= 0) then--and ammo>1 then
					local weaponid = getPedWeapon(source, slot)
					local weapon = nil
					local ammo = nil
					-------------zzzzzzzzzzz------------------
					if weaponid == 1 then weapon = "Tactical Shield" end
					if weaponid == 2 then weapon = "Axe" end
					if weaponid == 3 then weapon = "Nightstick" end
					if weaponid == 4 then weapon = "Knife" end
					if weaponid == 5 then weapon = "Baseball Bat" end
					if weaponid == 6 then weapon = "Crowbar" end
					if weaponid == 7 then weapon = "Sledgehammer" end
					if weaponid == 8 then weapon = "Raider Sword" end
					if weaponid == 9 then weapon = "Chainsaw" end
					if weaponid == 10 then weapon = "Machete" end
					if weaponid == 11 then weapon = "Kitchen Knife" end
					if weaponid == 12 then weapon = "Meatcleaver" end
					if weaponid == 14 then weapon = "Broken Bottle" end
					if weaponid == 15 then weapon = "Nail Bat" end
					if weaponid == 16 then weapon = "Grenade" end
					if weaponid == 17 then weapon = "Teargas" end
					if weaponid == 18 then weapon = "Molotov" end
					
					if weaponid == 22 then weapon = "Pistol" end
					if weaponid == 22 then ammo = "Pistol Ammo" end
					
					if weaponid == 23 then weapon = "Crossbow" end
					if weaponid == 23 then ammo = "Bolts" end
					
					if weaponid == 24 then weapon = "Magnum Revolver" end
					if weaponid == 24 then ammo = "Magnum Ammo" end
					
					if weaponid == 25 then weapon = "Pump Shotgun" end
					if weaponid == 25 then ammo = "Shotgun Ammo" end
					
					if weaponid == 26 then weapon = "Sawn-off Shotgun" end
					if weaponid == 26 then ammo = "Shotgun Ammo" end
					
					if weaponid == 27 then weapon = "Combat Shotgun" end
					if weaponid == 27 then ammo = "Shotgun Ammo" end
					
					if weaponid == 28 then weapon = "Uzi" end
					if weaponid == 28 then ammo = "SMG Ammo" end
					
					if weaponid == 29 then weapon = "MP5" end
					if weaponid == 29 then ammo = "SMG Ammo" end
					
					if weaponid == 30 then weapon = "AK 47" end
					if weaponid == 30 then ammo = "Assault Ammo" end
					
					if weaponid == 31 then weapon = "M4" end
					if weaponid == 31 then ammo = "Assault Ammo" end
					
					if weaponid == 32 then weapon = "Vehicle Minigun" end
					if weaponid == 32 then ammo = "SMG Ammo" end
					
					if weaponid == 33 then weapon = "Rifle" end
					if weaponid == 33 then ammo = "Rifle Ammo" end
					
					if weaponid == 34 then weapon = "Sniper Rifle" end
					if weaponid == 34 then ammo = "Rifle Ammo" end
					
					if weaponid == 35 then weapon = "Rocket Launcher" end
					if weaponid == 36 then weapon = "Stinger Launcher" end
					if weaponid == 36 then ammo = "Stinger Missile" end
					if weaponid == 37 then weapon = "Flamethrower" end
					if weaponid == 37 then ammo = "Fuel Canister" end
					if weaponid == 38 then weapon = "Minigun" end
					if weaponid == 39 then weapon = "Satchel Charge" end
					
					if weaponid == 41 then weapon = "Spray Can" end
					if weaponid == 42 then weapon = "Agent Pale" end
					if weaponid == 43 then weapon = "Binoculars" end
					if weaponid == 44 then weapon = "Night Vision Googles" end
					if weaponid == 45 then weapon = "Thermal Googles" end

					table.insert(droppedWeapons, {weapon, ammo})					
				end
			end
						
			for _,item in ipairs(beltinv) do
				if item ~= "Empty" then
				table.insert(droppedWeapons, {item,nil})
				end
			end
			
			for _,item in ipairs(maininv) do
				if item ~= "Empty" then
				table.insert(droppedWeapons, {item,nil})
				end
			end
			
			for _,item in ipairs(equippinv) do
				if item ~= "Empty" then
				table.insert(droppedWeapons, {item,nil})
				end
			end
			
			local weaponstodrop = droppedWeapons
			
			setTimer(DropAllWeapons,2000,1,weaponstodrop,player)
			
		end)

addEventHandler ( "onPedWasted", getRootElement (),

function ()
	if getElementData(source,"zombie") ~= true then
		--outputDebugString("is not zombie")
		return
	else 
		--outputDebugString("is zombie")
		local randnumber = math.random(0,3)
		if randnumber >= 2 then 
		local zX, zY, zZ = getElementPosition ( source )
		local timeout = 60000--get("timeout")
		local pickup = createObjectItem( table.random (zombieloot), zX, zY, zZ-0.95, 97.3, 120, math.random(0,359) )
		else
		end
end
end	)	

addEventHandler ( "onPedWasted", getRootElement (),
	function ( source_ammo, killer, killer_weapon, bodypart )
		local pX, pY, pZ = getElementPosition ( source )
		local timeout = 36000--get("timeout")

		local droppedWeapons = {}
			for slot = 0,12 do
				 
				if (getPedWeapon(source, slot) ~= 0) then
					local weaponid = getPedWeapon(source, slot)
					local weapon = nil
					local ammo = nil

					if weaponid == 1 then weapon = "Tactical Shield" end
					if weaponid == 2 then weapon = "Axe" end
					if weaponid == 3 then weapon = "Nightstick" end
					if weaponid == 4 then weapon = "Knife" end
					if weaponid == 5 then weapon = "Baseball Bat" end
					if weaponid == 6 then weapon = "Crowbar" end
					if weaponid == 7 then weapon = "Sledgehammer" end
					if weaponid == 8 then weapon = "Raider Sword" end
					if weaponid == 9 then weapon = "Chainsaw" end
					if weaponid == 10 then weapon = "Machete" end
					if weaponid == 11 then weapon = "Kitchen Knife" end
					if weaponid == 12 then weapon = "Meatcleaver" end
					if weaponid == 14 then weapon = "Broken Bottle" end
					if weaponid == 15 then weapon = "Nail Bat" end
					if weaponid == 16 then weapon = "Grenade" end
					if weaponid == 17 then weapon = "Teargas" end
					if weaponid == 18 then weapon = "Molotov" end
					
					if weaponid == 22 then weapon = "Pistol" end
					if weaponid == 22 then ammo = "Pistol Ammo" end
					
					if weaponid == 23 then weapon = "Crossbow" end
					if weaponid == 23 then ammo = "Bolts" end
					
					if weaponid == 24 then weapon = "Magnum Revolver" end
					if weaponid == 24 then ammo = "Magnum Ammo" end
					
					if weaponid == 25 then weapon = "Pump Shotgun" end
					if weaponid == 25 then ammo = "Shotgun Ammo" end
					
					if weaponid == 26 then weapon = "Sawn-off Shotgun" end
					if weaponid == 26 then ammo = "Shotgun Ammo" end
					
					if weaponid == 27 then weapon = "Combat Shotgun" end
					if weaponid == 27 then ammo = "Shotgun Ammo" end
					
					if weaponid == 28 then weapon = "Uzi" end
					if weaponid == 28 then ammo = "SMG Ammo" end
					
					if weaponid == 29 then weapon = "MP5" end
					if weaponid == 29 then ammo = "SMG Ammo" end
					
					if weaponid == 30 then weapon = "AK 47" end
					if weaponid == 30 then ammo = "Assault Ammo" end
					
					if weaponid == 31 then weapon = "M4" end
					if weaponid == 31 then ammo = "Assault Ammo" end
					
					if weaponid == 32 then weapon = "Vehicle Minigun" end
					if weaponid == 32 then ammo = "SMG Ammo" end
					
					if weaponid == 33 then weapon = "Rifle" end
					if weaponid == 33 then ammo = "Rifle Ammo" end
					
					if weaponid == 34 then weapon = "Sniper Rifle" end
					if weaponid == 34 then ammo = "Rifle Ammo" end
					
					if weaponid == 35 then weapon = "Rocket Launcher" end
					if weaponid == 36 then weapon = "Stinger Launcher" end
					if weaponid == 36 then ammo = "Stinger Missile" end
					if weaponid == 37 then weapon = "Flamethrower" end
					if weaponid == 37 then ammo = "Fuel Canister" end
					if weaponid == 38 then weapon = "Minigun" end
					if weaponid == 39 then weapon = "Satchel Charge" end
					
					if weaponid == 41 then weapon = "Spray Can" end
					if weaponid == 42 then weapon = "Agent Pale" end
					if weaponid == 43 then weapon = "Binoculars" end
					if weaponid == 44 then weapon = "Night Vision Googles" end
					if weaponid == 45 then weapon = "Thermal Googles" end
					if weaponid == 46 then weapon = "Backpack" end

					table.insert(droppedWeapons, {weapon, ammo})					
				end
			end
			local weaponstodrop = droppedWeapons
			setTimer(DropAllWeapons,2000,1,weaponstodrop,source)
		end)


function DropAllWeapons ( droppedWeapons, ped )

if not ped then return end

	setPedWeaponSlot(ped,0)
	
	local radius = get("radius")/2
	local numberDropped = #droppedWeapons
	for i, t in ipairs(droppedWeapons) do
		local pX, pY, pZ = getElementPosition ( ped )
		local x = pX + radius * math.cos((i-1) * 2 * math.pi / numberDropped)
		local y = pY + radius * math.sin((i-1) * 2 * math.pi / numberDropped)
		local timeout = 60000 
		local pickup = createObjectItem( t[1], x, y, pZ-0.90, 97.3,120,0 ) 
			if type(t[2]) == "string" then
			local ammopickup = createObjectItem( t[2], x+0.3, y+0.3, pZ-0.90, 97.3,120,math.random(0,359) )
			end
			
			
		if getElementData(ped,"raider") == true then
			local pickup2 = createObjectItem( table.random(raidersLoot), x-0.3, y-0.3, pZ-0.95, 97.3,120,math.random(0,359) )
		
		elseif getElementData(ped,"questgiver") == true then
			local pickup2 = createObjectItem( table.random(QuestGiverLoot), x-0.3, y-0.3, pZ-0.95, 97.3,120,math.random(0,359) )
		
		elseif getElementData(ped,"vendor") == true then
			local pickup2 = createObjectItem( table.random(vendorLoot), x-0.3, y-0.3, pZ-0.95, 97.3,120,math.random(0,359) )
			
		elseif getElementData(ped,"scavenger") == true then
				local pickup2 = createObjectItem( table.random(scavengersLoot), x-0.3, y-0.3, pZ-0.95, 97.3,120,math.random(0,359) )
			
		elseif getElementData(ped,"freelancer") == true then
				local pickup2 = createObjectItem( table.random(freelancerLoot), x-0.3, y-0.3, pZ-0.95, 97.3,120,math.random(0,359) )
		
		elseif getElementData(ped,"neutralfreelancer") == true then
				local pickup2 = createObjectItem( table.random(neutralfreelancerLoot), x-0.3, y-0.3, pZ-0.95, 97.3,120,math.random(0,359) )
		
		
		elseif getElementData(ped,"cdf") == true then
			local name = getElementData(ped,"name")
				if name == "Citizen" then
					local pickup2 = createObjectItem( table.random(CDFCitizenLoot), x-0.3, y-0.3, pZ-0.95, 97.3,120,math.random(0,359) )
				elseif name == "Militia" then
					local pickup2 = createObjectItem( table.random(CDFMilitiaLoot), x-0.3, y-0.3, pZ-0.95, 97.3,120,math.random(0,359) )
				end
		
		elseif getElementData(ped,"refugee") == true then
				local pickup2 = createObjectItem( table.random(refugeeLoot), x-0.3, y-0.3, pZ-0.95, 97.3,120,math.random(0,359) )
		
		elseif getElementData(ped,"syndicate") == true then
				local pickup2 = createObjectItem( table.random(scavengersLoot), x-0.3, y-0.3, pZ-0.95, 97.3,120,math.random(0,359) )
		
		elseif getElementData(ped,"bandit") == true then
				local pickup2 = createObjectItem( table.random(banditLoot), x-0.3, y-0.3, pZ-0.95, 97.3,120,math.random(0,359) )
		
		elseif getElementData(ped,"heavy") == true then
				local pickup2 = createObjectItem( table.random(establishmentHeavyTrooperLoot), x-0.3, y-0.3, pZ-0.95, 97.3,120,math.random(0,359) )
		
		elseif getElementData(ped,"spec") == true then
				local pickup2 = createObjectItem( table.random(establishmentSpecLoot), x-0.3, y-0.3, pZ-0.95, 97.3,120,math.random(0,359) )

		elseif getElementData(ped,"peacekeeper") == true then
				local pickup2 = createObjectItem( table.random(establishmentPeacekeeperLoot), x-0.3, y-0.3, pZ-0.95, 97.3,120,math.random(0,359) )
				
		elseif getElementData(ped,"establishment") == true then
				local pickup2 = createObjectItem( table.random(establishmentTrooperLoot), x-0.3, y-0.3, pZ-0.95, 97.3,120,math.random(0,359) )
		
		end	
	end
end

