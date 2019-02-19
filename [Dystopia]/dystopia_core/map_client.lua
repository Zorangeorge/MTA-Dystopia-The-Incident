g_Root = getRootElement()
g_client = getLocalPlayer()
g_thisRes = getThisResource()
g_mapEnabled = false

g_blipIndex = 0
g_blip = { }
g_blipAIndex = 0
g_blipA = { }

g_screenWidth, g_screenHeight = guiGetScreenSize ( )

g_mapA = 250--128
g_mapW = g_screenHeight
g_mapH = g_screenHeight
g_mapX = g_screenWidth/2 - g_mapW/2
g_mapY = g_screenHeight/2 - g_mapH/2

g_Adj = g_mapW/6000


g_blipList = {
	[0] = dxCreateTexture( "blips/0.png" ),
	[1] = dxCreateTexture( "blips/1.png" ),
	[2] = dxCreateTexture( "blips/2.png" ),
	[3] = dxCreateTexture( "blips/3.png" ),
	[4] = dxCreateTexture( "blips/4.png" ),
	[5] = dxCreateTexture( "blips/5.png" ),
	[6] = dxCreateTexture( "blips/6.png" ),
	[7] = dxCreateTexture( "blips/7.png" ),
	[8] = dxCreateTexture( "blips/8.png" ),
	[9] = dxCreateTexture( "blips/9.png" ),
	[10] = dxCreateTexture( "blips/10.png" ),
	[11] = dxCreateTexture( "blips/11.png" ),
	[12] = dxCreateTexture( "blips/12.png" ),
	[13] = dxCreateTexture( "blips/13.png" ),
	[14] = dxCreateTexture( "blips/14.png" ),
	[15] = dxCreateTexture( "blips/15.png" ),
	[16] = dxCreateTexture( "blips/16.png" ),
	[17] = dxCreateTexture( "blips/17.png" ),
	[18] = dxCreateTexture( "blips/18.png" ),
	[19] = dxCreateTexture( "blips/19.png" ),
	[20] = dxCreateTexture( "blips/20.png" ),
	[21] = dxCreateTexture( "blips/21.png" ),
	[22] = dxCreateTexture( "blips/22.png" ),
	[23] = dxCreateTexture( "blips/23.png" ),
	[24] = dxCreateTexture( "blips/24.png" ),
	[25] = dxCreateTexture( "blips/25.png" ),
	[26] = dxCreateTexture( "blips/26.png" ),
	[27] = dxCreateTexture( "blips/27.png" ),
	[28] = dxCreateTexture( "blips/28.png" ),
	[29] = dxCreateTexture( "blips/29.png" ),
	[30] = dxCreateTexture( "blips/30.png" ),
	[31] = dxCreateTexture( "blips/31.png" ),
	[32] = dxCreateTexture( "blips/32.png" ),
	[33] = dxCreateTexture( "blips/33.png" ),
	[34] = dxCreateTexture( "blips/34.png" ),
	[35] = dxCreateTexture( "blips/35.png" ),
	[36] = dxCreateTexture( "blips/36.png" ),
	[37] = dxCreateTexture( "blips/37.png" ),
	[38] = dxCreateTexture( "blips/38.png" ),
	[39] = dxCreateTexture( "blips/39.png" ),
	[40] = dxCreateTexture( "blips/40.png" ),
	[41] = dxCreateTexture( "blips/41.png" ),
	[42] = dxCreateTexture( "blips/42.png" ),
	[43] = dxCreateTexture( "blips/43.png" ),
	[44] = dxCreateTexture( "blips/44.png" ),
	[45] = dxCreateTexture( "blips/45.png" ),
	[46] = dxCreateTexture( "blips/46.png" ),
	[47] = dxCreateTexture( "blips/47.png" ),
	[48] = dxCreateTexture( "blips/48.png" ),
	[49] = dxCreateTexture( "blips/49.png" ),
	[50] = dxCreateTexture( "blips/50.png" ),
	[51] = dxCreateTexture( "blips/51.png" ),
	[52] = dxCreateTexture( "blips/52.png" ),
	[53] = dxCreateTexture( "blips/53.png" ),
	[54] = dxCreateTexture( "blips/54.png" ),
	[55] = dxCreateTexture( "blips/55.png" ),
	[56] = dxCreateTexture( "blips/56.png" ),
	[57] = dxCreateTexture( "blips/57.png" ),
	[58] = dxCreateTexture( "blips/58.png" ),
	[59] = dxCreateTexture( "blips/59.png" ),
	[60] = dxCreateTexture( "blips/60.png" ),
	[61] = dxCreateTexture( "blips/61.png" ),
	[62] = dxCreateTexture( "blips/62.png" ),
	--[63] = dxCreateTexture( "blips/63.png" )
	--[64] = dxCreateTexture( "blips/64.png" )
}

