myZombies = { }
helmetzombies = {264, 167, 128} --{ 27, 51, 52, 99, 27, 137, 153, 167, 205, 260, 277, 278, 279, 284, 285 }
resourceRoot = getResourceRootElement()

-----BRUTES and RUNNERS
addEvent("MorphZombieUP",true)
addEvent("MorphZombieDOWN",true)
morphShaderUP, tec = dxCreateShader ( "shaders/ped_morph.fx", 0, 0, false, "ped" )
morphShaderDOWN, tec = dxCreateShader ( "shaders/ped_morph.fx", 0, 0, false, "ped" )

addEventHandler( "onClientResourceStart", resourceRoot,function ()
if getVersion ().sortable < "1.3.1-9.04939" then
				outputChatBox( "Resource is not compatible with this client." )
				outputChatBox( "Please update MTA:SA." )
				return
end
if not morphShaderUP or not morphShaderDOWN then
				outputChatBox( "Could not create morph shader. Please use debugscript 3" )
end
end)

function morphpedup(ped)
	local size = 0.0305
	engineApplyShaderToWorldTexture ( morphShaderUP, "*", ped )
	dxSetShaderValue( morphShaderUP, "sMorphSize", size, size, size+0.01 )

end

function morphpeddown(ped)
	local size2 = -0.015
	engineApplyShaderToWorldTexture ( morphShaderDOWN, "*", ped )
	dxSetShaderValue( morphShaderDOWN, "sMorphSize", size2, size2, size2 )
	
end
addEventHandler( "MorphZombieUP", resourceRoot,morphpedup)	
addEventHandler( "MorphZombieDOWN", resourceRoot,morphpeddown)	


--------INFECTION------------------------------------------
--addEvent("Stage1infection",true)--------zzz
addEvent("ClearInfection",true)

if getElementData(localPlayer,"infection") == "uninfected" and isElement(infectionTimer) then killTimer(infectionTimer) end
--elseif getElementData(localPlayer,"infection") == "stage1" then infectionTimer = setTimer(infectiondrainhealth, 1000,-1,"stage1") end
--[[
function infectiondrainhealth(stage)
local playerHealth = getElementHealth(localPlayer)
if stage == "stage1" and playerHealth>0 then setElementHealth(localPlayer, playerHealth-1) end--elseif stage == "stage1" and playerHealth == 1 then killPed(localPlayer) end
end

function infectionstage1()--------zzzzzzzzz
local screenX, screenY = guiGetScreenSize()
infectionstage1shader = guiCreateStaticImage( 0, 0, screenX, screenY, "shaders/infectionstage1shader.png", false ) --shader
guiMoveToBack(infectionstage1shader)
infectionTimer = setTimer(infectiondrainhealth, 5000,-1,"stage1") 
end
addEventHandler("Stage1infection", resourceRoot, infectionstage1)
]]

function clearinfection()------clears infection on player
if isElement(infectionstage1shader) then destroyElement(infectionstage1shader); killTimer(infectionTimer) end
 
setElementData(localPlayer, "infection","uninfected",true)
--outputChatBox("Infection cleared")
end
addEventHandler("ClearInfection", localPlayer, clearinfection)
addCommandHandler("clearinfection",clearinfection)
-----------------------------------------------------------


--FORCES ZOMBIES TO MOVE ALONG AFTER THEIR TARGET PLAYER DIES
function playerdead ()
    setTimer ( Zomb_release, 8000, 1 )
end
addEventHandler ( "onClientPlayerWasted", getLocalPlayer(), playerdead )

function Zomb_release ()
    for k, ped in pairs( myZombies ) do
        if (isElement(ped)) then
            if (getElementData (ped, "zombie") == true) then
                setElementData ( ped, "target", nil )
                setElementData ( ped, "status", "idle" )
                table.remove(myZombies,k)
            end
        end
    end
end

--REMOVES A ZOMBIE FROM INFLUENCE AFTER ITS KILLED
function pedkilled ( killer, weapon, bodypart )
    if (getElementData (source, "zombie") == true) and (getElementData (source, "status") ~= "dead" ) then
        setElementData ( source, "target", nil )
        setElementData ( source, "status", "dead" )
    end
