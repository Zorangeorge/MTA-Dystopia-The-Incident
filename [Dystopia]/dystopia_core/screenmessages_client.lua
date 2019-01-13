--[[
    # Resource Name
	  Rage's Wasted Screen
	# Author
	  Rage
	# Date
	  1.05.2014
	# Copyright (c)
	  If you edit it, then please respect me and keep
	  the credits.
--]]

---------------TOP, STATUS AND INTERACT MESSAGES

local text = ""
local text2 = ""
local interact = ""
local interact2 = ""
local status = ""
local status2 = ""
local messages =  { }
local statuses = { }
local interactions = { }

local r,g,b = 255,255,255
local ChunkfiveFont = dxCreateFont ( "fonts/Chunkfive.otf", 100 )

function outputTopBarMessage( cmd, red, green, blue, ... )
	local arg = {...}
	local message = table.concat( arg, " " )
	text = message
	r = red
	g = green
	b = blue
end
--addCommandHandler ( "topbar", outputTopBarMessage )

function outputStatusMessage( cmd, red, green, blue, ... )
	local arg = {...}
	local message = table.concat( arg, " " )
	status = message
	r = red
	g = green
	b = blue
end
--addCommandHandler ( "status", outputStatusMessage )

function outputInteractionMessage( cmd, red, green, blue, ... )
	local arg = {...}
	local message = table.concat( arg, " " )
	interact = message
	r = red
	g = green
	b = blue
end
--addCommandHandler ( "interactionmessage", outputInteractionMessage )

local timer = nil
function outputTopBar( message, red, green, blue )
	text = message
	r = red
	g = green
	b = blue
	-- Fix the ability to set the same message twice with anti spam included
	if isTimer( timer ) then
		killTimer( timer )
	end
	timer = setTimer( function() text = "" end, 1000, 1 )
end

local statustimer = nil
function outputStatusInfo( message, red, green, blue )
	status = message
	r = red
	g = green
	b = blue

	if isTimer( statustimer ) then
		killTimer( statustimer )
	end
	statustimer = setTimer( function() status = "" end, 1000, 1 )
end

local interacttimer = nil
function outputInteractInfo( message, red, green, blue )
	interact = message
	r = red
	g = green
	b = blue

	if isTimer( interacttimer ) then
		killTimer( interacttimer )
	end
	interacttimer = setTimer( function() interact = "" end, 300, 1 )
end

addEvent( "onTextAdd", true )
addEvent( "onStatusAdd", true )
addEvent( "onInteractAdd", true )
addEventHandler( "onTextAdd", getRootElement(), outputTopBar )
addEventHandler( "onStatusAdd", getRootElement(), outputStatusInfo )
addEventHandler( "onInteractAdd", getRootElement(), outputInteractInfo )