function dxDrawCircle( posX, posY, radius, width, angleAmount, startAngle, stopAngle, color, postGUI )
	if ( type( posX ) ~= "number" ) or ( type( posY ) ~= "number" ) then
		return false
	end
 
	local function clamp( val, lower, upper )
		if ( lower > upper ) then lower, upper = upper, lower end
		return math.max( lower, math.min( upper, val ) )
	end
 
	radius = type( radius ) == "number" and radius or 50
	width = type( width ) == "number" and width or 5
	angleAmount = type( angleAmount ) == "number" and angleAmount or 1
	startAngle = clamp( type( startAngle ) == "number" and startAngle or 0, 0, 360 )
	stopAngle = clamp( type( stopAngle ) == "number" and stopAngle or 360, 0, 360 )
	color = color or tocolor( 255, 255, 255, 200 )
	postGUI = type( postGUI ) == "boolean" and postGUI or false
 
	if ( stopAngle < startAngle ) then
		local tempAngle = stopAngle
		stopAngle = startAngle
		startAngle = tempAngle
	end
 
	for i = startAngle, stopAngle, angleAmount do
		local startX = math.cos( math.rad( i ) ) * ( radius - width )
		local startY = math.sin( math.rad( i ) ) * ( radius - width )
		local endX = math.cos( math.rad( i ) ) * ( radius + width )
		local endY = math.sin( math.rad( i ) ) * ( radius + width )
 
		dxDrawLine( startX + posX, startY + posY, endX + posX, endY + posY, color, width, postGUI )
	end
 
	return true
end

function getCameraRotation ()
    local px, py, pz, lx, ly, lz = getCameraMatrix()
    local rotz = 6.2831853071796 - math.atan2 ( ( lx - px ), ( ly - py ) ) % 6.2831853071796
    local rotx = math.atan2 ( lz - pz, getDistanceBetweenPoints2D ( lx, ly, px, py ) )
    --Convert to degrees
    rotx = math.deg(rotx)
    rotz = -math.deg(rotz)	
    return rotx, 180, rotz
end

function startResource( theRes )
	if theRes == g_thisRes then
		setPlayerHudComponentVisible( "radar", false )
		toggleControl ( "radar", false )
	end
end
addEventHandler ( "onClientResourceStart", g_Root, startResource)

function endResource( theRes )
	if theRes == g_thisRes then
		setPlayerHudComponentVisible( "radar", true )
		toggleControl ( "radar", true )
		for i,v in ipairs(getElementsByType("dxBlip")) do
			destroyElement (v)
		end
		for i,v in ipairs(getElementsByType("dxBlipA")) do
			destroyElement (v)
		end
	end
end
addEventHandler ( "onClientResourceStop", g_Root, endResource)

addEvent("mapUsed",true)

MapImage = dxCreateTexture( "images/map.png" )
SurvivorMapImage = dxCreateTexture( "images/map_survivor.png" )
MilitaryMapImage = dxCreateTexture( "images/map_military.png" )
EmptyMapImage = dxCreateTexture( "images/empty.png" )

local cmd 	
local map

function createMap()

