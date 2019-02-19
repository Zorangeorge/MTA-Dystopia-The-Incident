-- Made By XX3, from scratch with MS Notepad. Purpose: To make a new exotic compact HUD.
-- You may edit this resource, but please credit me if you wanted to post an edited / extended version. 
-- PS: I was in MTA SA to show what Indonesia is really made of! :D
--[[Commands:
- /showhud or /hidegtahud  : Shows the alternate HUD, and hides the GTA HUD excluding the radar.
- /hidehud  or /showgtahud : Hides the alternate HUD, and shows the GTA HUD excluding the radar.
- /hideall : Hides both alternate HUD and GTA HUD. (Hides the radar too)
- /showradar : Shows the radar.
- /hideradar : Hides the radar.

Credits goes to:
- 50p : For helping me most of my work and the better weapon icons used here.
- Doomed_Space_marine : For giving me a very useful hint on the variables, and helped me on how to make tables.
- R3mp : For the guieditor and helping me to understand about guiGetScreenSize.
- Dragon: For helping me making a part of DX text visible or invisible according to weapon.
- Dre++ : Allowing me to learn from his HUD script, thus improving my script.
And all the others who already tried to help me.]]


NO_HUD_MODE = false
function dys_hud_toggler()

	if not NO_HUD_MODE then 
	NO_HUD_MODE = true 
	
	else
	NO_HUD_MODE = false
	
	end
	toggleHUD() --toggles stamina display, great func name!
	toggleChatBox() --hides chat
	if helpAnimation then helpAnimation:remove() end --
	--setTimer ( function() helpText:color(255,255,255,0) end, 300, 1 )
	--setTimer ( function() dys_helpText:color(255,255,255,0) end, 300, 1 )
	hudChanger3() --hides rest of the hud
end
addCommandHandler("togghud",dys_hud_toggler)

--Building objects table: move it to a shared location, it is doubled on server side
BuildableObjectsData = {}
--wooden
BuildableObjectsData[3260] = {"Wood Panel"}
BuildableObjectsData[1407] = {"Wood Fence"}
BuildableObjectsData[1482] = {"Wood Platform"}
BuildableObjectsData[1428] = {"Wood Ladder"}
BuildableObjectsData[1472] = {"Wood Steps"}
BuildableObjectsData[2636] = {"Wood Chair"}
BuildableObjectsData[2115] = {"Wood Table"}
BuildableObjectsData[3927] = {"Wood Sign"}
BuildableObjectsData[1492] = {"Wood Door"}
--metal
BuildableObjectsData[1447] = {"Metal Fence"}
BuildableObjectsData[1411] = {"Metal Barbed Fence"}
BuildableObjectsData[3302] = {"Metal Panel"}
BuildableObjectsData[3280] = {"Metal Grate"}
BuildableObjectsData[2937] = {"Metal Plank"}
BuildableObjectsData[1424] = {"Metal Barrier"}
BuildableObjectsData[3049] = {"Metal Strong Fence"}
BuildableObjectsData[1499] = {"Metal Door"}
BuildableObjectsData[5779] = {"Metal Wall"}
--structures
BuildableObjectsData[16281] = {"Gate"}
BuildableObjectsData[1457] = {"Shelter"}
BuildableObjectsData[16405] = {"Hut Structure"}
BuildableObjectsData[1452] = {"Outhouse"}
BuildableObjectsData[1466] = {"Scaffold"}
BuildableObjectsData[1464] = {"Reinforced Scaffold"}
BuildableObjectsData[1426] = {"Scaffold Tower"}
BuildableObjectsData[12991] = {"Small Cabin"}
BuildableObjectsData[18259] = {"Large Cabin"}
--special
BuildableObjectsData[1362] = {"Fire Bin"}
BuildableObjectsData[1800] = {"Bed"}
BuildableObjectsData[1271] = {"Storage"}
BuildableObjectsData[2451] = {"Workbench"}
BuildableObjectsData[1345] = {"Large Storage"}
BuildableObjectsData[16732] = {"Fish Trap"}
BuildableObjectsData[3261] = {"Potato Farm"}
BuildableObjectsData[1451] = {"Critter Pen"}
BuildableObjectsData[1570] = {"Trading Post"}

-- Weapon tables for ammo.
        resourceroot = getResourceRootElement(getThisResource())
    local noreloadweapons = {} --Weapons that don't reload (including the flamethrower, minigun, which doesn't have reload anim).
    
    noreloadweapons[19] = true
    noreloadweapons[25] = true
    --noreloadweapons[33] = true --managed separately
    --noreloadweapons[34] = true
    --noreloadweapons[35] = true
    noreloadweapons[36] = true
    noreloadweapons[37] = true
    noreloadweapons[38] = true
    noreloadweapons[41] = true
    noreloadweapons[42] = true
	noreloadweapons[23] = true
	
	local projectileweapons = {} --grenades, molotov, flashbang - they don't need the 'ghost bullet' feature
    projectileweapons[16] = true
    projectileweapons[17] = true
    projectileweapons[18] = true
	projectileweapons[39] = true

    local meleespecialweapons = {} --Weapons that don't shoot, and special weapons.
    meleespecialweapons[0] = true
    meleespecialweapons[1] = true
    meleespecialweapons[2] = true
    meleespecialweapons[3] = true
    meleespecialweapons[4] = true
    meleespecialweapons[5] = true
    meleespecialweapons[6] = true
    meleespecialweapons[7] = true
    meleespecialweapons[8] = true
    meleespecialweapons[9] = true
    meleespecialweapons[10] = true
    meleespecialweapons[11] = true
    meleespecialweapons[12] = true
    --meleespecialweapons[13] = true
    meleespecialweapons[14] = true
    meleespecialweapons[15] = true
    meleespecialweapons[40] = true
    meleespecialweapons[44] = true
    meleespecialweapons[45] = true
    meleespecialweapons[46] = true
    meleespecialweapons[43] = true 
    meleespecialweapons[35] = true 
	
	
