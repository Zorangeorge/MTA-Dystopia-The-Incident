---DIALOGUE
	positiveAnswers = {"Yes","Yeah","Okay"}
	negativeAnswers = {"No","No way...","Hell no!"}
	greetings = {"Hey!","What's up?","How you doin'?"}
	followchat = {"Follow me","Come with me"}
	waitchat = {"Wait here","Wait"}
	helpchat = {"Heeelp!","I need help!","Help me!"}
	followingAknowledgments = {"Okay, you lead!","Lead on!","I'm following!"}
	followingRefused = {"I don't think so","Maybe later","Not likely...","Ummm... no!"}
	resumingFollow = {"Let's move!","Let's go!","Lead on!"}
	nope_anims = {"endchat_01","endchat_02"}
	chat_anims = {"IDLE_chat","endchat_01","XPRESSscratch","roadcross"}
	pigAnims = {"WALK_civi","facsurp"}
	animalAnims = {"WALK_civi","facsurp"}
	civiliansAnims = {"WALK_civi","IDLE_tired","WALK_civi","WALK_civi","roadcross","WALK_civi","endchat_01","facgum","gum_eat","Idlestance_fat","XPRESSscratch"}
	civiliansPanicAnims = {"run_civi","cower"}
	
	empty_help_messsage = " "
vehicle_help_messsage = "Use [F] to enter vehicle or [Q] to access its storage."
loot_help_messsage = "Break loot boxes to obtain items. Right-Click + [F] delivers a heavy attack. You can pick up smaller loot boxes with [H]."
items_help_messsage = "Use [Q] to open inventory and click item labels to pick them up. Alternatively, use [E] while standing on top of the item."
firebin_help_messsage = "Stay close to a fire place to slowly regain health. Use [J] to cook (ingredients required)."
shelter_help_messsage = "Shelters provide a safe area around them, where you can securely park vehicles."
strongbox_help_messsage = "Use [Q] to open the Strongbox. This is your safe storage, accessible from multiple locations."
wreck_help_messsage = "Use [E] to scavenge wrecked vehicles for vehicle parts and scrap metal (toolbox required)."
fuel_help_messsage = "Use [E] to take fuel from barrels (empty canister required). Use [H] to pick up barrels. Drop them over a suitable vehicle to load them up."
clothes_help_messsage = "Use [E] to change your character while standing over clothes piles."
stockpile_help_messsage = "Use [Q] to open Stockpile or [H] to pick it up and move it to a different location. Drop it over a suitable vehicle to load it up."
bed_help_messsage = "Use [E] to sleep in a bed. Sleeping in beds slowly regains your health. Sleep for 60 seconds to also regain a life!"
spikestrip_help_messsage = "Press [E] to remove a placed spikestrip and add it to your inventory."
dialogue_help_messsage = "Press [1] to talk with NPCs. Some have missions for you, others may trade or offer random advice."
butcher_help_messsage = "Press [R] to butcher a dead body and obtain raw meat. You need to have a bladed weapon equipped."
trade_help_messsage = "Right-click your items to sell them. Press [Q] to close trade."

	
playerSkin = {  239, -- hobo; SURV 1
					106, --thug fam2; MIL 1
					161, -- smoking cowboy; TECH 1
					291  -- paul; MED 1
					}
	
--[[Levels={ -- you can edit, name to level name, and Expreq to exp need to this level
			[1]={Name="lvl 0",Expreq=0}, 
			[2]={Name="lvl 1",Expreq=25}, --25
			[3]={Name="lvl 2",Expreq=50}, --50
			[4]={Name="lvl 3",Expreq=100}, --100
			[5]={Name="Hero",Expreq=200}, --200
			[6]={Name="Legend",Expreq=500} --500

			}]]

Levels={ -- you can edit, name to level name, and Expreq to exp need to this level
				[1]={Name="lvl 1",Expreq=0}, 
			[2]={Name="lvl 2",Expreq=25}, 
			[3]={Name="lvl 3",Expreq=50}, 
			[4]={Name="lvl 4",Expreq=100}, 
			[5]={Name="lvl 5",Expreq=200}, 
			[6]={Name="lvl 6",Expreq=400}, 
			[7]={Name="lvl 7",Expreq=800},
			[8]={Name="lvl 8",Expreq=1200},
			[9]={Name="lvl 9",Expreq=1600},
			[10]={Name="lvl 10",Expreq=2000},
			[11]={Name="Hero",Expreq=2500},
			[12]={Name="Legend",Expreq=3000} -- total XP: 11875
				--[[	[1]={Name="lvl 1",Expreq=0}, 
			[2]={Name="lvl 2",Expreq=2}, 
			[3]={Name="lvl 3",Expreq=3}, 
			[4]={Name="lvl 4",Expreq=4}, 
			[5]={Name="lvl 5",Expreq=5}, 
			[6]={Name="lvl 6",Expreq=6}, 
			[7]={Name="lvl 7",Expreq=7},
			[8]={Name="lvl 8",Expreq=8},
			[9]={Name="lvl 9",Expreq=9},
			[10]={Name="lvl 10",Expreq=10},
			[11]={Name="Hero",Expreq=11},
			[12]={Name="Legend",Expreq=12}]]

			}
	
---BOT SKIN AND WEAP TABLES

zedWalkerSkins = {22,56,67,68,69,70,128,152,162,167,188,195,206,209,229,264,280}
zedRunnerSkins = {22,56,67,68,69,70,128,152,162,167,188,195,206,209,229,264,280}
zedBruteSkins = {277,128,264,167,67}

raiderSkin = {
				108,109, --vagos
				181, --punk
				247, 248, --bikers
				242, --dread brother
				293 --ogloc
				} 
raiderPlayerSkin = {
				108,109, --vagos
				181, --punk
				247, 248, --bikers
				242 --dread brother
				} 

ScavengerGuardSkins = {143,160, 180, 183, 24, 220,272, 25,135}	
ScavengerFreelancerSkins = {183,29,202,24,25,112}
WastelanderFreelancerSkins = {100,133,143,13,202,26,223}	
NeutralFreelancerSkins = {32,79,134,183,29,100,177,241,28,30,47, 104, 144,135,137,160,168,182,200,230,223}
EstablishmentPeacekeeperSkins = {266,284,281,282}	
peacekeeperskin = 266
peacekeeperrecruitskin = 71
peacekeepermotoskin = 284
peacekeeperriotskin = 282
peacekeepercleanerskin = 281
EstablishmentSpecSkins = {285,279}
EstabTrooperSkins = {287,277}
EstabSuitSkins = {163,164,165,166}
EstabVIPSkins = {147,169,216,219,228,235,249,227,231,223,224,187,185,186,148,150,141,113,98,94,88,85,76,59,57,55,54,53,46,43,40,38,37,36,12,9,14}
EstabStaffSkins = {171,172,194,189,253,274,211,217,50,27,11,153,260,268,309,305}
banditSkin = { 
					28, --bmydrug
					30, --hmydrug
					47, --hmycr
					104, --ballas3
					144, --bmycg -masked black
					301, --ryder3
					241, --smyst - fat homeless masked
					177, --masked biker
					184, --brown hoody balaclava
					102, --bullets
					18, --wastelander
					223 --scarred bountyhunter
					}
survivorSkin = {}
slaveSkin = {	
					63, --bfypro
					145, --wfycrk
					146, --hmycm
					213, --vwmotr2
					238, --sbfypro
					257, --swfystr
					310
				}
meatSkin = {	
					252, --wmyva2
					154, --wmybe
					97 --wmylg
				}
cultSkin = {
					32, --dwmolc1
					33, --dwmolc2
					132, --dnmolc1
					157, --cwfyhb
					158, --cwmofr
					159, --cwmohb1
					160, --cwmohb2
					200 --cwmyhb2
				}
