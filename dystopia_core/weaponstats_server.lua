    --server
    addEvent("killPedSpecial",true)
    addEventHandler("killPedSpecial",root,
    function(a)
    killPed(source,a)
    end)

-- damage ex: 140 = 3 shots/kill, 180 = 2 shots/kill

addEventHandler ( "onResourceStart", root,
function ()
--PISTOL: low damage, medium range, 15 bullets/clip, dualwield, 9 mm
	setWeaponProperty(22, "poor", "weapon_range", 80)
	setWeaponProperty(22, "std", "weapon_range", 80)
	setWeaponProperty(22, "pro", "weapon_range", 80)
    --clip ammo
	setWeaponProperty(22, "poor", "maximum_clip_ammo", 10)
	setWeaponProperty(22, "std", "maximum_clip_ammo", 10)
	setWeaponProperty(22, "pro", "maximum_clip_ammo", 20)
--CROSSBOW (silenced): medium damage, medium range, reloads after every shot, *bleeding 50%, bolts
    setWeaponProperty(23, "poor", "weapon_range", 50)
    setWeaponProperty(23, "std", "weapon_range", 50)
    setWeaponProperty(23, "pro", "weapon_range", 50)
	setWeaponProperty(23, "poor", "maximum_clip_ammo", 1)
	setWeaponProperty(23, "std", "maximum_clip_ammo", 1)
	setWeaponProperty(23, "pro", "maximum_clip_ammo", 1)
    --longer reload
	setWeaponProperty(23, "poor", "flags", 0x008000)
	setWeaponProperty(23, "std", "flags", 0x008000)
	setWeaponProperty(23, "pro", "flags", 0x008000)
	--slows down
	setWeaponProperty(23, "pro", "flags",0x010000) 
    setWeaponProperty(23, "poor", "flags", 0x010000)
	setWeaponProperty(23, "std", "flags", 0x010000)
--AUTO PISTOL (tec-9): low damage, low range, 31 bullets/clip, dualwield, 9 mm
    setWeaponProperty(32, "poor", "weapon_range", 100)
    setWeaponProperty(32, "std", "weapon_range", 100)
    setWeaponProperty(32, "pro", "weapon_range", 100)
    setWeaponProperty(32, "poor", "maximum_clip_ammo", 1000)
    setWeaponProperty(32, "std", "maximum_clip_ammo", 1000)
    setWeaponProperty(32, "pro", "maximum_clip_ammo", 1000) 
    setWeaponProperty(32, "poor", "damage", 100) 
    setWeaponProperty(32, "std", "damage", 100)
    setWeaponProperty(32, "pro", "damage", 100) 
--SAWED-OFF: high damage, low range, 2 bullets/clip, *breaks bones 30%, .12 gauge
    setWeaponProperty(26, "poor", "weapon_range", 30)
    setWeaponProperty(26, "std", "weapon_range", 30)
    setWeaponProperty(26, "pro", "weapon_range", 30)
    --slows down
	setWeaponProperty(26, "pro", "flags",0x010000) 
    setWeaponProperty(26, "poor", "flags", 0x010000)
	setWeaponProperty(26, "std", "flags", 0x010000)	
--PUMP SHOTGUN: high damage, low range, *breaks bones 30%, .12 gauge
    setWeaponProperty(25, "poor", "weapon_range", 70)
    setWeaponProperty(25, "std", "weapon_range", 70)
    setWeaponProperty(25, "pro", "weapon_range", 70)
    --clip ammo
   -- setWeaponProperty(25, "poor", "maximum_clip_ammo", 8)
  --  setWeaponProperty(25, "std", "maximum_clip_ammo", 8)
  --  setWeaponProperty(25, "pro", "maximum_clip_ammo", 8)
  	--slows down
	setWeaponProperty(25, "pro", "flags",0x010000) --slows down
    setWeaponProperty(25, "poor", "flags", 0x010000)
	setWeaponProperty(25, "std", "flags", 0x010000)
--M4: lower damage, higher range, 5.56 mm
    setWeaponProperty(31, "poor", "weapon_range", 240)
    setWeaponProperty(31, "std", "weapon_range", 240)
    setWeaponProperty(31, "pro", "weapon_range", 240)
    setWeaponProperty(31, "poor", "maximum_clip_ammo", 30)
    setWeaponProperty(31, "std", "maximum_clip_ammo", 30)
    setWeaponProperty(31, "pro", "maximum_clip_ammo", 30)
	setWeaponProperty(31, "pro", "flags",0x010000) --slows down
    setWeaponProperty(31, "poor", "flags", 0x010000)
	setWeaponProperty(31, "std", "flags", 0x010000)
--AK 47: higher damage, lower range, 7.62 mm
    setWeaponProperty(30, "poor", "weapon_range", 220)
    setWeaponProperty(30, "std", "weapon_range", 220)
    setWeaponProperty(30, "pro", "weapon_range", 220)
    setWeaponProperty(30, "poor", "maximum_clip_ammo", 30)
    setWeaponProperty(30, "std", "maximum_clip_ammo", 30)
    setWeaponProperty(30, "pro", "maximum_clip_ammo", 30)
	 --slows down
	setWeaponProperty(30, "pro", "flags",0x010000)
    setWeaponProperty(30, "poor", "flags", 0x010000)
	setWeaponProperty(30, "std", "flags", 0x010000)
--SNIPER: high damage, long range, Rifle Rounds
    setWeaponProperty(34, "poor", "weapon_range", 450)
    setWeaponProperty(34, "std", "weapon_range", 450)
    setWeaponProperty(34, "pro", "weapon_range", 450)
	--slows down
	setWeaponProperty(34, "pro", "flags",0x010000) 
    setWeaponProperty(34, "poor", "flags", 0x010000)
	setWeaponProperty(34, "std", "flags", 0x010000)
	
	setWeaponProperty(34, "poor", "maximum_clip_ammo", 5)
    setWeaponProperty(34, "std", "maximum_clip_ammo", 5)
    setWeaponProperty(34, "pro", "maximum_clip_ammo", 5)
--RIFLE: high damage, long range, Rifle Rounds
    setWeaponProperty(33, "poor", "weapon_range", 420)
    setWeaponProperty(33, "std", "weapon_range", 420)
    setWeaponProperty(33, "pro", "weapon_range", 420)
	--fire rate
	local riflepoor=getOriginalWeaponProperty(33, "poor", "anim_loop_stop")
	local riflestd=getOriginalWeaponProperty(33, "std", "anim_loop_stop")
	local riflepro=getOriginalWeaponProperty(33, "pro", "anim_loop_stop")
	local riflefirepoor=getOriginalWeaponProperty(33, "poor", "anim_loop_bullet_fire")
	local riflefirestd=getOriginalWeaponProperty(33, "std", "anim_loop_bullet_fire")
	local riflefirepro=getOriginalWeaponProperty(33, "pro", "anim_loop_bullet_fire")
	setWeaponProperty(33, "poor", "anim_loop_stop", riflepoor-riflepoor/7) 
    setWeaponProperty(33, "std", "anim_loop_stop", riflestd-riflestd/7)
    setWeaponProperty(33, "pro", "anim_loop_stop", riflepro-riflepro/7)
	setWeaponProperty(33, "poor", "anim_loop_bullet_fire", riflefirepoor-riflefirepoor/7) 
    setWeaponProperty(33, "std", "anim_loop_bullet_fire", riflefirestd-riflefirestd/7)
    setWeaponProperty(33, "pro", "anim_loop_bullet_fire", riflefirepro-riflefirepro/7)
	setWeaponProperty(33, "poor", "maximum_clip_ammo", 10)
    setWeaponProperty(33, "std", "maximum_clip_ammo", 10)
    setWeaponProperty(33, "pro", "maximum_clip_ammo", 10)
	--setWeaponProperty(33, "poor", "flags", 0x001000)
	--setWeaponProperty(33, "std", "flags", 0x001000)
	--setWeaponProperty(33, "pro", "flags", 0x001000)
	setWeaponProperty(33, "pro", "flags",0x010000) --slows down
    setWeaponProperty(33, "poor", "flags", 0x010000)
	setWeaponProperty(33, "std", "flags", 0x010000)
	setWeaponProperty(33, "pro", "flags",0x000020 ) --move and fire
    setWeaponProperty(33, "poor", "flags", 0x000020 )
	setWeaponProperty(33, "std", "flags", 0x000020 )
	
--MP5: medium damage, low range, 30 bullets/clip, 9 mm
    setWeaponProperty(29, "poor", "weapon_range", 100)
    setWeaponProperty(29, "std", "weapon_range", 100)
    setWeaponProperty(29, "pro", "weapon_range", 100)
    setWeaponProperty(29, "poor", "maximum_clip_ammo", 30)
    setWeaponProperty(29, "std", "maximum_clip_ammo", 30)
    setWeaponProperty(29, "pro", "maximum_clip_ammo", 30)
    --slows down
    setWeaponProperty(29, "pro", "flags",0x010000) 
    setWeaponProperty(29, "poor", "flags", 0x010000)
	setWeaponProperty(29, "std", "flags", 0x010000)
 --COMBAT SHOTGUN: high damage, low range, *breaks bones 30%, .12 gauge
    setWeaponProperty(27, "poor", "weapon_range", 70)
    setWeaponProperty(27, "std", "weapon_range", 70)
    setWeaponProperty(27, "pro", "weapon_range", 70)
    setWeaponProperty(27, "poor", "maximum_clip_ammo", 8)
    setWeaponProperty(27, "std", "maximum_clip_ammo", 8)
    setWeaponProperty(27, "pro", "maximum_clip_ammo", 8)
	--slows down
	setWeaponProperty(27, "pro", "flags",0x010000) 
    setWeaponProperty(27, "poor", "flags", 0x010000)
	setWeaponProperty(27, "std", "flags", 0x010000)
--UZI: low damage, low range, 30 bullets/clip, dualwield, 9 mm
    setWeaponProperty(28, "poor", "weapon_range", 80)
    setWeaponProperty(28, "std", "weapon_range", 80)
    setWeaponProperty(28, "pro", "weapon_range", 80)
    setWeaponProperty(28, "poor", "maximum_clip_ammo", 30)
    setWeaponProperty(28, "std", "maximum_clip_ammo", 30)
    setWeaponProperty(28, "pro", "maximum_clip_ammo", 30) 
 --MAGNUM PISTOL 
    setWeaponProperty(24, "poor", "weapon_range", 100)
    setWeaponProperty(24, "std", "weapon_range", 100)
    setWeaponProperty(24, "pro", "weapon_range", 100)
    setWeaponProperty(24, "poor", "maximum_clip_ammo", 6)
    setWeaponProperty(24, "std", "maximum_clip_ammo", 6)
    setWeaponProperty(24, "pro", "maximum_clip_ammo", 6) 
	--slows down
	setWeaponProperty(24, "pro", "flags",0x010000) 
    setWeaponProperty(24, "poor", "flags", 0x010000)
	setWeaponProperty(24, "std", "flags", 0x010000)
 -- BINOCULARS: long range, used to identify distance to target
    setWeaponProperty(43, "poor", "weapon_range", 1000)
    setWeaponProperty(43, "std", "weapon_range", 1000)
    setWeaponProperty(43, "pro", "weapon_range", 1000)
--ROCKET LAUNCHER
--[[    setWeaponProperty(35, "pro", "flag_aim_1st_person",false ) 
    setWeaponProperty(35, "poor", "flag_aim_1st_person", false )
	setWeaponProperty(35, "std", "flag_aim_1st_person", false )]]
--FIRETHROWER
--[[    setWeaponProperty(37, "poor", "damage", 100) 
    setWeaponProperty(37, "std", "damage", 100)
    setWeaponProperty(37, "pro", "damage", 100)]]
end)
       
