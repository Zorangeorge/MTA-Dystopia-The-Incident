--[[-- water level
addCommandHandler ( "water",
    function ( thePlayer, command, level )
        if level and tonumber ( level ) then -- if we input something and if it is actually a number value
            setWaterLevel ( tonumber( level ) ) -- change the water level
            outputChatBox ( "Waterlevel is now: " .. level ) -- send a message to everyone to inform about the change
        end
    end
)]]

addEventHandler( "onResourceStart", resourceRoot, --fog, farClip
	function( )
  setFogDistance(300)
  setFarClipDistance( 8000 )
  setWeather(12) --dull and hazy
end)

function setInitialTeam()

	local players = getElementsByType("player")

	for _,player in pairs(players) do
		if getPlayerTeam(player) == false then
		local team = getTeamFromName("Scavengers")
		setPlayerTeam ( player, team)
		end
	end
	
end
addEventHandler("onResourceStart",resourceRoot,setInitialTeam)

function setHungerAndThirst()
local acc = getPlayerAccount(source)
if isGuestAccount(acc) then return end
local hunger = getAccountData(acc,"hunger")
local thirst = getAccountData(acc,"thirst")
triggerClientEvent(source,"SetThirstOnSpawn",source,thirst)
triggerClientEvent(source,"SetHungerOnSpawn",source,hunger)
end
addEventHandler("onPlayerLogin",root, setHungerAndThirst)

---SCOREBOARD STUFF

exports.scoreboard:scoreboardForceTeamsHidden(true)
exports.scoreboard:scoreboardAddColumn("Level")
--exports.scoreboard:scoreboardAddColumn("Faction")
--exports.scoreboard:addScoreboardColumn("    ",root,1, 0.01) 
call( getResourceFromName("Scoreboard"), "addScoreboardColumn", "    ",root,1, 0.01 )
      
--[[addEventHandler("onPlayerSpawn", root, 
function  () 
    --local country = exports.admin:getPlayerCountry(source) 
	local faction = getTeamName(getPlayerTeam(source)) or "Scavengers"
	--outputDebugString(faction)
    local image = faction and ":dystopia_core/images/"..string.lower(faction).."_logo.png" 
    setElementData(source, "    ", image and {type = "image", src =  image, height = 20, width = 20} or " ") 
end)]]

--[[EXAMPLE this function would replace the "_"'s in player names with a space

function fixName( playerName )
    return playerName:gsub( "_", " " )
end

]]

addEventHandler ( "onPlayerWasted", root, --kills score
    function( totalAmmo, killer, killerWeapon, bodypart, stealth )
       
	   if killer and getElementType(killer) == "player" then
            local account = getPlayerAccount ( killer )
            if killer ~= source then
                setAccountData( account,"totalkillsdeaths.Kills",tonumber( getAccountData( account,"totalkillsdeaths.Kills" ) or 0 ) + 1 )
                setElementData( killer, "Kills", tonumber( getAccountData( account,"totalkillsdeaths.Kills" ) ),true )
                --setElementData( killer, "K/D", tonumber(getElementData( killer, "Kills" )/getElementData( source, "Deaths") ) )
            end 
		--[[else
            local accountSource = getPlayerAccount ( source )
            setAccountData( accountSource,"totalkillsdeaths.Deaths",tonumber( getAccountData(accountSource,"totalkillsdeaths.Deaths") or 0 ) +1 )
            setElementData( source, "Deaths", tonumber( getAccountData( accountSource,"totalkillsdeaths.Deaths" ) ) )
			--setElementData( source, "K/D", getElementData( source, "Kills" )/getElementData( source, "Deaths") )]]
		end
		
    end
)      
 