cultLadiesSkin = 214 --vwfywai
cultLeaderSkin = 259 --heck2
ScavengersVendorSkins = {132,95,44}
SyndicateDaNangSkin = { 121, 122, 123 }
SyndicateTriadSkin = {117,118}
SyndicateCivSkin = { 210, 54, 58, 57, 123, 170, 224, 225, 227, 263 }
wastelandersSkin = {34, --dwmylc1
						133, --dnmolc2
						134, --sbmotr2
						198, --cwfyfr1
						201, --dwfylc2
						202, --dwmylc2
						261, --wmycd1
						26 --el topo / gta backpack guy
						}
wastelanderCivSkin = {201, 197, 196, 160, 131, 132, 134, 129, 31, 10}
suitsSkin = {163, --bmyboun
				164, --wmyboun
				165, --wmomib
				166 --bmymib
				}
refUndergSkin = 23 --wmybmx
CDFStaffSkins = { 101,133,234,250,16,73,2 }
CDFskins = {179,101,133,234,250,16,176,73,2,21}
CDFVendorSkins = {236, 131, 1,2,21}
CDFMilitiaskins = {73,16,176,179,2,21,278}
dumpSkins = { 10,15,77,78,79 } 
animalFarmSkins = { 81 } --pig
animalWildSkins = { 80 } --goat
randomSCAVskins = {44, 213} --tatooed plaid, hobo elvis	
refugeeSkins = { 10,15,77,78,79, 32, 44, 58, 62, 95, 131, 132, 134, 137, 151, 157, 158, 159, 160 }
ScavengersQuestgiverSkins = {1} --the truth
WastelandersQuestgiverSkins = {161,133,129,136}
SyndQuestgiverSkins = {294,49} --wuzi, kungfumaster
banditWeapons = {25,27,29,30,33,34,31}
randomMelee = {  2, 4, 5,6,7, 8,10,11,12,15 }
randomweapon = { 0, 2, 4, 5, 8, 9, 24, 25, 28, 33 } --random weap
gruntWeapons = { 3, 31, 29, 27 }
raiderWeapons = { 11,12,15,23,33,25,2,4,5,6,7,8,10,24}
raiderBossWeapons = { 25,27,30,33,34,31,24}
genericGuardWeapons = {25,29,33} --pump shotgun, MP5 and rifle
SyndicateTriadWeapons = {30,27,29}
randomSmallMelee = {0,4,10,11,12}
randomSmallGun = {22,28,24}
--randomweapon = { 0, 1, 2, 4, 5, 8, 9, 24, 25, 28, 33 } --random weap	
ESTgruntWeapons = { 31, 29 } --military weapons
ESTCleanerWeapons = {29,27,37}
ESTgruntHeavyWeapons = {31,27}
ESTSpecWeapons = {3}
CampGuardWeapons = { 29, 25 } --camp guards weapons
NeutralFreelancerWeapons = { 4,5,6,7,8,25,10,11,12,14,15,24 } --vagrants and looters weapons



woodobjects = {1219,1224,1228,1255,1280,1407,1410,1408,1418,1417,1421,1425,1431,1446,1448,1449,1450,1451,1452,1456,1457,1458,1459,1460,1461,1462,1463,1470,1471,1472,1473,1474,1475,1476,1477,1479,1480,1482,3260,3275,3276,881,882,883,884,885,886,887,888,889,890,891,892,893,894,895,904,858,1428,1437,3091} --wood
scrapmetalobjects = {996,1211,1227,1229,1235,1285,1286,1287,1288,1289,1291,1293,1300,1328,1414,1424,1481,1554,3067,3302} --scrap metal
complexmetalobjects = {1302,1411,1412,1413,1420,1429,1447,1514,2942,2943,3864} --scrap metal & wire
woodmetalobjects = {1415,1426,1436,1464,1465,1466,1467,1469,1478,1483} --scrap metal & wood
dispenserobjects = {955, 956, 1209, 1775, 1776} --vending machines; one type will have to be reserved for the refugee camp soup dispenser	
lowXpObj = {955, 956, 1209, 1775, 1776} --these objects can be farmed since they are not really destroyed when they break; might be a bug with dystopia or gta or mta; list needs some trees added
residentialLootObjects = {1440,1438,1429,2968,2900,1230,1220,1221}	
--residentialMovableLootObjects = {1220, 1221, 1230, 2900, 2968 }	
--industrialMovableLootObjects = {1224,1224}
industrialLootObjects = {2971,1431,1441,1224}
supermarketLootObjects = {1221,1220,1230,2900,2968,1438}	
farmLootObjects = {1431, 1441, 1224}
militaryLootObjects = {1421,2977}
medicalLootObjects = {1558}
dispenseritems = {"Water Bottle","Scrap Metal","Wire"}
ammoBoxContents = {"Pistol Ammo","SMG Ammo","Shotgun Ammo","Assault Ammo","Rifle Ammo","Magnum Ammo"}
	
allweap = {"Knife", "Raider Sword", "Meat Can", "Water", "SMG Ammo","SMG Ammo", "MP5","Combat Shotgun","Pistol Ammo", "Magnum Revolver", "Magnum Ammo", 
			"Crossbow", "Bolts","Assault Ammo","Assault Ammo", "M4","Hunting Rifle","Sniper Rifle","AK 47", "Uzi", "Shotgun Ammo", "Sawn-off Shotgun", "Crowbar", 
			"Sledgehammer", "Pistol", "Molotov", "Nightstick","Baseball Bat", "Axe","Binoculars","Spray Can","Pump Shotgun","Body Armor","Backpack", "Medikit", 
			"Painkillers", "Rifle Ammo", "Rifle Ammo","Stinger Launcher", "Rocket Launcher", "Flamethrower","Kitchen Knife", "Machete", "Nail Bat","Broken Bottle" }

randomStartItemsTable = {"Water Bottle","Meat Can","Kitchen Knife","Baseball Bat","Painkillers","Headlamp","Lighter","Bandage"} --low level items for initial spawn; use table.random(randomStartItemsTable) to insert them 