--TASER--
--[[
	##########################################################################
	##                                                                      ##
	## Project: 'Taser' - resource for MTA: San Andreas                     ##
	##                                                                      ##
	##########################################################################
	[C] Copyright 2013-2014, Falke

local cFunc = {}
local cSetting = {}
]]
--HEADSHOT
--[[function MakePlayerHeadshot( attacker, weapon, bodypart, loss )
        if bodypart == 9 and getElementData(source,"zombie")~= true then
            triggerEvent( "onPlayerHeadshot", source, attacker, weapon, loss )
            setPedHeadless ( source, true )
            killPed( source, attacker, weapon, bodypart )
            setTimer( BackUp, 900, 1, source )
        end
end

function MakeHeadshot( source, attacker, weapon, loss )
    triggerEvent( "onPlayerHeadshot", source, attacker, weapon, loss )
    killPed( source, attacker, weapon, 9 )
    setPedHeadless ( source, true )
    setTimer( BackUp, 900, 1, source )
end

function BackUp( source )   
    if getElementType ( source ) == "player" then
        setPedHeadless ( source, false )
    end
end

addEvent ( "onServerHeadshot", true )
addEventHandler( "onPlayerDamage", getRootElement(), MakePlayerHeadshot )
addEventHandler( "onServerHeadshot", getRootElement(), MakeHeadshot )]]

