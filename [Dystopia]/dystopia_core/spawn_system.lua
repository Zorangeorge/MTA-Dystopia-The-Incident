local spawnpoint

addEventHandler("onResourceStart", resourceRoot,
	function()
		resetMapInfo()
		for i,player in ipairs(getElementsByType("player")) do
			setElementFrozen(player,true)
		end
	end)

addEventHandler("onPlayerJoin", resourceRoot,
	function()
			triggerEvent(player,"PlayerJoined",resourceRoot)
			setElementFrozen(source,true)
	end)

function unstuckPlayer (player,command,args)
		local acc = getPlayerAccount(player)
			setAccountData(acc,"positionx",0)
			setAccountData(acc,"positiony",0)
			setAccountData(acc,"positionz",3)
			local skin = getAccountData(acc,"currentSkin") or table.random(playerSkin)
			spawnPlayer(player,0,0,3,0,skin)
end
addCommandHandler("unstuck",unstuckPlayer)

function preSpawnAndFreeze()
spawnPlayer(source,0,0,-300,0,0)
setElementFrozen(source,true)
end
addEventHandler("onPlayerJoin",root,preSpawnAndFreeze)

function spawn(player)
	
	setTimer(fadeCamera,5000,1,player,true,5)
	if not isElement(player) then return end
	
	local acc = getPlayerAccount(player)
	local x = getAccountData(acc,"positionx") or false
	local y = getAccountData(acc,"positiony") or false
	local z = getAccountData(acc,"positionz") or false
	local rotation = getAccountData(acc,"rotation") or false
	
	--iprint(getAccountData(acc, "bedspawnx"))
	--iprint(getAccountData(acc, "bedspawny"))
	--iprint(getAccountData(acc, "bedspawnz"))
	
	if getAccountData(acc, "bedspawnx") then
	x = getAccountData(acc, "bedspawnx")
	y = getAccountData(acc, "bedspawny")
	z = getAccountData(acc, "bedspawnz")
	rotation = math.random(0,360)
	end

	--if getAccountData(acc, "bedspawnx") == x then iprint("coordinates are good") end

	if x and y and z and rotation then 
	
	spawnPlayer(player,x,y,z,rotation,0)
	
	else	
	
	spawnpoint = getSpawnPoint(player)
	--iprint("spawning at normal spawnpoint")
	exports.spawnmanager:spawnPlayerAtSpawnpoint(player,spawnpoint,false)	
	end
	
	local acc = getPlayerAccount(player)
	local skin = getAccountData(acc,"currentSkin") or table.random(playerSkin)
	if skin then setElementModel(player,skin) else setElementModel(player,table.random(playerSkin)) end -- need to implement a "baseskin" attribute, the skin the player choses during character creation; will come eventually
	
	setElementFrozen(player,true)
	setElementAlpha(player,150)
	setTimer(function() setElementFrozen(player,false); setElementAlpha(player,255)end,5000,1)
	showChat(player, true)
	bindKey(player, "5", "down", funcBindHandsup)
	bindKey(player, "6", "down", funcBindSit)
	bindKey(player, "4", "down", funcBindLie)
	bindKey(player, "7", "down", funcBindPoint)
	bindKey(player,"h", "down", "Carry")
	addCommandHandler("Carry",funcBindCarry)
	


----------------------LOAD AND SET ACCOUNT DATA-------------------------

if isGuestAccount(acc) then 
setTimer(convenienceFeatures,5000,1,player)	
return 
end

local invtemp = {}
local belttemp = {}	
for i=1,9 do
local invvalue =  getAccountData(acc,"ItensInventory_"..i) or "Empty"
local beltvalue = getAccountData(acc,"ItemsBelt_"..i) or "Empty"
table.insert(invtemp,invvalue)
table.insert(belttemp,beltvalue)
end

setPlayerItens(player,invtemp)
setPlayerBeltItens(player,belttemp)
triggerClientEvent(player,"synchronizeTables", player, PlayersItens)
triggerClientEvent(player,"synchronizeBelt", player, PlayersBeltItens)
triggerClientEvent(player,"clearInfectionEffects",player)