end
addEventHandler ( "onClientPedWasted", getRootElement(), pedkilled )

--THIS CHECKS ALL ZOMBIES EVERY SECOND TO SEE IF THEY ARE IN SIGHT
function zombie_check ()
    if (getElementData (getLocalPlayer (), "zombie") ~= true) and ( isPedDead ( getLocalPlayer () ) == false ) then
        local zombies = getElementsByType ( "ped",getRootElement(),true )
        local Px,Py,Pz = getElementPosition( getLocalPlayer () )
        if isPedDucked ( getLocalPlayer ()) then
            local Pz = Pz-1
        end     
        for theKey,theZomb in ipairs(zombies) do
            if (isElement(theZomb)) then
			
			--if getElementData(theZomb,"zombietype") == "brute" then engineApplyShaderToWorldTexture ( myShader, "*", theZomb ); changeSize("",nil,0) end
			
			
                local Zx,Zy,Zz = getElementPosition( theZomb )
                local block, anim = getPedAnimation( theZomb )----------added
                if (getDistanceBetweenPoints3D(Px, Py, Pz, Zx, Zy, Zz) < 20 ) and isPedDucked( localPlayer )==true 
                    or (getDistanceBetweenPoints3D(Px, Py, Pz, Zx, Zy, Zz) < 45 ) and isPedDucked( localPlayer )==false 
                    or (getDistanceBetweenPoints3D(Px, Py, Pz, Zx, Zy, Zz) < 2 ) and isPedDucked( localPlayer ) == true and getPedAnimation( theZomb ) ~= false and block == "CRACK" -- sneaking past a sleeping zombie 
                    then
                    if (getElementData (theZomb, "zombie") == true) then
                        if ( getElementData ( theZomb, "status" ) == "idle" ) then --CHECKS IF AN IDLE ZOMBIE IS IN SIGHT
                            local isclear = isLineOfSightClear (Px, Py, Pz+1, Zx, Zy, Zz +1, true, false, false, true, false, false, false) 
                            if (isclear == true) then
								if table.maxn (myZombies)>10 and getDistanceBetweenPoints3D(Px, Py, Pz, Zx, Zy, Zz) > 15 then return else --if player has more than ten zombies chasing, make zombies farther than 15 units ignore him, unles gunshots or zombie alerted
                                setElementData ( theZomb, "status", "chasing" )
                                setPedAnimation ( theZomb, "BSKTBALL", "BBALL_def_loop", 1000, false, false, false)
                                local randnum = math.random( 1, 2 )
                                alertsound = playSound3D("sounds/alert"..randnum..".wav", Zx, Zy, Zz, false)
                                setSoundMaxDistance(alertsound, 45)
                                setElementData ( theZomb, "target", getLocalPlayer() )
                                table.insert( myZombies, theZomb ) --ADDS ZOMBIE TO PLAYERS COLLECTION
                                table.remove( zombies, theKey)
                                zombieradiusalert (theZomb)
                            end
							end---------zzzzzzzzzz
							
                        elseif (getElementData(theZomb,"status") == "chasing") and (getElementData(theZomb,"target") == nil) then --CHECKS IF AN AGGRESSIVE LOST ZOMBIE IS IN SIGHT
                            local isclear = isLineOfSightClear (Px, Py, Pz+1, Zx, Zy, Zz +1, true, false, false, true, false, false, false) 
                            if (isclear == true) then
								if table.maxn (myZombies)>10 and getDistanceBetweenPoints3D(Px, Py, Pz, Zx, Zy, Zz) > 15 then return else----if player has more than ten zombies chasing, make zombies farther than 15 units ignore him, unless gunshots or zombie alerted
                                setElementData ( theZomb, "target", getLocalPlayer() )
                                isthere = "no"
                                for k, ped in pairs( myZombies ) do
                                    if ped == theZomb then
                                        isthere = "yes"
                                    end
                                end
                                if isthere == "no" then
                                    table.insert( myZombies, theZomb ) --ADDS THE WAYWARD ZOMBIE TO THE PLAYERS COLLECTION
                                    table.remove( zombies, theKey)
                                end
								end---------zzzzzzzzzz
                            end
                        elseif ( getElementData ( theZomb, "target" ) == getLocalPlayer() ) then --CHECKS IF AN ALREADY AGGRESSIVE ZOMBIE IS IN SIGHT
                            local isclear = isLineOfSightClear (Px, Py, Pz+1, Zx, Zy, Zz +1, true, false, false, true, false, false, false) 
                            if (isclear == false) then --IF YOUR ZOMBIE LOST YOU, MAKES IT REMEMBER YOUR LAST COORDS
                                setElementData ( theZomb, "target", nil )
                                triggerServerEvent ("onZombieLostPlayer", theZomb, oldPx, oldPy, oldPz)
                            end
                        end
                    end
                end
            end
        end
    --this second half is for checking peds and zombies
    
        local nonzombies = getElementsByType ( "ped",getRootElement(),true )
        for theKey,theZomb in ipairs(zombies) do
            if (isElement(theZomb)) then
                if (getElementData (theZomb, "zombie") == true) then
                    local Zx,Zy,Zz = getElementPosition( theZomb )
                    for theKey,theNonZomb in ipairs(nonzombies) do
                        if (getElementData (theNonZomb, "zombie") ~= true) then -- if the ped isnt a zombie
                            local Px,Py,Pz = getElementPosition( theNonZomb )
                            if (getDistanceBetweenPoints3D(Px, Py, Pz, Zx, Zy, Zz) < 45 ) then
                                local isclear = isLineOfSightClear (Px, Py, Pz+1, Zx, Zy, Zz +1, true, false, false, true, false, false, false ) 
                                if (isclear == true) and ( getElementHealth ( theNonZomb ) > 0) then
                                    if ( getElementData ( theZomb, "status" ) == "idle" ) then --CHECKS IF AN IDLE ZOMBIE IS IN SIGHT
                                        triggerServerEvent ("onZombieLostPlayer", theZomb, Px, Py, Pz)                                  
                                        setElementData ( theZomb, "status", "chasing" )
                                        setElementData ( theZomb, "target", theNonZomb )
                                        zombieradiusalert (theZomb)
                                    elseif ( getElementData ( theZomb, "status" ) == "chasing" ) and ( getElementData ( theZomb, "target" ) == nil) then
                                        triggerServerEvent ("onZombieLostPlayer", theZomb, Px, Py, Pz)
                                        setElementData ( theZomb, "target", theNonZomb )                                    
                                    end
                                end                 
                            end     
                            if ( getElementData ( theZomb, "target" ) == theNonZomb ) then --CHECKS IF AN ALREADY AGGRESSIVE ZOMBIE IS IN SIGHT OF THE PED
                                local Px,Py,Pz = getElementPosition( theNonZomb )
                                if (getDistanceBetweenPoints3D(Px, Py, Pz, Zx, Zy, Zz) < 45 ) then
                                    local isclear = isLineOfSightClear (Px, Py, Pz+1, Zx, Zy, Zz+1, true, false, false, true, false, false, false) 
                                    if (isclear == false) then --IF YOUR ZOMBIE LOST THE PED, MAKES IT REMEMBER the peds LAST COORDS
                                        triggerServerEvent ("onZombieLostPlayer", theZomb, Px, Py, Pz)                          
                                        setElementData ( theZomb, "target", nil )
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    for k, ped in pairs( myZombies ) do
        if (isElement(ped) == false) then
            table.remove( myZombies, k)
        end
    end
    oldPx,oldPy,oldPz = getElementPosition( getLocalPlayer () )