function getWeaponIcon (id)
local weaponiconname
 
	if id == 0 then weaponiconname = "Fist"
	elseif id == 1 then weaponiconname = "Tactical Shield"
	elseif id == 2 then weaponiconname = "Axe"
	elseif id == 3 then weaponiconname = "Nightstick"
	elseif id == 4 then weaponiconname = "Knife"
	elseif id == 5 then weaponiconname = "Baseball Bat"
	elseif id == 6 then weaponiconname = "Crowbar"
	elseif id == 7 then weaponiconname = "Sledgehammer"
	elseif id == 8 then weaponiconname = "Raider Sword"
	elseif id == 9 then weaponiconname = "Chainsaw"
	elseif id == 10 then weaponiconname = "Machete"
	elseif id == 11 then weaponiconname = "Kitchen Knife"
	elseif id == 12 then weaponiconname = "Meatcleaver"
	elseif id == 13 then weaponiconname = "Dildo"
	elseif id == 14 then weaponiconname = "Broken Bottle"
	elseif id == 15 then weaponiconname = "Nail Bat"
	elseif id == 16 then weaponiconname = "Grenade"
	elseif id == 17 then weaponiconname = "Teargas"
	elseif id == 18 then weaponiconname = "Molotov"
	elseif id == 22 then weaponiconname = "Pistol"
	elseif id == 23 then weaponiconname = "Crossbow"
	elseif id == 24 then weaponiconname = "Magnum Revolver"
	elseif id == 25 then weaponiconname = "Pump Shotgun"
	elseif id == 26 then weaponiconname = "Sawn-off Shotgun"
	elseif id == 27 then weaponiconname = "Combat Shotgun"
	elseif id == 28 then weaponiconname = "Uzi"
	elseif id == 29 then weaponiconname = "MP5"
	elseif id == 30 then weaponiconname = "AK 47"
	elseif id == 31 then weaponiconname = "M4"
	elseif id == 32 then weaponiconname = "Vehicle Minigun"
	elseif id == 33 then weaponiconname = "Rifle"
	elseif id == 34 then weaponiconname = "Sniper Rifle"
	elseif id == 35 then weaponiconname = "Rocket Launcher"
	elseif id == 36 then weaponiconname = "Stinger Launcher"
	elseif id == 37 then weaponiconname = "Flamethrower"
	elseif id == 38 then weaponiconname = "Minigun"
	elseif id == 39 then weaponiconname = "Satchel Charge"
	elseif id == 40 then weaponiconname = "Detonator"
	elseif id == 41 then weaponiconname = "Spray Can"
	elseif id == 42 then weaponiconname = "Agent Pale"
	elseif id == 43 then weaponiconname = "Binoculars"
	elseif id == 44 then weaponiconname = "Night Vision Googles"
	elseif id == 45 then weaponiconname = "Thermal Googles"
	elseif id == 46 then weaponiconname = "Backpack"
	end
 
  return weaponiconname

end



currentGadget = "Empty"
currentGadgetList = {}

function getCurrentGadgetList ()

local tempPlayersEquippedGadgets = {}
tempPlayersEquippedGadgets[1] = "Empty"
local item
local ammo
local zipline = getElementData(localPlayer,"zipline")
local spikestrip = getElementData(localPlayer,"spikestrips") or 0
local incendiary = getElementData(localPlayer,"incendiarytraps") or 0
--local grenades = getElementData(player,"spikestrips") or 0
--local molotovs = getElementData(player,"spikestrips") or 0
--local satchels = getElementData(player,"spikestrips") or 0
local mine = getElementData(localPlayer,"explosivetraps") or 0
local shards = getElementData(localPlayer,"glasstraps") or 0
local timedbombs = getElementData(localPlayer,"timedbombs") or 0
local laser = getElementData(localPlayer,"laserpointer") or false
local stomper = getElementData(localPlayer,"stomperequipped") or false
local stomperammo = getElementData(localPlayer,"stomperammo") or 0
local headlamp = getElementData(localPlayer,"headlampequipped") or false
local projectileType = nil
local weapslot8ammo = getPedTotalAmmo(localPlayer, 8)
if weapslot8ammo > 0 then	
	if (getPedWeapon(localPlayer,8) == 16) then
		projectileType="Grenade" 
	elseif (getPedWeapon(localPlayer,8) == 17) then
		projectileType="Teargas"
	elseif (getPedWeapon(localPlayer,8) == 18) then
		projectileType="Molotov"
	--elseif (getPedWeapon(localPlayer,8) == 39) then
	--	projectileType= "Satchel Charge"
	end
end

if zipline then table.insert(tempPlayersEquippedGadgets,"Zip Line") end
if spikestrip~=0 then table.insert(tempPlayersEquippedGadgets,"Spikestrip")end
if incendiary~=0 then table.insert(tempPlayersEquippedGadgets,"Incendiary Trap")end
if mine~=0 then table.insert(tempPlayersEquippedGadgets,"Mine")end
if shards~=0 then table.insert(tempPlayersEquippedGadgets,"Shards Trap")end
if timedbombs~=0 then table.insert(tempPlayersEquippedGadgets,"Timed Bomb")end
if laser~=false then table.insert(tempPlayersEquippedGadgets,"Laser Pointer")end
if headlamp~=false then table.insert(tempPlayersEquippedGadgets,"Headlamp")end
if stomper~=false then table.insert(tempPlayersEquippedGadgets,"M37 Stomper")end
if projectileType then table.insert(tempPlayersEquippedGadgets,projectileType)end

currentGadgetList = tempPlayersEquippedGadgets
	
return tempPlayersEquippedGadgets	

end

function simpleSwitchGadget ()

	if not source then source = localPlayer end

	if source == localPlayer then
	cancelEvent()
	--if currentGadget then iprint("Current gadget: "..currentGadget) end
	
	getCurrentGadgetList()
	
	--if currentGadgetList then iprint(currentGadgetList) end
		local itemIndex = table.contains(currentGadgetList,currentGadget) or 0
		--iprint(itemIndex)
		
		if itemIndex then 
			currentGadget = currentGadgetList[itemIndex+1] or "Empty" 
		end
		
	end
	