local stringteam = getAccountData(acc,"team") or "Scavengers"
local team = getTeamFromName(stringteam)
if not team then team = Scavengers end
local armor = getAccountData(acc,"armor") or 0
local projectiletype = getAccountData(acc,"projectiletype")
local hunger = getAccountData(acc,"hunger") or 100
local thirst = getAccountData(acc,"thirst") or 100
local pistolammo = getAccountData(acc,"pistolammo") or 1
local crossbowammo = getAccountData(acc,"crossbowammo") or 1
local taserammo = getAccountData(acc,"taserammo") or 1
local shotgunammo = getAccountData(acc,"shotgunammo") or 1
local smgammo = getAccountData(acc,"smgammo") or 1
local assaultammo = getAccountData(acc,"assaultammo") or 1
local rifleammo = getAccountData(acc,"rifleammo") or 1
local stomperammo = getAccountData(acc,"stomperammo") or 0
local weapslot0 = getAccountData(acc,"weapslot0")
local weapslot1 = getAccountData(acc,"weapslot1")
local weapslot2 = getAccountData(acc,"weapslot2")
local weapslot3 = getAccountData(acc,"weapslot3")
local weapslot4 = getAccountData(acc,"weapslot4")
local weapslot5 = getAccountData(acc,"weapslot5")
local weapslot6 = getAccountData(acc,"weapslot6")
local weapslot7 = getAccountData(acc,"weapslot7")
local weapslot8 = getAccountData(acc,"weapslot8")
local weapslot9 = getAccountData(acc,"weapslot9")
local weapslot10 = getAccountData(acc,"weapslot10")
local weapslot11 = getAccountData(acc,"weapslot11")
--local weapslot12 = getAccountData(acc,"weapslot12")
local minorfracture = getAccountData(acc,"minorfracture") or false
local majorfracture = getAccountData(acc,"majorfracture") or false
local onFire = getAccountData(acc,"onFire") or false
--local fightingStyle = getAccountData(acc,"fightingStyle") or 15
local walkingStyle = getAccountData(acc,"walkingStyle") or 0
local health = getAccountData(acc,"health") or 100
if health <= 0 then health = 100; setAccountData(acc,"health",100) end
local headlamp = getAccountData(acc,"headlampequipped") or false
local medikit = getAccountData(acc,"medikitequipped") or false
local toolbox = getAccountData(acc,"toolboxequipped") or false
local bleeding = getAccountData(acc,"bleeding") or false
local lives = getAccountData(acc,"lives") or 3
local karma = getAccountData(acc,"karma") or 0
local backpack = getAccountData(acc,"backpackequipped") or false
local zipline = getAccountData(acc,"ziplineequipped") or false
local stomper = getAccountData(acc,"stomperequipped") or false
local timedbombs = getAccountData(acc,"timedbombs")
local incendiarytraps = getAccountData(acc,"incendiarytraps")
local spikestrips = getAccountData(acc,"spikestrips")
local explosivetraps = getAccountData(acc,"explosivetraps")
local glasstraps = getAccountData(acc,"glasstraps")
local infection = getAccountData(acc,"infection") or "uninfected"
local radiation = getAccountData(acc,"radiation") or 0
local money = getAccountData(acc,"money") or 0
--local camo = getAccountData(acc,"camoequipped")
--local hazmat = getAccountData(acc,"hazmatequipped")