residentialhousehold = {"Kitchen Knife", "Water Bottle", "Meat Can", "Baseball Bat", "Alcohol Bottle","Plastic Foil","Empty Bottle","Rags","Map","Meatcleaver","Headlamp","Fish Can","Lighter","Bandage","Watch","Painkillers","Pistol","Pistol Ammo"}
residentialgarage = {"Crossbow", "Crowbar", "Bolts", "Axe","Sledgehammer","Toolbox","Empty Canister","Fuel Canister","Broken Bottle","Plastic Foil","Wire","Map","Knife","Scrap Metal","Water Canister","Spray Can","Binoculars", "Alcohol Bottle","Empty Bottle","Rags","Headlamp","Wood","Lighter","Backpack","Road Flare","Radio","Magnum Revolver","Magnum Ammo"}
residentialweapons = {"Pistol","Pistol Ammo","Magnum Revolver","Magnum Ammo","Pump Shotgun","Shotgun Ammo","Sawn-off Shotgun","Machete","Uzi","SMG Ammo","Backpack","Ammo Box"}
ammunitionweapons = {"Pistol","Pistol Ammo","Pump Shotgun","Hunting Rifle","Rifle Ammo","Shotgun Ammo","Machete","Uzi","SMG Ammo","MP5","Binoculars","AK 47","Assault Ammo","Backpack","Knife","Ammo Box","Ammo Box","Laser Pointer","Night Vision Googles","Spikestrip","Magnum Revolver","Magnum Ammo","Body Armor","Teargas"}
policeweapons ={"Pump Shotgun","Shotgun Ammo","Pistol","Pistol Ammo","MP5","SMG Ammo","Nightstick","Magnum Revolver","Magnum Ammo","Body Armor","Headlamp","Laser Pointer","Night Vision Googles","Ammo Box","Spikestrip","Road Flare","Radio","Agent Pale","Teargas"}
heavyduty = {"Sledgehammer","Toolbox","Empty Canister","Fuel Canister","Axe","Scrap Metal","Crowbar","Vehicle Parts","Wire","Headlamp","Wood","Road Flare"}
foodandwater = {"Water Bottle","Meat Can","Fish Can","Water Bottle","Empty Bottle","Broken Bottle","Soup Can"}
officedistrict = {"Water Bottle","Binoculars","Spray Can","Pistol","Pistol Ammo","Painkillers","Map","Headlamp","Laser Pointer","Lighter","Bandage","Backpack","Watch","Radio"}
militaryloot ={"M4","Assault Ammo","Combat Shotgun","Shotgun Ammo","MP5","SMG Ammo","Binoculars","Ammo Box","Military Map","Thermal Googles","Laser Pointer","Zip Line","Night Vision Googles","Backpack","Rifle Ammo","Sniper Rifle","Spikestrip","EM Scanner","M37 Stomper","Stomper Ammo","Minigun Ammo","Agent Pale","Rocket Launcher","Grenade","Satchel Charge","Timed Bomb","Body Armor","Teargas","M4","Assault Ammo","Combat Shotgun","Shotgun Ammo","MP5","SMG Ammo","Binoculars","Ammo Box","Military Map","Thermal Googles","Laser Pointer","Zip Line","Night Vision Googles","Backpack","Rifle Ammo","Sniper Rifle","Spikestrip","EM Scanner","M37 Stomper","Stomper Ammo","Minigun Ammo","Agent Pale","Rocket Launcher","Grenade","Satchel Charge","Timed Bomb","Body Armor","Teargas","M4","Assault Ammo","Combat Shotgun","Shotgun Ammo","MP5","SMG Ammo","Binoculars","Ammo Box","Military Map","Thermal Googles","Laser Pointer","Zip Line","Night Vision Googles","Backpack","Rifle Ammo","Sniper Rifle","Spikestrip","EM Scanner","M37 Stomper","Stomper Ammo","Minigun Ammo","Agent Pale","Rocket Launcher","Grenade","Satchel Charge","Timed Bomb","Body Armor","Teargas","Minigun"}
medicalloot ={"Medikit","Painkillers","Bandage","Medikit","Splint","Adrenaline","ZomboKleen","Medikit"}
garbage = {"Scrap Metal","Rags","Plastic Foil","Wood","Broken Bottle"}

zombieloot = {"Rags","Rags","Rags","Kitchen Knife","Empty Bottle","Lighter","Broken Bottle","Watch"}
scavengersLoot = {"Rags","Kitchen Knife","Empty Bottle","Scrap Metal","Map","Painkillers","Alcohol Bottle","Survivor Map","Dirty Water","Headlamp","Wood","Lighter","Bandage","Empty Canister","Broken Bottle","Watch","Splint","Road Flare","Shards Trap","Wire"}
raidersLoot = {"Rags","Kitchen Knife","Empty Bottle","Scrap Metal","Survivor Map","Painkillers","Alcohol Bottle","Survivor Map","Dirty Water","Headlamp","Wood","Lighter","Bandage","Empty Canister","Broken Bottle","Watch","Splint","Road Flare","Shards Trap","Wire","Raw Human Meat","Roasted Human Meat"}
refugeeLoot = {"Rags","Kitchen Knife","Empty Bottle","Scrap Metal","Dirty Water","Map","Painkillers","Alcohol Bottle","Meat Can","Survivor Map","Dirty Water","Headlamp","Wood","Lighter","Bandage","Empty Canister","Broken Bottle","Watch","Splint","Road Flare","Soup Can","Spray Can","Wire"}
establishmentSpecLoot = {"Agent Pale","Water Bottle","Military Map","Painkillers","Headlamp","Soup Can","Lighter","Bandage","Adrenaline","ZomboKleen","Watch","EM Scanner","Road Flare","Nightstick","Radio","Mine","Laser Pointer","Thermal Googles","Teargas"}
establishmentPeacekeeperLoot = {"Water Bottle","Map","Painkillers","Headlamp","Soup Can","Lighter","Bandage","Adrenaline","Watch","Road Flare","Nightstick","Radio","Laser Pointer","Teargas"}
establishmentTrooperLoot = {"Water Bottle","Military Map","Painkillers","Headlamp","Soup Can","Lighter","Bandage","Adrenaline","Watch","Knife","Radio","Binoculars","Teargas"}
establishmentHeavyTrooperLoot = {"Water Canister","Military Map","Painkillers","Backpack","Headlamp","Soup Can","Lighter","Bandage","Toolbox","Adrenaline","Watch","EM Scanner","Road Flare","Knife","Radio","Mine","Satchel Charge","Ammo Box","Night Vision Googles","Teargas"}
CDFMilitiaLoot = {"Water Bottle","Military Map","Painkillers","Headlamp","Meat Can","Lighter","Toolbox","Bandage","Adrenaline","Watch","Road Flare","Knife","Radio","Incendiary Trap","Ammo Box","Fish Can","Teargas"}
CDFCitizenLoot = {"Empty Bottle","Map","Painkillers","Headlamp","Lighter","Bandage","Watch","Road Flare","Knife","Radio"}
QuestGiverLoot = {"Water Bottle","Survivor Map","Painkillers","Headlamp","Timed Bomb","Lighter","Bandage","Watch","EM Scanner","Road Flare","Knife","Radio","Medikit","Toolbox","Ammo Box"}
banditLoot = {"Water Bottle","Survivor Map","Painkillers","Headlamp","Lighter","Bandage","Adrenaline","Watch","Toolbox","Knife","Radio","Binoculars","Laser Pointer","Ammo Box","Alcohol Bottle","Roasted Meat","Incendiary Trap","Shards Trap","Spikestrip","Teargas"}
vendorLoot = {"Water Bottle","Survivor Map","Painkillers","Headlamp","Meat Can","Fish Can","Lighter","Bandage","Adrenaline","Watch","Knife","Radio","Binoculars","Toolbox","Medikit","Fuel Canister","Water Canister","Empty Canister","Backpack","Ammo Box","Roasted Meat","Pistol Ammo","SMG Ammo","Shotgun Ammo","Assault Ammo","Rifle Ammo","Magnum Ammo","Splint","Body Armor"}
freelancerLoot = {"Water Bottle","Survivor Map","Painkillers","Headlamp","Lighter","Toolbox","Bandage","Adrenaline","Watch","Road Flare","Knife","Radio","Incendiary Trap","Ammo Box","Roasted Meat","Spray Can","Fuel Canister","Water Canister","Shards Trap","Spikestrip","Medikit","Crowbar","Alcohol Bottle"}
neutralfreelancerLoot = {"Rags","Kitchen Knife","Empty Bottle","Scrap Metal","Map","Painkillers","Alcohol Bottle","Survivor Map","Dirty Water","Headlamp","Wood","Lighter","Bandage","Empty Canister","Broken Bottle","Watch","Splint","Road Flare","Shards Trap","Wire","Dirty Water","Survivor Map","Painkillers","Headlamp","Lighter","Toolbox","Bandage","Adrenaline","Watch","Road Flare","Knife","Radio","Incendiary Trap","Ammo Box","Roasted Meat","Spray Can","Fuel Canister","Empty Canister","Shards Trap","Spikestrip","Medikit","Crowbar","Alcohol Bottle"}
pedRobberyLoot = {"Survivor Map","Painkillers","Headlamp","Lighter","Toolbox","Bandage","Adrenaline","Watch","Road Flare","Kitchen Knife","Radio","Roasted Meat","Splint","Alcohol Bottle","Map","Water Bottle","Binoculars","Spray Can"}