end

function switchGadget (butt,press)

	--if not source then source = localPlayer end
	if not getElementData(localPlayer, "isPressingAlt") then return end
	
	getCurrentGadgetList()

	if butt == "mouse_wheel_up" and press == true then 
		nextWeapon()
		--if currentGadget then iprint("Current gadget: "..currentGadget) end
		
		local itemIndex = table.contains(currentGadgetList,currentGadget) or 0
		if itemIndex then 
			currentGadget = currentGadgetList[itemIndex+1] or "Empty" 
		end

	elseif butt == "mouse_wheel_down" and press == true then
		prevWeapon()
		--if currentGadget then iprint("Current gadget: "..currentGadget) end
		
		local itemIndex = table.contains(currentGadgetList,currentGadget) or 0
		if itemIndex then 
			currentGadget = currentGadgetList[itemIndex-1] or currentGadgetList[#currentGadgetList]
		end	
	end
	
end

addEventHandler("onClientKey", root, switchGadget)

switchGadget()

function deployingGadget(gadget)
outputStatusInfo("[ deploying "..gadget.." ]",240,240,240 )
setPedAnimation( localPlayer, "BASEBALL", "BAT_PART",-1,false,false,true,false)
triggerEvent("sleep:drawDXProgress", localPlayer, 1000,1000)
setTimer(triggerEvent,1000,1,"sleep:stopDXProgress", localPlayer,localPlayer)
end

function useGadget()
--if not getElementData(localPlayer, "isPressingAlt") then return end
	if currentGadget == "Empty" then
	outputStatusInfo("[ no gadget ]",240,240,240 )
	return
	elseif currentGadget == "M37 Stomper" then
	shootstomper()
	
	elseif currentGadget == "Grenade" then
		local weapslot8ammo = getPedTotalAmmo(localPlayer, 8)
		if weapslot8ammo > 0 then
			shootgrenade()
			if weapslot8ammo-1<=0 then simpleSwitchGadget() end
			triggerServerEvent("ReduceProjectileAmmo",localPlayer)
		else
		simpleSwitchGadget()
		end
	elseif currentGadget == "Molotov" then
		local weapslot8ammo = getPedTotalAmmo(localPlayer, 8)
		if weapslot8ammo > 0 then
			shootmolotov()
			if weapslot8ammo-1<=0 then simpleSwitchGadget() end
			triggerServerEvent("ReduceProjectileAmmo",localPlayer)
		else
		simpleSwitchGadget()
		end

	elseif currentGadget == "Teargas" then
		local weapslot8ammo = getPedTotalAmmo(localPlayer, 8)
		if weapslot8ammo > 0 then
			shootteargas()
			if weapslot8ammo-1<=0 then simpleSwitchGadget() end
			triggerServerEvent("ReduceProjectileAmmo",localPlayer)
		else
		simpleSwitchGadget()
		end
	
	elseif currentGadget == "Incendiary Trap" then
	local incendiary = getElementData(localPlayer,"incendiarytraps") or 0
	if incendiary > 0 then
		deployingGadget(currentGadget)
		triggerServerEvent("createIncendiaryTrap",localPlayer)
		setPedAnimation( localPlayer, "ped", "FALL_collapse",1000,false,true,false,false)
		if incendiary-1<=0 then incendiary = 1; simpleSwitchGadget() end
		setElementData(localPlayer,"incendiarytraps",incendiary-1,true)
	end
	
	elseif currentGadget == "Shards Trap" then
	local shards = getElementData(localPlayer,"glasstraps") or 0
	if shards > 0 then
		deployingGadget(currentGadget)
		triggerServerEvent("createBleedingTrap",localPlayer)
		setPedAnimation( localPlayer, "ped", "FALL_collapse",1000,false,true,false,false)
		if shards-1<=0 then shards = 1; simpleSwitchGadget() end
		setElementData(localPlayer,"glasstraps",shards-1,true)
	end
	
	elseif currentGadget == "Mine" then
	local mines = getElementData(localPlayer,"explosivetraps") or 0
	if mines > 0 then
		deployingGadget(currentGadget)
		triggerServerEvent("createMine",localPlayer)
		setPedAnimation( localPlayer, "ped", "FALL_collapse",1000,false,true,false,false)
		if mines-1<=0 then mines = 1; simpleSwitchGadget() end
		setElementData(localPlayer,"explosivetraps",mines-1,true)
	end

	
	elseif currentGadget == "Timed Bomb" then
	local timedbombs = getElementData(localPlayer,"timedbombs") or 0
	if timedbombs > 0 then
		deployingGadget(currentGadget)
		triggerServerEvent("createTimeBomb",localPlayer)
		setPedAnimation( localPlayer, "ped", "FALL_collapse",1000,false,true,false,false)
		if timedbombs-1<=0 then timedbombs = 1; simpleSwitchGadget() end
		setElementData(localPlayer,"timedbombs",timedbombs-1,true)
	end
	
	elseif currentGadget == "Spikestrip" then
	local spikestrip = getElementData(localPlayer,"spikestrips") or 0
		if spikestrip > 0 then
			deployingGadget(currentGadget)
			triggerServerEvent("deploySpikestrip",localPlayer)
				setPedAnimation( localPlayer, "ped", "FALL_collapse",1000,false,true,false,false)
			if spikestrip-1<=0 then spikestrip = 1; simpleSwitchGadget() end
			setElementData(localPlayer,"spikestrips",spikestrip-1,true)
		end
	
	elseif currentGadget == "Laser Pointer" then
		if getElementData(localPlayer,"laserpointer")== true then
		triggerEvent("ToggleLaserPointer",localPlayer)
		end
	
	elseif currentGadget == "Zip Line" then
	--triggerServerEvent("---",localPlayer)
	elseif currentGadget == "Headlamp" then
		if getElementData(localPlayer,"headlampequipped")== true then
		triggerEvent("ToggleHeadlamp",localPlayer)
		end
	end
	
end
--bindKey("mouse3", "down", useGadget)
bindKey("X", "down", useGadget)

function DXdrawHUD()

if not getPedOccupiedVehicle(localPlayer) then --this should hide the hud while login; yay, also hides it when in a vehicle, hold on..
	if getCameraTarget() ~= getLocalPlayer() or getCameraTarget() == false then 
		return 
	end 
end

--Variables
        sWidth, sHeight = guiGetScreenSize() -- Getting the screen size

        health = getElementHealth( getLocalPlayer() )
        lineLength1 = 114 * ( health / 100 ) -- Health bar

        armor = getPedArmor( getLocalPlayer() )
        lineLength2 = 114 * ( armor / 100 ) -- Armor bar
        
        ammoinclip = getPedAmmoInClip (getLocalPlayer()) -- The ammo inside the clip
        totalammo = getPedTotalAmmo(getLocalPlayer())-getPedAmmoInClip(getLocalPlayer()) -- The total ammo minus ammo inside clip
        totalammo2 = getPedTotalAmmo(getLocalPlayer())
        showammo1 = ammoinclip
        showammo2 = totalammo
        showammo3 = totalammo2
		
		if showammo2-1 < 1 then showammo2 = "empty" end
		
		

        moneycount=getPlayerMoney(getLocalPlayer())
        if moneycount>0 then 
		money= moneycount.." $" -- Money
		else 
		money = " "
		end

        local hour, mins = getTime ()
        time = hour .. ":" .. (((mins < 10) and "0"..mins) or mins) -- Time. This one makes the minutes always show by 2 digits (3:05 instead of 3:5)
        
-------- Dynamic health colour thanks to 50p ----------
        tick = getTickCount () 
        
-- For active health bar
      local maxHealth = 100;  -- get max health stat
        local colourPercent = ( health / maxHealth ) * 200;
        local red, green; -- we don't need blue because we don't use it, it'll be 0
        if health < ( maxHealth / 2 ) then
        red = 200;
        green = ( health / 50 ) * ( colourPercent * 2 );
else
        green = 200;
        red = 200 - ( ( health - 50 ) / 50 ) * 200;
end
-- For inactive health bar
        local maxHealth = 75;  -- get max health stat
        local colourPercent1 = ( health / maxHealth ) * 75;
        local red1, green1; -- we don't need blue because we don't use it, it'll be 0
        if health < ( maxHealth / 2 ) then
        red1 = 75;
        green1 = ( health / 50 ) * ( colourPercent1 * 2 );
else
        green1 = 75;
        red1 = 75 - ( ( health - 50 ) / 50 ) * 75;
end
local color1 = tocolor( red1, green1, 0, 150 )
local color2 = tocolor( red, green, 0, 200 )
 
 -- For the health bar
 if getTickCount () %1500 < 500 and health <= 20 and armor <=0 then -- If health is less than 20%, armor is 0%, the health bar will blink by hiding the health bar every 1.5 seconds.
 
 else
 
 dxDrawRectangle(sWidth-206,sHeight-29,114.0,14.0,color1, false) -- Health inactive bar
 dxDrawRectangle(sWidth-206,sHeight-29,lineLength1,14.0,color2,false) --Health active bar
 
 end
 
 if armor <= 0 then
 
 else
 dxDrawRectangle(sWidth-206,sHeight-43,lineLength2,14.0,tocolor(200,200,200,200),false) -- Armor active bar
 dxDrawRectangle(sWidth-206,sHeight-43,114.0,14.0,tocolor(50,50,50,150),false) -- Armor inactive bar
 
 end
 


------ DX drawing that are visible at all times
--sWidth-200,sHeight-63
--sWidth-202,sHeight-66
dxDrawText(tostring (money),sWidth/10,sHeight-50,sWidth-5,sHeight-34,tocolor(0,0,0,200),0.7,"pricedown","right","top",false,false,false)  -- Money DX text (shadow) -- USE THIS AS FACTION REPUTATION
dxDrawText(tostring (money),sWidth/10,sHeight-53,sWidth-7,sHeight-37,tocolor(240,240,240,220),0.7,"pricedown","right","top",false,false,false) -- Money DX text

if getElementData(localPlayer,"watch")==true then
dxDrawText(tostring (time),sWidth-71,sHeight-36,sWidth-10,sHeight-16,tocolor(250,250,250,200),0.8,"bankgothic","center","top",false,false,false) -- GTA Time DX text  ----- SHOW CLOCK LINE --WATCH LIne
end
------- Weapon icons & Ammo DX drawings
local weaponID = getPedWeapon (getLocalPlayer()); -- Get weapon ID
local weaponicon = getWeaponIcon(weaponID)
--local weaponicon = currentGadget


dxDrawImage(sWidth-266-70,sHeight-70,48.0,52.0,"icons/".. weaponicon .. ".png",0.0,0.0,0.0,tocolor(255,255,255,200),false) -- Weapon icons image. Check the icons file if you want to take and replace weapon icons.
dxDrawImage(sWidth-266,sHeight-70,48.0,52.0,"icons/".. currentGadget .. ".png",0.0,0.0,0.0,tocolor(255,255,255,200),false) --Gadget icon

-- now decide if the optional stuff should be drawn
if noreloadweapons [getPedWeapon(getLocalPlayer())] and getPedTotalAmmo(getLocalPlayer()) >= 2 then
	dxDrawText(tostring (showammo3-1),sWidth-400-70,sHeight-47,sWidth-288-70,sHeight-12,tocolor(255,255,255,200),1.0,"bankgothic","right","top",false,false,false) -- No reload weapons (for shotgun, grenades, etc)
	
	elseif meleespecialweapons [getPedWeapon(getLocalPlayer())] --[[and getPedTotalAmmo(getLocalPlayer()) < 2]] then
	-- Draw Nothing for melee and special weapons.
	
	elseif getPedTotalAmmo(getLocalPlayer()) < 2 and getPedWeaponSlot(getLocalPlayer()) ~= 0 and getPedWeaponSlot(getLocalPlayer()) ~= 1 and getPedWeaponSlot(getLocalPlayer()) ~= 8 then --new 'no ammo' case: if only one bullet left, block fire and display 'no ammo' to preserve weapon. ammo display must be adjusted accordingly, as '1' becomes the new '0'
	dxDrawText("EMPTY",sWidth-345-70,sHeight-47,sWidth-272-70,sHeight-12,tocolor(255,255,255,200),1.0,"bankgothic","right","top",false,false,false)

	elseif projectileweapons [getPedWeapon(getLocalPlayer())] then
	dxDrawText(tostring (showammo3),sWidth-400-70,sHeight-47,sWidth-288-70,sHeight-12,tocolor(255,255,255,200),1.0,"bankgothic","right","top",false,false,false) -- grenades, flashbang, molotov

else --Weapons that reload.

		if type(showammo2) == "string" then 
        dxDrawText(tostring (showammo2),sWidth-414-70,sHeight-47,sWidth-369-70,sHeight-18,tocolor(255,255,255,200),1.0,"bankgothic","right","top",false,false,false)
		else
		dxDrawText(tostring (showammo2-1),sWidth-414-70,sHeight-47,sWidth-369-70,sHeight-18,tocolor(255,255,255,200),1.0,"bankgothic","right","top",false,false,false)
		end
        dxDrawText("|",sWidth-361-70,sHeight-48,sWidth-385-70,sHeight-8,tocolor(255,200,0,200),1.0,"bankgothic","left","top",false,false,false)
        dxDrawText(tostring (showammo1),sWidth-345-70,sHeight-47,sWidth-272-70,sHeight-12,tocolor(255,255,255,200),1.0,"bankgothic","left","top",false,false,false)
end
   
end 

-------- HUD toogle command functions.

function hudChanger ()
    addEventHandler("onClientRender", getRootElement(), DXdrawHUD)
    setPlayerHudComponentVisible ( "armour", false )
    setPlayerHudComponentVisible ( "health", false )
    setPlayerHudComponentVisible ( "money", false )
    setPlayerHudComponentVisible ( "clock", false )
    setPlayerHudComponentVisible ( "weapon", false )
    setPlayerHudComponentVisible ("ammo", false)
    setPlayerHudComponentVisible ( "money", false )
     setPlayerHudComponentVisible ( "wanted", false )
end

addCommandHandler ( "showhud", hudChanger ) -- Shows the Alternate HUD
addCommandHandler ( "hidegtahud", hudChanger ) -- Hides the GTA HUD 
addEventHandler( "onClientResourceStart", resourceroot, hudChanger ) 
addEventHandler( "onPlayerJoin", resourceroot, hudChanger ) -- The same, but also on player join.

function hudChanger2 ()
     removeEventHandler("onClientRender", getRootElement(), DXdrawHUD)
    setPlayerHudComponentVisible ( "armour", true )    
    setPlayerHudComponentVisible ( "health", true ) 
    setPlayerHudComponentVisible ( "money", true )
    setPlayerHudComponentVisible ( "clock", true )
    setPlayerHudComponentVisible ( "weapon", true )
    setPlayerHudComponentVisible ("ammo", true)
    setPlayerHudComponentVisible ( "money", true)
     setPlayerHudComponentVisible ( "wanted", true )
end
addCommandHandler ( "hidehud", hudChanger2) -- Removes the HUD, and shows the GTA HUD.
addCommandHandler ( "showgtahud", hudChanger2) 
addEventHandler("onClientResourceStop", resourceroot, hudChanger2) -- When you stop the resource, executes.

function hudChanger3 ()
     removeEventHandler("onClientRender", getRootElement(), DXdrawHUD)
     setPlayerHudComponentVisible ("all", false)
end
addCommandHandler ( "hideall", hudChanger3 ) -- Shows the Alternate HUD

function radarcommand1 ()
        setPlayerHudComponentVisible ("radar", true)
end
addCommandHandler( "showradar", radarcommand1 )

function radarcommand2 ()
        setPlayerHudComponentVisible ("radar", false)
end
addCommandHandler( "hideradar", radarcommand2 )

----------the 'drop equipped item' button, located over the weapon icon in HUD---------- 

--[[sWidth, sHeight = guiGetScreenSize()
dropbutt = guiCreateButton(sWidth-266, sHeight-60, 48.0,52.0, " ", false)
guiSetAlpha(dropbutt, 0)
guiMoveToBack (dropbutt)

addEventHandler( "onClientMouseEnter", guiRoot, 
function()
guiSetAlpha(dropbutt, 0.3)
--guiSetText(dropbutt,"test")
--outputInteractInfo("MOUSE1 to retrieve ammo or MOUSE2 to unequip.", localPlayer, 0, 0, 0, 0) 
end)

addEventHandler( "onClientMouseLeave", dropbutt, 
function()
guiSetAlpha(dropbutt, 0)
--guiSetText(dropbutt,"")
end)

addEventHandler( "onClientGUIClick", dropbutt, 
function(button,state,x,y)

	if button == "left" and state == "up" then
	--outputChatBox("left")
	triggerServerEvent ( "ammoRetrieve", root, localPlayer, getPedWeapon(localPlayer), getPedTotalAmmo(localPlayer) )
	elseif button == "right" and state == "up" then
	--outputChatBox("right")
	triggerServerEvent ( "weaponRetrieve", root, localPlayer, getPedWeapon(localPlayer), getPedTotalAmmo(localPlayer) )
end
end)]]

----------------------------------------------------------------------------------------

--NEW HINT MESAGES;

local dys_helpText,dys_helpAnimation
local currentHelpText

addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),
	function()
		dys_helpText = dxText:create(" ",0.015,0.98)
		dys_helpText:scale(1)
		dys_helpText:type("stroke",1)
		--fadeOutHelp()
	end
)