local theMapImage = cmd
map = getElementData(localPlayer,"currentmap")
if not theMapImage then return end
	dxDrawImage(g_mapX,g_mapY,g_mapW,g_mapH, theMapImage,0,0,0,tocolor(255,255,255,g_mapA))
	for i,v in ipairs(getElementsByType("dxBlip")) do
		local icon = getElementData ( v, "icon" )
		local width = getElementData ( v, "width" )
		local height = getElementData ( v, "height" )
		local color = getElementData ( v, "color" )
		local x,y,z = getElementPosition ( v )
		local rotation = getElementData ( v, "rotZ" )

		dxDrawImage(
			x*g_Adj + g_screenWidth/2 - width/2,
			-y*g_Adj + g_screenHeight/2 - height/2,
			width, height, icon, 360-rotation,0,0, color
		)
	end
	
	for i,v in ipairs(getElementsByType("dxBlipA")) do
		local elemAttachedTo = getElementData ( v, "elemTo" )
		local icon = getElementData ( v, "icon" )
		local width = getElementData ( v, "width" )
		local height = getElementData ( v, "height" )
		local color = getElementData ( v, "color" )
		local x,y,z = getElementPosition(elemAttachedTo)
		local rx,ry,rotation = getElementRotation(elemAttachedTo) 
		
		if rotation == nil then rotation = 0 end

		if x then dxDrawImage(
			x*g_Adj + g_screenWidth/2 - width/2,
			-y*g_Adj + g_screenHeight/2 - height/2,
			width, height, icon, 360-rotation,0,0, color
		)
		end

	end
	for i,v in ipairs(getElementsByType("blip")) do
		local x,y,z = getElementPosition(v)
		dxDrawImage(x*g_Adj + g_screenWidth/2 -8,-y*g_Adj + g_screenHeight/2 -8,16,16,g_blipList[getBlipIcon(v)],0,0,0,tocolor(255,255,255,255))
	end
end

function playMapSound ()
		if not mapsound then
				mapsound = playSound("sounds/map.mp3", false)
				setSoundVolume(mapsound,0.5)
				setTimer(function() if mapsound then mapsound = nil end end,1000,1)
		end
end

addEvent("closeMapOnDropped",true)

function closeTheMapOnDropped()
if g_mapEnabled then removeEventHandler( "onClientRender", g_Root, createMap ) end 
end		
addEventHandler("closeMapOnDropped",g_Root,closeTheMapOnDropped)

blipscreated = false

function showmap (button,press)

if button ~= "m" then return end
	
	if getElementData(localPlayer,"currentmap") then
	bindKey ( "m", "both", toggleMap) --sends key,keystate,arguments to the function
		
	else 
	unbindKey ("m")
	end
if g_mapEnabled then toggleMap(map) toggleMap(map)end
	
end
addEventHandler("onClientKey",root,showmap)

function toggleMap(map)

	if map == "Map" then cmd = MapImage; playMapSound ()
	elseif map == "Survivor Map" then cmd = SurvivorMapImage; playMapSound ()
	elseif map == "Military Map" then cmd = MilitaryMapImage; playMapSound ()
	else theMapImage = EmptyMapImage 
	end
	
	--if theMapImage ~= EmptyMapImage then
		
	--end
					
	if g_mapEnabled then
		
		removeEventHandler( "onClientRender", g_Root, createMap)
		
	else
		addEventHandler ( "onClientRender", g_Root, createMap)
		if blipscreated == false then
		addPlayerMapBlips()
		blipscreated = true
		end
		
	end
	g_mapEnabled = not g_mapEnabled

end
addEventHandler("mapUsed",g_Root,toggleMap)

function dxCreateBlip( x,y,z, rotation, icon, width, height, color, visibleDistance )

	local newBlip = createElement( "dxBlip" )

	if rotation == nil then rotation=0 end
	if icon == nil then icon = 0 end
	if width == nil then width = 16 end
	if height == nil then height = 16 end
	if color == nil then color = tocolor(255,255,255,255) end
	if visibleDistance == nil then visibleDistance = 16000 end 

	setElementPosition(newBlip, x,y,z )
	setElementData ( newBlip, "rotZ", rotation )
	setElementData ( newBlip, "icon", g_blipList[icon] )
	setElementData ( newBlip, "width", width )
	setElementData ( newBlip, "height", height )
	setElementData ( newBlip, "color", color )
	setElementData ( newBlip, "visibleDistance", visibleDistance )
	return newBlip
end

