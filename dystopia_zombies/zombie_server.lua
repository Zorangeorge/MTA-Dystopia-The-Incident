---TEMP UTIL, delete after merging zombie script
function table.random ( theTable ) 
    return theTable[math.random ( #theTable )]
end 
--

ZombieLimit = 60--get("zombies.MaxZombies")-- HOW MANY ZOMBIES SHOULD EXIST AT MAXIMUM?

ZombiePedSkins = {22,56,67,68,69,70,128,152,162,167,188,195,206,209,229,264,280}

zedWalkerSkins = {22,56,67,68,69,70,128,152,162,167,188,195,206,209,229,264,280}
zedRunnerSkins = {22,56,67,68,69,70,128,152,162,167,188,195,206,209,229,264,280}
zedBruteSkins = {277,128,264,167,67}
--local chaseanim = "run_old"
local checkspeed = 200--330--680
resourceRoot = getResourceRootElement()
moancount = 0
moanlimit = 10
everyZombie = { }

function getNight()
	if ( getTime()>=22 ) or ( getTime()<=9 ) then 
	return true
	else 
	return false
	end
end

function getZombieStreamMethodByDayTime ()
local zombiestreamingtype -- 1 to constantly stream zombies, 0 to only allow zombies to spawn via createZombie function, 2 to only allow spawning at set spawnpoints
	
	if getNight() then 
		zombiestreamingtype = 1
	else
		zombiestreamingtype = 0
	end
	
	return 
	zombiestreamingtype
end


-----------***********Zombie streaming method
ZombieStreaming = 0 --getZombieStreamMethodByDayTime ()--get("zombies.StreamMethod") -- 1 to constantly stream zombies, 0 to only allow zombies to spawn via createZombie function, 2 to only allow spawning at set spawnpoints
-----------***********

for theKey,ped in ipairs(everyZombie) do
    if ( getElementData ( source, "status" ) ==  "dead" ) then
                setTimer ( Zomb_delete, 10000, 1, source)
                
        else return
                
    end    

end    

--IDLE BEHAVIOUR OF A ZOMBIE
function Zomb_Idle (ped)
    if isElement(ped) then
        if ( getElementData ( ped, "status" ) == "idle" ) and ( isPedDead ( ped ) == false ) and (getElementData (ped, "zombie") == true) then
            local action = math.random( 1, 10 )
			
			if getElementData (ped,"walker") == true then zedtype = "walker"
			elseif getElementData (ped,"brute") == true then zedtype = "brute"
			elseif getElementData (ped,"runner") == true then zedtype = "runner"
			end
			
            if action <= 4 then -- walk a random direction
                local rndmangle = math.random( 1, 359 )
                setPedRotation( ped, rndmangle )
                setPedAnimation ( ped, "PED", "WALK_old", -1, true, true, true)
                setTimer ( Zomb_Idle, 5000, 1, ped )
			else 
			
				if zedtype == "brute" then
					if action < 7 then -- stand still doing nothing
					setPedAnimation ( ped, "WUZI", "Wuzi_stand_loop", -1, true, true, true  ) --BRUTE
					setTimer ( Zomb_Idle, 15000, 1, ped )
					elseif action < 10 then -- stand still doing nothing
					setPedAnimation ( ped, "FAT", "IDLE_tired", -1, true, true, true ) --BRUTE
					setTimer ( Zomb_Idle, 7000, 1, ped )
					elseif action == 10 then -- look around startled
					setPedAnimation ( ped, "ped", "flee_lkaround_01", -1, true, true, true ) --BRUTE,WALKER,RUNNER
					setTimer ( Zomb_Idle, 2000, 1, ped )
					end
				else
					if action == 5 then -- infected twitch
					setPedAnimation ( ped, "ped", "DAM_armR_frmBK", 6, false, true, true) --WALKER,RUNNER
					setTimer ( Zomb_Idle, 4000, 1, ped )
					elseif action == 6 then -- lay down
					setPedAnimation ( ped, "CRACK", "crckdeth2", -1, true, true, true ) --WALKER, RUNNER
					setTimer ( Zomb_Idle, 30000, 1, ped )
					elseif action == 7 then -- lay down
					setPedAnimation ( ped, "CRACK", "crckidle4", -1, true, true, true  ) --WALKER, RUNNER
					setTimer ( Zomb_Idle, 35000, 1, ped )
					elseif action == 8 then -- walk around
						if zedtype == "walker" then
						setPedAnimation ( ped, "ped", "WALK_drunk", -1, true, true, true ) --WALKER
						setTimer ( Zomb_Idle, 7000, 1, ped )
						else
						setPedAnimation ( ped, "BSKTBALL", "BBALL_react_miss", -1, true, true, true ) --RUNNER
						setTimer ( Zomb_Idle, 1500, 1, ped )
						end
						
					elseif action == 9 then -- infected twitch
					setPedAnimation ( ped, "ped", "DAM_LegL_frmFT", 6, true, true, true ) --WALKER,RUNNER
					setTimer ( Zomb_Idle, 6000, 1, ped )
					elseif action == 10 then -- look around startled
					setPedAnimation ( ped, "ped", "flee_lkaround_01", -1, true, true, true ) --WALKER,RUNNER
					setTimer ( Zomb_Idle, 2000, 1, ped )
					end
				end
			end
		end
	end
end

--[[addEvent("ZombieKicked",true)
function setZombieKicked ()
setElementData(source,"kicked",true,true)
end
addEventHandler("ZombieKicked",resourceRoot, setZombieKicked)

function stunnedSequence(ped)
--setPedAnimation ( ped )
setPedAnimation(ped, "SUNBATHE","Lay_bac_out",3000,false,true,false,true)
setElementData(ped,"kicked",false,true)
setTimer( backToHunt,3000,1,ped)
end

function backToHunt (ped)
setElementData(ped,"zombie",true,true)
setElementData(ped,"status","chasing")
end]]

--BEHAVIOUR WHILE CHASING PLAYERS
function Zomb_chase (ped, Zx, Zy, Zz )
   
   if isElement(ped) then
	
		local chaseanim
		
		if getNight() then --night anims
		
			if getElementData(ped,"walker") == true then 
				chaseanim = "Run_Wuzi" 
			elseif getElementData(ped,"runner") == true then 
				chaseanim = "sprint_panic" 
			else 
				chaseanim = "run_old"
			end
		else --day anims
			if getElementData(ped,"runner") == true then 
				chaseanim = "sprint_panic" 
			else 
				chaseanim = "run_old"
			end
		end
		
		if getElementData(ped,"incapacitated") == true and getElementData(ped,"brute") ~= true then
			chaseanim = "WALK_drunk"
		end
		
			
	
--[[		if (getElementData ( ped, "status" ) == "chasing") and (getElementData (ped, "zombie") == true) and (getElementData(ped,"kicked")== true )  then --and getDistanceBetweenPoints3D( getElementPosition(localPlayer), getElementPosition(ped) )<2
			setElementData(ped,"zombie","paused")
			setElementData(ped,"status","paused")
			setPedAnimation(ped, "FIGHT_E","Hit_fightkick_B",3000,false,true,true,true)
			setTimer( stunnedSequence,3000,1,ped)
			
		end]]
		
        if (getElementData ( ped, "status" ) == "chasing") and (getElementData (ped, "zombie") == true) then
		    local x, y, z = getElementPosition( ped )
            if (getElementData ( ped, "target" ) == nil) and getElementData ( ped, "Tx" ) ~= false then         
                local Px = getElementData ( ped, "Tx" )
                local Py = getElementData ( ped, "Ty" )
                local Pz = getElementData ( ped, "Tz" )
                local Pdistance = (getDistanceBetweenPoints3D( Px, Py, Pz, x, y, z ))
                if (Pdistance < 1.5 ) then
                    setTimer ( function (ped) if ( isElement ( ped ) ) then setElementData ( ped, "status", "idle" ) end end, 2000, 1, ped )
                end
            end
            local distance = (getDistanceBetweenPoints3D( x, y, z, Zx, Zy, Zz ))            
            if (distance < 1 ) then -- IF THE PED HASNT MOVED
                if (getElementData ( ped, "target" ) == nil) then
                    local giveup = math.random( 1, 15 )
                    if giveup == 1 then
                        setElementData ( ped, "status", "idle" )
                    else
                        local action = math.random( 1, 2 )
                        if action == 1 then
                            setPedAnimation ( ped )
                            triggerClientEvent ( "Zomb_Punch", getRootElement(), ped )
                            setTimer ( function (ped) if ( isElement ( ped ) ) then setPedAnimation ( ped, "ped", chaseanim, -1, true, true, true ) end end, 800, 1, ped )
                            setTimer ( Zomb_chase, 2000, 1, ped, x, y, z )
                        elseif action == 2 then
                            setPedAnimation ( ped )
                            triggerClientEvent ( "Zomb_Jump", getRootElement(), ped )
                            setTimer ( Zomb_chase, 3500, 1, ped, x, y, z )
                        end
                    end
                else 
                    local Ptarget = (getElementData ( ped, "target" ))
                    if isElement(Ptarget) then
                        local Px, Py, Pz = getElementPosition( Ptarget )
                        local Pdistance = (getDistanceBetweenPoints3D( Px, Py, Pz, Zx, Zy, Zz ))
                        if (Pdistance < 1.2 ) then -- ATTACK A PLAYER IF THEY ARE CLOSE
                            if ( isPedDead ( Ptarget ) ) then --EAT A DEAD PLAYER
                                setPedAnimation ( ped )
                                setPedAnimation ( ped, "ROB_BANK", "CAT_Safe_Rob", -1, true, false, false)
                                setTimer ( function (ped) if ( isElement ( ped ) ) then setElementData ( ped, "status", "idle" ) end end, 10000, 1, ped )
                                setTimer ( function (ped) if ( isElement ( ped ) ) then setPedRotation ( ped, getPedRotation(ped)-180) end end, 10000, 1, ped )
                                zmoan(ped)
                            else
                                local action = math.random( 1, 6 )
                                if action == 1 then
                                    setPedAnimation ( ped)
                                    triggerClientEvent ( "Zomb_Jump", getRootElement(), ped )
                                    setTimer ( Zomb_chase, 2000, 1, ped, x, y, z )
                                else
                                    setPedAnimation ( ped)
                                    triggerClientEvent ( "Zomb_Punch", getRootElement(), ped )
                                    setTimer ( function (ped) if ( isElement ( ped ) ) then setPedAnimation ( ped, "ped", chaseanim, -1, true, true, true ) end end, 800, 1, ped )
                                    setTimer ( Zomb_chase, 2000, 1, ped, x, y, z )
                                end
                            end
                        else
                            if ( isPedDead (Ptarget) ) then
                            setTimer ( function (ped) if ( isElement ( ped ) ) then setElementData ( ped, "status", "idle" ) end end, 2000, 1, ped )
                            setTimer ( function (ped) if ( isElement ( ped ) ) then setPedRotation ( ped, getPedRotation(ped)-180) end end, 1800, 1, ped )
                            else
                                local action = math.random( 1, 2 )
                                if action == 1 then
                                    setPedAnimation ( ped)
                                    triggerClientEvent ( "Zomb_Punch", getRootElement(), ped )
                                    setTimer ( function (ped) if ( isElement ( ped ) ) then setPedAnimation ( ped, "ped", chaseanim, -1, true, true, true ) end end, 800, 1, ped )
                                    setTimer ( Zomb_chase, 2000, 1, ped, x, y, z )
                                elseif action == 2 then
                                    setPedAnimation ( ped)
                                    triggerClientEvent ( "Zomb_Jump", getRootElement(), ped )
                                    setTimer ( Zomb_chase, 2000, 1, ped, x, y, z )
                                end
                            end
                        end
                    else
                        setElementData ( ped, "status", "idle" )
                    end
                end
            else
                setPedAnimation ( ped, "ped", chaseanim, -1, true, true, true) --KEEP WALKING
                setTimer ( Zomb_chase, checkspeed, 1, ped, x, y, z ) --CHECK AGAIN
            end
        end
    end
end

--SET THE DIRECTION OF THE ZOMBIE
function setangle ()
    for theKey,ped in ipairs(everyZombie) do
        if isElement(ped) then
            if ( getElementData ( ped, "status" ) == "chasing" ) then
                local x
                local y
                local z
                local px
                local py
                local pz
                if ( getElementData ( ped, "target" ) ~= nil ) then
                    local ptarget = getElementData ( ped, "target" )
                    if isElement(ptarget) then
                        x, y, z = getElementPosition( ptarget )
                        px, py, pz = getElementPosition( ped )
                    else
                        setElementData ( ped, "status", "idle" )
                        x, y, z = getElementPosition( ped )
                        px, py, pz = getElementPosition( ped )
                    end
                    zombangle = ( 360 - math.deg ( math.atan2 ( ( x - px ), ( y - py ) ) ) ) % 360 --MAGIC SPELL TO MAKE PEDS LOOK AT YOU
                    setPedRotation( ped, zombangle )
                elseif ( getElementData ( ped, "target" ) == nil ) and (getElementData ( ped, "Tx" ) ~= false) then --IF THE PED IS AFTER THE PLAYERS LAST KNOWN WHEREABOUTS
                    x = getElementData ( ped, "Tx" )
                    y = getElementData ( ped, "Ty" )
                    z = getElementData ( ped, "Tz" )
                    px, py, pz = getElementPosition( ped )
                    zombangle = ( 360 - math.deg ( math.atan2 ( ( x - px ), ( y - py ) ) ) ) % 360 --MAGIC SPELL TO MAKE PEDS LOOK AT YOU
                    setPedRotation( ped, zombangle )
                end
            end
        end
    end
end

--SETS THE ZOMBIE ACTIVITY WHEN STATUS CHANGES
addEventHandler ( "onElementDataChange", getRootElement(),
function ( dataName )
    if getElementType ( source ) == "ped" and dataName == "status" then
        if (getElementData (source, "zombie") == true) then
            if ( isPedDead ( source ) == false ) then
                if (getElementData ( source, "status" ) ==  "chasing" ) then
                    local Zx, Zy, Zz = getElementPosition( source )
                    setTimer ( Zomb_chase, 1000, 1, source, Zx, Zy, Zz )
                    local newtarget = (getElementData ( source, "target" ))
                    if isElement (newtarget) then
                        if getElementType ( newtarget ) == "player" then
                            setElementSyncer ( source, newtarget )
                        end
                    end
                    zmoan(source)
                elseif (getElementData ( source, "status" ) ==  "idle" ) then
                    setTimer ( Zomb_Idle, 1000, 1, source)
                elseif (getElementData ( source, "status" ) ==  "throatslashing" ) then
                    local tx,ty,tz = getElementPosition( source )
                    local ptarget = getElementData ( source, "target" )
                    if isElement(ptarget) then
                        local vx,vy,vz = getElementPosition( ptarget )
                        local zombdistance = (getDistanceBetweenPoints3D (tx, ty, tz, vx, vy, vz))
                        if (zombdistance < 1) then
                            zmoan(source)
                            --[[setPedAnimation ( source, "knife", "KILL_Knife_Player", -1, false, false, true)
                            setPedAnimation ( ptarget, "knife", "KILL_Knife_Ped_Damage", -1, false, false, true)]]
							setPedAnimation ( source, "knife", "KILL_Knife_Player", -1, false, false, true)
                            setPedAnimation ( ptarget, "ped", "KILL_Knife_Ped_Damage", -1, false, false, true)
                            setTimer ( setPedAnimation, 1200, 1, ptarget) 
                            setTimer ( Playerthroatbitten, 2300, 1, ptarget, source) 
                            setTimer ( function (source) if ( isElement ( source ) ) then setElementData ( source, "status", "idle" ) end end, 5000, 1, source )
                        else
                            setElementData ( source, "status", "idle" )
                        end
                    else
                        setElementData ( source, "status", "idle" )
                    end
                end
            elseif (getElementData ( source, "status" ) ==  "dead" ) then
                setTimer ( Zomb_delete, 120000, 1, source) -- DEAD ZOMBIE DELETION TIMER
            end
        end
    end
end)

--RESOURCE START/INITIAL SETUP
function outbreak(startedResource)
    newZombieLimit = get("" .. getResourceName(startedResource) .. ".Zlimit")
    if newZombieLimit ~= false then
        if newZombieLimit > ZombieLimit then 
            newZombieLimit = ZombieLimit
        end
    else
        newZombieLimit = ZombieLimit
    end
    WoodTimer = setTimer ( WoodSetup, 2000, 1) -- CHECKS FOR BARRIERS
    if startedResource == getThisResource() then
--      call(getResourceFromName("scoreboard"), "scoreboardAddColumn", "Zombie kills") --ADDS TO SCOREBOARD
        local allplayers = getElementsByType ( "player" )
        for pKey,thep in ipairs(allplayers) do
            setElementData ( thep, "dangercount", 0 )
        end 
        local alivePlayers = getAlivePlayers ()
        for playerKey, playerValue in ipairs(alivePlayers) do
            setElementData ( playerValue, "alreadyspawned", true  )
        end
        if ZombieSpeed == 2 then
            MainTimer1 = setTimer ( setangle, 200, 0) -- KEEPS ZOMBIES FACING THE RIGHT DIRECTION (fast)
        else
            MainTimer1 = setTimer ( setangle, 400, 0) -- KEEPS ZOMBIES FACING THE RIGHT DIRECTION
        end
        MainTimer3 = setTimer ( clearFarZombies, 3000, 0) --KEEPS ALL THE ZOMBIES CLOSE TO PLAYERS  
        if ZombieStreaming == 1 then
            MainTimer2 = setTimer ( SpawnZombie, 2500, 0 ) --Spawns zombies in random locations
        elseif ZombieStreaming == 2 then
            MainTimer2 = setTimer ( SpawnpointZombie, 2500, 0 ) --spawns zombies in zombie spawnpoints
        end
    end
end
addEventHandler("onResourceStart", getRootElement(), outbreak)

function player_Connect()
    setElementData ( source, "dangercount", 0 )
end
addEventHandler ( "onPlayerConnect", getRootElement(), player_Connect )

function WoodSetup()
    local allcols = getElementsByType ( "colshape" ) --clears off old wood cols
    for colKey, colValue in ipairs(allcols) do
        if ( getElementData ( colValue, "purpose" ) =="zombiewood" ) then
            destroyElement(colValue)
        end
    end 
    local allobjects = getElementsByType ( "object" ) --SETS UP ALL THE WOOD BARRIERS
    for objectKey, objectValue in ipairs(allobjects) do
        if ( getElementData ( objectValue, "purpose" ) =="zombiewood" ) then
            setElementDimension ( objectValue, 26 )
            local x,y,z = getElementPosition( objectValue )
            local thecol = createColSphere ( x, y, z, 1.6 )
            setElementData ( thecol, "purpose", "zombiewood" )
            setElementParent ( thecol, objectValue )
        end
    end 
end

function ReduceMoancount()
    moancount = moancount-1
end

function zmoan(zombie)
    if moancount < moanlimit then
        moancount = moancount+1
        local randnum = math.random( 1, 8 )
        triggerClientEvent ( "Zomb_Moan", getRootElement(), zombie, randnum )
        setTimer ( ReduceMoancount, 800, 1 )
    end
end

--CLEARS A DEAD ZOMBIE
function Zomb_delete (ped)
    if isElement(ped) then
        if (getElementData (ped, "zombie") == true) then
            for theKey,thePed in ipairs(everyZombie) do
                if ped == thePed then
                    table.remove( everyZombie, theKey )
                    break
                end
            end
            destroyElement ( ped )
        end
    end
end

addEvent("MorphedZombieRemoval",true)
function MorphedZomb_delete (ped)
    if isElement(ped) then
        if (getElementData (ped, "zombie") == true) then
            for theKey,thePed in ipairs(everyZombie) do
                if ped == thePed then
                    table.remove( everyZombie, theKey )
                    break
                end
            end
            destroyElement ( ped )
        end
    end
end
addEventHandler("MorphedZombieRemoval",root,MorphedZomb_delete)
--HEADSHOTS
addEvent( "headboom", true )
function Zheadhit ( ped,attacker, weapon, bodypart)
    if (getElementData (ped, "zombie") == true) then
        killPed ( ped, attacker, weapon, bodypart )
        setPedHeadless  ( ped, true )
		triggerClientEvent(root, "sync.message", ped, ped, 240, 125, 0, "HEADSHOT!")
    end
end
addEventHandler( "headboom", getRootElement(), Zheadhit )

--KILL FROM ZOMBIE ATTACK
addEvent( "playereaten", true )
function Playerinfected ( player, attacker, weapon, bodypart)
    killPed ( player, attacker, weapon, bodypart )
end
addEventHandler( "playereaten", getRootElement(), Playerinfected )

--CHECKS FOR ZOMBIE GRABBING FROM BEHIND
function Playerthroatbitten ( player, attacker)
if isPedInVehicle(player) and getVehicleType(getPedOccupiedVehicle(player)) ~= "Bike" then return end
    local Zx, Zy, Zz = getElementPosition( attacker )
    local Px, Py, Pz = getElementPosition( player )
	local playerHealth = getElementHealth(player)
    local distance = (getDistanceBetweenPoints3D( Px, Py, Pz, Zx, Zy, Zz ))
    if (distance < 1) then
		if isPedInVehicle(player) and getVehicleType(getPedOccupiedVehicle(player)) == "Bike" then
		--[[nada]]
		else
		setPedAnimation (player,"ped", "CAR_crawloutRHS", 2000, false, true, true,false) 
		end
		
		if playerHealth >= 30 then setElementHealth(player,playerHealth-30) else killPed(player) end
			if getElementData(player,"infection")== false or getElementData(player,"infection")== "uninfected" then 
			--outputDebugString("Infected!")
			triggerClientEvent(player, "onInfected", player)
			
			
			else 
			--outputDebugString("Already infected")
			end
        
    else
        setPedAnimation (player)
    end
end



--[[function infectionsymptoms(data,oldvalue)--------------zzzzzzzzzzz
if data == "infection" then
if getElementData ( source, "infection") == "stage1" then
outputChatBox("infected checked",source)
triggerClientEvent("Stage1infection", source)
--infectionstage1shader = guiCreateStaticImage( 0, 0, screenX, screenY, "shaders/infectionstage1shader.png", false )
end --shader
end
addEventHandler("onElementDataChange", resourceRoot, infectionsymptoms) ]]


--ADJUSTS PLAYERS ZOMBIE KILL SCORE
function deanimated( ammo, attacker, weapon, bodypart )
    if (attacker) then
        if (getElementType ( attacker ) == "player") and (getElementType ( source ) == "ped") then
            if (getElementData (source, "zombie") == true) then
                local oldZcount = getElementData ( attacker, "Zombie kills" )
                if oldZcount ~= false then
                    setElementData ( attacker, "Zombie kills", oldZcount+1  )
                    triggerEvent ( "onZombieWasted", source, attacker, weapon, bodypart )
                else
                    setElementData ( attacker, "Zombie kills", 1  )
                    triggerEvent ( "onZombieWasted", source, attacker, weapon, bodypart ) 
					setElementData ( source, "zombie", false  ) --might block the loot drop? depends on which bit gets run first? hell knows..
                end
            end
        end
    end
end
addEventHandler("onPedWasted", resourceRoot, deanimated)





--STUFF TO ALLOW PLAYERS TO PLACE BOARDS
function boarditup( player, key, keyState )
    local rightspot = 0
    local allcols = getElementsByType ( "colshape" )
    for ColKey,theCol in ipairs(allcols) do
        if (getElementData ( theCol, "purpose" ) == "zombiewood" ) then
            if (isElementWithinColShape ( player, theCol )) then
                local rightcol = theCol
                local Cx, Cy, Cz = getElementPosition( rightcol )
                local Bx, By, Bz = getElementPosition( player )
                woodangle = ( 360 - math.deg ( math.atan2 ( ( Cx - Bx ), ( Cy - By ) ) ) ) % 360
                setPedRotation( player, woodangle )
                setPedAnimation(player, "riot", "RIOT_PUNCHES", 3000, true, true, true )
                local wx, wy, wz = getElementPosition( player )
                setTimer( doneboarding, 2000, 1, player, rightcol, wx, wy, wz )
            end
        end
    end
end
addCommandHandler ( "construct", boarditup )
    
function doneboarding(player, rightcol, wx, wy, wz)
    setPedAnimation(player)
    local newx, newy, newz = getElementPosition( player )
    local distance = (getDistanceBetweenPoints3D( wx, wy, wz, newx, newy, newz ))           
    if (distance < .7 ) then
        newwood = getElementParent ( rightcol )
        setElementDimension ( newwood, 25 )
        setTimer( setElementDimension, 50, 1, newwood, 0)
    end
end

--[[ZCityNameList = {    
					"Tierra Robada",
                    "Bone County",
                    "Las Venturas",
                    "San Fierro",
                    "Red County",
                    "Whetstone",
                    "Flint County",
                    "Los Santos",
                }]]

--SPAWN ZOMBIE (now can be cancelled!)

addEvent( "onZombieSpawn", true )
function RanSpawn_Z ( gx, gy, gz, rot)
    
	local safezone = 0
    local allradars = getElementsByType("radararea")
    for theKey,theradar in ipairs(allradars) do
        if getElementData(theradar, "safeAreas") == true then
            if isInsideRadarArea ( theradar, gx, gy ) then
                safezone = 1
            end
        end
    end
	
    if safezone == 0 then
        if table.getn ( everyZombie ) < newZombieLimit and table.getn ( everyZombie )/ table.getn ( getElementsByType("player") ) < 4 then -- this is the max number of zombies spawning for every player, up tot the total zombie limit; NEED TO COME UP WITH A BETTER FORMULA -- original: if table.getn ( everyZombie ) < newZombieLimit then ---***
            if not rot then
                rot = math.random (1,359)
            end
            randomZskin = math.random ( 1, table.getn ( ZombiePedSkins ) )
					
					local therandomskin = ZombiePedSkins[randomZskin] --add checks for certain skins
					if therandomskin == 277 or therandomskin == 128 or therandomskin == 264 or therandomskin == 167 or therandomskin == 67 then
					zombSpec = "brute"
					else 
						local dicenum = math.random(1,5)
						if dicenum == 5 then
						zombSpec = "runner"
						else
						zombSpec = "walker"
						if getNight() then chaseanim = "Run_Wuzi" else chaseanim = "run_old" end
						end
					end
			
				--if zombSpec is not runner and outsidePopulatedArea then return end
            local zomb = createPed( tonumber( ZombiePedSkins[randomZskin] ), gx, gy, gz )
			--local outsidePopulatedArea = 0
			local zonename = getElementZoneName(zomb,true)
			if (zonename ~= "Los Santos" and zonename ~= "San Fierro" and zonename ~= "Las Venturas") and zombSpec ~= "runner" then 
				local randnum = math.random(1,100000)
				if randnum ~=7 then
				destroyElement(zomb); --outputDebugString("zed deleted")
				return 
				else
				outputDebugString("ZED runner spawned!")
				end
			end

			
				if zombSpec == "brute" then
					if math.random(1,2) == 2 then
					triggerClientEvent("MorphZombieUP",root,zomb)
					setElementData(zomb,"brute",true) 
					setPedArmor(zomb,100)
					setElementHealth(zomb,200)
					chaseanim = "run_old"
					end
				elseif zombSpec == "runner" then
					triggerClientEvent("MorphZombieDOWN",root,zomb)
					setElementData(zomb,"runner",true)
					setElementHealth(zomb,50)
					chaseanim = "sprint_panic"
				elseif zombSpec == "walker" then
					setElementData(zomb,"walker",true)
					chaseanim = "run_old"
				end
				
            setPedFightingStyle (zomb, 16)
            if zomb ~= false then
                setElementData ( zomb, "zombie", true  )
                table.insert( everyZombie, zomb )   
                setTimer ( function (zomb, rot) if ( isElement ( zomb ) ) then setPedRotation ( zomb, rot ) end end, 500, 1, zomb, rot )
                setTimer ( function (zomb) if ( isElement ( zomb ) ) then setPedAnimation ( zomb, "ped", chaseanim, -1, true, true, true ) end end, 1000, 1, zomb )
                setTimer ( function (zomb) if ( isElement ( zomb ) ) then setElementData ( zomb, "status", "idle" ) end end, 2000, 1, zomb )
                triggerClientEvent ( "Zomb_STFU", getRootElement(), zomb )
            end
        end
    end
	
end
addEventHandler( "onZombieSpawn", getRootElement(), RanSpawn_Z )


--SPAWNS ZOMBIES RANDOMLY NEAR PLAYERS
function SpawnZombie ()
    local pacecount = 0
    while pacecount < 2 do  --1 ZOMBIE AT A TIME
        if (table.getn( everyZombie )+pacecount < newZombieLimit ) and (ZombieStreaming == 1) then  
            local xcoord = 0
            local ycoord = 0
            local xdirection = math.random(1,2)
            if xdirection == 1 then
                xcoord = math.random(15,40)
            else
                xcoord = math.random(-40,-15)
            end
            local ydirection = math.random(1,2)
            if ydirection == 1 then
                ycoord = math.random(15,40)
            else
                ycoord = math.random(-40,-15)
            end
            local liveplayers = getAlivePlayers ()
            if (table.getn( liveplayers ) > 0 ) then
                local lowestcount = 99999
                local lowestguy = nil
                for PKey,thePlayer in ipairs(liveplayers) do
                    if isElement(thePlayer) then
                        if (getElementData (thePlayer, "dangercount")) and (getElementData(thePlayer, "safeAreas") ~= true) and (getElementData(thePlayer, "alreadyspawned" ) == true) then
                            if (getElementData (thePlayer, "dangercount") < lowestcount) then
                                local safezone = 0
                                local gx, gy, gz = getElementPosition( thePlayer )
                                local allradars = getElementsByType("radararea")
                                for theKey,theradar in ipairs(allradars) do
                                    if getElementData(theradar, "safeAreas") == true then
                                        if isInsideRadarArea ( theradar, gx, gy ) then
                                            safezone = 1
                                        end
                                    end
                                end
                                if safezone == 0 then
                                    lowestguy = thePlayer
                                    lowestcount = getElementData (thePlayer, "dangercount")
                                end
                            end
                        end
                    end
                end
                pacecount = pacecount+1
                if isElement(lowestguy) then
                    triggerClientEvent ( "Spawn_Placement", lowestguy, ycoord, xcoord )
                else
                    pacecount = pacecount+1
                end
            else
                pacecount = pacecount+1
            end
        else
            pacecount = pacecount+1
        end
    end
end

--SPAWNS ZOMBIES IN SPAWNPOINTS NEAR PLAYERS
function SpawnpointZombie ()
    local pacecount = 0
    while pacecount < 2 do  --5 ZOMBIES AT A TIME TO PREVENT FPS DROP
        if (table.getn( everyZombie )+pacecount < newZombieLimit ) and (ZombieStreaming == 2) then  
            local liveplayers = getAlivePlayers ()
            if (table.getn( liveplayers ) > 0 ) then
                local lowestcount = 99999
                local lowestguy = nil
                for PKey,thePlayer in ipairs(liveplayers) do --THIS PART GETS THE PLAYER WITH THE LEAST ZOMBIES ATTACKING
                    if (getElementData (thePlayer, "dangercount")) and (getElementData(thePlayer, "safeAreas") ~= true) then
                        if (getElementData (thePlayer, "dangercount") < lowestcount) then
                            lowestguy = thePlayer
                            lowestcount = getElementData (thePlayer, "dangercount")
                        end
                    end
                end
                if isElement(lowestguy) then
                    local zombiespawns = { }
                    local possiblezombies = getElementsByType ( "Zombie_spawn" )
                    local Px, Py, Pz = getElementPosition( lowestguy )
                    for ZombKey,theZomb in ipairs(possiblezombies) do
                        local Zx, Zy, Zz = getElementPosition( theZomb )
                        local distance = (getDistanceBetweenPoints3D( Px, Py, Pz, Zx, Zy, Zz ))
                        if (distance < 8) then
                            table.remove( possiblezombies, ZombKey) --IF SPAWN IS TOO CLOSE TO ANY PLAYER
                        end
                    end
                    local Px, Py, Pz = getElementPosition( lowestguy )
                    for ZombKey2,theZomb2 in ipairs(possiblezombies) do
                        local Zx, Zy, Zz = getElementPosition( theZomb2 )
                        local distance = (getDistanceBetweenPoints3D( Px, Py, Pz, Zx, Zy, Zz ))
                        if (distance < 60) then --AS LONG AS THE SPAWN IS CLOSE ENOUGH TO A PLAYER
                            table.insert( zombiespawns, theZomb2 )
                        end
                    end
                    if (table.getn( zombiespawns ) > 0 ) then--IF THE LOWEST PLAYER HAS ANY CLOSE SPAWNS,USE ONE
                        local random = math.random ( 1, table.getn ( zombiespawns ) )
                        local posX = getElementData(zombiespawns[random], "posX") 
                        local posY = getElementData(zombiespawns[random], "posY") 
                        local posZ = getElementData(zombiespawns[random], "posZ")
                        local rot = getElementData(zombiespawns[random], "rotZ")
                        pacecount = pacecount+1
                        triggerEvent ( "onZombieSpawn",zombiespawns[random], posX, posY, posZ, rot )            
                    else--IF THE LOWEST PLAYERS DOESNT HAVE ANY SPAWNS, THEN SEE IF ANYONE HAS ANY
                        local zombiespawns = { }
                        local possiblezombies = getElementsByType ( "Zombie_spawn" )
                        local allplayers = getAlivePlayers ()
                        for theKey,thePlayer in ipairs(allplayers) do
                            local Px, Py, Pz = getElementPosition( thePlayer )
                            for ZombKey,theZomb in ipairs(possiblezombies) do
                                local Zx, Zy, Zz = getElementPosition( theZomb )
                                local distance = (getDistanceBetweenPoints3D( Px, Py, Pz, Zx, Zy, Zz ))
                                if (distance < 8) then
                                    table.remove( possiblezombies, ZombKey) --IF SPAWN IS TOO CLOSE TO ANY PLAYER
                                end
                            end
                        end
                        for theKey,thePlayer in ipairs(allplayers) do
                            local Px, Py, Pz = getElementPosition( thePlayer )
                            for ZombKey2,theZomb2 in ipairs(possiblezombies) do
                                local Zx, Zy, Zz = getElementPosition( theZomb2 )
                                local distance = (getDistanceBetweenPoints3D( Px, Py, Pz, Zx, Zy, Zz ))
                                if (distance < 60) then --AS LONG AS THE SPAWN IS CLOSE ENOUGH TO A PLAYER
                                    table.insert( zombiespawns, theZomb2 )
                                end
                            end
                        end
                        if (table.getn( zombiespawns ) >1 ) then
                            local random = math.random ( 1, table.getn ( zombiespawns ) )
                            local posX = getElementData(zombiespawns[random], "posX") 
                            local posY = getElementData(zombiespawns[random], "posY") 
                            local posZ = getElementData(zombiespawns[random], "posZ")
                            local rot = getElementData(zombiespawns[random], "rotZ")
                            pacecount = pacecount+1
                            triggerEvent ( "onZombieSpawn",zombiespawns[random], posX, posY, posZ, rot )            
                        else
                            pacecount = pacecount+1
                        end
                    end
                else
                    pacecount = pacecount+1
                end
            else
                pacecount = pacecount+1
            end
        else
            pacecount = pacecount+1
        end
    end
end

--DELETES ZOMBIES THAT ARE TOO FAR FROM ANY PLAYERS TO KEEP THEM MORE CONCENTRATED WHILE STREAMING ZOMBIES
function clearFarZombies ()
    if newZombieLimit ~= false then
        local toofarzombies = { }
        local allplayers = getElementsByType ( "player" )
        for ZombKey,theZomb in ipairs(everyZombie) do
            if isElement(theZomb) then
                if (getElementData (theZomb, "zombie") == true) then
                    far = 1
                    local Zx, Zy, Zz = getElementPosition( theZomb )
                    for theKey,thePlayer in ipairs(allplayers) do
                        local Px, Py, Pz = getElementPosition( thePlayer )
                        local distance = (getDistanceBetweenPoints3D( Px, Py, Pz, Zx, Zy, Zz ))
                        if (distance < 75) then
                            far = 0
                        end
                    end
                    if far == 1 then
                        table.insert( toofarzombies, theZomb )
                    end
                end
            else
                table.remove( everyZombie, ZombKey )
            end
        end
        if (table.getn( toofarzombies ) >1 ) then
            for ZombKey,theZomb in ipairs(toofarzombies) do
                if (getElementData (theZomb, "zombie") == true) and  ( getElementData ( theZomb, "forcedtoexist" ) ~= true) then
                    Zomb_delete (theZomb)
                end
            end
        end
    end
end

-- DESTROYS UP TO 13 ZOMBIES THAT ARE IDLE WHEN A PLAYER SPAWNS (TO FORCE NEW ZOMBIES TO SPAWN NEAR THE NEW GUY)
function player_Spawn ()
    if ZombieStreaming == 1 or ZombieStreaming == 2 then
        local relocatecount = 0
        for ZombKey,theZomb in ipairs(everyZombie) do
            if relocatecount < 14 then
                if ( getElementData ( theZomb, "forcedtoexist" ) ~= true) then
                    if ( getElementData ( theZomb, "status" ) == "idle" ) and ( isPedDead ( theZomb ) == false ) and (getElementData (theZomb, "zombie") == true) then
                        relocatecount = relocatecount+1
                        Zomb_delete (theZomb)
                    end
                end
            end
        end
    end
    if ( getElementData ( source, "alreadyspawned" ) ~= true) then
        setElementData ( source, "alreadyspawned", true  )
    end
end
addEventHandler ( "onPlayerSpawn", getRootElement(), player_Spawn )

--EXPORTED FUNCTIONS!!!!!!!!!!!!!!
--[[
function createZombie ( _,x, y, z, rot, skin, interior, dimension )
outputDebugString("createZombie() triggered")
    if (table.getn( everyZombie ) < newZombieLimit ) then
    --this part handles the args
        if not x then return false end
        if not y then return false end
        if not z then return false end
        if not rot then
            rot = math.random (1,359)
        end
        if not skin then
            randomZskin = math.random ( 1, table.getn ( ZombiePedSkins ) )          
            skin = ZombiePedSkins[randomZskin]
        end
		
        if not interior then interior = 0 end
        if not dimension then dimension = 0 end
    --this part spawns the ped
        local zomb = createPed (tonumber(skin),tonumber(x),tonumber(y),tonumber(z))--spawns the ped
    --if successful, this part applies the zombie settings/args
        if (zomb ~= false) then
            setTimer ( setElementInterior, 100, 1, zomb, tonumber(interior)) --sets interior
            setTimer ( setElementDimension, 100, 1, zomb, tonumber(dimension)) --sets dimension
            setElementData ( zomb, "zombie", true  )
            setElementData ( zomb, "forcedtoexist", true  )
            setTimer ( function (zomb, rot) if ( isElement ( zomb ) ) then setPedRotation ( zomb, rot ) end end, 500, 1, zomb, rot )
            setTimer ( function (zomb) if ( isElement ( zomb ) ) then setElementData ( zomb, "status", "idle" ) end end, 2000, 1, zomb )
            setTimer ( function (zomb) if ( isElement ( zomb ) ) then setElementData ( zomb, "forcedtoexist", true ) end end, 1000, 1, zomb )
            setTimer ( function (zomb) if ( isElement ( zomb ) ) then table.insert( everyZombie, zomb ) end end, 1000, 1, zomb )
            triggerClientEvent ( "Zomb_STFU", getRootElement(), zomb )
            return zomb --returns the zombie element
        else
            return false --returns false if there was a problem
        end
    else
        return false --returns false if there was a problem
    end
end
]]

function createZombie (zedType,x,y,z,rot)
            
			if not rot then
                rot = math.random (1,359)
            end
			
			local skin
			
			if zedType == "Walker" then 
			skin = table.random(zedWalkerSkins)
			elseif zedType == "Runner" then 
			skin = table.random(zedRunnerSkins)
			elseif zedType == "Brute" then 
			skin = table.random(zedBruteSkins)
			else
			skin = math.random ( 1, table.getn ( ZombiePedSkins ) )
			outputDebugString("random zombie skin assigned")
			end
			
			local zombSpec = string.lower(zedType)
			
			if getNight() and zombSpec == "walker" then chaseanim = "Run_Wuzi" else chaseanim = "run_old" end

            local zomb = createPed( skin, x,y,z )
			
				if zombSpec == "brute" then
					triggerClientEvent("MorphZombieUP",root,zomb)
					setElementData(zomb,"brute",true) 
					setPedArmor(zomb,100)
					setElementHealth(zomb,200)
					chaseanim = "run_old"
				elseif zombSpec == "runner" then
					triggerClientEvent("MorphZombieDOWN",root,zomb)
					setElementData(zomb,"runner",true)
					setElementHealth(zomb,50)
					chaseanim = "sprint_panic"
				elseif zombSpec == "walker" then
					setElementData(zomb,"walker",true)
					chaseanim = "run_old"
				end
				
            setPedFightingStyle (zomb, 16)
			
			if zomb ~= false then
				setElementData ( zomb, "zombie", true )
				table.insert( everyZombie, zomb )   
				setTimer ( function (zomb, rot) if ( isElement ( zomb ) ) then setPedRotation ( zomb, rot ) end end, 500, 1, zomb, rot )
				setTimer ( function (zomb) if ( isElement ( zomb ) ) then setPedAnimation ( zomb, "ped", chaseanim, -1, true, true, true ) end end, 1000, 1, zomb )
				setTimer ( function (zomb) if ( isElement ( zomb ) ) then setElementData ( zomb, "status", "idle" ) end end, 2000, 1, zomb )
				--setTimer ( setElementInterior, 100, 1, zomb, tonumber(interior)) --sets interior
				--setTimer ( setElementDimension, 100, 1, zomb, tonumber(dimension)) --sets dimension
				setElementData ( zomb, "zombie", true  )
				setElementData ( zomb, "forcedtoexist", true  )
				setTimer ( function (zomb) if ( isElement ( zomb ) ) then setElementData ( zomb, "forcedtoexist", true ) end end, 1000, 1, zomb )
				setTimer ( function (zomb) if ( isElement ( zomb ) ) then table.insert( everyZombie, zomb ) end end, 1000, 1, zomb )
				triggerClientEvent ( "Zomb_STFU", getRootElement(), zomb )
				return zomb --returns the zombie element
			else
				return false --returns false if there was a problem
			end
					
end

--check if a ped is a zombie or not
function isPedZombie(ped)
    if (isElement(ped)) then
        if (getElementData (ped, "zombie") == true) then
            return true
        else
            return false
        end
    else
        return false
    end
end

addEvent( "onZombieLostPlayer", true )
function ZombieTargetCoords ( x,y,z )
	setPedAnimation ( source, "ped", "flee_lkaround_01", -1, true, true, true )
    setElementData ( source, "Tx", x, false )
    setElementData ( source, "Ty", y, false )
    setElementData ( source, "Tz", z, false )
	triggerClientEvent(root, "sync.message", source, source, 125, 125, 125, "HUH?!")
end
addEventHandler( "onZombieLostPlayer", getRootElement(), ZombieTargetCoords )

addEvent("BruteStomp",true)

function bruteStomp(ped)
setPedAnimation(ped,"CHAINSAW","CSAW_1",1000,false, true, false, false)
local x,y,z = getElementPosition(ped)
local kickcol = createColSphere(0,0,0,1)
	triggerClientEvent(root, "sync.message", ped, ped, 125, 125, 125, "STOMP!")

			attachElements(kickcol,ped,0,1,0)
			x,y,z = getElementPosition(kickcol)
			destroyElement(kickcol)
			kickcol = createColSphere(x,y,z,1)
			--local pedsHit = getElementsWithinColShape(kickcol,"ped")
			local playersHit = getElementsWithinColShape(kickcol,"player")
			local pedsHit = getElementsWithinColShape(kickcol,"ped")
			
			for k,target in ipairs(playersHit) do
				setPedAnimation(target)
				setPedAnimation(target, "FIGHT_B","HitB_2",600,false,true,false,true)
				setTimer(setPedAnimation,600,1,target, "FIGHT_E","Hit_fightkick_B",3000,false,true,true,true)
					
				setElementData(target,"incapacitated",true,true)
				setTimer(setElementData,5000,1,target,"incapacitated",false,true)
				triggerEvent("S_MELEE",client,target,true)
				triggerEvent("pedWasDamaged",target,ped)
				setTimer(setPedAnimation,3200,1,target, "ped","getup",1500,false,true,true,false)
				--setTimer(setPedAnimation,4700,1,target, "ped","cower",1000,false,true,true,false)
				--break
			end
			
			for k,target in ipairs(pedsHit) do
				if target == source then 
					break 
				else
				setPedAnimation(target)
				setPedAnimation(target, "FIGHT_B","HitB_2",600,false,true,false,true)
				setTimer(setPedAnimation,600,1,target, "FIGHT_E","Hit_fightkick_B",3000,false,true,true,true)
					
				setElementData(target,"incapacitated",true,true)
				setTimer(setElementData,5000,1,target,"incapacitated",false,true)
				triggerEvent("S_MELEE",client,target,true)
				triggerEvent("pedWasDamaged",target,ped)
				setTimer(setPedAnimation,3200,1,target, "ped","getup",1500,false,true,true,false)
				setTimer(setPedAnimation,4700,1,target, "ped","cower",1000,false,true,true,false)
				--break
				end
			end
			
			setTimer(destroyElement,400,1,kickcol)

end

addEventHandler("BruteStomp",root,bruteStomp)

--toggle player immunity
function toggleZedImmunity(p, c)

	if getElementData(p, "zombie") then
		setElementData(p,"zombie",false,true)
		outputChatBox("zed off",p)
		return
	end

	setElementData(p, "zombie", true,true)
	outputChatBox("zed on",p)

end
addCommandHandler("zedme", toggleZedImmunity)