function fadeInHelp()
	if dys_helpAnimation then dys_helpAnimation:remove() end
	local _,_,_,a = dys_helpText:color()
	if a == 255 then return end
	dys_helpAnimation = Animation.createAndPlay(dys_helpText, Animation.presets.dxTextFadeIn(300))
	setTimer ( function() dys_helpText:color(255,255,255,255) end, 300, 1 )
end

function fadeOutHelp()
	if dys_helpAnimation then dys_helpAnimation:remove() end
	local _,_,_,a = dys_helpText:color()
	if a == 0 then return end
	dys_helpAnimation = Animation.createAndPlay(dys_helpText, Animation.presets.dxTextFadeOut(300))
	setTimer ( function() dys_helpText:color(255,255,255,0) end, 300, 1 )
end
		--local prevw,nextw = next(getBoundKeys ( "Previous driveby weapon" )),next(getBoundKeys ( "Next driveby weapon" ))
		--if prevw and nextw then ... end
--[[			if dys_helpAnimation then Animation:remove() end
			helpText:text( "Scroll up to switch guns" )
			fadeInHelp()
			setTimer ( fadeOutHelp, 10000, 1 )]]
			
addEventHandler("onClientPlayerSpawn",root,function()
if source == localPlayer then
	if getElementData(localPlayer,"lives") == 3 then
		message_text = "Welcome to Dystopia! Hold [F1] for quick help or press [F9] for the complete game manual."
	elseif getElementData(localPlayer,"lives") == 1 then
		message_text = "CAUTION! 1❤ remaining! Find a bed to sleep and regain lives. Avoid the death of your character, you will lose your progress."
	else 
		message_text = dialogue_help_messsage
	end
	dys_helpText:text( message_text )
	fadeInHelp()
	dys_help_timer = setTimer ( fadeOutHelp, 10000, 1 )
end
end)