function dxCreateBlipAttachedTo( elemAttachedTo, icon, width, height, color, visibleDistance )

	local newBlip = createElement( "dxBlipA" )

	if elemAttachedTo == nil then return false end
	if icon == nil then icon = 0 end
	if width == nil then width = 16 end
	if height == nil then height = 16 end
	if color == nil then color = tocolor(255,255,255,255) end
	if visibleDistance == nil then visibleDistance = 16000 end

	setElementData ( newBlip, "elemTo", elemAttachedTo )
	setElementData ( newBlip, "icon", g_blipList[icon] )
	setElementData ( newBlip, "onscreenicon", icon )
	setElementData ( newBlip, "width", width )
	setElementData ( newBlip, "height", height )
	setElementData ( newBlip, "color", color )
	setElementData ( newBlip, "visibleDistance", visibleDistance )

	return newBlip
end

addEvent("RefreshBlips",true)

allplayerblips = {}

local housesize = 24 --spawn/camp icon size

PLAYER_BLIPS_VISIBLE = false --TODO: put this in a settings file; TODO: 

function addPlayerMapBlips ()

	for _,blip in ipairs(allplayerblips) do
		if isElement(blip) then 
		destroyElement(blip) 
		end
	end
--SAFE CAMPS
	local spawns = getElementsByType("spawnpoint")
	local players = getElementsByType("player")
	local team = getPlayerTeam(localPlayer)
	local teamname 
	if team then teamname = getTeamName(team) else teamname = "Scavengers" end
for _,spawn in ipairs(spawns) do
	local spawnfaction = getElementData(spawn,"SpawnFaction")
	if spawnfaction == "Raiders" and spawnfaction == teamname then
		spblip = dxCreateBlipAttachedTo( spawn, 35, housesize, housesize, tocolor(240,0,0,255) )
		setElementData(spblip,"blip.visibleOnScreen",true,true) 
		elseif spawnfaction == "Scavengers" and spawnfaction == teamname then
		spblip =dxCreateBlipAttachedTo( spawn, 35, housesize, housesize, tocolor(255,255,255,255) )
		setElementData(spblip,"blip.visibleOnScreen",true,true) 
		elseif spawnfaction == "Establishment" and spawnfaction == teamname then
		spblip =dxCreateBlipAttachedTo( spawn, 32, housesize, housesize, tocolor(255,255,255,255) )
		setElementData(spblip,"blip.visibleOnScreen",true,true) 
		elseif spawnfaction == "Bandits" and spawnfaction == teamname then
		spblip =dxCreateBlipAttachedTo( spawn, 35, housesize, housesize, tocolor(153, 102, 51,255) )
		setElementData(spblip,"blip.visibleOnScreen",true,true) 
		elseif spawnfaction == "CDF" and spawnfaction == teamname then
		spblip =dxCreateBlipAttachedTo( spawn, 35, housesize, housesize, tocolor(0,102,204,255) )
		setElementData(spblip,"blip.visibleOnScreen",true,true) 
	end
	
	if spblip then 
	table.insert(allplayerblips,spblip)
	end
	
end		
--[[--QUEST BLIPS (per faction)		
	local team = getPlayerTeam(localPlayer)
	local teamname 
	if team then teamname = getTeamName(team) else teamname = "Scavengers" end
	
	if teamname =="Scavengers" then 
	local botspawns = getElementsByType("Scavenger_spawn")
		for _,spawn in ipairs(botspawns) do
		local bottype =  getElementData(spawn,"BotType") 
			if bottype == "ScavQuest" or bottype == "WasteQuest" or bottype == "SyndQuest" then
				questblip = dxCreateBlipAttachedTo( spawn, 37, 12, 12, tocolor(255,255,255,255) )
			end
			if questblip then 
				table.insert(allplayerblips,questblip)
				questblip = nil
			end
		end
	elseif teamname =="CDF" then 
	local botspawns = getElementsByType("CDF_spawn")
		for _,spawn in ipairs(botspawns) do
		local bottype =  getElementData(spawn,"BotType") 
			if bottype == "Quest" then
				questblip = dxCreateBlipAttachedTo( spawn, 37, 12, 12, tocolor(255,255,255,255) )
			end
			if questblip then 
				table.insert(allplayerblips,questblip)
				questblip = nil
			end
		end
	elseif teamname =="Raiders" then 
	local botspawns = getElementsByType("Raider_spawn")
		for _,spawn in ipairs(botspawns) do
		local bottype =  getElementData(spawn,"BotType") 
			if bottype == "Quest" then
				questblip = dxCreateBlipAttachedTo( spawn, 37, 12, 12, tocolor(255,255,255,255) )
			end
			if questblip then 
				table.insert(allplayerblips,questblip)
				questblip = nil
			end
		end
	elseif teamname =="Bandits" then 
	local botspawns = getElementsByType("Bandit_spawn")
		for _,spawn in ipairs(botspawns) do
		local bottype =  getElementData(spawn,"BotType") 
			if bottype == "Quest" then
				questblip = dxCreateBlipAttachedTo( spawn, 37, 12, 12, tocolor(255,255,255,255) )
			end
			if questblip then 
				table.insert(allplayerblips,questblip)
				questblip = nil
			end
		end
	elseif teamname =="Establishment" then 
	local botspawns = getElementsByType("Establishment_spawn")
		for _,spawn in ipairs(botspawns) do
		local bottype =  getElementData(spawn,"BotType") 
			if bottype == "Quest" then
				questblip = dxCreateBlipAttachedTo( spawn, 37, 12, 12, tocolor(255,255,255,255) )
			end
			if questblip then 
				table.insert(allplayerblips,questblip)
				questblip = nil
			end
		end
	end
]]