wreckscavengerandomtable = {"Scrap Metal", "Vehicle Parts", "Scrap Metal","Scrap Metal","Scrap Metal"}
vehiclescavengerandomtable = {"Vehicle Parts", "Vehicle Parts", "Scrap Metal","Vehicle Parts","Vehicle Parts"}

--TABLES FOR WEAPON STATS AND FEATURES
weaponsTrue = { [0]=true,[1]=true, [2]=true, [3]=true, [4]=true, [5]=true, [6]=true, [7]=true, [8]=true, [9]=true, [10]=true, [11]=true, [12]=true, [14]=true, [15]=true }
meleeWeaponsDamage = { [0]=3,[1]=5, [2]=10, [3]=10, [4]=10, [5]=10, [6]=10, [7]=15, [8]=15, [9]=5, [10]=15, [11]=10, [12]=10, [14]=5, [15]=10 } -- ONLY MELEE WEAPONS HERE; 
KOWeapons = { [0]=true, [1]=true, [3]=true, [5]=true, [7]=true, [14]=true  }
bleedWeapons = { [2]=true, [4]=true, [8]=true, [9]=true, [10]=true, [11]=true, [12]=true, [14]=true, [15]=true, [23]=true }
bladedWeapons = {[2]=true, [4]=true, [8]=true, [9]=true, [10]=true, [11]=true, [12]=true, [15]=true }

idstable = { --vehicle ids table -- do not change order, it is co-dependent with namestbl below 
		 "482",
		 "440",
		 "558",
		 "541",
		 "426",
		 "602",
		 "600",
		 "401",
		 "518",
		 "496",
		 "479",
		 "527",
		 "580",
		 "575",
		 "542",
		 "445",
		 "489",
		 "400",
		 "422",
		 "589",
		 "466",
		 "504",
		 "478",
		 "514",
		 "408",
		 "467",
		 "536",
		 "500",
		 "475",
		 "402",
		 "434",
		 "552",
		 "528",
		 "508",
		 "459",
		 "470",
		 "484",
		 "454",
		 "554",
		 "523",
		 "525",
		 "515",
		 "463",
		 "468",
		 "586",
		 "581",
		 "471",
		 "481",
		 "510",
		 "413",
		 "543",
		 "530",
		 "596",
		 "598",
		 "597",
		 "407",
		 "599",
		 "473",
		 "453",
		 "472",
		 "553",
		 "512",
		 "563",
		 "487",
		 "460",
		 "548",
		 "469",
		 "443",
		 "549",
		 "403",
		 "568",
		 "537",
		 "538",
		 "521",
		 "522", -- NRG-500 entry, keep name empty, used for grapple hook
		 "464",  --RC Baron, used for mounted minigun
		 "447",
		 "442",
		"474",
		"455",
		"490",
		"416",
		"534",
		"576",
		"412",
		"476",
		"520",
		"417",
		"609",
		"498",
		"593",
		"583",
		"404",
		"458",
		"410",
		"421",
		"545",
		"414",
		"433",
		"539",
		"592",
		"456",
		"573",
		"405",
		"603",
		"594", --RC flowerpot, used as an aircraft bomb
		 }
namestbl = { --vehicle custom names table
"Burrito" ,
"Reinforced Burrito" ,
"Uranus" ,
"Uranus Ram" ,
"Premier" ,
"Reinforced Premier" ,
"Picador" ,
"Reinforced Picador" ,
"Buccaneer" ,
"Reinforced Buccaneer" ,
"Regina",
"Reinforced Regina" ,
"Stafford" ,
"Reinforced Stafford" ,
"Clover" ,
"Reinforced Clover" ,
"Rancher" ,
"Reinforced Rancher" ,
"Bobcat" ,
"Reinforced Bobcat" ,
"Glendale" ,
"Reinforced Glendale" ,
"Rusty Walton" ,
"Tanker" ,
"Trashmaster" ,
"Rusty Oceanic" ,
"Rusty Blade" ,
"Mesa Rockcrawler" ,
"Sabre Supercharged" ,
"Buffalo Bonemaster" ,
"Interceptor" ,
"Flat Van" ,
"Rescue01 Van" ,
"Journey" ,
"Surveillance Van" ,
"Patriot" ,
"Yacht" ,
"Cruiser" ,
"Yosemite" ,
"HPV 1000" ,
"Towtruck" ,
"Roadtrain" ,
"Freeway" ,
"Sanchez" ,
"Wayfarer" ,
"BF 400" ,
"Quadbike" ,
"Bike" ,
"Mountain Bike" ,
"Pony" ,
"Sadler" ,
"Forklift" ,
"Police Cruiser" ,
"Police Cruiser" ,
"Police Cruiser" ,
"Firetruck" ,
"Police Ranger" ,
"Dinghy" ,
"Fishing Boat" ,
"Coastguard" ,
"Nevada" ,
"Cropduster" ,
"Raindance" ,
"Maverick" ,
"Skimmer" ,
"Cargobob" ,
"Sparrow" ,
"Siege Truck" ,
"Tampa" ,
"Linerunner" ,
"Bandito" ,
"Freight Engine" ,
"Brown Streak",
"FCR-900",
"",  -- NRG-500 entry, keep it empty, used for grapple hook
"Minigun",   -- RC Baron, used for mounted minigun
"Gunship" ,  
"Romero",
"Hermes",
"Flatbed",
"Rancher XL",
"Ambulance",
"Remington",
"Tornado",
"Voodoo",
"Rustler",
"Hydra",  
"Leviathan",
"Boxville",  
"Boxville",  
"Dodo",
"Tug",
"Perennial",
"Solair",  
"Manana",
"Washington",  
"Hustler" ,
"Mule",
"Barracks",
"Vortex" ,
"Andromada",
"Yankee",
"Dune",
"Sentinel",
"Phoenix",
" ", --RC flowerpot, used as an aircraft bomb
}



	

cityNameList = {    
					"Tierra Robada",
                    "Bone County",
                    "Las Venturas",
                    "San Fierro",
                    "Red County",
                    "Whetstone",
                    "Flint County",
                    "Los Santos",
                }
