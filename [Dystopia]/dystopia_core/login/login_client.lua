--[[
	Dystopia Login System

	Credits
	Simple DX LOGIN: NearGreen(Gabox)
	Dystopia: Zorgman
	New Login interface: Anderson and Random Login Form
]]
-- Variables
LoginVisible = false
local screenWidth, screenHeight = guiGetScreenSize()
local page = "http://mta/local/login/index.html"
local initBrowser = guiCreateBrowser(0, 0, screenWidth, screenHeight, true, true, false)
local theBrowser = guiGetBrowser(initBrowser)

--TITLE SCREEN 
titlescreens = {"images/titlescreen1.png"}--, 
				--"images/titlescreen2.png" }

function showClientTitleImage()
	
	local x,y = guiGetScreenSize()
	backgrectangle = guiCreateStaticImage ( 0, 0, x, y, "images/beltblack.png", false )
    myTitleImage = guiCreateStaticImage( (x-1024)/2,0.0,1024,768, table.random(titlescreens), false )
	centerWindow(myTitleImage)
	guiBringToFront(myTitleImage)
	guiMoveToBack(backgrectangle)
	toggleHUD()
end
addEventHandler( "onClientResourceStart", resourceRoot, showClientTitleImage )

addEvent("ShowTitleImage",true)
addEventHandler( "ShowTitleImage", resourceRoot, showClientTitleImage )
-- Hide Title Image
function hideClientTitleImage()
	if isElement (myTitleImage) == false then return end
    if isElement ( myTitleImage ) then destroyElement ( myTitleImage ); myTitleImage = nil LoginVisible = true end
	if isElement ( backgrectangle ) then destroyElement ( backgrectangle ) end
	drawLoginPanel()
	toggleHUD()
	loginCamerasAndStuff()
	fadeCamera (true, 5) --fade camera after closing the title screen

end
bindKey("space", "down", hideClientTitleImage)

-- Show Camera Martix
cameraMatrices = -- learning table inception, hold on 
				 {{-1677.4290771484,598.68981933594,164.63450622559,-1676.6274414063,599.05981445313,164.16494750977,0,70}, --SF bridge
				  {1412.5029296875, -1299.3662109375, 10.809233665466, 1412.5029296875, -1304.3662109375, 11.409233665466}, --pipe view LS
				  {2476.9719238281,-1693.0726318359,14.319430351257,2442.9675292969,-1655.9752197266,17.080892562866,0,70}, --the grove
				  {699.59735107422,-675.17028808594,29.266096115112,683.11566162109,-644.05908203125,23.060228347778,0,70}, --dillimore
				  {355.80987548828,-1960.1350097656,15.301483154297,367.22906494141,-1971.2764892578,12.489312171936,0,70}} --carnival camp LS
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
	if not isCursorShowing() then showCursor(true) end
	addEventHandler("onClientRender",root, forceShowCursor)
	guiSetInputMode ( "no_binds_when_editing" )

end
-- Spawn Menu
function outputChangeLog ()
	outputChatBox("Welcome to Dystopia!",255, 255, 255)
	outputChatBox("Join the community: discord.gg/Zs5bWSX",255, 200, 0)
end


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
addEvent("ShowSpawnMenu",true)
addEventHandler("ShowSpawnMenu", resourceRoot, triggerSpawnMenu)
-- loggedout
function recreateLogin()
	showClientTitleImage()
	loginCamerasAndStuff()
	drawLoginPanel()
	LoginVisible = true
	toggleHUD()
end
addEvent("PlayerLoggedOut",true)
addEventHandler("PlayerLoggedOut", localPlayer, recreateLogin)

-- Login Panel
function drawLoginPanel()
	loadBrowserURL(theBrowser, page)
	toggleHUD()
	if not isCursorShowing() then showCursor(true) end
	-- body
end

