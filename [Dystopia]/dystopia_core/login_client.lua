--[[--------------------------------|
----|                          |----|
----|    Simple DX LOGIN       |----|
----|      Copyright(c)        |----|
----|         by               |----|
----|    NearGreen(Gabox)      |----|
----|                          |----|
   *Do not remove credits, b1tch* 
-----------------------------------]]
--TITLE SCREEN 

addEvent("ShowTitleImage",true)

titlescreens = {"images/titlescreen1.png"}--, 
				--"images/titlescreen2.png" }

 function showClientTitleImage()
	
	local x,y = guiGetScreenSize()
	backgrectangle = guiCreateStaticImage ( 0, 0, x, y, "images/beltblack.png", false )
    myTitleImage = guiCreateStaticImage( (x-1024)/2,0.0,1024,768, table.random(titlescreens), false )
	centerWindow(myTitleImage)
	accBar = guiCreateEdit(px*479, py*230, px*190, py*33, "", false)
	passBar = guiCreateEdit(px*479, py*270, px*190, py*33, "", false)
	guiBringToFront(myTitleImage)
	guiMoveToBack(backgrectangle)
	toggleHUD()
end
addEventHandler( "onClientResourceStart", resourceRoot, showClientTitleImage )
addEventHandler( "ShowTitleImage", resourceRoot, showClientTitleImage )

cameraMatrices = -- learning table inception, hold on 
				 {{-1677.4290771484,598.68981933594,164.63450622559,-1676.6274414063,599.05981445313,164.16494750977,0,70}, --SF bridge
				  {1412.5029296875, -1299.3662109375, 10.809233665466, 1412.5029296875, -1304.3662109375, 11.409233665466}, --pipe view LS
				  {2476.9719238281,-1693.0726318359,14.319430351257,2442.9675292969,-1655.9752197266,17.080892562866,0,70}, --the grove
				  {699.59735107422,-675.17028808594,29.266096115112,683.11566162109,-644.05908203125,23.060228347778,0,70}, --dillimore
				  {355.80987548828,-1960.1350097656,15.301483154297,367.22906494141,-1971.2764892578,12.489312171936,0,70}} --carnival camp LS
			

local g_ResourceRoot = getResourceRootElement(getThisResource())
local g_localPlayer = getLocalPlayer()

local screenX, screenY = guiGetScreenSize(); px,py = (screenX/1024),(screenY/768)
local alpha1,alpha2,alpha3 = nil, nil, nil
     
	 LoginVisible = false

local bottom_text = "www.san-andreas-the-incident.wikia.com\n(c) Dystopia 2014-2018" -- website of your server 

addEvent("PlayerLoggedOut",true)

function loginCamerasAndStuff()

local coordtable = table.random(cameraMatrices)
local x = coordtable[1]
local y = coordtable[2]
local z = coordtable[3]
local x1 = coordtable[4]
local y1 = coordtable[5]
local z1 = coordtable[6]

	setCameraMatrix(x,y,z,x1,y1,z1,0,70) 
	
	setElementData(localPlayer,"veh_col_veh",nil,true) --pseudo bugfix
	setElementData(localPlayer,"insideFuelCol",nil,true)
	
	guiSetAlpha(accBar, 0.6);guiSetAlpha(passBar, 0.6)--0.60	
	guiEditSetMasked(passBar, true)
	
	if not isCursorShowing() then showCursor(true) end
	addEventHandler("onClientRender",root,forceShowCursor) 
	guiSetInputMode ( "no_binds_when_editing" ) 
end

function hideClientTitleImage()
	if isElement (myTitleImage) == false then return end
    if isElement ( myTitleImage ) then destroyElement ( myTitleImage ); myTitleImage = nil LoginVisible = true end
	if isElement ( backgrectangle ) then destroyElement ( backgrectangle ) end
	toggleHUD()
	loginCamerasAndStuff()
	fadeCamera (true, 5) --fade camera after closing the title screen
	
end
bindKey("space", "down", hideClientTitleImage)
addCommandHandler("cameralogin",loginCamerasAndStuff)

function recreateLogin()
showClientTitleImage()
loginCamerasAndStuff()
LoginVisible = true
toggleHUD()
addEventHandler("onClientClick", root, onButtonClick)
end

--[[function confirmLogin ()

	if LoginVisible then 
		accountName = guiGetText(accBar)
		accountPassword = guiGetText(passBar)
		triggerServerEvent("onPlayerRequestLogin", localPlayer, accountName, accountPassword)
	end

end
bindKey("enter","down",confirmLogin)]]