zoneTable = {
        "Bayside Marina",
        "Bayside",
        "Battery Point",
        "Paradiso",
        "Santa Flora",
        "Palisades",
        "City Hall",
        "Ocean Flats",
        "Foster Valley",
        "Foster Valley",
        "Hashbury",
        "Juniper Hollow",
        "Esplanade North",
        "Financial",
        "Calton Heights",
        "Downtown",
        "Juniper Hill",
        "Chinatown",
       "Downtown",
        "King's",
        "Garcia",
        "Doherty",
        "Easter Bay Airport",
        "Easter Basin",
        "Esplanade East",
        "Angel Pine",
        "Shady Cabin",
        "Back o Beyond",
        "Leafy Hollow",
        "Flint Range",
        "Fallen Tree",
        "The Farm",
        "El Quebrados",
        "Aldea Malvada",
        "The Sherman Dam",
        "Las Barrancas",
        "Fort Carson",
        "Hunter Quarry",
        "Octane Springs",
        "Green Palms",
        "Regular Tom",
        "Las Brujas",
        "Verdant Meadows",
        "Las Payasadas",
        "Arco del Oeste",
        "Hankypanky Point",
        "Palomino Creek",
        "North Rock",
        "Montgomery",
        "Hampton Barns",
        "Fern Ridge",
        "Dillimore",
        "Hilltop Farm",
        "Blueberry",
        "The Panopticon",
        "Frederick Bridge",
        "The Mako Span",
        "Blueberry Acres",
        "Martin Bridge",
        "Fallow Bridge",
        "Shady Creeks",
        "Queens",
        "Los Santos",
        "Las Venturas",
        "Bone County",
        "Tierra Robada",
        "Gant Bridge",
        "San Fierro",
        "Red County",
        "Flint County",
        "Easter Bay Chemicals",
        "Foster Valley",
        "Easter Bay Airport",
        "Whetstone",
        "Los Santos International",
        "Verdant Bluffs",
        "El Corona",
        "Willowfield",
       "Ocean Docks",
        "Marina",
        "Verona Beach",
        "Verdant Bluffs",
        "Conference Center",
        "Commerce",
        "Pershing Square",
        "Little Mexico",
        "Idlewood",
        "Glen Park",
        "Jefferson",
        "Las Colinas",
        "Ganton",
        "East Beach",
        "East Los Santos",
        "Los Flores",
        "Downtown Los Santos",
        "Mulholland Intersection",
        "Mulholland",
        "Market",
        "Vinewood",
        "Temple",
        "Santa Maria Beach",
        "Rodeo",
        "Richman",
        "The Strip",
        "The Four Dragons Casino",
        "The Pink Swan",
        "The High Roller",
        "Pirates in Men's Pants",
        "The Visage",
        "Julius Thruway South",
        "Julius Thruway West",
        "Rockshore East",
        "Come-A-Lot",
        "The Camel's Toe",
        "Royal Casino",
        "Caligula's Palace",
        "Pilgrim",
        "Starfish Casino",
        "The Emerald Isle",
        "Old Venturas Strip",
        "K.A.C.C. Military Fuels",
        "Creek",
        "Sobell Rail Yards",
        "Linden Station",
        "Julius Thruway East",
        "Linden Side",
        "Julius Thruway North",
        "Harry Gold Parkway",
        "Redsands East",
        "Redsands West",
        "Las Venturas Airport",
        "LVA Freight Depot",
        "Blackfield Intersection",
        "LVA Freight Depot",
        "Greenglass College",
        "Blackfield",
        "Roca Escalante",
        "Last Dime Motel",
        "Rockshore West",
        "Randolph Industrial Estate",
        "Blackfield Chapel",
        "Pilson Intersection",
        "Whitewood Estates",
        "Prickle Pine",
        "Spinybed",
        "Pilgrim",
        "San Andreas Sound",
        "Fisher's Lagoon",
        "Garver Bridge",
        "Kincaid Bridge",
        "Los Santos Inlet",
        "Sherman Reservoir",
        "Flint Water",
        "Easter Tunnel",
        "Bayside Tunnel",
        "'The Big Ear'",
        "Lil' Probe Inn",
       "Valle Ocultado",
        "Glen Park",
        "Ocean Docks",
        "Linden Station",
        "Unity Station",
        "Market Station",
        "Cranberry Station",
        "Yellow Bell Station",
         "San Fierro Bay",
        "El Castillo del Diablo",
        "Restricted Area",
       "Montgomery Intersection",
        "Robada Intersection",
        "Flint Intersection",
        "Easter Bay Airport",
        "Market",
        "Avispa Country Club",
        "Missionary Hill",
        "Mount Chiliad",
        "Yellow Bell Golf Course",
        "Las Venturas Airport",
        "Ocean Docks",
        "Los Santos International",
      "Los Santos International",
      "Starfish Casino",
       "Beacon Hill",
       "Avispa Country Club",
        "Garcia",
       "Playa del Seville",
        "The Clown's Pocket" }

---BOTS SPAWNED ZONE TABLES --am I still using these? #investigate NOPE :)
--[[LasColinasBots = {}
RestrictedAreaBots = {}
AldeaMalvadaBots = {}
EastLosSantosBots = {}
PershingSquareBots = {}
ChinatownBots = {}
SantaMariaBeachBots = {}
JunkyardBots = {}
DillimoreBots = {}
RedCountyBots = {}
FlintRangeBots = {}
OctaneSpringsBots = {}
FlintCountyBots = {}
ShadyCreeksBots = {}
TierraRobadaBots = {}
ThePanopticonBots = {}
TheFarmBots = {}
BackOBeyondBots = {}
HankypankyPointBots = {}
VerdantBluffsBots = {}
HilltopFarmBots = {}
BlueberryAcresBots = {}
LasPayasadasBots = {}
YellowBellGolfCourseBots = {}
RockshoreEastBots = {}
PalominoCreekBots = {} 
CommerceBots = {}]]