-- first attempt to output only generic kill and headshot icons
function genericKillIconOnly (killer, weapon, bodypart)

--if bodypart == 9 and getElementType(killer) == "player" then
			--cancelEvent()
			--local r2,g2,b2 = getTeamColor ( getPlayerTeam( killer ) )
			--local r1,g1,b1 = getTeamColor ( getPlayerTeam( source ) )
			--exports.killmessages:outputMessage (
			--{getPlayerName(killer),{"padding",width=3},{"icon",id=256},{"padding",width=3},{"icon",id=999},{"padding",width=3},{"color",r=r1,g=g1,b=b1},getPlayerName(source) }, getRootElement(),r2,g2,b2)              

	--else

		cancelEvent()
		
		--if not killer or killer == source then
			exports.killmessages:outputMessage ( {"",{"padding",width=3},{"icon",id=999},{"padding",width=3},{"color",r=r1,g=g1,b=b1},getPlayerName(source) }, getRootElement(),255,255,255)
		--elseif getElementType(killer) == "player" then
			--exports.killmessages:outputMessage ( {getPlayerName(killer),{"padding",width=3},{"icon",id=999},{"padding",width=3},{"color",r=r1,g=g1,b=b1},getPlayerName(source) }, getRootElement(),r2,g2,b2) 
		--else 
			--exports.killmessages:outputMessage ( {"",{"padding",width=3},{"icon",id=999},{"padding",width=3},{"color",r=r1,g=g1,b=b1},getPlayerName(source) }, getRootElement(),r2,g2,b2)

		--end
	--end
	