addEvent("showHelpMessageEvent",true)
function showHelpMessage(message)
	--if NO_HUD_MODE then return end
	dys_helpText:text( "" )
	dys_helpText:text( message )
	currentHelpText = message
	fadeInHelp()
	
	if isTimer(dys_help_timer) then 
	killTimer(dys_help_timer)
	end
	
	dys_help_timer = setTimer ( fadeOutHelp, 10000, 1 )
		
	setTimer(function () 
		dys_helpText:text(empty_help_messsage); 
		currentHelpText =" "; 
		bottomHelpLineVisible = false 
		--iprint("help text emptied") 
	end,10000,1)
end
addEventHandler("showHelpMessageEvent",root,showHelpMessage)

---Surrounding active objects and items on the floor handlers

-- Draw function config
-- Message config
local MINIMUM_SIZE = 0.1
local MESSAGE_TIME = 1000 -- milliseconds
local VEHICLE_SCALE_MULTIPLIER = 0.7 -- 30%
--local SPACE_BETWEEN_LINES = 0.3
local DISTANCE_TO_RENDER_DAMAGE = 200 -- GTA units
local HEIGHT_OFFSET = 1--1.20
local SHADING_PER_RENDER = 7.5
local SCALE = 0.2

local DRAW_CHECK_BUILDINGS = true
local DRAW_CHECK_VEHICLES = true
local DRAW_CHECK_PEDS = false
local DRAW_CHECK_OBJECTS = true
local DRAW_CHECK_DUMMIES = false
local DRAW_SEE_THROUGH_STUFF = false
local DRAW_IGNORE_CAMERA_OBJECTS = false