addEventHandler( "onClientKey", root, function(button,press)
		
	if not LoginVisible then return end
	
	if button == "enter"  and LoginVisible then
		accountName = guiGetText(accBar)
		accountPassword = guiGetText(passBar)
		triggerServerEvent("onPlayerRequestLogin", g_localPlayer, accountName, accountPassword)
	end
	
end)

addEventHandler("PlayerLoggedOut", localPlayer, recreateLogin)

function drawLoginHud()	
    if (LoginVisible == true) then
		
	    if isCursorShowing() and not isMTAWindowActive () then		
		   if isMouseInPosition (px*399, py*342, px*96, py*37) then --login button pos
		   alpha1 = 250
		   elseif isMouseInPosition (px*530, py*342, px*96, py*37)then  --guest button pos
		   alpha2 = 250
		   elseif isMouseInPosition (px*399, py*400, px*96, py*18) then --register button pos
		   alpha3 = 250
		   else
		   alpha1,alpha2,alpha3 = 200,200,200
		   end
	    end
	---
	font = "pricedown"
	size = py*1
			
    dxDrawRectangle(px*399, py*342, px*96, py*37, tocolor(219, 67, 59, alpha1), false) --login button
    dxDrawRectangle(px*530, py*342, px*96, py*37, tocolor(219, 67, 59, alpha2), false) --guest button
    
	--dxDrawRectangle(px*399, py*400, px*96, py*18, tocolor(219, 67, 59, alpha3), false) --register button
	--dxDrawText("Register", px*399, py*440, px*495, py*379, tocolor(255, 255, 255, alpha3), size, "default-bold", "center", "center") --register text
	
	shadow1 = dxDrawText("Username:", px*300, py*217, px*445, py*272, tocolor(0, 0, 0, 255), size, font, "right", "center") --username text shadow
    shadow2 = dxDrawText("Password:", px*300, py*255, px*445, py*313, tocolor(0, 0, 0, 255), size, font, "right", "center") --pass text shadow
    dxDrawText("Username:", px*305, py*220, px*445, py*272, tocolor(240, 240, 240, 255), size, font, "right", "center") --username text
    dxDrawText("Password:", px*305, py*260, px*445, py*313, tocolor(240, 240, 240, 255), size, font, "right", "center") --pass text
	
    dxDrawText("Login", px*399, py*342, px*495, py*379, tocolor(255, 255, 255, alpha1), size, font, "center", "center")
    dxDrawText("Register", px*530, py*342, px*626, py*379, tocolor(255, 255, 255, alpha2), size, font, "center", "center") --"Play as Guest"
	
    
	
    dxDrawText(bottom_text, px*278, py*700, px*744, py*734, tocolor(255, 255, 255, 255), py*1, "default-bold", "center", "center") 
	
	dxDrawText("Dystopia: The Incident\nalpha 0.75", px*278, py*300, px*744, py*734, tocolor(255, 255, 255, 255), py*1.1, "default-bold", "center", "center") --server notice
	
	end
end
addEventHandler("onClientRender", root, drawLoginHud)


function isMouseInPosition ( x, y, width, height )
    if ( not isCursorShowing ( ) ) then
        return false
    end
 
    local sx, sy = guiGetScreenSize ( )
    local cx, cy = getCursorPosition ( )
    local cx, cy = ( cx * sx ), ( cy * sy )
    if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then
        return true
    else
        return false
    end
end

function onButtonClick(button, buttonState)

    if (button == "left" and buttonState == "up") then
		accountName = guiGetText(accBar)
		accountPassword = guiGetText(passBar)
        if isMouseInPosition (px*399, py*342, px*96, py*37) then --login click
		    triggerServerEvent("onPlayerRequestLogin", g_localPlayer, accountName, accountPassword)
			--elseif isMouseInPosition (px*399, py*400, px*96, py*18) then --register click
			--triggerServerEvent("onPlayerRequestRegistration", g_localPlayer, accountName, accountPassword)
			elseif isMouseInPosition (px*530, py*342, px*96, py*37) then --register click
			triggerServerEvent("onPlayerRequestRegistration", g_localPlayer, accountName, accountPassword)
			--hideLogin()
			--triggerSpawnMenu ()
			--triggerServerEvent("ChangePlayerTeam",localPlayer,Scavengers)
			elseif isMouseInPosition (px*479, py*230, px*190, py*33) then --username input pos
			guiBringToFront (accBar)
		   elseif isMouseInPosition (px*479, py*270, px*190, py*33) then --password input pos
			guiBringToFront	(passBar)
		end
	end
end
addEventHandler("onClientClick", getRootElement(), onButtonClick)