end
addEventHandler( "onPlayerKillMessage", getRootElement(), genericKillIconOnly )

--RELOAD -- edited to allow for rifle reload; might add shotgun one-by-one slugs reloading

 ----------------cunt rifle reloads

addEvent ( "onRifleShoot", true )  
 function riflereload ()
 
    if isPedDucked(source) then
			setPedAnimation(source, "RIFLE", "RIFLE_crouchload", -1, false, false, false, false)
		else
			setPedAnimation(source, "RIFLE", "RIFLE_load", -1, false, false, false, false)
	end
		
 end 
  
addEventHandler ( "onRifleShoot", root, riflereload ) 

function reloadDysRifle()

local rifletype = getPedWeapon(client)
	
	if rifletype == 33 or rifletype == 34 then
	
		if isPedDucked(client) then
			setPedAnimation(client, "RIFLE", "RIFLE_crouchload", -1, false, false, false, false)
		else
			setPedAnimation(client, "RIFLE", "RIFLE_load", -1, false, false, false, false)
		end
		
		local rifleammo = getPedTotalAmmo(client, 6)
		if rifletype == 33 and rifleammo>10 then
		setWeaponAmmo(client,rifletype,rifleammo,10)
		elseif rifletype == 34 and rifleammo>5 then
		setWeaponAmmo(client,rifletype,rifleammo,5)
		else
		reloadPedWeapon(client)
		end
	else 
		reloadPedWeapon(client)
	end
	
end
addEvent("relWep", true)
addEventHandler("relWep", resourceRoot, reloadDysRifle)

-----------------------------------------------LASER POINTER
-- laserpointer server.lua
-- by vick

--[[
Player Element Data	-- changing these to an invalid value can break this script
	"laser.on"	-- tells you player has turned laser on
	"laser.aim"  -- tells you player is aiming and laser is drawn
	"laser.red", "laser.green", "laser.blue", "laser.alpha"
	
Exported Functions:
	SetLaserEnabled(player, state)    -- (element:player, bool:state)    -- returns false if invalid params, true otherwise
	IsLaserEnabled(player)    -- (element:player)    -- returns true or false
	SetLaserColor(player, r,g,b,a)    -- (element:player, int:r, int:g, int:b, int:a)   -- returns true
	GetLaserColor(player)    -- (element:player)   -- returns r,g,b,a (int:) or false but shouldnt happen.
	IsPlayerWeaponValidForLaser(player)    -- (element:player)    -- returns true or false
]]