function dxDrawNameOnElement(element, text, height, distance, R, G, B, alpha, size, font)
	local x, y, z = getElementPosition(element)
	local x2, y2, z2 = getElementPosition(localPlayer)
	local distance = distance or 20
	local height = height or 1

	if (isLineOfSightClear(x, y, z, x2, y2, z2, DRAW_CHECK_BUILDINGS, DRAW_CHECK_VEHICLES, DRAW_CHECK_PEDS, DRAW_CHECK_OBJECTS, DRAW_CHECK_DUMMIES, DRAW_SEE_THROUGH_STUFF, DRAW_IGNORE_CAMERA_OBJECTS,element)) then
		local sx, sy = getScreenFromWorldPosition(x, y, z+height)
		if (sx and sy) then
			local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
			if(distanceBetweenPoints < distance) then
				scale = (size or 1)-(distanceBetweenPoints / distance)
				if scale < MINIMUM_SIZE then
					scale = MINIMUM_SIZE
				end
				height = HEIGHT_OFFSET - (distanceBetweenPoints / distance )
				dxDrawText(text, sx-2, sy-2, sx, sy, tocolor(1, 1, 1, alpha or 255), scale, font or "arial", "center", "center", false, false, false,true)
				dxDrawText(text, sx, sy, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), scale, font or "arial", "center", "center", false, false, false,true)
			end
		end
	end
end

--dxDrawNameOnElement(localPlayer,"wtf",1,nil,255,255,255,255,1,ChunkfiveFontDX)

function getObjCoronaColor(itemName) --determines item corona color based on item name
local r,g,b 
if itemName == "Water Bottle" or itemName == "Alcohol Bottle" or itemName == "Dirty Water" or itemName == "Water Canister" 
then r,g,b = 33,163,181
elseif itemName == "Pistol" or itemName == "Magnum Revolver" or itemName == "Pump Shotgun" or itemName == "Sawn-off Shotgun" or itemName == "Combat Shotgun" or itemName == "MP5" or itemName == "Uzi" or itemName == "Auto Pistol" or itemName == "M4" or itemName == "AK 47" or itemName == "Rifle" or itemName == "Sniper Rifle" or itemName == "Crossbow" or itemName == "Minigun" or itemName == "Laser Pointer" or itemName == "Zip Line" or itemName == "M37 Stomper" 
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
function rotateIfGroundButton()
	if isElement(source) and getElementType(source) == "gui-button" then
		for i,v in pairs(ground_items) do
			if v == source then
				local x,y,z = getElementPosition(localPlayer)
				if isElement(i) then
					local ix,iy,iz = getElementPosition(i)
					local pedangle = ( 360 - math.deg ( math.atan2 ( ( ix - x ), ( iy - y ) ) ) ) % 360
					if pedangle then
					setElementRotation(localPlayer,0,0,pedangle)
					end
				end
			end
		end
	end
end
addEventHandler("onClientMouseEnter",guiRoot,rotateIfGroundButton)