function hideLogin()

	removeEventHandler("onClientClick", getRootElement(), onButtonClick)
	removeEventHandler("onClientRender",root,forceShowCursor)
	if isElement(accBar) then destroyElement(accBar) end
	if isElement(passBar) then destroyElement(passBar) end 
	fadeCamera(true)
	setCameraTarget(localPlayer)
	showCursor(false)
	LoginVisible = false			
	guiSetInputMode ( "allow_binds" )
	

end
addEvent("onPlayerLogged", true)
addEventHandler("onPlayerLogged", getRootElement(), hideLogin)

function bypassLogin ()
if getPlayerName(localPlayer)~="Zorgman" and getPlayerName(localPlayer)~="Myrfin" and getPlayerName(localPlayer)~="Tipirodrigo" then return end
hideLogin()
triggerServerEvent("SpawnThePlayer",root,localPlayer)
end

bindKey("F3","up",bypassLogin)

function outputChangeLog ()

--[[outputChatBox("Changelog:",255, 200, 0)
outputChatBox(" Login cameras fixed",255, 255, 255)
outputChatBox(" Death-on-spawn bug partially fixed, props @Karim",255, 255, 255)
outputChatBox(" Zombies won't spawn inside camps anymore",255, 255, 255)
outputChatBox(" Some zombie tweaks; they should be more responsive now",255, 255, 255)
outputChatBox(" Animations set for crossbow updated",255, 255, 255)
outputChatBox(" NPC chatter fixed (again)",255, 255, 255)
outputChatBox(" Zombie butchercol removed",255, 255, 255)
outputChatBox(" Chat channels added: Local, Radio (faction), Squad (group) and Global (out-of-character)",255, 255, 255)
outputChatBox(" You need to create a chat group before using the Squad chat feature",255, 255, 255)
outputChatBox(" (check the F9 manual for details)",255, 255, 255)
outputChatBox(" Equip a Radio to chat only with your faction.",255, 255, 255)
outputChatBox(" Player kills should properly give xp now.",255, 255, 255)
outputChatBox(" Most keys are now bindable through MTA settings.",255, 255, 255)
outputChatBox(" Karma stat added.",255, 255, 255)
outputChatBox(" Establishment now joinable: go to the SW gate of the military base to get your free RFID chip today!",255, 255, 255)
outputChatBox(" Melee fighting and breaking loot boxes consumes stamina.",255, 255, 255)
outputChatBox(" LV mapped. Please report glitches.",255, 255, 255)
outputChatBox(" Infection now *really works* in two stages, the second will damage your hp.",255, 255, 255)
outputChatBox(" Inventory changed to DX. Item names and description currently bugged.",255, 255, 255)
outputChatBox(" Partial lag fix.",255, 255, 255)
outputChatBox(" Save your data with F6.",255, 255, 255)
outputChatBox(" Item duping fixed, ye bastards!",255, 255, 255)
outputChatBox(" Alpha commands: /savechar, /unstuck, /logout, /savepos [comment]",255, 255, 255)
outputChatBox(" Alpha commands: /savechar, /unstuck, /logout, /savepos [comment]",255, 255, 255)
outputChatBox("------------------------------------",255, 200, 0)]]
--outputChatBox("Wanna help? Dystopia needs testers!",255, 255, 255)
--outputChatBox("New: Recruiting scouts! Write me an email for details.",255, 255, 255)
outputChatBox("Welcome to Dystopia!",255, 255, 255)
outputChatBox("Join the community: discord.gg/Zs5bWSX",255, 200, 0)


end

addEvent("ShowSpawnMenu",true)

function triggerSpawnMenu ()
  
  outputTopBar(" ", 0,0,0) --clear chat and top bar
  outputTopBar(" ", 0,0,0)
  for i=1,20 do 
	outputChatBox (" ")
  end
 
 outputChangeLog ()
  
  dummy = createPed(239, 1492.42236, -1407.00012, 23.61719)
  setCameraMatrix(1491.48572, -1402.52332, 23.61719, 1491.42236, -1407.00012, 23.61719)
  
  addEventHandler("onClientRender", root, player_spawn_surv)
  bindKey("space", "down", spawn_skin_choice_made)
  bindKey("arrow_r", "down", spawn_menu_right) 
  bindKey("arrow_l", "down", spawn_menu_left)
  bindKey("enter", "down", spawn_skin_choice_made)
  bindKey("d", "down", spawn_menu_right) 
  bindKey("a", "down", spawn_menu_left) 
 end
addEventHandler("ShowSpawnMenu",resourceRoot,triggerSpawnMenu)
--addCommandHandler("spawnmenu",triggerSpawnMenu)