function SetLaserEnabled(player, state) -- returns false if invalid params passed, true if successful changed laser enabled
	if not player or not isElement(player) or getElementType(player) ~= "player" then return false end
	if not state then return false end
	
	if state == true then -- enable laser
		setElementData(player, "laser.on", true, true)
		setElementData(player, "laser.aim", false, true)
		return true
	elseif state == false then -- disable laser
		setElementData(player, "laser.on", false, true)
		setElementData(player, "laser.aim", false, true)
		return true
	end
	return false
end
function IsLaserEnabled(player) -- returns true or false based on player elementdata "laser.on"
	if getElementData(player, "laser.on") == true then
		return true
	else
		return false
	end
end

function IsPlayerWeaponValidForLaser(player) -- returns false for unarmed and awkward weapons
	local weapon = getPedWeapon(player)
	if weapon and weapon > 21 and weapon < 39 and weapon ~= 35 and weapon ~= 36 then
		return true
	end
	return false
end

---TURN AUTOAIM OFF FOR ALL WEAPS
function setAutoAimForAllWeapons( bEnable )
    weaponList = { "colt 45", "silenced", "deagle", "shotgun", "sawed-off", "combat shotgun", "uzi", "mp5", "ak-47", "m4", "tec-9", "rifle", "sniper", "minigun" }
    for _,weapon in ipairs( weaponList ) do
        for _,skill in ipairs( { "poor", "std", "pro" } ) do
            setWeaponPropertyFlag( weapon, skill, 0x0001, not bEnable )
        end
    end
end

-- Set or clear an individual weapon flag bit
function setWeaponPropertyFlag( weapon, skill, flagBit, bSet )
    local bIsSet = bitAnd( getWeaponProperty(weapon, skill, "flags"), flagBit ) ~= 0
    if bIsSet ~= bSet then
        setWeaponProperty(weapon, skill, "flags", flagBit)
    end
end

-- Turn off auto aim
setAutoAimForAllWeapons( false )
-----------------------------------------

function createExplosiveTrap ( creator )
if not creator then creator = source end
	local x, y, z = getElementPosition ( creator )
	local explObject = createObject ( 1381, x, y, z - 0.9, 0, 0, 0 ) --create an object which looks like a claymore
	setObjectScale(explObject,0.09)
	setElementAlpha(explObject,150)
	setElementCollisionsEnabled(explObject,false)
	local explCol = createColSphere ( x, y, z, 1 ) --create a collision sphere with radius 1
	setElementData ( explCol , "type", "explosive" ) --store the type of colshape so it can be retrieved
	setElementData ( explCol, "object", explObject ) --store the object of the claymore
	setElementData ( explCol, "creatorPlayer", creator ) --store the person who created it
end

function explodeTimedBomb (explCol)
	if isElement(explCol) and getElementData ( explCol, "type" ) == "timedbomb" then 
			local claymoreObject = getElementData ( explCol, "object" )
			local claymoreObject2 = getElementData ( explCol, "object2" )
			local claymoreCreator = getElementData ( explCol, "creatorPlayer" )
			--get the position of the claymore
			local x, y, z = getElementPosition ( explCol )
			createExplosion ( x, y, z-1, 7, claymoreCreator ) --create an explosion, associated to the creator
			createExplosion ( x+3, y, z+2, 11, claymoreCreator ) --create an explosion, associated to the creator
			createExplosion ( x, y+3, z+2, 11, claymoreCreator ) --create an explosion, associated to the creator
			createExplosion ( x-3, y, z+2, 11, claymoreCreator ) --create an explosion, associated to the creator
			createExplosion ( x, y-3, z+2, 11, claymoreCreator ) --create an explosion, associated to the creator
			--destroy the claymore object, and the col shape so it doesnt trigger again.
			destroyElement ( claymoreObject )
			destroyElement ( claymoreObject2 )
			destroyElement ( explCol )
	end
end