end


--INITAL SETUP

function clientsetupstarter(startedresource)
    if startedresource == getThisResource() then
        setTimer ( clientsetup, 1234, 1)
        MainClientTimer1 = setTimer ( zombie_check, 1000, 0)  --STARTS THE TIMER TO CHECK FOR ZOMBIES
    end
end
addEventHandler("onClientResourceStart", getRootElement(), clientsetupstarter)

function clientsetup()
    oldPx,oldPy,oldPz = getElementPosition( getLocalPlayer () )
    --grabcol = createColSphere ( 0, 0, 0, 0.95)
    grabcol = createColSphere ( 0, 0, 0, .5)
    woodpic = guiCreateStaticImage( .65, .06, .1, .12, "zombiewood.png", true )
    guiSetVisible ( woodpic, false )

--ALL ZOMBIES STFU
    local zombies = getElementsByType ( "ped" )
    for theKey,theZomb in ipairs(zombies) do
        if (isElement(theZomb)) then
            if (getElementData (theZomb, "zombie") == true) then
                setPedVoice(theZomb, "PED_TYPE_DISABLED")
            end
        end
    end
    
--SKIN REPLACEMENTS

    local skin = engineLoadTXD ( "skins/107.txd" ) -- fam3
    engineImportTXD ( skin, 22 )
    local skin = engineLoadDFF("skins/107.dff", 22)
    engineReplaceModel(skin, 22)  
	
    local skin = engineLoadTXD ( "skins/126.txd" ) --hitman1
    engineImportTXD ( skin, 56 )
	local skin = engineLoadDFF("skins/126.dff", 56)
    engineReplaceModel(skin, 56) 
	
	local skin = engineLoadTXD ( "skins/127.txd" ) -- hitman2
    engineImportTXD ( skin, 68 )
	local skin = engineLoadDFF("skins/127.dff", 68)
    engineReplaceModel(skin, 68) 
	
    local skin = engineLoadTXD ( "skins/212.txd" ) --homeless brain
    engineImportTXD ( skin, 69 )
	local skin = engineLoadDFF("skins/212.dff", 69)
    engineReplaceModel(skin, 69) 
	
    local skin = engineLoadTXD ( "skins/230.txd" ) --homeless hoodie
    engineImportTXD ( skin, 70 )
	local skin = engineLoadDFF("skins/230.dff", 70)
    engineReplaceModel(skin, 70) 
	
	local skin = engineLoadTXD ( "skins/258.txd" ) --heck
    engineImportTXD ( skin, 152 )
	local skin = engineLoadDFF("skins/258.dff", 152)
    engineReplaceModel(skin, 152) 
	
    local skin = engineLoadTXD ( "skins/287.txd" ) --army
    engineImportTXD ( skin, 167 )
	local skin = engineLoadDFF("skins/287.dff", 167)
    engineReplaceModel(skin, 167) 
	
	local skin = engineLoadTXD ( "skins/277.txd" ) --fireman
    engineImportTXD ( skin, 264 )
	local skin = engineLoadDFF("skins/277.dff", 264)
    engineReplaceModel(skin, 264) 
	

	
    local skin = engineLoadTXD ( "skins/67.txd" ) -- slit r* employee
    engineImportTXD ( skin, 67 )
    local skin = engineLoadTXD ( "skins/128.txd" ) --holy native by Slothman
    engineImportTXD ( skin, 128 )
    local skin = engineLoadTXD ( "skins/162.txd" ) --shirtless redneck by Slothman
    engineImportTXD ( skin, 162 )
    local skin = engineLoadTXD ( "skins/188.txd" ) --burnt greenshirt by Slothman
    engineImportTXD ( skin, 188 )
    local skin = engineLoadTXD ( "skins/195.txd" ) --gang girl/bloody ex by Slothman
    engineImportTXD ( skin, 195 )
    local skin = engineLoadTXD ( "skins/206.txd" ) -- faceless zombie by Slothman
    engineImportTXD ( skin, 206 )
    local skin = engineLoadTXD ( "skins/209.txd" ) --Noodle vendor by 50p
    engineImportTXD ( skin, 209 )
    local skin = engineLoadTXD ( "skins/229.txd" ) --infected tourist by Slothman
    engineImportTXD ( skin, 229 )
     local skin = engineLoadTXD ( "skins/280.txd" ) --infected cop by Lordy
    engineImportTXD ( skin, 280 )     
	--[[local skin = engineLoadTXD ( "skins/277.txd" ) --gutted firefighter by Wall-E
    engineImportTXD ( skin, 227 )]]
 