addEventHandler( "onPlayerLogin",root, --kills score
    function( thePreviousAccount, theCurrentAccount, autoLogin )
        local account = getPlayerAccount ( source )
        if not getAccountData( account,"totalkillsdeaths.Kills" ) --[[and not getAccountData( account,"totalkillsdeaths.Deaths" )]] then
            setAccountData( account,"totalkillsdeaths.Kills",0 )
            --setAccountData( account,"totalkillsdeaths.Deaths",0 )
        end
        --setElementData( source,"Deaths",tonumber( getAccountData( account,"totalkillsdeaths.Deaths" ) or 0 ) )
        setElementData( source,"Kills",tonumber( getAccountData( account,"totalkillsdeaths.Kills" ) or 0 ),true )
		--setElementData( source, "K/D", getElementData( source, "Kills" )/getElementData( source, "Deaths") )
		
--[[			local faction = getTeamName(getPlayerTeam(source))
			outputDebugString(faction)
			local image = faction and ":dystopia_core/images/"..string.lower(faction).."_logo.png" 
			setElementData(source, "    ", image and {type = "image", src =  image, height = 20, width = 20} or " ") ]]
		
    end
 )
 
addEventHandler( "onResourceStart",resourceRoot, --kills score
    function( )
        
            call( getResourceFromName("Scoreboard"), "addScoreboardColumn", "Kills",root,100, 0.05 )
            --call( getResourceFromName("Scoreboard"), "addScoreboardColumn", "Deaths",root,101, 0.06 )
            --call( getResourceFromName("Scoreboard"), "addScoreboardColumn", "K/D",root,4, 0.047 )
       
		
    end
)


--MOUNTED MINIGUN BELOW --moved to minigun_server.lua

--[[function mountminigun ( pla, dim ) 
if not isPedInVehicle(pla)then 
local mountedgun=getElementData(pla,"mountedgun") 
if mountedgun then 
local x,y,z=getElementPosition(pla) 
local xx,yy,zz=getElementRotation(pla) 
setElementPosition(mountedgun,x,y+2,z-1) 
setElementRotation(mountedgun,xx,yy,zz+90) 
else 
local x,y,z=getElementPosition(pla) 
local xx,yy,zz=getElementRotation(pla) 
local mountgun = createObject(2985, x,y+2, z-1,0,0,0) 
local miniggun1 = createVehicle(464, 0, 0, 0) 
local serial = getPlayerSerial(pla) 
setElementRotation(mountgun,xx,yy,zz+90) 
setElementData(pla,"mountedgun",mountgun) 
setElementData(pla,"mountedgun2",miniggun1) 
setElementData(mountgun,"doel","mountedgun") 
  
setVehicleVariant ( miniggun1, 601 , 601  ) 
setVehicleDamageProof ( miniggun1, true ) 
setElementCollisionsEnabled(mountgun, false) 
setVehicleEngineState ( miniggun1, false ) 
attachElements( miniggun1, mountgun, -0.4, 0, 1.1, 0, 0, -90 ) 
setElementAlpha(miniggun1, 0) 
end 
  
end 
if isPedInVehicle(pla)then 
local zitin=getElementModel(getPedOccupiedVehicle(pla)) 
if (zitin == 441)or(zitin == 464)or(zitin == 501)or(zitin == 465)or(zitin == 564)then 
cancelEvent() 
else 
local mountedgun=getElementData(pla,"mountedgun") 
if mountedgun then 
local heeftal=getElementData(getPedOccupiedVehicle(pla),"ismounted") 
if not heeftal then 
attachElements( mountedgun, getPedOccupiedVehicle(pla), 0, 0, 0.5, 0, 0, 90 ) 
setElementData(pla,"ismounted",getPedOccupiedVehicle(pla)) 
setElementData(getPedOccupiedVehicle(pla),"ismounted",pla) 
end 
end 
end 
end 
end 
  
function mmmgleft(pla) 
if isPedInVehicle(pla)then 
local mountedgun=getElementData(pla,"mountedgun") 
local ismounted=getElementData(pla,"ismounted") 
  
if mountedgun  then 
local x,y,z=getElementPosition(mountedgun) 
local xx,yy,zz=getElementRotation(mountedgun) 
setElementRotation(mountedgun,xx,yy,zz-2) 
end 
end 
end 

  
function mmmgright(pla) 
if isPedInVehicle(pla)then 
local mountedgun=getElementData(pla,"mountedgun") 
local ismounted=getElementData(pla,"ismounted") 

if mountedgun  then 
local x,y,z=getElementPosition(mountedgun) 
local xx,yy,zz=getElementRotation(mountedgun) 
setElementRotation(mountedgun,xx,yy,zz+2) 
end 
end 
end 
  
function mmmgleft2(pla) 
if isPedInVehicle(pla)then 
local mountedgun=getElementData(pla,"mountedgun") 
if mountedgun then 
local ismounted=getElementData(pla,"ismounted") 
if ismounted then 
local xx,yy,zz=getElementRotation(mountedgun) 
attachElements( mountedgun, ismounted, 0, 0, 0.5, 0, 0,zz+10) 
  
end 
end 
end 
end

function mmmgright2(pla) 
if isPedInVehicle(pla)then 
local mountedgun=getElementData(pla,"mountedgun") 
if mountedgun then 
local ismounted=getElementData(pla,"ismounted") 
if ismounted then 
local xx,yy,zz=getElementRotation(mountedgun) 
local xxx,yyy,zzz=getElementRotation(ismounted) 
local test=(zz-zzz) 
attachElements( mountedgun, ismounted, 0, 0, 0.5, 0, 0,zz -10) 
end 
end 
end 
end 
  
addEventHandler ("onPlayerQuit", getRootElement(),  
function(quitType, reason, responsibleElement) 
  if (getElementData (source, "mountedgun")) then 
local mountedgun=getElementData(source,"mountedgun") 
local mountedgun2=getElementData(source,"mountedgun2") 
destroyElement (mountedgun)     
  
destroyElement (mountedgun2)     
removeElementData (source, "mountedgun") 
removeElementData (source, "mountedgun2") 
removeElementData (source, "ismounted") 
  end 
end) 
  
addEventHandler( "onResourceStop", getResourceRootElement( getThisResource() ), 
    function () 
        for i,v in ipairs (getElementsByType ("player")) do 
            if (getElementData (v, "mountedgun")) then 
removeElementData (v, "ismounted") 
                 
                removeElementData (v, "mountedgun") 
            end 
        end 
    end 
)
 
addEventHandler( "onResourceStart", getResourceRootElement( getThisResource() ), 
    function () 
        for i,v in ipairs (getElementsByType ("player")) do 
  
            if (getElementData (v, "mountedgun")) then 
                 
removeElementData (v, "ismounted") 
                removeElementData (v, "mountedgun") 
            end 
        end 
    end 
) ]]
  