function createTimedBomb ( creator )
if not creator then creator = source end
	local x, y, z = getElementPosition ( creator )
	local explObject = createObject ( 1654, x, y, z - 0.9, 0, 0, 0 ) --create an object which looks like a claymore
	local explObjectBeacon = createObject ( 1213, x, y, z -0.9, 0, 0, 90 ) --create an object which looks like a claymore
	setElementAlpha(explObject,150)
	setElementAlpha(explObjectBeacon,0)
	setElementCollisionsEnabled(explObject,false)
	setElementCollisionsEnabled(explObjectBeacon,false)
	local explCol = createColSphere ( x, y, z, 1 ) --create a collision sphere with radius 1
	setElementData ( explCol , "type", "timedbomb" ) --store the type of colshape so it can be retrieved
	setElementData ( explCol, "object", explObject ) --store the object of the claymore
	setElementData ( explCol, "object2", explObjectBeacon ) --store the object of the claymore
	setElementData ( explCol, "creatorPlayer", creator ) --store the person who created it
	setTimer(explodeTimedBomb,20000,1,explCol)
end

function createIncendiaryTrap ( creator )
if not creator then creator = source end
	local x, y, z = getElementPosition ( creator )
	local incendiaryObject = createObject ( 2978, x, y, z - 1, 0, 0, 90 ) --create an object which looks like a claymore
	local incendiaryObject2 = createObject ( 1650, x, y, z - 1, 0, 0, 90 ) --create an object which looks like a claymore
	setObjectScale(incendiaryObject,0.2)
	setElementAlpha(incendiaryObject,150)
	setElementAlpha(incendiaryObject2,150)
	setElementCollisionsEnabled(incendiaryObject,false)
	setElementCollisionsEnabled(incendiaryObject2,false)
	local incendiaryCol = createColSphere ( x, y, z, 1 ) --create a collision sphere with radius 1
	setElementData ( incendiaryCol , "type", "incendiary" ) --store the type of colshape so it can be retrieved
	setElementData ( incendiaryCol, "object", incendiaryObject ) --store the object of the claymore
	setElementData ( incendiaryCol, "object2", incendiaryObject2 ) --store the object of the claymore
	setElementData ( incendiaryCol, "creatorPlayer", creator ) --store the person who created it
end

function createGlassTrap ( creator )
if not creator then creator = source end
	local x, y, z = getElementPosition ( creator )
	local glassObject = createObject ( 2978, x, y, z - 1, 0, 0, 90 ) --create a base
	local glassObject2 = createObject ( 325, x, y, z - 1, 0, 0, 90 ) --create a broken bottle
	setObjectScale(glassObject,0.2)
	setElementAlpha(glassObject,150)
	setElementAlpha(glassObject2,150)
	setElementCollisionsEnabled(glassObject,false)
	setElementCollisionsEnabled(glassObject2,false)
	local glassCol = createColSphere ( x, y, z, 1 ) --create a collision sphere with radius 1
	setElementData ( glassCol , "type", "glass" ) --store the type of colshape so it can be retrieved
	setElementData ( glassCol, "object", glassObject ) --store the object of the claymore
	setElementData ( glassCol, "object2", glassObject2 ) --store the object of the claymore
	setElementData ( glassCol, "creatorPlayer", creator ) --store the person who created it
end

addEvent("createMine",true)
addEvent("createTimeBomb",true)
addEvent("createIncendiaryTrap",true)
addEvent("createBleedingTrap",true)
addEventHandler("createBleedingTrap",root,createGlassTrap)
addEventHandler("createIncendiaryTrap",root,createIncendiaryTrap)
addEventHandler("createTimeBomb",root,createTimedBomb)
addEventHandler("createMine",root,createExplosiveTrap)


function reduceProjectileAmmo()
local weapslot8ammo = getPedTotalAmmo(source, 8)
local weapon = getPedWeapon(source,8)
--iprint("Proj ammo is: "..tostring(weapslot8ammo))
setWeaponAmmo(source,weapon,weapslot8ammo-1)
if weapslot8ammo == 0 then takeWeapon(source,weapon) end
end
addEvent("ReduceProjectileAmmo",true)
addEventHandler("ReduceProjectileAmmo",root,reduceProjectileAmmo)

function explTrapHit ( player )
	if isElement(source) and getElementData ( source, "type" ) == "explosive" then --ensure its a claymore
		--retrieve the object associated to the claymore, and who created it
		local claymoreObject = getElementData ( source, "object" )
		local claymoreCreator = getElementData ( source, "creatorPlayer" )
		--get the position of the claymore
		local x, y, z = getElementPosition ( source )
		createExplosion ( x, y, z-1, 12, claymoreCreator ) --create an explosion, associated to the creator, of a small size at the col's position
		--destroy the claymore object, and the col shape so it doesnt trigger again.
		destroyElement ( claymoreObject )
		destroyElement ( source )
	end