--VENDOR BLIPS (per faction)		
	local team = getPlayerTeam(localPlayer)
	local teamname 
	if team then teamname = getTeamName(team) else teamname = "Scavengers" end
	if teamname == "Scavengers" then 
	local botspawns = getElementsByType("Scavenger_spawn")
		for _,spawn in ipairs(botspawns) do
		local name =  getElementData(spawn,"name") 
			if name == "Outfitter" then
				questblip = dxCreateBlipAttachedTo( spawn, 26, 32, 32, tocolor(255,255,255,255) )
			elseif name == "Trader" then
				questblip = dxCreateBlipAttachedTo( spawn, 52, 32, 32, tocolor(255,255,255,255) )
			end
			if questblip then 
				table.insert(allplayerblips,questblip)
				questblip = nil
			end
		end
	elseif teamname == "Raiders" then 
	local botspawns = getElementsByType("Raider_spawn")
		for _,spawn in ipairs(botspawns) do
		local name =  getElementData(spawn,"name") 
			if name == "Outfitter" then
				questblip = dxCreateBlipAttachedTo( spawn, 26, 32, 32, tocolor(255,255,255,255) )
			elseif name == "Trader" then
				questblip = dxCreateBlipAttachedTo( spawn, 52, 32, 32, tocolor(255,255,255,255) )
			end
			if questblip then 
				table.insert(allplayerblips,questblip)
				questblip = nil
			end
		end
	elseif teamname == "CDF" then 
	local botspawns = getElementsByType("CDF_spawn")
		for _,spawn in ipairs(botspawns) do
		local name =  getElementData(spawn,"name") 
			if name == "Quartermaster" then
				questblip = dxCreateBlipAttachedTo( spawn, 26, 32, 32, tocolor(255,255,255,255) )
			elseif name == "Trader" then
				questblip = dxCreateBlipAttachedTo( spawn, 52, 32, 32, tocolor(255,255,255,255) )
			end
			if questblip then 
				table.insert(allplayerblips,questblip)
				questblip = nil
			end
		end
	elseif teamname == "Establishment" then 
	local botspawns = getElementsByType("Establishment_spawn")
		for _,spawn in ipairs(botspawns) do
		local name =  getElementData(spawn,"name") 
			if name == "Trader" then
				questblip = dxCreateBlipAttachedTo( spawn, 52, 32, 32, tocolor(255,255,255,255) )
			elseif name == "Quartermaster" then
				questblip = dxCreateBlipAttachedTo( spawn, 26, 32, 32, tocolor(255,255,255,255) )
			end
			if questblip then 
				table.insert(allplayerblips,questblip)
				questblip = nil
			end
		end
	elseif teamname == "Bandits" then 
	local botspawns = getElementsByType("Bandit_spawn")
		for _,spawn in ipairs(botspawns) do
		local name =  getElementData(spawn,"name") 
			if name == "Outfitter" then
				questblip = dxCreateBlipAttachedTo( spawn, 26, 32, 32, tocolor(255,255,255,255) )
			elseif name == "Trader" then
				questblip = dxCreateBlipAttachedTo( spawn, 52, 32, 32, tocolor(255,255,255,255) )
			end
			if questblip then 
				table.insert(allplayerblips,questblip)
				questblip = nil
			end
		end
	end