setElementData(player,"pistolammo",pistolammo)
setElementData(player,"crossbowammo",crossbowammo)
setElementData(player,"taserammo",taserammo)
setElementData(player,"shotgunammo",shotgunammo)
setElementData(player,"smgammo",smgammo)
setElementData(player,"assaultammo",assaultammo)
setElementData(player,"rifleammo",rifleammo)
setElementData(player,"projectiletype",projectiletype)
setElementData(player,"headlampequipped",headlamp)
setElementData(player,"medikitequipped",medikit)
setElementData(player,"toolboxequipped",toolbox)
setElementData(player,"stomperammo",stomperammo)
setElementData(player,"spikestrips",spikestrips)
setElementData(player,"incendiarytraps",incendiarytraps)
setElementData(player,"timedbombs",timedbombs)
setElementData(player,"explosivetraps",explosivetraps)
setElementData(player,"glasstraps",glasstraps)
--setElementData(player,"camoequipped",camo,true)
--setElementData(player,"hazmatequipped",hazmat,true)
setElementData(player,"backpackequipped", backpack,true)
setPlayerMoney(player,money)
if headlamp == true then triggerClientEvent(player,"HeadlampEquipped",player) end
if hasPlayerBeltItem ("Map", player) then setElementData(player,"currentmap","Map") 
	elseif hasPlayerBeltItem ("Survivor Map", player) then setElementData(player,"currentmap","Survivor Map")
	elseif hasPlayerBeltItem ("Military Map", player) then setElementData(player,"currentmap","Military Map")
	else setElementData(player,"currentmap",false)
end

setPedArmor(player,armor)

	if hasPlayerBeltItem ("EM Scanner", player) then
	triggerClientEvent(player,"ScannerEquipped",player)
	end

if weapslot0 then giveWeapon(player, weapslot0) end -- unarmed
if weapslot1 then giveWeapon(player, weapslot1) end-- melee
if weapslot2 then
	if weapslot2 == 22 then giveWeapon(player, weapslot2, pistolammo) end -- pistol
	if weapslot2 == 23 then giveWeapon(player, weapslot2, crossbowammo) end --crossbow
	if weapslot2 == 24 then giveWeapon(player, weapslot2, taserammo) end --taser
end
if weapslot3 then giveWeapon(player, weapslot3, shotgunammo) end -- shotgun
if weapslot4 then giveWeapon(player, weapslot4, smgammo) end-- smg
if weapslot5 then giveWeapon(player, weapslot5, assaultammo) end-- assault
if weapslot6 then giveWeapon(player, weapslot6, rifleammo) end--rifle
if weapslot7 then giveWeapon(player, weapslot7) end-- heavy
if projectiletype == "grenade" then giveWeapon(player, 16, weapslot8) end
if projectiletype == "Teargas" then giveWeapon(player, 17, weapslot8) end
if projectiletype == "molotov" then giveWeapon(player, 18, weapslot8) end
if projectiletype == "satchel" then giveWeapon(player, 39, weapslot8) end
if weapslot9 then giveWeapon(player, weapslot9) end-- spray, camera
if weapslot10 then giveWeapon(player, weapslot10) end -- melee2
if weapslot11 then giveWeapon(player, weapslot11) end-- googles, parachute
--giveWeapon(player, weapslot12) -- satchel detonator; i think is not needed, you get it automatically if you set a satchel charge
setElementData(player, "hunger", hunger)
setElementData(player, "thirst", thirst)
setElementData(player, "Faction", stringteam)
local loadLevel = getPlayerLevel(player)
if loadLevel == 1 then setPlayerLevel(player,1) end
local expreq, friendlyLevelName = getLevelValues(loadLevel)
if friendlyLevelName then setElementData(player,"Level",friendlyLevelName,true) else setElementData(player,"Level","lvl 0",true) end
setElementData(player,"veh_col_veh",nil,true)
setElementData(player,"insideFuelCol",nil,true)
setElementData(player,"infirecol",false,true)
setPlayerTeam(player, team) 
setPedFightingStyle(player, 15)
if walkingStyle then setPedWalkingStyle(player, walkingStyle) end
if onFire then setPedOnFire(player, onFire) end
setElementHealth(player, health)
setElementData(player,"factionkills",0)
setElementData(player,"lives",lives,true)
setElementData(player,"zipline",zipline,true)
setElementData(player,"stomperequipped",stomper,true)
setElementData(player,"infection",infection,true)
setElementData(player,"radiationDamage",radiation,true)