local x,y,z = getElementPosition(localPlayer)
my_detection_col = createColSphere(x,y,z,2)
my_extended_detection_col = createColSphere(x,y,z,3.5)
attachElements(my_detection_col,localPlayer)
attachElements(my_extended_detection_col,localPlayer)
ground_items = {}
local ChunkfiveFontDX = dxCreateFont ( "fonts/Chunkfive.otf", 100 )

--allGroundButtons = createElement("loot_buttons_colection")
--local ground_item_buttons = {}
--dxDrawNameOnElement(localPlayer,"wtf",1,10,255,255,255,255,0.2,ChunkfiveFontDX)
function checkTHEItem(butt,state,x,y)

	if isElement(source) and getElementType(source) == "gui-button" then
	outputDebugString("it's a button")

		for i,v in pairs(ground_items) do
			if v == source then
				triggerServerEvent("pickupItemFromGroundButton",localPlayer,i)
			end
			destroyElement(v)
			setTimer(function() ground_items[i] = nil end,1000,1)
		end
				
	end

end

function drawItemsOnFloor ()
	if NO_HUD_MODE then return end
	local items = getElementsWithinColShape(my_detection_col)
	
	if not isCursorShowing() then

		if items and #items>0 then
				for i,item in ipairs(items) do
				local parent = getElementParent(item)
					if parent and getElementType(parent) == "colshape" then
					if isElement(ground_items[parent]) then 
					removeEventHandler("onClientGUIClick",ground_items[parent],checkTHEItem)
					destroyElement(ground_items[parent]); 
					ground_items[parent] = nil 
					end
					local itemtype = getElementData(parent,"item_inventory")
								if isElement(parent) and tostring(itemtype) and itemtype ~= "Empty" then
									local x,y,z = getElementPosition(parent)
									local sx,sy,dist = getScreenFromWorldPosition(x,y,z)
									local r,g,b = getObjCoronaColor(itemtype)
									if sx then
									dxDrawRectangle( sx-80,sy+10, 160, 5 , tocolor(r,g,b,150) )
									dxDrawNameOnElement(parent,itemtype,0,100,255,255,255,200,0.12,ChunkfiveFontDX,false,false,false,false,false,false)
									end
									
									if currentHelpText ~= items_help_messsage then
									showHelpMessage(items_help_messsage)
									end
									
								end
					end
				end
				
		end
	else
		if items and #items>0 then
				for i,item in ipairs(items) do
				local parent = getElementParent(item)
					if parent and getElementType(parent) == "colshape" then
					--iprint("found colshape")
					 local itemtype = getElementData(parent,"item_inventory")
								if isElement(parent) and tostring(itemtype) and itemtype ~= "Empty" then
									local x,y,z = getElementPosition(parent)
									local sx,sy,dist = getScreenFromWorldPosition(x,y,z)
									if sx then
									
										if not ground_items[parent] then 
										local butt = guiCreateButton(sx-80,sy-15, 160, 30,"",false)
										--local butt = guiCreateButton(sx-80,sy-15, 160, 30,"",false)
										addEventHandler("onClientGUIClick",butt,checkTHEItem)	
										ground_items[parent] = butt
										guiSetAlpha(ground_items[parent],0)
										--butt = nil
										end
									local r,g,b = getObjCoronaColor(itemtype)
									dxDrawRectangle( sx-80,sy-15, 160, 30 , tocolor(0,0,0,150) )
									dxDrawRectangle( sx-80,sy+10, 160, 5 , tocolor(r,g,b,150) )
									dxDrawNameOnElement(parent,itemtype,0,100,255,255,255,200,0.12,ChunkfiveFontDX,false,false,false,false,false,false)
									end
									
									--[[if currentHelpText ~= items_help_messsage then
									showHelpMessage(items_help_messsage)
									end]]
									--destroyElement(ground_item_buttons[parent])
								end
					end
				end
				
		end
	end								
end
addEventHandler("onClientRender",root,drawItemsOnFloor)

local fire_models = {[1222] = true, [1362] = true, [1442] = true} --  [3525] = true,  [3524] = true --actual fire objects, I tag the barrels instead
local shelter_models = {[1457] = true}
local wirefence_models = {[1411] = true}
local barricade_models = {[1449] = true}
local strongbox_models = {[964] = true }
local loot_box_models = {

[2971] = true, --smashboxes
[1431] = true, 
[1441] = true, 
[1224] = true, 
[1221] = true, 
[1220] = true, 
[1230] = true,
[2900] = true,
[2968] = true,
[1438] = true,
[1421] = true,
[2977] = true, --mil box
[1558] = true,
[1440] = true,
[1429] = true,

}
local wreck_models = {[12957] = true, [3593] = true, [3594] = true}
local clothes_models = {[2846] = true, [2844] = true, [2843] = true, [2819] = true, [2845] = true}
local radio_station_model = { [11631] = true }
local stockpile_model = { [1264] = true }
local fuel_barrel_models = {[1217] = true, [1225] = true}
local bed_models = {[1800] = true, [14861] = true, [1801] = true, [1793] = true }

bottomHelpLineVisible = false

building_buttons = { }

function removeTheBuilding(butt,state,x,y)

	if isElement(source) and getElementType(source) == "gui-button" then
	--outputDebugString("it's a button")

		for i,v in pairs(building_buttons) do
			if v == source then
				triggerServerEvent("removeBuildingForClient",localPlayer,i)
			end
			destroyElement(v)
			setTimer(function() building_buttons[i] = nil end,1000,1)
		end
				
	end

end

function drawSurroundingObjects ()
if NO_HUD_MODE then return end
local items = getElementsWithinColShape(my_extended_detection_col,"object")
local vehicles = getElementsWithinColShape(my_extended_detection_col,"vehicle")
local message
local message_height
		if not isCursorShowing() then
		