end

--UPDATES PLAYERS COUNT OF AGGRESIVE ZOMBIES
addEventHandler ( "onClientElementDataChange", getRootElement(),
function ( dataName )
    if getElementType ( source ) == "ped" and dataName == "status" then
        local thestatus = (getElementData ( source, "status" ))
        if (thestatus == "idle") or (thestatus == "dead") then      
            for k, ped in pairs( myZombies ) do
                if ped == source and (getElementData (ped, "zombie") == true) then
                    setElementData ( ped, "target", nil )
                    table.remove( myZombies, k)
                    setElementData ( getLocalPlayer(), "dangercount", tonumber(table.getn( myZombies )) )
                end
            end
        end
    end
end )

--MAKES A ZOMBIE JUMP
addEvent( "Zomb_Jump", true )
function Zjump ( ped )
    if (isElement(ped)) then
	
			if getElementData(ped,"brute") ~= true then 
			setPedControlState( ped, "jump", true )
			setTimer ( function (ped) if ( isElement ( ped ) ) then setPedControlState ( ped, "jump", false) end end, 800, 1, ped )
		end
	end
end
addEventHandler( "Zomb_Jump", getRootElement(), Zjump )

--MAKES A ZOMBIE PUNCH
addEvent( "Zomb_Punch", true )
 function Zpunch ( ped )
    if isElement(ped) and not isPedDead(ped) then
	
		if  getElementData(ped,"brute") == true then
		triggerServerEvent("BruteStomp",ped,ped)
		end
	
    setPedControlState( ped, "fire", true )
	Zmoan(ped,math.random(4,8))
	setTimer ( function (ped) 
				if ( isElement ( ped ) ) then 
				setPedControlState ( ped, "fire", false) 
				end 
				end, 300, 1, ped )
	setTimer(  function (ped)
				if ( isElement ( ped ) ) then 
				setPedControlState( ped, "fire", true )
				end
				end, 600, 2, ped )
	setTimer(  function (ped)
				if ( isElement ( ped ) ) then 
				setPedControlState( ped, "fire", false )
				setPedWeaponSlot(ped,0)
				end
				end, 900, 1, ped )
				
	--[[setTimer(  function (ped)
				if ( isElement ( ped ) ) then 
				setPedControlState( ped, "fire", true )
				end
				end, 1000, 2, ped )
	setTimer(  function (ped)
				if ( isElement ( ped ) ) then 
				setPedControlState( ped, "fire", false )
				end
				end, 1200, 2, ped )]]
		
    end
 end
 	