--[[--VEHICLES	
local vehicles = getElementsByType("vehicle")
for _,veh in ipairs(vehicles) do
	if getElementData(veh,"vehicle-scenery") == true then 
	--nothing
	else 
	vehblip = dxCreateBlipAttachedTo( veh, 55, 5, 5, tocolor(255,255,255,255) )
	end
end
]]
--MECHANIC BLIPS		
		local mechanicshops = getElementChildren(all_mechanic_cols,"marker")
		for _,mech in ipairs(mechanicshops) do
		
			if getElementData(mech,"BotTeam") == getPlayerTeam(localPlayer) then
				mechblip = dxCreateBlipAttachedTo( mech, 27, 20, 20, tocolor(255,255,255,255) )
			end	
			
			if mechblip then 
				table.insert(allplayerblips,mechblip)
				mechblip = nil
			end	
			
		end	
--PLAYERS	
if PLAYER_BLIPS_VISIBLE == true then
	for _,player in ipairs(players) do
		if player == localPlayer then 
		--nothing, solved separately above
		else	
			local targetgroup = getElementData ( player, "Group" ) or "N/A"
			local localgroup =  getElementData ( localPlayer, "Group" ) or "N/A"
			local color = nil
			
			if localgroup and localgroup ~= "--" and localgroup ~= "N/A" then 
				if localgroup == targetgroup then
					color = tocolor(51, 204, 255,255) --light blue blips for group members
				end
			end
			
			plblip = dxCreateBlipAttachedTo( player, 2, width, height, color )
			table.insert(allplayerblips,plblip)
			plblip = nil
		end
	end
end
--LOCAL PLAYER
if playerBlip then return else
localplayerBlip = dxCreateBlipAttachedTo( localPlayer, 2, width, height, tocolor(255,0,0,255) ) --localPlayer blip
table.insert(allplayerblips,localplayerBlip)
end

end

function addPlayerMapBlips_ALL ()

		for _,blip in ipairs(allplayerblips) do
			if isElement(blip) then 
			destroyElement(blip) 
			end
		end
		
-- VEHICLE BLIPS
		--[[local vehicles = getElementsByType("vehicle")
		for _,veh in ipairs(vehicles) do
			if getElementData(veh,"vehicle-scenery") == true then 
			--nothing
			else 
			vehblip = dxCreateBlipAttachedTo( veh, 55, 5, 5, tocolor(255,255,255,255) )
			end
			
			if vehblip then 
			table.insert(allplayerblips,vehblip)
			vehblip = nil
			end

		end]]
		
--SAFE CAMP BLIPS	
		local spawns = getElementsByType("spawnpoint")
		for _,spawn in ipairs(spawns) do
			local spawnfaction = getElementData(spawn,"SpawnFaction")
			if spawnfaction == "Raiders" then
				spblip = dxCreateBlipAttachedTo( spawn, 35, 8, 8, tocolor(240,0,0,255) )
				setElementData(spblip,"blip.visibleOnScreen",true,true) 
				elseif spawnfaction == "Scavengers" then
				spblip =dxCreateBlipAttachedTo( spawn, 35, 8, 8, tocolor(255,255,255,255) )
				setElementData(spblip,"blip.visibleOnScreen",true,true) 
				elseif spawnfaction == "Establishment" then
				spblip =dxCreateBlipAttachedTo( spawn, 32, 8, 8, tocolor(255,255,255,255) )
				setElementData(spblip,"blip.visibleOnScreen",true,true) 
				elseif spawnfaction == "Bandits" then
				spblip =dxCreateBlipAttachedTo( spawn, 35, 8, 8, tocolor(153, 102, 51,255) )
				setElementData(spblip,"blip.visibleOnScreen",true,true) 
				elseif spawnfaction == "CDF" then
				spblip =dxCreateBlipAttachedTo( spawn, 35, 8, 8, tocolor(0,102,204,255) )
				setElementData(spblip,"blip.visibleOnScreen",true,true) 
			end
			
			if spblip then 
			table.insert(allplayerblips,spblip)
			spblip = nil
			end
		end	