--[[		for i,butt in ipairs(building_buttons) do --attempt to delete the buttons
		
			if isElement(butt) then 
			removeEventHandler("onClientGUIClick",butt,removeTheBuilding)
			destroyElement(butt); 
			outputDebugString("button destroyed")
			butt = nil 
			end
		
		end]]
			
			
			if vehicles and #vehicles>0 then
					for i,vehicle in ipairs(vehicles) do
							
						local vehmodel = getElementModel(vehicle)
						message = retrieveCustomCarName (vehicle)
						if not message then message = "Vehicle" end
						if getElementData(vehicle,"driverminigun_vehweapon") then message = "Weaponized\n"..message end
						if getElementData(vehicle,"vehicle-scenery") then message = "Wrecked\n"..message end
						message_height = 1.5
						
						if message and vehicle ~= getPedOccupiedVehicle(localPlayer) then
							local x,y,z = getElementPosition(vehicle)
							local sx,sy,dist = getScreenFromWorldPosition(x,y,z)
							
							if sx then
								--dxDrawRectangle( sx-80,sy-15, 160, 30 , tocolor(0,0,0,150) ) --move it to the draw text function
								dxDrawNameOnElement(vehicle,message,message_height,100,255,255,255,200,0.22,ChunkfiveFontDX,false,false,false,false,false,false)
								
								--[[if currentHelpText ~= vehicle_help_messsage then
								showHelpMessage(vehicle_help_messsage)
								end]]
							end
						end
						message = nil	
						message_height = nil
					end
			end

			if items and #items>0 then
				for i,item in ipairs(items) do
				
				if isElement(building_buttons[item]) then 
					removeEventHandler("onClientGUIClick",building_buttons[item],removeTheBuilding)
					destroyElement(building_buttons[item]); 
					outputDebugString("button destroyed")
					building_buttons[item] = nil 
				end
						
						local objmodel = getElementModel(item)
						if getElementData(item,"destroyed")~=true then				
							if fire_models[objmodel] then
								message = "Fire Place"
								message_height = 1
							elseif strongbox_models[objmodel]  and ( not isElementAttached(item) or (getAttachedElements(item))[1] ~= getPedOccupiedVehicle(localPlayer) ) then
								message = "Strongbox"
								message_height = 1.5
							elseif loot_box_models[objmodel] and ( not isElementAttached(item) or (getAttachedElements(item))[1] ~= getPedOccupiedVehicle(localPlayer) ) then --some need pos adjustment
								message = "Loot"
								message_height = 0.5
							elseif fuel_barrel_models[objmodel] and ( not isElementAttached(item) or (getAttachedElements(item))[1] ~= getPedOccupiedVehicle(localPlayer) ) then
								message = "Fuel"
								message_height = 1
							elseif stockpile_model[objmodel] and not isElementAttached(item) then
								message = "Stockpile"
								message_height = 1
							elseif wirefence_models[objmodel] and not isElementAttached(item) then
								message = "Barbed Wire"
								message_height = 0.5
							elseif barricade_models[objmodel] and not isElementAttached(item) then
								message = "Barricade"
								message_height = 0.5				
							elseif shelter_models[objmodel] then
								message = "Shelter"
								message_height = 0.5				
							elseif objmodel == 1370 and ( not isElementAttached(item) or (getAttachedElements(item))[1] ~= getPedOccupiedVehicle(localPlayer) )  then
								message = "Gas Drum"
								message_height = 0.5				
		
		
							end
				
							if message == "Loot" then 
							
								local x,y,z = getElementPosition(localPlayer)
								local ox,oy,oz = getElementPosition(item)
								local dist = getDistanceBetweenPoints3D(x,y,z,ox,oy,oz)
								
								if dist <= 1.5 and bottomHelpLineVisible == false and currentHelpText ~= loot_help_messsage then
									showHelpMessage(loot_help_messsage)
									currentHelpText = loot_help_messsage
									bottomHelpLineVisible = true
								end 
								
							end
				
						end
				
				
						if message then
							local x,y,z = getElementPosition(item)
							local sx,sy,dist = getScreenFromWorldPosition(x,y,z)
							
							if sx then
								dxDrawNameOnElement(item,message,message_height,100,255,255,255,200,0.22,ChunkfiveFontDX,false,false,false,false,false,false)
							end
							
						end
						
						message = nil
				end
			end
		else -- when cursor is visible, draw buildings names and buttons
		
		
		if items and #items>0 then
			for i,item in ipairs(items) do
			
				local objmodel = getElementModel(item)
				if BuildableObjectsData[objmodel] and getElementData(item, "persistent_id") then
					--outputDebugString("building in sight")
					message = BuildableObjectsData[objmodel][1]
					
--[[					if message then
						local x,y,z = getElementPosition(item)
						local sx,sy,dist = getScreenFromWorldPosition(x,y,z)
						if sx then
							dxDrawNameOnElement(item,message,0.4,100,255,255,255,200,0.22,ChunkfiveFontDX,false,false,false,false,false,false)
						end
					end
					message = nil]]
					--

					
					local x,y,z = getElementPosition(item)
					local sx,sy,dist = getScreenFromWorldPosition(x,y,z)
						if sx then
											
							if not building_buttons[item] then 
							local butt = guiCreateButton(sx-80,sy-15, 160, 30,"",false)

							addEventHandler("onClientGUIClick",butt,removeTheBuilding)	
							building_buttons[item] = butt
							guiSetAlpha(building_buttons[item],0)

							end
							--dxDrawNameOnElement(item,message,0.5,100,255,255,255,200,0.2,ChunkfiveFontDX,false,false,false,false,false,false)
							dxDrawText(message,sx-80,sy-55, 160, 30,tocolor(255,255,255,200),0.2,ChunkfiveFontDX,"left","top",false,false,false)
							dxDrawRectangle( sx-80,sy-15, 160, 30 , tocolor(0,0,0,150) )
							dxDrawRectangle( sx-80,sy+10, 160, 5 , tocolor(255,0,0,150) )
							dxDrawNameOnElement(item,"REMOVE",0,100,255,255,255,200,0.12,ChunkfiveFontDX,false,false,false,false,false,false)

						message = nil
						end
				end
			end
	end	
end	

	
	
end
addEventHandler("onClientRender",root,drawSurroundingObjects)
--addEventHandler("onClientGUIClick",guiRoot,checkTHEItem)	