addEventHandler( "Zomb_Punch", getRootElement(), Zpunch ) 

--MAKES A ZOMBIE STFU
addEvent( "Zomb_STFU", true )
function Zstfu ( ped )
    if (isElement(ped)) then
        setPedVoice(ped, "PED_TYPE_DISABLED")
    end
end
addEventHandler( "Zomb_STFU", getRootElement(), Zstfu )

--MAKES A ZOMBIE MOAN
addEvent( "Zomb_Moan", true )
function Zmoan ( ped, randnum )
    if (isElement(ped)) then
        local Zx,Zy,Zz = getElementPosition( ped )
        local sound = playSound3D("sounds/idle"..randnum..".wav", Zx, Zy, Zz, false)
        setSoundMaxDistance(sound, 30)
		setSoundVolume(sound, 0.3)
    end
end
addEventHandler( "Zomb_Moan", getRootElement(), Zmoan )

--ZOMBIE DAMAGED SPECIFICS
function zombiedamaged ( attacker, weapon, bodypart )

if not attacker then return end
if weapon == 51 then weapon = 16 end

    if getElementType ( source ) == "ped" and getElementType ( attacker ) == "player" then
        if (getElementData (source, "zombie") == true) then
			local weapslot = getSlotFromWeapon(weapon)
            local brute
			local runner
			local walker
			local thezedstatus = getElementData(source,"status") or "idle"
			
				if (getElementData (source, "brute") == true) then
					brute = "yes"
				else
					brute = "no"				
				end
				if (getElementData (source, "runner") == true) then
					runner = "yes"
				else
					runner = "no"				
				end
				if (getElementData (source, "walker") == true) then
					walker = "yes"
				else
					walker = "no"				
				end
				               
				if brute == "no" and  bodypart == 9 then
					triggerServerEvent ("headboom", source, source, attacker, weapon, bodypart )
					return
				end
				
				if brute == "yes" and  bodypart == 9 then
				local rand = math.random(1,2)
					if rand == 1 then
						setPedAnimation(source,"ped","gas_cwr",2000,false,true,false,false)
						setElementData(source,"status","paused")
						setTimer(setElementData,2000,1,source,"status","chasing")
					else
						setPedAnimation(source,"ped","KO_shot_face",5000,false,true,false,false)
						setElementData(source,"status","paused")
						setTimer(setElementData,5000,1,source,"status","chasing")
					end
				end
				
				if brute == "yes" then
					local rand = math.random(1,100)
					if rand > 80 then
						local x,y,z = getElementPosition(source)
						local rot = getElementRotation(source)
						local skin = getElementModel(source)
						
						triggerServerEvent("BruteFrenzy",root,x,y,z,rot,skin)
						triggerServerEvent("MorphedZombieRemoval",root,source)
					end
				end
				
				if runner == "yes" and  bodypart ~= 9 and weapslot ~= 0 and weapslot ~= 1 and weapslot ~= 10 then
				local rand = math.random(1,2)
					if rand == 1 then
						setPedAnimation(source,"ped","Crouch_Roll_L",1500,false,true,true,false)
					else
						setPedAnimation(source,"ped","Crouch_Roll_R",1500,false,true,true,false)
					end
				end
				
				if walker == "yes" and  bodypart == 3  and weapslot ~= 0 and weapslot ~= 1 and weapslot ~= 10 then
				local rand = math.random(1,4)
					if rand == 1 then
						setPedAnimation(source,"ped","handscower",2000,false,true,false,false)
						setElementData(source,"status","paused")
						setTimer(setElementData,2000,1,source,"status","chasing")
					elseif rand == 2 then
						setPedAnimation(source,"ped","EV_step",2000,false,true,false,false)
						setElementData(source,"status","paused")
						setTimer(setElementData,2000,1,source,"status","chasing")
					elseif rand == 3 then
						setPedAnimation(source,"ped","getup",3000,false,true,false,false)
						setElementData(source,"status","paused")
						setTimer(setElementData,3000,1,source,"status","chasing")
					elseif rand == 4 then
						setPedAnimation(source,"ped","KO_shot_stom",5000,false,true,false,false)
						setElementData(source,"status","paused")
						setTimer(setElementData,5000,1,source,"status","chasing")
					end
				elseif walker == "yes" and  weapslot ~= 0 and weapslot ~= 1 and weapslot ~= 10 and (bodypart == 7 or bodypart == 8) then
				setPedAnimation(source,"ped","getup",3000,false,true,false,false)
				setElementData(source,"status","paused")
				setTimer(setElementData,3000,1,source,"status","chasing")
				end
			
        end
    end