addEvent("onPlayerLogged", true)
addEventHandler("onPlayerLogged", root,
	function()
		removeEventHandler("onClientRender",root,forceShowCursor)
		destroyElement(initBrowser)
		showCursor(false)
		fadeCamera(true)
		LoginVisible = false
		setCameraTarget(localPlayer)
		toggleHUD()		
		guiSetInputMode ( "allow_binds" )
	end
)
function onPlayerPushButton(login, password, command, remember)
	if (command == "login") then
		triggerServerEvent("onPlayerRequestLogin", getLocalPlayer(), login, password)
	elseif (command == "register") then
		triggerServerEvent("onPlayerRequestRegistration", getLocalPlayer(), login, password)
	end
end
addEvent("onPlayerPushButton", true)
addEventHandler("onPlayerPushButton", root, onPlayerPushButton)

-- LOGIN NO Title Image
-- cameraMatrices = -- learning table inception, hold on 
-- 				 {{-1677.4290771484,598.68981933594,164.63450622559,-1676.6274414063,599.05981445313,164.16494750977,0,70}, --SF bridge
-- 				  {1412.5029296875, -1299.3662109375, 10.809233665466, 1412.5029296875, -1304.3662109375, 11.409233665466}, --pipe view LS
-- 				  {2476.9719238281,-1693.0726318359,14.319430351257,2442.9675292969,-1655.9752197266,17.080892562866,0,70}, --the grove
-- 				  {699.59735107422,-675.17028808594,29.266096115112,683.11566162109,-644.05908203125,23.060228347778,0,70}, --dillimore
-- 				  {355.80987548828,-1960.1350097656,15.301483154297,367.22906494141,-1971.2764892578,12.489312171936,0,70}} --carnival camp LS
	
-- function loginCamerasAndStuff()
-- 	-- toggleHUD()
-- 	fadeCamera (true, 5)
-- 	local coordtable = table.random(cameraMatrices)
-- 	local x = coordtable[1]
-- 	local y = coordtable[2]
-- 	local z = coordtable[3]
-- 	local x1 = coordtable[4]
-- 	local y1 = coordtable[5]
-- 	local z1 = coordtable[6]
-- 	setCameraMatrix(x,y,z,x1,y1,z1,0,70) 
-- 	setElementData(localPlayer,"veh_col_veh",nil,true) --pseudo bugfix
-- 	setElementData(localPlayer,"insideFuelCol",nil,true)
-- 	if not isCursorShowing() then showCursor(true) end
-- 	guiSetInputMode ( "no_binds_when_editing" ) 
-- end
-- addEventHandler( "onClientResourceStart", resourceRoot, loginCamerasAndStuff)

-- local screenWidth, screenHeight = guiGetScreenSize()

-- local page = "http://mta/local/login/index.html"
-- local initBrowser = guiCreateBrowser(0, 0, screenWidth, screenHeight, true, true, false)
-- local theBrowser = guiGetBrowser(initBrowser)

-- addEventHandler("onClientBrowserCreated", theBrowser, 
-- 	function()
-- 		loadBrowserURL(source, page)
-- 		toggleHUD()
-- 		showCursor(true)
-- 	end
-- )

-- addEvent("onPlayerLogged", true)
-- addEventHandler("onPlayerLogged", root,
-- 	function()
-- 		destroyElement(initBrowser)
-- 		showCursor(false)
-- 		fadeCamera(true)
-- 		setCameraTarget(localPlayer)		
-- 		guiSetInputMode ( "allow_binds" )
-- 	end
-- )
-- function onPlayerPushButton(login, password, command)
-- 	if (command == "login") then
-- 		triggerServerEvent("onPlayerRequestLogin", getLocalPlayer(), login, password)
-- 	elseif (command == "register") then
-- 		-- triggerServerEvent("register", resourceRoot, login, password)
-- 		triggerServerEvent("onPlayerRequestRegistration", getLocalPlayer(), login, password)
-- 	end
-- end
-- addEvent("onPlayerPushButton", true)
-- addEventHandler("onPlayerPushButton", root, onPlayerPushButton)