if radiation > 0 then triggerClientEvent(player,"TriggerRadFromServer",player) end

	local faction = getTeamName(team) -- for scoreboard icon
    local image = faction and ":dystopia_core/images/"..string.lower(faction).."_logo.png" 
    setElementData(player, "    ", image and {type = "image", src =  image, height = 20, width = 20} or " ",true) 

local laser = getAccountData(acc,"laserequipped") or false
	if tostring(laser) == "true" then 
		laser = true 
	else 
		laser = false 
	end
setElementData(player,"laserpointer",laser,true)
if IsLaserEnabled(player) then SetLaserEnabled(player,false) end
--minorfracture
--majorfracture
--pain
--infection
--bleeding
--baseSkin
outputInteractInfo("[ loading... ]", player, 255,255,255)
---------------------------------------------------------------------------
setTimer(convenienceFeatures,5000,1,player)	
	
end
addEvent("SpawnThePlayer",true)
addEventHandler("SpawnThePlayer",root,spawn)

function getSpawnPoint (player)	
	
	local spawnarea
	local deathlocation = getElementZoneName(player,true)
	local spawnedPlayerLevel = tonumber(getPlayerLevel(player))-1 or 0
	
		if 	deathlocation == "Los Santos" then spawnarea = "LosSantos"
		elseif deathlocation == "Las Venturas" then spawnarea = "LasVenturas"
		elseif deathlocation == "San Fierro" then spawnarea = "SanFierro"
		elseif deathlocation == "Bone County" then spawnarea = "BoneCountry" -- typo in the edf/map, too lazy to change it (Bone County instead of Bone Country )
		elseif deathlocation == "Flint County" then spawnarea = "FlintCounty"
		elseif deathlocation == "Red County" then spawnarea = "RedCounty"
		elseif deathlocation == "Whetstone" then spawnarea = "Whetstone"
		elseif deathlocation == "Tierra Robada" then spawnarea = "TierraRobada"
		else spawnarea = "LosSantos"
		end
	
	local lives = getElementData(player,"lives")
	if lives == 3 or lives < 1 then 
	spawnarea = "LosSantos"
	setPlayerTeam(player,Scavengers) 
	end --if your char is a new one or is dead-dead, you're back to LS
	
	local allspawnpoints = getElementsByType("spawnpoint") 
	local teamspawnpoints = {}
	local team = getPlayerTeam(player)

	if not team then team = Scavengers; setPlayerTeam(player,Scavengers)	end
		
	for i,spawnpoint in ipairs(allspawnpoints) do
		local spawnzone = getElementData(spawnpoint,"SpawnZone")
		local spawnLevelRating = tonumber(getElementData(spawnpoint,"SpawnLevel")) or 0
		if getElementData(spawnpoint,"SpawnFaction") == getTeamName(team) and spawnzone == spawnarea and spawnedPlayerLevel <= spawnLevelRating then table.insert(teamspawnpoints,spawnpoint) 
		end
	end
	
	if #teamspawnpoints < 1 then -- fall back solution
	outputDebugString("spawnpoint selection fallback")
			for i,spawnpoint in ipairs(allspawnpoints) do
				if getElementData(spawnpoint,"SpawnFaction") == getTeamName(team) then table.insert(teamspawnpoints,spawnpoint) end
			end
	end
	
	return teamspawnpoints[math.random(1,#teamspawnpoints)]
	
end

addEventHandler("onPlayerQuit",root,
	function ()
		if getPlayerCount() == 1 and get("spawnreset") == "onServerEmpty" then
			spawnpoint = getSpawnPoint(source)
		end
	end
)

addEventHandler("onPlayerWasted", root,
	function() 	--place here all stuff that needs to be cleared/reset/set when player dies
	
		local acc = getPlayerAccount(source)
		setAccountData(acc,"positionx", false)
		setAccountData(acc,"positiony", false)
		setAccountData(acc,"positionz", false)
		setAccountData(acc,"rotation", false)
		setAccountData(acc,"armor", 0)
		setAccountData(acc,"pistolammo", 1)
		setAccountData(acc,"crossbowammo", 1)
		setAccountData(acc,"taserammo", 1)
		setAccountData(acc,"shotgunammo", 1)
		setAccountData(acc,"smgammo", 1)
		setAccountData(acc,"assaultammo", 1)
		setAccountData(acc,"rifleammo", 1)
		setAccountData(acc,"weapslot0", 0)
		setAccountData(acc,"weapslot1", 0)
		setAccountData(acc,"weapslot2", 0)
		setAccountData(acc,"weapslot3", 0)
		setAccountData(acc,"weapslot4", 0)
		setAccountData(acc,"weapslot5", 0)
		setAccountData(acc,"weapslot6", 0)
		setAccountData(acc,"weapslot7", 0)
		setAccountData(acc,"weapslot8", 0)
		setAccountData(acc,"weapslot9", 0)
		setAccountData(acc,"weapslot10", 0)
		setAccountData(acc,"weapslot11", 0)
		--setAccountData(acc,"weapslot12", 0)
		setAccountData(acc,"minorfracture", false)
		setAccountData(acc,"majorfracture", false)
		setAccountData(acc,"onFire", false)
		setAccountData(acc,"health", 100)
		setAccountData(acc,"hunger", 100)
		setAccountData(acc,"thirst", 100)
		triggerClientEvent(source,"SetThirstOnSpawn",source,100)
		triggerClientEvent(source,"SetHungerOnSpawn",source,100)
		setAccountData(acc,"headlampequipped",false)
		setAccountData(acc,"toolboxequipped",false)
		setAccountData(acc,"medikitequipped",false)
		setAccountData(acc,"projectiletype", false)
		setAccountData(acc,"backpackequipped", false)
		setAccountData(acc,"zipline", false)
		setAccountData(acc,"stomperequipped", false)
		setAccountData(acc,"laserequipped", false)
		setAccountData(acc,"timedbombs",0)
		setAccountData(acc,"spikestrips",0)
		setAccountData(acc,"incendiarytraps",0)
		setAccountData(acc,"explosivetraps",0)
		setAccountData(acc,"glasstraps",0)
		setAccountData(acc,"stomperammo",0)
		setAccountData(acc,"infection","uninfected")
		setAccountData(acc,"radiation",0)
		--setAccountData(acc,"camoequipped",false)
		--setAccountData(acc,"hazmatequipped",false)
		
		local lives = getElementData(source,"lives")
		if not lives then lives = 3 elseif lives > 3 then lives = 3 elseif lives <= 0 then lives = 1 end
		setElementData(source,"lives",lives-1)
		setAccountData(acc,"lives", lives-1)
		
		--if player is dead-dead
		if lives-1<1 then 
			setPlayerLevel(source,1)
			setAccountData(acc,"level", 1) 
			--##HERE##### reset spawn position
			setAccountData(acc,"bedspawnx",false) 
			setAccountData(acc,"bedspawny",false) 
			setAccountData(acc,"bedspawnz",false)
		end
		
		
		if getElementData(source, "headlampequipped") == true then
		setElementData(source, "headlampequipped",false,true)
		triggerClientEvent(source,"ToggleHeadlampObj",source)
		end
		
		if getElementData(source, "medikitequipped") == true then
		triggerClientEvent(source,"UnequipMedikit",source) 
		setElementData(source, "medikitequipped",false)
		end
		
		if getElementData(source, "toolboxequipped") == true then
		triggerClientEvent(source,"UnequipToolbox",source) 
		setElementData(source, "toolboxequipped",false)
		end
		
		--[[if getElementData(source, "hazmatequipped") == true then
			setElementData(source, "hazmatequipped",false,true)
		end
		
		if getElementData(source, "camoequipped") == true then
			setElementData(source, "camoequipped",false,true)
		end]]

		setElementData(source, "minorfracture",false)
		setElementData(source, "majorfracture",false)

		if getElementData(source, "backpackequipped") == true then
		setElementData(source,"backpackequipped",false,true)
		end
		
		setElementData(source,"veh_col_veh",nil,true)
		setElementData(source,"insideFuelCol",nil,true)
		setElementData(source,"infirecol",false,true)
		setElementData (source, "KO", false, true)
		
		local playertospawn = source
		setTimer(assesssSpawn, playerRespawnTime, 1, playertospawn) -- set respawn time here
		if getResourceState(getResourceFromName("dystopia_zombies")) == "running" then triggerClientEvent("ClearInfection",source) end --clear infection if zombie resource is running. when i bring the zombie res into the stack, i must change this condition; 
		
		triggerClientEvent(source,"hideInventorySlots",source)
		triggerClientEvent(source,"closeMapOnDropped",source)
		triggerClientEvent (source, "UnequipHeadlamp", source)
		setElementData(source,"laserpointer",false,true)
		setElementData(source,"zipline",false,true)
		
		setElementData(source,"laser.on",false,true)
		setElementData(source,"laser.aim",false,true)
		
		--local player = source
		--triggerClientEvent(source,"EnableDisableLaserPointer",source,player,false)
		--SetLaserEnabled(player, false)		
	end
)

function cleandDamnedIcons()

	--if source == localPlayer then
	setElementData(source,"veh_col_veh",nil,true)
	setElementData(source,"insideFuelCol",nil,true)
	setElementData(source,"infirecol",false,true)
	setElementData(source,"infection",false,true)
	--end

end
addEventHandler("onPlayerJoin",root,cleandDamnedIcons)

function convenienceFeatures ( player) -- as the name says, some convenience features because not all people enjoy a hardcore ruleset and most players assume they don't need help

if not getElementData(player,"Level") or getElementData(player,"Level") == "lvl 1" then 

setElementData(player,"Level","lvl 1",true)
setPlayerLevel(player,1)
local acc = getPlayerAccount(player)
local stringteam = getAccountData(acc,"team") or "Scavengers"
setElementData(player, "Faction", stringteam)
	--add a map if new character
	--if getElementData(player,"lives") == 3 then --disabled for now
	if hasPlayerBeltItem("Map",player) == false and hasPlayerBeltItem("Survivor Map",player) == false and hasPlayerBeltItem("Military Map",player) == false and hasPlayerItem("Map",player) == false and hasPlayerItem("Survivor Map",player) == false and hasPlayerItem("Military Map",player) == false then
		addPlayerBeltItem(player,"Map")
		setElementData(player,"currentmap","Map",true)
		triggerClientEvent(player,"synchronizeBelt",root,PlayersBeltItens)
		syncronizePlayerBeltItens(player,PlayersBeltItens)
	end
	-- trigger help key message
	triggerClientEvent(player,"ForceFeedHelpMessage",player)	
end
end

function assesssSpawn(player)
if player then
 local acc = getPlayerAccount(player)
 local lives = getElementData(player,"lives") or 0
	if lives == 0 then 
		triggerClientEvent(player,"ShowSpawnMenu",resourceRoot)
		setElementData(player,"veh_col_veh",nil,true)
		setElementData(player,"insideFuelCol",nil,true)
		setPlayerTeam(player,Scavengers)
		setAccountData(acc,"team","Scavengers")
	else
		spawn(player)
	end
end
end

addEvent("takeAllPlayerGear",true)

function takeAllPlayerGear_func()
	if not isPedDead(client) then
		local acc = getPlayerAccount(client)
		setAccountData(acc,"armor", 0)
		setAccountData(acc,"pistolammo", 1)
		setAccountData(acc,"crossbowammo", 1)
		setAccountData(acc,"taserammo", 1)
		setAccountData(acc,"shotgunammo", 1)
		setAccountData(acc,"smgammo", 1)
		setAccountData(acc,"assaultammo", 1)
		setAccountData(acc,"rifleammo", 1)
		setAccountData(acc,"weapslot0", 0)
		setAccountData(acc,"weapslot1", 0)
		setAccountData(acc,"weapslot2", 0)
		setAccountData(acc,"weapslot3", 0)
		setAccountData(acc,"weapslot4", 0)
		setAccountData(acc,"weapslot5", 0)
		setAccountData(acc,"weapslot6", 0)
		setAccountData(acc,"weapslot7", 0)
		setAccountData(acc,"weapslot8", 0)
		setAccountData(acc,"weapslot9", 0)
		setAccountData(acc,"weapslot10", 0)
		setAccountData(acc,"weapslot11", 0)
		setAccountData(acc,"headlampequipped",false)
		setAccountData(acc,"toolboxequipped",false)
		setAccountData(acc,"medikitequipped",false)
		setAccountData(acc,"projectiletype", false)
		setAccountData(acc,"backpackequipped", false)
		setAccountData(acc,"zipline", false)
		setAccountData(acc,"stomperequipped", false)
		setAccountData(acc,"laserequipped", false)
		setAccountData(acc,"timedbombs",0)
		setAccountData(acc,"spikestrips",0)
		setAccountData(acc,"incendiarytraps",0)
		setAccountData(acc,"explosivetraps",0)
		setAccountData(acc,"glasstraps",0)
		setAccountData(acc,"stomperammo",0)
		
		if getElementData(client, "headlampequipped") == true then
		setElementData(client, "headlampequipped",false,true)
		triggerClientEvent(client,"ToggleHeadlampObj",client)
		end
		
		if getElementData(client, "medikitequipped") == true then
		triggerClientEvent(client,"UnequipMedikit",client) 
		setElementData(client, "medikitequipped",false)
		end
		
		if getElementData(client, "toolboxequipped") == true then
		triggerClientEvent(client,"UnequipToolbox",client) 
		setElementData(client, "toolboxequipped",false)
		end
		
		if getElementData(client, "backpackequipped") == true then
		setElementData(client,"backpackequipped",false,true)
		end
		
		triggerClientEvent(client,"hideInventorySlots",client)
		triggerClientEvent(client,"closeMapOnDropped",client)
		triggerClientEvent (client, "UnequipHeadlamp", client)
		setElementData(client,"laserpointer",false,true)
		setElementData(client,"zipline",false,true)
		
		setElementData(client,"laser.on",false,true)
		setElementData(client,"laser.aim",false,true)
		
		PlayersItens[client] = {"Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty"}
		PlayersBeltItens[client] = {"Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty"}

	triggerClientEvent(client,"takeAllPlayerGear_client",root)
	takeAllWeapons(client)
	
	outputInteractInfo("[ all gear removed ]", client, 255,50,0)
	
	end
	
end

addEventHandler("takeAllPlayerGear",root,takeAllPlayerGear_func)

--------SPAWN MENU
function spawn1()
local acc = getPlayerAccount(source)
setAccountData(acc,"currentSkin",239)
setAccountData(acc,"lives",3)
setElementData(source,"lives",3)
setElementData(source,"RESILIENT",true,true)
setTimer(spawn, 2000,1,source)
end
addEvent("spawn1", true)
addEventHandler("spawn1", root, spawn1)

function spawn2()
local acc = getPlayerAccount(source)
setAccountData(acc,"currentSkin",106)
setAccountData(acc,"lives",3)
setElementData(source,"lives",3)
setElementData(source,"GUNSLINGER",true,true)
setTimer(spawn, 2000,1,source)
end
addEvent("spawn2", true)
addEventHandler("spawn2", root, spawn2)

function spawn3()
local acc = getPlayerAccount(source)
setAccountData(acc,"currentSkin",291)
setAccountData(acc,"lives",3)
setElementData(source,"lives",3)
setElementData(source,"FIRST AID",true,true)
setTimer(spawn, 2000,1,source)
end
addEvent("spawn3", true)
addEventHandler("spawn3", root, spawn3)

function spawn4()
local acc = getPlayerAccount(source)
setAccountData(acc,"currentSkin",161)
setAccountData(acc,"lives",3)
setElementData(source,"lives",3)
setElementData(source,"TINKERER",true,true)
setTimer(spawn, 2000,1,source)
end
addEvent("spawn4", true)
addEventHandler("spawn4", root, spawn4)