end
addEventHandler ( "onClientPedDamage", getRootElement(), zombiedamaged )

function zombiedkilled(killer, weapon, bodypart)
    if getElementType ( source ) == "ped" then
        if (getElementData (source, "zombie") == true) then
            setElementCollisionsEnabled(source, false)
        end
    end
end
addEventHandler ( "onClientPedWasted", getRootElement(), zombiedkilled )

--CAUSES MORE DAMAGE TO PLAYER WHEN ATTACKED BY A ZOMBIE
function zombieattack ( attacker, weapon, bodypart )
    if (attacker) then
        if getElementType ( attacker ) == "ped" then
            if (getElementData (attacker, "zombie") == true) then
			local goOn
			local damage
			local zombtype
			local randeffectchance = math.random(1,5)
				if getElementData(attacker,"runner")== true then 
					zombtype = "runner"; damage = 25 
				elseif getElementData(attacker,"brute")== true then
					zombtype = "brute"; damage = 30
				elseif getElementData(attacker,"walker")== true then
					zombtype = "walker"; damage = 20
				else damage = 20
				end
			 
                local playerHealth = getElementHealth ( getLocalPlayer() )
                if playerHealth > damage then
                    setElementHealth ( source, playerHealth - damage )
					goOn = true
                else
                    triggerServerEvent ("playereaten", source, source, attacker, weapon, bodypart )
                end
				
				if goOn == true and zombtype == "runner" and randeffectchance == 5 then
				--infect player; was done someplace else afterall
				elseif goOn == true and zombtype == "brute" and randeffectchance > 3 then
				--stomp player
				end
			
            end
        end
    end