end
addEventHandler ( "onColShapeHit", getRootElement(), explTrapHit )

function incendTrapHit ( player )
	if isElement(source) and getElementData ( source, "type" ) == "incendiary" then --ensure its a claymore
		--retrieve the object associated to the claymore, and who created it
		local claymoreObject = getElementData ( source, "object" )
		local claymoreObject2 = getElementData ( source, "object2" )
		local claymoreCreator = getElementData ( source, "creatorPlayer" )
		--get the position of the claymore
		local x, y, z = getElementPosition ( source )
		createExplosion ( x, y, z-5, 1, claymoreCreator ) --create an explosion, associated to the creator, of a small size at the col's position
		--destroy the claymore object, and the col shape so it doesnt trigger again.
		setPedOnFire(player,true)
		setTimer(setPedOnFire,2000,1,player,true)
		destroyElement ( claymoreObject )
		destroyElement ( claymoreObject2 )
		destroyElement ( source )
	end
end
addEventHandler ( "onColShapeHit", getRootElement(), incendTrapHit )

function glassTrapHit ( player )
	if isElement(source) and getElementData ( source, "type" ) == "glass" then --ensure its a claymore
		--retrieve the object associated to the claymore, and who created it
		local claymoreObject = getElementData ( source, "object" )
		local claymoreObject2 = getElementData ( source, "object2" )
		local claymoreCreator = getElementData ( source, "creatorPlayer" )
		--get the position of the claymore
		local x, y, z = getElementPosition ( source )
		--createExplosion ( x, y, z, 9, claymoreCreator ) --create an explosion, associated to the creator, of a small size at the col's position
		--[[local sphere = createColSphere(x,y,z,50)
		local players = *getPlayersInsideSphere*(sphere)
		--etc to show it for all clients in sight]]
		if getElementType(player) == "player" or getElementType(player) == "ped" then
			triggerClientEvent(player,"GlassTrapEffects",player,player,x,y,z)
			local health = getElementHealth(player)
			setElementHealth(player,health-10)
			setPedAnimation(player,"ped","getup",3000,false,true,false,false)
			setPedWeaponSlot(player,0)
			playSound3DToElement(player,player,"sounds/bottlebreak.mp3",10,0.5)
			--destroy the claymore object, and the col shape so it doesnt trigger again.
			destroyElement ( claymoreObject )
			destroyElement ( claymoreObject2 )
			destroyElement ( source )
		end
	end
end
addEventHandler ( "onColShapeHit", getRootElement(), glassTrapHit )

--STOMPER ATTACHMENT
--original script by Redemtion

function recargar (player)
setPedAnimation(player, "BUDDY", "buddy_reload", 600, false)
end
addEvent("recargar", true)
addEventHandler("recargar", root, recargar)

addEvent("RocketFired",true)

function disposeOfLauncherTube()
if source and getElementType(source) == "player" then
local x,y,z = getElementPosition(client)
setTimer(setPedAnimation,800,1,client,"CARRY","putdwn05",500,false,false,false,false)
setTimer(takeWeapon,1100,1,client,35)
local temptube
local player = client
setTimer(function () temptube = createObject(359,x,y,z-0.95,0,0,math.random(0,359));setElementCollisionsEnabled(temptube,false); setElementAlpha(temptube,200); triggerClientEvent (player,"CleanRocketLauncher", player) end,1100,1)
setTimer(function() if isElement(temptube) then destroyElement(temptube); temptube = nil end end,5000,1)
end

end
addEventHandler("RocketFired",root,disposeOfLauncherTube)

-----Crossbow animation
function weaponSSwitch ( previousWeaponID, currentWeaponID )
local player = source
local name = getPlayerName(player)
	if currentWeaponID == 23 then 
	setPedWalkingStyle(source,62)
	else
	setPedWalkingStyle(source,0)
	end
end
addEventHandler ( "onPlayerWeaponSwitch", root, weaponSSwitch )


function setWalkAnimBack()
setPedWalkingStyle(source,0)
end
addEventHandler ( "onPlayerWasted", root, setWalkAnimBack )