traderChat ={"Check my wares! Maybe you'll find something you need.","You're looking to trade? Let me show you my wares!","Check my merchandise! C'mon, take a look!","Looking for something to buy? Search no more!","I might have something you need...","I'm a trader, not a philantrophist!","I sell all kind of goods. Take a look!","How much money you have?"}
dumpsitebosschat={"You're looking for a job?","You look like you could handle a punch... Perhaps I could use you.","I might have something for you to do..."}
campguardChat = {"Mind yourself inside the camp!","Lookin' to trade? Found the wrong guy, hehe...","Vehicle problems? A mechanic will help with that.","We're keeping a close watch on you!","We don't like your type 'round here","Solve your bussiness here and get lost!","No killing, no fighting, no loitering!","Were you bitten? Your pupils are kinda dilated...","Looking for the boss? Not me, not me!","They say there's a cure for the infection.","Don't you have somewhere else to be?","I don't want to talk right now","I'd do anything for a good meal right now!","Save your ammo. Shoot them in the head!","I barely got away from a group of robbers the other day!","Lock and load!","I don't trust you","I eat bandits for breakfast!"}
victimChat = {"No... Please! No...","*crying*","This is a nightmare, all this is a nightmare...","Please...","Please don't hurt me..."}
zombieChat = {"*angry moans*","*grunts*","*crazed mumbling*"}
civilianChat = {"Is that booze? Can I have a sip?","Please, do you have some food to spare?","I was thinking the same...","You look like you've seen a lot...","I've seen my family transforming in those monsters...","I drink to forget...","Be careful during the night, if you're heading out there","Be careful if you are going out there","There are good guys, and bad guys. Which one are you?","Psst! Got some smokes?","Thinking of them gives me the chills","I heard there are still some poker games around. Gambling will be the end of us!","I haven't seen you before...","I can't sleep anymore, I hear their screams every time I close my eyes","Life was hard before, but now it's unbearable...","I don't know for how long I can bare.","Sorry, what was that?","Do you hear them moaning? It gives me the shivers!","You thought of joining the Refugee Camp? Food, water and a safe place to sleep...","I heard there's a cure for the infection.","Are you infected?","My son had just landed at Easter Bay Airport when it all happened. Please, keep an eye out for him!","I heard rumors that the Establishment is hiding something","I'd do anything for a good meal right now!","I used to be a PR specialist before the Incident. How about you?","I was a plumber before all this","Never thought I'd live to see the End of Days!","I barely got away from a gang of robbers the other day!","I used to gamble in Las Venturas. Now it's just a hole in the ground.","I heard a big gunfight down the street last night","They keep getting stronger... crap, how do we get out of here?","*sigh* Look what I found! A broken bottle, the peeerfect weapon...", "I think I heard a train the other night...",
"There's an Establishment cargo plane circling all of San Andreas",
"They say that infection started in San Fierro",
"They say that bandits run a fighting ring in Las Venturas",
"Since they nuked Venturas, the whole place is a radiation dump hole!",
"Pack a rad suit if you're going to Venturas!",
"Avoid South Venturas. Radiation will melt your brain.",
"I heard mutant zeds were spotted around the nuke crater in Venturas",
"Do you have some wood and a bandage? I need to craft a splint",
"These camps are too busy. I'll go and build myself a shelter in the hills!",
"The whole Flint is bandit country nowadays",
"Joe Mills took his family to San Fierro through Whetstone. Never heard from them since!",
"Search for the Old Man. He has many answers!",
"I think I bought fake ZomboKleen the other day!",
"Have some rags? Gotta craft myself a backpack...",
"Two things are certain nowadays: infection and death.",
"Some gas stations still have fuel... you just need to look harder!",
"We can't stay here, we can't run away... What options do we get?",
"They say that the Establishment sinks any boat going too far from the coast",
"I heard that the Establishment would blow you to pieces if you try to leave San Andreas!","I heard raiders force people to fight in the cage in Hunter's Quarry" }
panicChat = {"Heeelp!","No, please no!","Go away!","Leave me alone!","Heeelp!","I'm scared, please nooo!","No! Don't touch me!"}
abusivecopChat = {"Move along!", "Nothing to see here, move along!","You want some too?","Do you have the guts to finish the job?","Get lost!","Move along! Official bussiness.","You talk too much","Are you infected?","Were you bitten? Your pupils are kinda dilated...","Don't you have somewhere else to be?","Do you ever get the feeling you're being watched through a sniper scope?","Piss off, don't get in my way!"}
refugeequesthubChat = { "We need water, food, fuel... Can you help?" , "The people here need any help available. Give us a hand!","You're looking for a job?","You look like you could take care of yourself... And others, perhaps?","I might have something for you to do..." }
refugeeChat = { "Life in the camp gets harder every day...", "Were you bitten? Your pupils are kinda dilated...","Have you seen my glasses?", "I heard that the Easter Bay quarantine camp was overrun. Zeds slaughtered them all...","If you're looking for a job, search for Aunt Helen","While we die of starvation here, the rich play poker in Bayside!", "Mind your words around the guards, or we'll all get punished.","Have you seen my daughter? I know she's alive!", "Is that booze? Can I have a sip?","Please, do you have some food to spare?","I was thinking the same...","You look like you've seen a lot...","I've seen my family transforming in those monsters...","Be careful during the night, if you're heading out there.","I haven't seen you before...","I can't sleep anymore, I hear their screams every time I close my eyes","Life was hard before, but now is unbearable...","I don't know for how long I can bare.","Sorry, what was that?","Do you hear them moaning? It gives me the shivers!","I never should have joined the Refugee Camp... The 'keepers kill us faster than the zombies!","Are you infected?","I got beaten for talking up to the guards...","Mind ye words 'round the 'keepers, or you'll end up in the cage.","Sally? Is that you?","I can't see without my glasses...","Before the Incident I was a chef","There are good guys, and bad guys. Which one are you?","I don't want to talk right now","My daughter went missing when it all happened. Please, keep an eye out for her!","I'd do anything for a good meal right now!","I used to be a bus driver before the Incident. How about you?","I was a plumber before all this","Never thought I'd live to see the End of Days!","Steve... Steve! Have you seen Steve?","I heard raiders force people to fight in the cage in Hunter's Quarry"}
peacekeepersChat = { "Get lost or I'll put you in the cage!", "We're keeping a close watch on you!", "We don't like your type around here, boy...", "Stay in line and you won't get hurt!", "Obey!", "Move along!","Get lost!","Go away, scum!","I don't like the looks of you, boy!","You talk too much","You look suspicious","Are you infected?","I was trained to bust heads, not babysit!","Don't mind my partner, he got here from LSPD","Do you ever get the feeling you're being watched through a sniper scope?","Don't you have somewhere else to be?","I don't want to talk right now","Save your ammo. Shoot them in the head!","A smile is cheaper than a bullet!","Lock and load!","I don't trust you","We is recruitin', go see Sgt. Stone to join!","Piss off, don't get in my way!",
"I'm told that MonoCorp is paying the Peacekeeper wages",
"MonoCorp brought their Air01 division to San Andreas", 
"I'm tired of these arrogant Suits snooping around", 
"The Underground scum will pay for their defiance!",
"I can't stand these fucking bureaucrats!",
"I just love the Peacekeeper life. We're clubbing all night long!",
"Don't get in the way of cleaners... They love burning people","I heard raiders force people to fight in the cage in Hunter's Quarry"}
suitChat = {"Hrrmpf..!","I don't like you","In the land of truth, the man with the facts is king","And I thought being transferred to San Andreas was a promotion...","You look suspicious","Get lost!","They told me this assignment will be like a holiday","You know too much","You talk too much","You've seen too much","Move along!","Shit, I forgot my night vision googles in the old bunker","Damn, I somehow lost my EM scanner","Don't you have somewhere else to be?","Do you ever get the feeling you're being watched through a sniper scope?","I don't want to talk right now","I don't trust you","I just love Site Echo assignments! The silence, the trees...",
"Since the Marines parked that carrier off-shore, supplies started flowing more easily","Air crashes became more frequent, we need to find the cause","Our aircraft keep getting shot down above Bone County and Tierra Robada"}
guardchat = {"*hhrmpf!*","*cough!*cough!*","I think I heard something!","Life's short out there, we need more people","*humming*","Huh...? What was that?","All this waiting, making me crazy...","The zeds grow restless, I can hear them!","Is that booze? Gimme a sip!","Psst! Got some smokes?","I drink to forget...","You talk too much","Are you infected?","A bullet a day keeps the zeds away","Do you ever get the feeling you're being watched through a sniper scope?","Don't you have something else to do?","I don't want to talk right now","I'd do anything for a good meal right now!","Save your ammo. Shoot them in the head!","Lock and load!","I don't trust you"}
raiderChat = {"Gotcha!", "*crazed laughter*", "Meat! Meat! Meat!", "Groaaaa..!","Bleed, little pig!","I'm hungry", "*crazed giggles*", "Meat! Red juicy meat!", "Hhrmpf...","*cough*cough*","I think I heard something...!","*humming*","What was that?","Is that booze? Gimme a sip!","Psst! Got a cig'?","Before the Incident I was a chef","Skraaaa pra-pra ta-ta-ta!","Ski-bi-di like boom!","I was eating people from before the Incident, hehe","When you're tired of hunting people, go play poker in the Quarry","You heard of the Cage Fighting in Hunter's Quarry?","You're alpha? Go and prove it in The Cage!","*howling*","My lunch just walked in!","Avoid South Venturas. Radiation will melt your brain.","I heard mutant zeds were spotted around the nuke crater in Venturas"}
CDFChat = {"I jumped in my BOV and evac'ed when SHTF!", "Watch out for hostiles!", "Don't try anything funny!", "I stand for the Free County of Red!", "Freemantle for President!", "Sheriff Gruber offers employment in Dillimore.", "The Freemantles will keep us safe!", "The zeds grow restless, I can hear them!","I heard there's a cure for the infection.","I like to play poker in Dillimore between assignments","Are you infected?","Psst! Got some smokes?","I drink to forget...","Do you hear them moaning? It gives me the shivers!","Don't you have something else to do?","Save your ammo. Shoot them in the head!","Keep your guns at ready!","Lock and load!","Keep your guns clean and loaded","I think I heard a train the other night...","There's an Establishment cargo plane circling all of San Andreas","They say that infection started in San Fierro","They say that bandits run a fighting ring in Las Venturas","Since they nuked Venturas, the whole place is a radiation dump hole!","Pack a rad suit if you're going to Venturas!","Avoid South Venturas. Radiation will melt your brain.","I heard mutant zeds were spotted around the nuke crater in Venturas","Do you have some wood and a bandage? I need to craft a splint","These camps are too busy. I'll go and build myself a shelter in the hills!","The whole Flint is bandit country nowadays","I think I bought fake ZomboKleen the other day!","Have some rags? Gotta craft myself a backpack...","Some gas stations still have fuel... you just need to look harder!","Don't get in the cleaner's way... They love burning people!","Our recruitors are always looking for new people. Not all recruits are prime material though..."}
banditChat = {"Those suckers in the scav camps, they scared of us...","*hhrmpf!*","*cough!*cough!*","I think I heard something!","Life's short out there, we need more people","*humming*","Huh...? What was that?","All this waiting, making me crazy...","Wanna play poker? Go to CJs mansion!","...so I told the fuckers: Hands up mo'fuckaz, 'dis a robbery!","Is that booze? Gimme a sip!","Psst! Got some smokes?","I heard old Derrik opened his Venturas fighting school again","I drink to forget...","The zeds grow restless, I can hear them!","You talk too much","Are you infected?","Do you ever get the feeling you're being watched through a sniper scope?","Don't you have something else to do?","I'd do anything for a good meal right now!","Save your ammo. Shoot them in the head!","A guy once told me to enjoy the little things in life. I shot him the morning after.","I can't remember the last time I had a good bourbon! Got any?","The day I shot my ex was the happiest in my life!","You better not go through my stuff back there!","I saw a man travelling with a bitten girl, claiming she was immune. She turned and ate him the next day, haha!","Lock and load!","Hey you! Come here, lemme tell you a joke!","Piss off, don't get in my way!","There's an Establishment cargo plane circling all of San Andreas", "They say that infection started in San Fierro", "Since they nuked Venturas, the whole place is a radiation dump hole!", "Pack a rad suit if you're going to Venturas!", "Avoid South Venturas. Radiation will melt your brain.", "I heard mutant zeds were spotted around the nuke crater in Venturas", "Do you have some wood and a bandage? I need to craft a splint", "These camps are too busy. I'll go and build myself a shelter in the hills!","I think I bought fake ZomboKleen the other day!", "Have some rags? Gotta craft myself a backpack...","Two things are certain nowadays: infection and death.", "Some gas stations still have fuel... you just need to look harder!", "We can't stay here, we can't run away... What options do we get?", "They say that the Establishment sinks any boat going too far from the coast", "I heard that the Establishment would blow you to pieces if you try to leave San Andreas!","I heard our boys brought down another Establishment aircraft. Here comes the booty!" }
refugeequesthubQuests = {"Our people are starving. Bring us some food cans.","We need more water! Can you bring us two water canisters?"}
refugeequesthubQuestsPositive = {"Great! Come back here when the job is done.","Very good. I'll wait for your return!"}
refugeequesthubQuestsNegative = {"Too bad. Let me know if you change your mind.","Well, we'll have to sort this out ourselves, then...","Okay, maybe someone else will help us..."}