end
addEventHandler ( "onClientPlayerDamage", getLocalPlayer(), zombieattack )

--WOOD GUI
function showwoodpic ( theElement, matchingDimension )
    if ( theElement == getLocalPlayer() ) and (getElementData ( source, "purpose" ) == "zombiewood" ) then
        guiSetVisible ( woodpic, true )
    end
end
addEventHandler ( "onClientColShapeHit", getRootElement(), showwoodpic )

function hidewoodpic ( theElement, matchingDimension )
    if ( theElement == getLocalPlayer() ) and (getElementData ( source, "purpose" ) == "zombiewood" ) then
        guiSetVisible ( woodpic, false )
    end
end
addEventHandler ( "onClientColShapeLeave", getRootElement(), hidewoodpic )

--ZOMBIES ATTACK FROM BEHIND AND GUI STUFF
function movegrabcol ()

	--[[if isElement(grabcol) then
	local px,py,pz = getElementPosition( getLocalPlayer () )
	setElementPosition ( grabcol, px,py,pz )
	end]]

    if isElement(grabcol) then --- BELOW IS A NIFTY FORMULA TO KEEP AN ELEMENT BEHIND ANOTHER and rotate them together
        local playerrot = getPedRotation ( getLocalPlayer () )
        local radRot = math.rad ( playerrot )
        local radius = 1
        local px,py,pz = getElementPosition( getLocalPlayer () )
        local tx = px + radius * math.sin(radRot)
        local ty = py + -(radius) * math.cos(radRot)
        local tz = pz
        setElementPosition ( grabcol, tx, ty, tz )
    end
	
end
addEventHandler ( "onClientRender", getRootElement(), movegrabcol )

--THREATCOUNTER
--[[function showthreatcounter()
    local screenWidth, screenHeight = guiGetScreenSize()
    local dcount = tostring(table.getn( myZombies ))
	dxDrawText( dcount, screenWidth-40, screenHeight -50, screenWidth, screenHeight, tocolor ( 0, 0, 0, 255 ), 1.44, "pricedown" )       ---ZOMBIES SPAWNED/PLAYER COUNTER
    dxDrawText( dcount, screenWidth-42, screenHeight -52, screenWidth, screenHeight, tocolor ( 255, 255, 255, 255 ), 1.4, "pricedown" )
end    
addEventHandler ( "onClientRender", getRootElement(), showthreatcounter )]]

function choketheplayer ( theElement, matchingDimension )
    if getElementType ( theElement ) == "ped" and ( isPedDead ( getLocalPlayer () ) == false ) then
        if ( getElementData ( theElement, "target" ) == getLocalPlayer () ) and (getElementData (theElement, "zombie") == true) then
            local px,py,pz = getElementPosition( getLocalPlayer () )
			local interval
			if getElementData(theElement,"runner") == true then interval = 600 else interval = 1000 end
			triggerEvent("sync.message", root, ped, 125, 125, 125, "GRAB")
            setTimer ( checkplayermoved, interval, 1, theElement, px, py, pz)
        end
    end
end
addEventHandler ( "onClientColShapeHit", getRootElement(), choketheplayer )

function checkplayermoved (zomb, px, py, pz)
    if (isElement(zomb)) then
        local nx,ny,nz = getElementPosition( getLocalPlayer () )
        local distance = (getDistanceBetweenPoints3D (px, py, pz, nx, ny, nz))
        if (distance < .7) and ( isPedDead ( getLocalPlayer () ) == false ) then
            setElementData ( zomb, "status", "throatslashing" )
        end
    end
end