--FUEL BLIPS			
		local fuelsources = getElementsByType("Fuel_Source")
		for _,fuel in ipairs(fuelsources) do
			fuelblip = dxCreateBlipAttachedTo( fuel, 56, 12, 12, tocolor(255,255,255,255) )
			
			if fuelblip then 
				table.insert(allplayerblips,fuelblip)
				fuelblip = nil
			end	
			
		end
--MECHANIC BLIPS		
		local mechanicshops = getElementChildren(all_mechanic_cols,"marker")
		for _,mech in ipairs(mechanicshops) do
		
			if getElementData(mech,"BotTeam") == getPlayerTeam(localPlayer) then
				mechblip = dxCreateBlipAttachedTo( mech, 27, 24, 24, tocolor(255,255,255,255) )
			end	
			
			if mechblip then 
				table.insert(allplayerblips,mechblip)
				mechblip = nil
			end	
			
		end
--QUEST BLIPS (per faction)		
	local team = getPlayerTeam(localPlayer)
	local teamname 
	if team then teamname = getTeamName(team) else teamname = "Scavengers" end
	
	if teamname =="Scavengers" then 
	local botspawns = getElementsByType("Scavenger_spawn")
		for _,spawn in ipairs(botspawns) do
		local bottype =  getElementData(spawn,"BotType") 
			if bottype == "ScavQuest" or bottype == "WasteQuest" or bottype == "SyndQuest" then
				questblip = dxCreateBlipAttachedTo( spawn, 37, 20, 20, tocolor(255,255,255,255) )
			end
			if questblip then 
				table.insert(allplayerblips,questblip)
				questblip = nil
			end
		end
	elseif teamname =="CDF" then 
	local botspawns = getElementsByType("CDF_spawn")
		for _,spawn in ipairs(botspawns) do
		local bottype =  getElementData(spawn,"BotType") 
			if bottype == "Quest" then
				questblip = dxCreateBlipAttachedTo( spawn, 37, 20, 20, tocolor(255,255,255,255) )
			end
			if questblip then 
				table.insert(allplayerblips,questblip)
				questblip = nil
			end
		end
	elseif teamname =="Raiders" then 
	local botspawns = getElementsByType("Raider_spawn")
		for _,spawn in ipairs(botspawns) do
		local bottype =  getElementData(spawn,"BotType") 
			if bottype == "Quest" then
				questblip = dxCreateBlipAttachedTo( spawn, 37, 20, 20, tocolor(255,255,255,255) )
			end
			if questblip then 
				table.insert(allplayerblips,questblip)
				questblip = nil
			end
		end
	elseif teamname =="Bandits" then 
	local botspawns = getElementsByType("Bandit_spawn")
		for _,spawn in ipairs(botspawns) do
		local bottype =  getElementData(spawn,"BotType") 
			if bottype == "Quest" then
				questblip = dxCreateBlipAttachedTo( spawn, 37, 20, 20, tocolor(255,255,255,255) )
			end
			if questblip then 
				table.insert(allplayerblips,questblip)
				questblip = nil
			end
		end
	elseif teamname =="Establishment" then 
	local botspawns = getElementsByType("Establishment_spawn")
		for _,spawn in ipairs(botspawns) do
		local bottype =  getElementData(spawn,"BotType") 
			if bottype == "Quest" then
				questblip = dxCreateBlipAttachedTo( spawn, 37, 20, 20, tocolor(255,255,255,255) )
			end
			if questblip then 
				table.insert(allplayerblips,questblip)
				questblip = nil
			end
		end
	end
--PLAYER BLIPS		
		local players = getElementsByType("player")
		for _,player in ipairs(players) do
			if player == localPlayer then 
			--nothing, solved separately above
			else	
				local targetgroup = getElementData ( player, "Group" ) or "N/A"
				local localgroup =  getElementData ( localPlayer, "Group" ) or "N/A"
				local color = nil
				
				if localgroup and localgroup ~= "--" and localgroup ~= "N/A" then 
					if localgroup == targetgroup then
						color = tocolor(51, 204, 255,255) --light blue
					end
				end
				
				plblip = dxCreateBlipAttachedTo( player, 2, width, height, color )
				table.insert(allplayerblips,plblip)
				plblip = nil
			end
		end
		
		