--[[addEventHandler("onPlayerSpawn", root, --keys for mounted minigun
    function(_, account) 
  
bindKey (source,"=", "up", mountminigun) 
bindKey (source,"1", "down", mmmgright) 
  
bindKey (source,"2", "down", mmmgleft) 
bindKey (source,".", "down", mmmgright2) 
  
bindKey (source,",", "down", mmmgleft2) 
    end 
) ]]

-------SPIKESTRIP

    addCommandHandler("sting", 
        function(player) 
            if (player) then 
            local x, y, z = getElementPosition(player) 
            local rx,ry,rz = getElementRotation(player) 
            local spike = createObject(2899,x,y,z-0.85) 
			setElementRotation(spike,rx,ry,rz+90)
            local x2, y2, z2 = getElementPosition(spike) 
            local blow =  createColSphere ( x2, y2, z2, 2 )
            addEventHandler("onColShapeHit",blow,function (player) 
            if player and getElementType(player) == "player" then 
            if isPedInVehicle(player) then 
                    local pveh = getPedOccupiedVehicle(player)       
                    setVehicleWheelStates(pveh,1,1,1,1) 
                    end 
                end 
            end) 
        end 
    end) 
	
function deploySpikestrip (player)

if not player then player = source end

            if (player) then 
            local x, y, z = getElementPosition(player) 
            local rx,ry,rz = getElementRotation(player) 
            local spike = createObject(2899,x,y,z-0.85) 
			setElementRotation(spike,rx,ry,rz+90)
			
            local x2, y2, z2 = getElementPosition(spike) 
            local blow =  createColSphere ( x2, y2, z2, 2 ) 
			setElementData(blow,"spike",true)
			setElementData(blow,"spikeobj",spike)
             
        end	