--ALERTS ANY IDLE ZOMBIES WITHIN A RADIUS WHEN GUNSHOTS OCCUR OR OTHER ZOMBIES GET ALERTED
function zombieradiusalert (theElement)
    local Px,Py,Pz = getElementPosition( theElement )
    local zombies = getElementsByType ( "ped" )
    for theKey,theZomb in ipairs(zombies) do
        if (isElement(theZomb)) then
            if (getElementData (theZomb, "zombie") == true) then
                if ( getElementData ( theZomb, "status" ) == "idle" ) then
                    local Zx,Zy,Zz = getElementPosition( theZomb )
                    local distance = (getDistanceBetweenPoints3D (Px, Py, Pz, Zx, Zy, Zz))
                    if (distance < 40) and ( isPedDead ( getLocalPlayer () ) == false ) then
                        isthere = "no"
                        for k, ped in pairs( myZombies ) do
                            if ped == theZomb then
                                isthere = "yes"
                            end
                        end
                        if isthere == "no" and (getElementData (getLocalPlayer (), "zombie") ~= true) then
                            if (getElementType ( theElement ) == "ped") then
                                local isclear = isLineOfSightClear (Px, Py, Pz, Zx, Zy, Zz, true, false, false, true, false, false, false) 
                                if (isclear == true) then
                                    setElementData ( theZomb, "status", "chasing" )
                                    setElementData ( theZomb, "target", getLocalPlayer () )
                                    table.insert( myZombies, theZomb ) --ADDS ZOMBIE TO PLAYERS COLLECTION
                                end
                            else
                                setElementData ( theZomb, "status", "chasing" )
                                setElementData ( theZomb, "target", getLocalPlayer () )
                                table.insert( myZombies, theZomb ) --ADDS ZOMBIE TO PLAYERS COLLECTION
                            end
                        end
                    end
                end
            end
        end
    end
end

function shootingnoise ( weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement)
    if alertspacer ~= 1 then
	
        if (weapon == 9) then
            alertspacer = 1
            setTimer ( resetalertspacer, 5000, 1 )
            zombieradiusalert(getLocalPlayer ())
        elseif (weapon > 21) and (weapon ~= 23) then
            alertspacer = 1
            setTimer ( resetalertspacer, 5000, 1 )
            zombieradiusalert(getLocalPlayer ())
        end
    end
    if hitElement then
        if (getElementType ( hitElement ) == "ped") then
            if (getElementData (hitElement, "zombie") == true) then         
                isthere = "no"
                for k, ped in pairs( myZombies ) do
                    if ped == hitElement then
                        isthere = "yes"
                    end
                end
                if isthere == "no" and (getElementData (getLocalPlayer (), "zombie") ~= true) then
                    setElementData ( hitElement, "status", "chasing" )
                    setElementData ( hitElement, "target", getLocalPlayer () )
                    table.insert( myZombies, hitElement ) --ADDS ZOMBIE TO PLAYERS COLLECTION
					triggerEvent("sync.message", root, ped, 125, 125, 125, "HUH?!")
                    zombieradiusalert (hitElement)
                end
            end
        end
    end
end
addEventHandler ( "onClientPlayerWeaponFire", getLocalPlayer (), shootingnoise )

function resetalertspacer ()
    alertspacer = nil
end

function choketheplayer ( theElement, matchingDimension )
    if getElementType ( theElement ) == "ped" and ( isPedDead ( getLocalPlayer () ) == false ) and (getElementData (theElement , "zombie") == true) then
        if ( getElementData ( theElement, "target" ) == getLocalPlayer () ) then
            local px,py,pz = getElementPosition( getLocalPlayer () )
            setTimer ( checkplayermoved, 600, 1, theElement, px, py, pz)
        end
    end
end

addEvent( "Spawn_Placement", true )
function Spawn_Place(xcoord, ycoord)
    local x,y,z = getElementPosition( getLocalPlayer() )
    local posx = x+xcoord
    local posy = y+ycoord
    local gz = getGroundPosition ( posx, posy, z+500 )
    triggerServerEvent ("onZombieSpawn", getLocalPlayer(), posx, posy, gz+1 )
end
addEventHandler("Spawn_Placement", getRootElement(), Spawn_Place)

--------------------------------------
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

function currentTime()
    local time = getTime()
    outputChatBox( "The current game time is "..time )
end
addCommandHandler("gettime", currentTime)