QuestsIntroLines = {"Listen up...","Hear me out...","Hey, you...","Listen up...","Listen up..."}
QuestsPositive = {"Good!","Great!","Very good!"}
QuestsNegative = {"Too bad...","Okay then, go your way!","Let me know if you change your mind"}

gasmasks_tbl = {"gasmask","respirator","biomask"}
trooperhead_tbl = {"respirator"}
civvests_tbl = {"khakivest","blackvest"}
raiderhead_tbl = {"gasmask","respirator","biomask","bloodhockey"}
militiahead_tbl = {"respirator","biomask","redberet","cowboy"}
nomadhead_tbl = {"gasmask","respirator","biomask","bag","bloodhockey"}
heavytrooperhead_tbl = {"cowboy","respirator","biomask","redberet"}

TradeItemDescription = {}
TradeItemDescription["Assault Kit"] = "M4(150), Pistol(30), Knife, Grenade, Stomper(5), Laser Pointer,\nHeadlamp, Soup Can, Painkillers, Bandage, Radio, Armor(100)"
TradeItemDescription["Demolitions Kit"] = "Combat Shotgun(36), Pistol(30), Crowbar, Rocket Launcher, Satchel Charge(2),\nMine(2), Timed Bomb, Headlamp, Soup Can, Painkillers,\nBandage, Toolbox, Radio, Armor(50)"
TradeItemDescription["Recon Kit"] = "MP5(150), Pistol(30), Knife, Teargas, Binoculars,\nHeadlamp, Soup Can, Painkillers, Bandage, Adrenaline(2),\nRadio, Road Flare(2), Armor(25)"
TradeItemDescription["Sniper Kit"] = "Sniper Rifle(50), Pistol(30), Knife, Mine, Teargas,\nBinoculars, Headlamp, Soup Can, Painkillers, Bandage,\nAdrenaline(2), Radio, Road Flare(2)"
TradeItemDescription["Agent Kit"] = "MP5(150), Pistol(30), Knife, Satchel Charge, Binoculars,\nEM Scanner, Radio, Road Flare, Soup Can, Painkillers,\nBandage, Adrenaline, ZomboKleen, Armor(50)"
TradeItemDescription["Cleaner Kit"] = "Pump Shotgun(36), Machete, Molotov, Radio,\nHeadlamp, Road Flare, Soup Can,\nPainkillers, Bandage, ZomboKleen"
TradeItemDescription["Peacekeeper Kit"] = "Pump Shotgun(36), Nightstick, Teargas, Radio,\nHeadlamp, Road Flare, Soup Can, Painkillers,\nBandage, Spikestrip, Armor(25)"
TradeItemDescription["Support Kit"] = "Combat Shotgun(36), Pistol(30), Nightstick, Radio, Timed Bomb,\nHeadlamp, Road Flare, Soup Can, Painkillers,\nBandage, Toolbox, Minigun(1000), Armor(50)"
TradeItemDescription["Combat Medic Kit"] = "Pump Shotgun(36), Pistol(30), Medikit(2), Painkillers,\nBandage(2), Splint, Adrenaline, Soup Can,\nRadio, Road Flare, Armor(25)"
TradeItemDescription["Mongrel Kit"] = "Pump Shotgun(36), Kitchen Knife, Road Flare, Alcohol Bottle,\nDirty Water, Roasted Human Meat"
TradeItemDescription["Roadrunner Kit"] = "Magnum Revolver(36), Meatcleaver, Crowbar,\nMolotov, Spikestrip, Mine, Toolbox, Road Flare\nAlcohol Bottle, Dirty Water, Roasted Human Meat"
TradeItemDescription["Greasemonkey Kit"] = "Sawn-off Shotgun(16), Crossbow(10), Kitchen Knife, Molotov,\nZipline(2), Spikestrip, Mine, Toolbox, Road Flare(2), Radio,\nAlcohol Bottle, Dirty Water, Roasted Human Meat"
TradeItemDescription["Man Eater Kit"] = "Crossbow(10), Machete, Molotov, Spikestrip(2),\nShards Trap(2), Road Flare, Radio, Painkillers,\nAlcohol Bottle, Dirty Water, Roasted Human Meat"
TradeItemDescription["Unburnt Kit"] = "Sawn-off Shotgun(64), Raider Sword, Molotov, Fuel Canister,\nPainkillers, Road Flare, Radio, Incendiary Trap(2),\nAlcohol Bottle, Dirty Water, Roasted Human Meat"
TradeItemDescription["Pitdog Kit"] = "AK 47(150), Raider Sword, Molotov, Magnum Revolver(36),\nPainkillers, Road Flare, Radio, Adrenaline, Alcohol Bottle,\nToolbox, Dirty Water, Roasted Human Meat, Armor(50)"
TradeItemDescription["Berserker Kit"] = "Sledgehammer, Raider Sword, Molotov, Uzi(180), Toolbox,\nRoad Flare(2), Radio, Adrenaline(2), Alcohol Bottle, Painkillers,\nDirty Water, Roasted Human Meat, Armor(100)"
TradeItemDescription["Body Snatcher Kit"] = "Pump Shotgun(64), Baseball Bat, Meatcleaver, Molotov,\nMedikit, Radio, Adrenaline, Alcohol Bottle, Painkillers, Splint,\nHeadlamp, Dirty Water, Roasted Human Meat, Armor(50)"
TradeItemDescription["Militia Kit"] = "Rifle(50), Pistol(30), Machete, Grenade, Spikestrip\nMine, Radio, Adrenaline, Painkillers, Road Flare,\nHeadlamp, Water Bottle, Meat Can, Armor(50)"
TradeItemDescription["Ranger Kit"] = "M4(150), Magnum Revolver(24), Machete, Grenade, Shards Trap(3)\nRadio, Adrenaline, Painkillers, Road Flare(2), Bandage\nWater Bottle, Roasted Meat, Armor(50)"
TradeItemDescription["Survivalist Kit"] = "Rifle(50), Crossbow(10), Grenade, Axe, Shards Trap(2)\nRadio, Adrenaline, Painkillers, Road Flare, Bandage\nSplint, Water Canister, Roasted Meat(2), Armor(25)"
TradeItemDescription["Medicine Man Kit"] = "MP5(120), Pistol(30), Knife, Medikit,\nAdrenaline, Painkillers, Splint, Bandage(2),\nRadio, Soup Can(2)"
TradeItemDescription["Citizen Kit"] = "Pistol(30), Knife, Toolbox\nPainkillers, Bandage, Radio,\nMeat Can, Water Bottle"
TradeItemDescription["Vigilante Kit"] = "Shotgun(48), Baseball Bat, Magnum Revolver(24), Molotov\nSpikestrip, Painkillers, Adrenaline, Bandage,\nRoad Flare, Radio, Roasted Meat, Water Bottle"
TradeItemDescription["Robber Kit"] = "Shotgun(48), Nail Bat, Pistol(20), Spikestrip\nPainkillers, Bandage, Road Flare,\nRadio, Fish Can, Alcohol Bottle"
TradeItemDescription["Highwayman Kit"] = "Rifle(50), Machete, Magnum Revolver(24), Spikestrip(2), Toolbox,\nPainkillers, Bandage, Road Flare(2), Headlamp, Radio,\nRoasted Meat, Alcohol Bottle, Water Bottle, Fuel Canister, Armor(25)"
TradeItemDescription["Veteran Kit"] = "AK 47(150), Knife, Pistol(30), Spikestrip(2), Toolbox,\nPainkillers, Bandage, Road Flare(2), Headlamp, Radio,\nAdrenaline, Roasted Meat, Alcohol Bottle, Water Bottle, Armor(50)"
TradeItemDescription["Pirate Kit"] = "AK 47(150), Machete, Pistol(30), Molotov(2), Toolbox,\nPainkillers, Bandage, Road Flare, Headlamp, Radio,\nAdrenaline, Roasted Meat, Alcohol Bottle, Dirty Water, Fuel Canister, Armor(50)"
TradeItemDescription["Infiltrator Kit"] = "MP5(150), Knife, Crossbow(30), Teargas(2), Toolbox,\nZipline(2), Painkillers, Bandage, Road Flare, Radio,\nAdrenaline, Alcohol Bottle, Water Bottle, Armor(25)"
TradeItemDescription["Saboteur Kit"] = "Sawn-off Shotgun(32), Crowbar, Machete, Spikestrip(2), Satchel Charge,\nTimed Bomb, Shards Trap, Incendiary Trap, Toolbox, Mine,\nPainkillers, Bandage, Road Flare, Adrenaline, Armor(25)"
TradeItemDescription["Thug Kit"] = "Uzi(60), Pistol(30), Baseball Bat, Molotov,\nPainkillers, Road Flare, Alcohol Bottle"
TradeItemDescription["Scavenger Kit"] = "Pump Shotgun(40), Machete, Crowbar, Toolbox,\nPainkillers, Bandage, Road Flare(2), Water Bottle,\nFish Can, Armor(25)"
TradeItemDescription["Survivor Kit"] = "Pistol(30), Kitchen Knife,\nBandage, Water Bottle,\nMeat Can"
TradeItemDescription["Wastelander Kit"] = "MP5(120), Magnum Revolver(18), Machete, Toolbox\nPainkillers, Bandage, Splint, Road Flare, Headlamp\nWater Bottle, Roasted Meat, Fuel Canister, Armor(25)"
TradeItemDescription["Hunter Kit"] = "Rifle(100), Axe, Machete, Toolbox, Radio\nBandage, Splint, Road Flare, Headlamp\nWater Bottle, Roasted Meat, Wood(2)"
TradeItemDescription["Medic Kit"] = "Pump Shotgun(36), Knife, Medikit, Radio,\nAdrenaline, Painkillers, Bandage(2), Splint,\nRoad Flare, Water Bottle, Fish Can"
TradeItemDescription["Traveler Kit"] = "Pump Shotgun(36), Magnum Revolver(18), Toolbox, Radio,\nAdrenaline, Painkillers, Splint, Road Flare,\nWater Bottle, Meat Can"
TradeItemDescription["Bounty Hunter Kit"] = "AK 47(150), Magnum Revolver(18), Knife, Toolbox, Radio,\nAdrenaline, Painkillers, Splint, Road Flare(2), Headlamp,\nWater Bottle, Meat Can, Armor(50)"