end

addEvent("deploySpikestrip",true)
addEventHandler("deploySpikestrip",root,deploySpikestrip)

function removeSpikestrip (player)
	if (player) then 
		local spikecol = getElementData(player,"spikecol")
		local spikeobj = getElementData(spikecol,"spikeobj")
		unbindKey(player,"E","down",removeSpikestrip) 
		setPedAnimation(player,"BOMBER", "BOM_plant", 4000, true, false, false, false)
		setTimer(function() destroyElement(spikecol); destroyElement(spikeobj); addPlayerItem(player,"Spikestrip"); end,4200,1)
	end
end
		
addEventHandler("onColShapeHit",root,
		function (player,_) 
		if getElementData(source,"spike") == true then
            if player and getElementType(player) == "player" then 
				if isPedInVehicle(player) then 
						local pveh = getPedOccupiedVehicle(player)       
						setVehicleWheelStates(pveh,1,1,1,1) 
				else
				outputInteractInfo("Remove Spikestrip\n[E]", player, 255,255,255)
				--outputInteractInfo(text, player, 240,240,240)
							triggerClientEvent(player,"showHelpMessageEvent",player,spikestrip_help_messsage)
				setElementData(player,"spikecol",source)
				bindKey(player,"E","down",removeSpikestrip,player)
				end
            end 
        end
		end)
		
addEventHandler("onColShapeLeave",root,
		function (player,_) 
		if getElementData(source,"spike") == true then
            if player and getElementType(player) == "player" then 
				unbindKey(player,"E","down",removeSpikestrip)
				removeElementData(player,"spikecol")
            end 
        end
		end)
	
--addCommandHandler("stingtest",deploySpikestrip)

--NICKNAME CHECKS & COLOR CODE REMOVER -- credits:FEAR

-- Check if a nick is too long
addEventHandler( "onPlayerChangeNick", root,
	function ( oldNick, newNick )
		if ( string.len ( newNick ) > 18 ) then
			cancelEvent()
			outputChatBox("New nickname too long, changed back to ".. oldNick ..".", source, 255, 0, 0)
			setPlayerName ( source, oldNick )
		end
	end
)

-- Check the nick on connect
addEventHandler ( "onPlayerConnect", root,
function ( playerNick, playerIP, playerUsername, playerSerial, playerVersionNumber )
    if ( playerNick == "Player" ) or ( playerNick == "player" ) or ( playerNick == "Admin" )  or ( playerNick == "Moderator" ) or ( playerNick == "moderator" ) or ( playerNick == "admin" ) or ( playerNick == "Nickname" ) or ( playerNick == "nickname" ) then
        cancelEvent( true, "Nickname not allowed, please change it. (Settings > Multiplayer tab)" )
    elseif ( string.len ( playerNick ) > 18 ) then
		cancelEvent( true, "Nickname too long, please change it. (Settings > Multiplayer tab)" )
    end
end
)

function deletecc()
	for k, v in ipairs (getElementsByType("player")) do
		local name = getPlayerName(v)
			if (string.find(name,"#%x%x%x%x%x%x")) then
				local name = string.gsub(name,"#%x%x%x%x%x%x","")
				setPlayerName(v,name)
				cancelEvent()
			end
	end
end

addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),deletecc)

function removeCC(oldNick,newNickname)
	local name = getPlayerName(source)
	if newNickname then
		name = newNickname
	end
	if (string.find(name,"#%x%x%x%x%x%x")) then
		local name = string.gsub(name,"#%x%x%x%x%x%x","")
		setPlayerName(source,name)
			if (newNickname) then
				cancelEvent()
			end
	end	
end

addEventHandler("onPlayerJoin",getRootElement(),removeCC)

addEventHandler("onPlayerChangeNick",getRootElement(),removeCC)