-- localPlayer BLIP	
		if playerBlip then return else
			localplayerBlip = dxCreateBlipAttachedTo( localPlayer, 2, width, height, tocolor(255,0,0,255) ) --localPlayer blip
			table.insert(allplayerblips,localplayerBlip)
		end

end
addCommandHandler("allblips",addPlayerMapBlips_ALL)
addCommandHandler("blips",addPlayerMapBlips)
addEventHandler("RefreshBlips",root,addPlayerMapBlips)
addEventHandler("onPlayerJoin",root,addPlayerMapBlips)
setTimer(addPlayerMapBlips,60000,0)

-----------BLIPS ON SCREEN

local sx, sy = guiGetScreenSize()

local fadeDistance = 10
local minimumDistance = 2

local distanceFromEdge = 0.4

local backgroundSize = 26
local backgroundAlpha = 150

local blipImageSize = 20

addEventHandler("onClientRender", root,
function()
	local middleX, middleY = getWorldFromScreenPosition(sx/2, sy/2, 100)
	local cameraX, cameraY = getCameraMatrix()
	local playerX, playerY, playerZ = getElementPosition(localPlayer)
	local cameraAngle = findRotation(cameraX, cameraY, middleX, middleY)
	
	for index, blip in ipairs(getElementsByType("blip")) do 
		if getElementData(blip, "blip.visibleOnScreen") then
			local blipX, blipY, blipZ = getElementPosition(blip)
			local blipIcon = getElementData(blip, "onscreenicon") or getBlipIcon(blip)
			local blipR, blipG, blipB, blipA = 255,255,255,100
			local alpha = 100
			
			local targetAngle = findRotation(playerX, playerY, blipX, blipY)
			local realAngle = targetAngle - cameraAngle + 180
			
			if realAngle < 0 then
				realAngle = realAngle + 360
			end
			if realAngle > 360 then
				realAngle = realAngle - 360
			end
			
			local distance = getDistanceBetweenPoints3D(blipX, blipY, blipZ, playerX, playerY, playerZ)
			distance = math.floor(distance)
			
			local screenX, screenY = (sx * 0.5) + math.sin(math.rad(realAngle)) * (sy * distanceFromEdge), (sy * 0.5) + math.cos(math.rad(realAngle)) * (sy * distanceFromEdge)
			
			if distance <= fadeDistance then
				alpha = (blipA/(fadeDistance+minimumDistance)) * distance
				alphabg = (backgroundAlpha/(fadeDistance+minimumDistance)) * distance
				if distance < minimumDistance then
					alpha = 0
					alphabg = 0
				end
			else
				alpha = blipA
				alphabg = backgroundAlpha
			end

			local textOffset = 18
			local text = tostring(convertNumber(distance)) .. " m"
			dxDrawText(text, screenX+1, screenY+textOffset+1, screenX+1, screenY+textOffset+1, tocolor(0, 0, 0, alpha), 1, "default-bold", "center", "top")
			dxDrawText(text, screenX, screenY+textOffset, screenX, screenY+textOffset, tocolor(255, 255, 255, alpha), 1, "default-bold", "center", "top")
			
			dxDrawImage(screenX-blipImageSize/2, screenY-blipImageSize/2, blipImageSize, blipImageSize, "blips/" .. blipIcon .. ".png", 0, 0, 0, tocolor(blipR, blipG, blipB, alpha))
		end
	end
end)

function convertNumber(number)
	local formatted = number
	while true do
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return formatted
end

function dxDrawBorder(x, y, w, h, size, color, postGUI)
	size = size or 2;
	dxDrawRectangle(x - size, y, size, h, color or tocolor(0, 0, 0, 180), postGUI);
	dxDrawRectangle(x + w, y, size, h, color or tocolor(0, 0, 0, 180), postGUI);
	dxDrawRectangle(x - size, y - size, w + (size * 2), size, color or tocolor(0, 0, 0, 180), postGUI);
	dxDrawRectangle(x - size, y + h, w + (size * 2), size, color or tocolor(0, 0, 0, 180), postGUI);
end

function findRotation(startX, startY, targetX, targetY)
	local t = -math.deg(math.atan2(targetX - startX, targetY - startY))
	if t < 0 then
		t = t + 360
	end
	return t
end