--[[ new lines to add
"I think I heard a train the other night...",
"There's an Establishment cargo plane circling all of San Andreas",
"They say that infection started in San Fierro",
"They say that bandits run a fighting ring in Las Venturas",
"Since they nuked Venturas, the whole place is a radiation dump hole!",
"Pack a rad suit if you're going to Venturas!",
"Avoid South Venturas. Radiation will melt your brain.",
"I heard mutant zeds were spotted around the nuke crater in Venturas",
"Do you have some wood and a bandage? I need to craft a splint",
"These camps are too busy. I'll go and build myself a shelter in the hills!",
"The whole Flint County is bandit country nowadays",
"Joe Mills took his family to San Fierro through Whetstone. Never heard from them since!",
"Search for the Old Man. He has many answers!",
"I think I bought fake ZomboKleen the other day!",
"Have some rags? Gotta craft myself a backpack..."


"Two things are certain nowadays: infection and death.",
"Some gas stations still have fuel... you just need to look harder!",
"We can't stay here, we can't run away... What options do we get?",
"They say that the Establishment sinks any boat going too far from the coast",
"I heard that the Establishment would blow you to pieces if you try to leave San Andreas!",

"I heard our boys brought down another Establishment aircraft. Here comes the booty!",

"I heard raiders force people to fight in the cage in Hunter's Quarry",
"You're alpha? Go and prove it in The Cage!",
"*howling*",
"My lunch just walked in!",

"Air crashes became more frequent, we need to find the cause",
"Our aircraft keep getting shot down above Bone County and Tierra Robada",



"I just love Site Echo assignments! The silence, the trees...",
"Since the Marines parked that carrier off-shore, supplies started flowing more easily",

"I heard that MonoCorp is paying the Peacekeeper wages",
"MonoCorp brought their Air01 division to San Andreas", 
"I'm tired of these arrogant Suits snooping around", 
"The Underground scum will pay for their defiance!",
"I can't stand these fucking beaurocrats!",
"I just love the Peacekeeper life. We're clubbing all night long!",
"Don't get in the way of cleaners... They love burning people"


]]

--refugeecampdetaineeChat = {"Mind ye words 'round the 'keepers, or you'll end up like me.","They've put me in this cage for nothing!", "I haven't done a thing!", "I got locked down for talking up to the guards...", "The Peacekeepers kill us faster than the zombies do...","There's no justice left!", "You don't wanna' be seen talking to us..."}
--aldeaquesthubChat = { "We need water, food, fuel... Can you help?" , "The people here need any help available. Give us a hand!","You're looking for a job?","You look like you could give a hand...","I might have something for you to do..." }
--bodyguardChat = {"Hrrmpf..!","I don't like the way you look at the boss!","Show respect!","You want me to waste him, boss?"}
--[[SlitChat = {"So, there are still people that stick it to The Man...","I'm in your debt.", "You saved my skin!"}
SlitQuests = {"They'll be here shortly. I know a place where we can lay low. Follow me!","We have to get out of here, they'll investigate this mess!"}
SlitQuestsPositive = {"Come on! And try to keep up, I won't wait for you.", "Good, let's go!"}
SlitQuestsNegative = {"Suit yourself. I'm outta' here!","Godspeed, brother! I won't forget you."}
]]
