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
				 {
					{-1677.4290771484,598.68981933594,164.63450622559,-1676.6274414063,599.05981445313,164.16494750977,0,70}, --SF bridge
					{1412.5029296875, -1299.3662109375, 10.809233665466, 1412.5029296875, -1304.3662109375, 11.409233665466}, --pipe view LS
					{2476.9719238281,-1693.0726318359,14.319430351257,2442.9675292969,-1655.9752197266,17.080892562866,0,70}, --the grove
					{699.59735107422,-675.17028808594,29.266096115112,683.11566162109,-644.05908203125,23.060228347778,0,70}, --dillimore
					{355.80987548828,-1960.1350097656,15.301483154297,367.22906494141,-1971.2764892578,12.489312171936,0,70}, --carnival camp LS
					{2060.693359375, 1323.3287353516, 65.554336547852, 2154.0563964844, 1301.9788818359, 36.787712097168},
					{-488.73297119141, 2129.7478027344, 131.07089233398, -577.43792724609, 2095.4423828125, 100.17473602295},
					{355.38235473633, -1999.6640625, 34.214122772217, 401.36798095703, -2077.3337402344, -8.8294067382813},
					{2373.4975585938, 69.472595214844, 68.322166442871, 2420.0559082031, -10.329551696777, 30.060695648193},
					{2055.7841796875, 1197.9633789063, 25.738883972168, 2141.7668457031, 1147.1596679688, 20.643169403076},
					{2321.8068847656, -1100.53125, 76.947044372559, 2365.5268554688, -1017.3639526367, 42.716026306152},
					{-807.52880859375, 2699.8017578125, 75.263061523438, -853.92779541016, 2777.5541992188, 32.816757202148},
					{196.63110351563, 2660.5759277344, 53.300601959229, 262.5549621582, 2594.3989257813, 17.598323822021},
					{-458.94390869141, -164.11698913574, 123.5959777832, -548.6953125, -195.21823120117, 92.332641601563},
					{-1070.3149414063, -1610.5084228516, 94.326530456543, -1135.0595703125, -1682.0073242188, 67.944076538086},
					{-632.33306884766, -1473.3518066406, 44.557136535645, -545.33532714844, -1492.6140136719, -0.833984375},
					{270.52749633789, -1205.0640869141, 110.60611724854, 321.99029541016, -1128.5759277344, 71.861503601074},
					{1156.4423828125, -1441.9432373047, 38.343357086182, 1086.1207275391, -1504.4560546875, 4.4757308959961},
					{-1267.3508300781, 1106.96484375, 102.32939910889, -1311.2535400391, 1019.9342041016, 80.008575439453},
					{-2662.2238769531, 2242.8115234375, 89.52938079834, -2584.8740234375, 2297.583984375, 57.639293670654},
				  } 
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