addEventHandler ( "onClientRender", root, function ( ) --INTERACTINFO RENDER
	local tick = getTickCount ( )
	local sx,sy = guiGetScreenSize ( )
	if (interact ~= interact2 and interact ~= "" ) then
		table.insert ( interactions, { interact, true, tick + 1500, 150, r, g, b } ) --1500 is the number of miliseconds before message fades out
	end
	interact2 = interact
	if ( #interactions > 2 ) then
		table.remove ( interactions, 1 )
	end
	
	for iindex, idata in ipairs ( interactions ) do
		local v1 = idata[1]
		local v2 = idata[2]
		local v3 = idata[3]
		local v4 = idata[4]
		local v5 = idata[5]
		local v6 = idata[6]
		local v7 = idata[7]
		
		dxDrawText ( v1, (sx/2)-2, ((sy-sy/10*1.01)-(iindex*46))-2,   sx/2, 0, tocolor( 1, 1, 1, v4+75 ), 0.1, ChunkfiveFont, "center", "top" ) -- interact shadow
		dxDrawText ( v1,  sx/2, (sy-sy/10*1.01)-(iindex*46),    sx/2, 0, tocolor( v5, v6, v7, v4+75 ), 0.1, ChunkfiveFont, "center", "top" ) -- interact text
		
		if ( tick >= v3 ) then
			interactions[iindex][4] = v4-2
			if ( v4 <= 25 ) then
				table.remove ( interactions, iindex )
			end
		end
	end
end )

addEventHandler ( "onClientRender", root, function ( ) --STATUSINFO RENDER
	local tick = getTickCount ( )
	local sx,sy = guiGetScreenSize ( )
	if ( status ~= status2 and status ~= "" ) then
		table.insert ( statuses, { status, true, tick + 1500, 150, r, g, b } ) --1500 is the number of miliseconds before message fade out
	end
	status2 = status
	if ( #statuses > 7 ) then
		table.remove ( statuses, 1 )
	end
	
	for sindex, sdata in ipairs ( statuses ) do
		local v1 = sdata[1]
		local v2 = sdata[2]
		local v3 = sdata[3]
		local v4 = sdata[4]
		local v5 = sdata[5]
		local v6 = sdata[6]
		local v7 = sdata[7]

		dxDrawText ( v1, (sx/2+sx/8)-2, ((sy/2)+(sindex*46)+sy/8)-2, sx/2, 0, tocolor( 1, 1, 1, v4+75 ), 0.1, ChunkfiveFont, "center", "center" ) -- status shadow
		dxDrawText ( v1, sx/2+sx/8, (sy/2)+(sindex*46)+sy/8, sx/2, 0, tocolor( v5, v6, v7, v4+75 ), 0.1, ChunkfiveFont, "center", "center" ) -- status text
		
		if ( tick >= v3 ) then
			statuses[sindex][4] = v4-2
			if ( v4 <= 25 ) then
				table.remove ( statuses, sindex )
			end
		end
	end
end )

addEventHandler ( "onClientRender", root, function ( ) --TOPBAR RENDER
	local tick = getTickCount ( )
	local sx,sy = guiGetScreenSize ( )
	if ( text ~= text2 and text ~= "" ) then
		table.insert ( messages, { text, true, tick + 9000, 150, r, g, b } )
	end
	text2 = text
	if ( #messages > 7 ) then
		table.remove ( messages, 1 )
	end
	
	for index, data in ipairs ( messages ) do
		local v1 = data[1]
		local v2 = data[2]
		local v3 = data[3]
		local v4 = data[4]
		local v5 = data[5]
		local v6 = data[6]
		local v7 = data[7]

		dxDrawText ( v1, sx/2-2, ((-25)+(index*46))-2, sx/2, 0, tocolor( 1, 1, 1, v4+75 ), 0.1, ChunkfiveFont, "center", "center" ) --topbar shadow
		dxDrawText ( v1, sx/2, (-25)+(index*46), sx/2, 0, tocolor( v5, v6, v7, v4+75 ), 0.1, ChunkfiveFont, "center", "center" ) --topbar text
		
		if ( tick >= v3 ) then
			messages[index][4] = v4-2
			if ( v4 <= 25 ) then
				table.remove ( messages, index )
			end
		end
	end
end )
---------------------------------------------------

addEvent("SlitMission1", true)

local screenW,screenH = guiGetScreenSize()
local resW,resH = 1280,720
local sW,sH =  (screenW/resW), (screenH/resH)

    function drawPlayerWastedScreen()
        --dxDrawRectangle(0*sW, 239*sH, 1280*sW, 147*sH, tocolor(0, 0, 0, 100), true)
		
		if getElementData(localPlayer,"lives")<1 then --text = "You're dead" else text = "Wasted" end
        dxDrawText("Wasted", 328*sW, 240*sH, 955*sW, 386*sH, tocolor(0, 0, 0, 255), 4.00, "pricedown", "center", "center", false, false, true, false, false)
        dxDrawText("Wasted", 328*sW, 238*sH, 955*sW, 384*sH, tocolor(0, 0, 0, 255), 4.00, "pricedown", "center", "center", false, false, true, false, false)
        dxDrawText("Wasted", 326*sW, 240*sH, 953*sW, 386*sH, tocolor(0, 0, 0, 255), 4.00, "pricedown", "center", "center", false, false, true, false, false)
        dxDrawText("Wasted", 326*sW, 238*sH, 953*sW, 384*sH, tocolor(0, 0, 0, 255), 4.00, "pricedown", "center", "center", false, false, true, false, false)
        dxDrawText("Wasted", 327*sW, 239*sH, 954*sW, 385*sH, tocolor(180, 23, 23, 240), 4.00, "pricedown", "center", "center", false, false, true, false, false)
		else
		--dxDrawText("Wasted", 328*sW, 240*sH, 955*sW, 386*sH, tocolor(0, 0, 0, 255), 4.00, "pricedown", "center", "center", false, false, true, false, false)
        --dxDrawText("Wasted", 328*sW, 238*sH, 955*sW, 384*sH, tocolor(0, 0, 0, 255), 4.00, "pricedown", "center", "center", false, false, true, false, false)
        --dxDrawText("Wasted", 326*sW, 240*sH, 953*sW, 386*sH, tocolor(0, 0, 0, 255), 4.00, "pricedown", "center", "center", false, false, true, false, false)
        --dxDrawText("Wasted", 326*sW, 238*sH, 953*sW, 384*sH, tocolor(0, 0, 0, 255), 4.00, "pricedown", "center", "center", false, false, true, false, false)
        --dxDrawText("Wasted", 327*sW, 239*sH, 954*sW, 385*sH, tocolor(180, 23, 23, 240), 4.00, "pricedown", "center", "center", false, false, true, false, false)
		end
    end
	
addEventHandler( "onClientPlayerWasted", getLocalPlayer(),
    function()
        addEventHandler("onClientRender", root, drawPlayerWastedScreen)
		removeScreen("wasted")
        playSound("sounds/wasted.mp3")	
	end)	
  
function removeScreen(id)
	setTimer ( function()
					if id == "wasted" then removeEventHandler("onClientRender", root, drawPlayerWastedScreen)	
					elseif id == "test" then removeEventHandler("onClientRender", root, drawPlayerTestScreen)
					elseif id == "infected" then removeEventHandler("onClientRender", root, drawInfected1)
					elseif id == "slit1" then removeEventHandler("onClientRender", root, drawPlayerSlitMission1Screen)
					elseif id == "levelupscreen" then removeEventHandler("onClientRender", root, drawLevelUpScreen)
					elseif id == "forcefeedhelp" then removeEventHandler("onClientRender", root, forceFeedHelp)
					elseif id == "escape" then removeEventHandler("onClientRender", root, drawPlayerEscapeScreen)
					end
				end, 5000, 1 )
end	

addEventHandler( "onClientPlayerSpawn", getLocalPlayer(),
	function()

    end)
	
--------------------------------------
addEvent("DrawQuestTitle",true)
tt1 = nil
tt2 = nil
tt3 = nil
objective_background = nil

function removeQuestTitleScreen()
setTimer ( function() removeEventHandler("onClientRender", root, drawPlayerQuestTitle) tt1 = nil tt2 = nil tt3 = nil objective_background = nil end, 5000,1)
end

function drawPlayerQuestTitle ()
		if objective_background ~= "no" then
		dxDrawRectangle(0*sW, 239*sH-185, 1280*sW, 147*sH, tocolor(0, 0, 0, 200), true)
		end
		dxDrawText(tt1, 327*sW-2, 239*sH-132, 954*sW, 385*sH-330, tocolor(0, 0, 0, 255), 1.5, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawText(tt1, 327*sW, 239*sH-130, 954*sW, 385*sH-330, tocolor(204, 204, 204, 255), 1.5, "default-bold", "center", "center", false, false, true, false, false)
		
		dxDrawText(tt2, 326*sW-2, 240*sH-92, 953*sW, 386*sH-300, tocolor(0, 0, 0, 255), 2.00, "pricedown", "center", "center", false, false, true, false, false)
		dxDrawText(tt2, 326*sW, 240*sH-90, 953*sW, 386*sH-300, tocolor(200, 200, 200, 255), 2.00, "pricedown", "center", "center", false, false, true, false, false)
		
		dxDrawText(tt3, 327*sW-2, 239*sH-52, 954*sW, 385*sH-250, tocolor(0, 0, 0, 255), 1.5, "default-bold", "center", "center", false, false, true, false, false)
		dxDrawText(tt3, 327*sW, 239*sH-50, 954*sW, 385*sH-250, tocolor(204, 204, 204, 255), 1.5, "default-bold", "center", "center", false, false, true, false, false)
end

addEventHandler( "DrawQuestTitle", root, function(title1,title2,title3,background)
		tt1 = title1
		tt2 = title2
		tt3 = title3
		objective_background = background
		--if not background then background = true end
        addEventHandler("onClientRender", root, drawPlayerQuestTitle)
		playSound("sounds/levelup.wav")
		removeQuestTitleScreen()
end)



function drawPlayerTestScreen()
        dxDrawRectangle(0*sW, 239*sH-150, 1280*sW, 147*sH, tocolor(0, 0, 0, 100), true)
		
        dxDrawText("NEW MISSION:", 327*sW, 239*sH-30-150, 954*sW, 385*sH-30-150, tocolor(204, 204, 204, 255), 1.5, "default-bold", "center", "center", false, false, true, false, false)
		dxDrawText("Stay alive!", 326*sW, 240*sH-150, 953*sW, 386*sH-150, tocolor(63, 173, 209, 255), 2.00, "pricedown", "center", "center", false, false, true, false, false)
		dxDrawText("Hold F1 for help", 327*sW, 239*sH+50-150, 954*sW, 385*sH+50-150, tocolor(204, 204, 204, 255), 1.5, "default-bold", "center", "center", false, false, true, false, false)
end

function drawPlayerEscapeScreen()
        dxDrawRectangle(0*sW, 239*sH-150, 1280*sW, 147*sH, tocolor(0, 0, 0, 100), true)
		
        dxDrawText("Congratulations!", 327*sW, 239*sH-30-150, 954*sW, 385*sH-30-150, tocolor(204, 204, 204, 255), 1.5, "default-bold", "center", "center", false, false, true, false, false)
		dxDrawText("YOU ESCaPED!", 326*sW, 240*sH-140, 953*sW, 386*sH-140, tocolor(255, 200, 0, 255), 2.00, "pricedown", "center", "center", false, false, true, false, false)
		dxDrawText("Yeah, it's 'Game Over'!", 327*sW, 239*sH+50-150, 954*sW, 385*sH+50-150, tocolor(204, 204, 204, 255), 1.5, "default-bold", "center", "center", false, false, true, false, false)
end

	--[[addCommandHandler( "testmessage", function()
        addEventHandler("onClientRender", root, drawPlayerTestScreen)
		removeScreen("test")
        end)]]
		
--[[	addCommandHandler( "escapemessage", function()
        addEventHandler("onClientRender", root, drawPlayerEscapeScreen)
		removeScreen("escape")
        end)	]]
		
	function drawInfected1()
	
	dxDrawRectangle(0*sW, 239*sH-150, 1280*sW, 147*sH, tocolor(0, 0, 0, 100), true)
		
        dxDrawText("NEW MISSION:", 327*sW, 239*sH-30-150, 954*sW, 385*sH-30-150, tocolor(204, 204, 204, 255), 1.5, "default-bold", "center", "center", false, false, true, false, false)
		dxDrawText("Infected!", 326*sW, 240*sH-150, 953*sW, 386*sH-150, tocolor(100, 209, 63, 255), 2.00, "pricedown", "center", "center", false, false, true, false, false)
		dxDrawText("Find a cure before it's too late", 327*sW, 239*sH+50-150, 954*sW, 385*sH+50-150, tocolor(204, 204, 204, 255), 1.5, "default-bold", "center", "center", false, false, true, false, false)
    end

	function drawPlayerSlitMission1Screen()
        dxDrawRectangle(0*sW, 239*sH-150, 1280*sW, 147*sH, tocolor(0, 0, 0, 100), true)
		
        dxDrawText("NEW MISSION:", 327*sW, 239*sH-30-150, 954*sW, 385*sH-30-150, tocolor(204, 204, 204, 255), 1.5, "default-bold", "center", "center", false, false, true, false, false)
		dxDrawText("Stick it to The Man", 326*sW, 240*sH-150, 953*sW, 386*sH-150, tocolor(63, 173, 209, 255), 2.00, "pricedown", "center", "center", false, false, true, false, false)
		dxDrawText("Follow Slit to safety", 327*sW, 239*sH+50-150, 954*sW, 385*sH+50-150, tocolor(204, 204, 204, 255), 1.5, "default-bold", "center", "center", false, false, true, false, false)
    end
	
	addEvent("LevelUpScreen", true)
	addEvent("EscapedScreen", true)
	
	function drawLevelUpScreen()
	
	local level = getPlayerLevel(localPlayer)
	--if level == 1 then return end
	local lvlmessg
	if level < 11 then lvlmessg = level end
	if level == 11 then lvlmessg = "Hero" end
	if level == 12 then lvlmessg = "Legend" end
	if level > 12 then lvlmessg = "WTF?!" end
	
        --dxDrawRectangle(0*sW, 239*sH, 1280*sW, 147*sH, tocolor(0, 0, 0, 100), true)

		dxDrawText("Level up!", 326*sW-2, 240*sH-2, 953*sW, 386*sH, tocolor(0, 0, 0, 255), 2.00, "pricedown", "center", "center", false, false, true, false, false)
		dxDrawText("Level up!", 326*sW, 240*sH, 953*sW, 386*sH, tocolor(255, 255, 255, 255), 2.00, "pricedown", "center", "center", false, false, true, false, false)
		dxDrawText("Level: "..lvlmessg.."", 327*sW-2, 239*sH+50-2, 954*sW, 385*sH+50, tocolor(0, 0, 0, 255), 1.5, "default-bold", "center", "center", false, false, true, false, false)
		dxDrawText("Level: "..lvlmessg.."", 327*sW, 239*sH+50, 954*sW, 385*sH+50, tocolor(204, 204, 204, 255), 1.5, "default-bold", "center", "center", false, false, true, false, false)
    end

	addEventHandler( "LevelUpScreen", root, function()
        addEventHandler("onClientRender", root, drawLevelUpScreen)
		playSound("sounds/levelup.wav")
		removeScreen("levelupscreen")
        end)	
		
	addEventHandler( "EscapedScreen", root, function()
        addEventHandler("onClientRender", root, drawPlayerEscapeScreen)
		playSound("sounds/levelup.wav")
		removeScreen("escape")
        end)	

	addEventHandler( "SlitMission1", root, function()
        addEventHandler("onClientRender", root, drawPlayerSlitMission1Screen)
		removeScreen("slit1")
        end)
	
	addEvent("ForceFeedHelpMessage",true)
		function forceFeedHelp()
		if getElementData(localPlayer,"lives") == 3 then
		dxDrawText("Quick help\n[F1]", 327*sW-2, 239*sH+50-150-2, 954*sW, 385*sH+50-150, tocolor(0, 0, 0, 255), 0.2, ChunkfiveFont, "center", "center", false, false, true, false, false)
		dxDrawText("Quick help\n[F1]", 327*sW, 239*sH+50-150, 954*sW, 385*sH+50-150, tocolor(204, 204, 204, 255), 0.2, ChunkfiveFont, "center", "center", false, false, true, false, false)
		end
		end
		addEventHandler( "ForceFeedHelpMessage", root, function()
			addEventHandler("onClientRender", root, forceFeedHelp)
			removeScreen("forcefeedhelp")
		
        end)

--[[currentWorldItem = ""
invoFull = false
--currentItemTextColor = 255,255,255,255
addEvent("currentWorldItemChange",true)	
addEvent("clearTheCurrentWorldItem",true)	

function showCurrentWorldItem ()
	if currentWorldItem ~= "" then
	
	local r,g,b,a
	
	if invoFull then r,g,b,a = 240,0,0,255 else r,g,b,a = 255,255,255,255 end
	
			local sx,sy = guiGetScreenSize( )
			dxDrawText ( "Pick up\n[E]" , (sx/2)-2, (sy-sy/10*1.01)-2,   sx/2, 0, tocolor( 1, 1, 1, 255), 0.1, ChunkfiveFont, "center", "top" ) -- shadow
			dxDrawText ( "Pick up\n[E]",  sx/2, (sy-sy/10*1.01),    sx/2, 0, tocolor( r,g,b,a ), 0.1, ChunkfiveFont, "center", "top" ) -- text
	end
end
addEventHandler("onClientRender", root, showCurrentWorldItem)


function changeCurrentWorldItem(itemName, full)
if itemName then currentWorldItem = itemName end
if full == true then invoFull = true else invoFull = false end
end	
addEventHandler("currentWorldItemChange", root, changeCurrentWorldItem)	

function clearCurrentWorldItem_c()
currentWorldItem = ""
currentItemTextColor = 255,255,255
end	
addEventHandler("clearTheCurrentWorldItem", root, clearCurrentWorldItem_c)	]]