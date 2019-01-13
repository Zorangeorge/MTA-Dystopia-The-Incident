--Drone Airstrike command, located in A69 war room
	--
		--# Created By MoDeR2014 'never remove the credits'
	--
--

-- ***************************** --
-- ***************************** --

--[[
	This script was made under the MTA AR Scripting Challenge
	تم تصميم هذا المود تحت تحدي البرمجة العربي 
	
	http://forum.mtasa.com/viewtopic.php?f=119&t=93698

--]]
-- ****************************** --
-- ****************************** --
ChunkfiveFontSmall = guiCreateFont("Font/Chunkfive.otf",12)

Main = {
	--[[Texts = {
		{ Text = "Armed Drone Control", Pos = {212.85, 1822.85, 5.4}, Dim = 0, Size = 1.5},
		{ Text = "'E'", Pos = {212.85, 1822.85, 5.2}, Dim = 0, Size = 1.8},
	},]]
	ScreenSize = {guiGetScreenSize()},
	DevScreen = {1366, 768},
	AirStrikeControl = { gridlist = {}, window = {}, button = {}, label = {} },
	AirStrikeTypes = {
		{ Name = "MK-7", Price = 1000, Abilities = "Fuel: 300\nMissiles"},
		{ Name = "MK-X", Price = 1500, Abilities = "Fuel: 600\nMissiles, Thermal Cam\nNight Cam, Zoom 6X" },
	},
	Timer,
	Flood,
	Type = nil,
	dxDrawText_ = dxDrawText,
	dxDrawRectangle_ = dxDrawRectangle,
	dxDrawLine_ = dxDrawLine,
	Sound,
	SmothCam = {
		moov = 0,
		object1 = nil,
		object2 = nil,
	},
	Zooming = 0,
};

function dxDrawFramedText(message, left, top, width, height, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, frameColor)
	color = color or tocolor(255, 255, 255, 255)
	frameColor = frameColor or tocolor(0, 0, 0, 255)
	scale = scale or 1.1
	font = font or "default"
	alignX = alignX or "left"
	alignY = alignY or "top"
	clip = clip or false
	wordBreak = wordBreak or false
	postGUI = postGUI or false
	dxDrawText(message, left + 1, top + 1, width + 1, height + 1, frameColor, scale, font, alignX, alignY, clip, wordBreak, postGUI)
	dxDrawText(message, left + 1, top - 1, width + 1, height - 1, frameColor, scale, font, alignX, alignY, clip, wordBreak, postGUI)
	dxDrawText(message, left - 1, top + 1, width - 1, height + 1, frameColor, scale, font, alignX, alignY, clip, wordBreak, postGUI)
	dxDrawText(message, left - 1, top - 1, width - 1, height - 1, frameColor, scale, font, alignX, alignY, clip, wordBreak, postGUI)
	dxDrawText(message, left, top, width, height, color, scale, font, alignX, alignY, clip, wordBreak, postGUI)
end
function dxDrawText(text, x, y, w, h, color, size, font, alignl, alignt, clip, wordbreak, postgui, colorcoded, spp)
	return Main["dxDrawText_"](text, (x/Main["DevScreen"][1])*Main["ScreenSize"][1], (y/Main["DevScreen"][2])*Main["ScreenSize"][2], (w/Main["DevScreen"][1])*Main["ScreenSize"][1], (h/Main["DevScreen"][2])*Main["ScreenSize"][2], color, (size/Main["DevScreen"][1])*Main["ScreenSize"][1], font, alignl, alignt, clip, wordbreak, postgui, colorcoded, spp);
end
function dxDrawRectangle(x, y, w, h, color, postgui)
	return Main["dxDrawRectangle_"]((x/Main["DevScreen"][1])*Main["ScreenSize"][1], (y/Main["DevScreen"][2])*Main["ScreenSize"][2], (w/Main["DevScreen"][1])*Main["ScreenSize"][1], (h/Main["DevScreen"][2])*Main["ScreenSize"][2], color, postgui);
end
function dxDrawLine(xs, ys, xe, ye, color, width, postgui)
	return Main["dxDrawLine_"]((xs/Main["DevScreen"][1])*Main["ScreenSize"][1], (ys/Main["DevScreen"][2])*Main["ScreenSize"][2], (xe/Main["DevScreen"][1])*Main["ScreenSize"][1], (ye/Main["DevScreen"][2])*Main["ScreenSize"][2], color, width, postgui);
end
function convertNumber( number )
	local formatted = number
	while true do
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2");
		if ( k==0 ) then
			break
		end
	end
	return formatted
end
function removeCamHandler()
	if Main["SmothCam"]["moov"] == 1 then
		Main["SmothCam"]["moov"] = 0
		removeEventHandler("onClientPreRender",root,camRender);
	end
end
function camRender()
	if Main["SmothCam"]["moov"] == 1 then
		local Pos1 = {getElementPosition(Main["SmothCam"]["object1"])};
		local Pos2 = {getElementPosition(Main["SmothCam"]["object2"])};
		setCameraMatrix(Pos1[1], Pos1[2], Pos1[3], Pos2[1], Pos2[2], Pos2[3]);
	end
end
function smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,time)
	if Main["SmothCam"]["moov"] == 1 then return false end
	Main["SmothCam"]["object1"] = createObject(1337,x1,y1,z1)
	Main["SmothCam"]["object2"] = createObject(1337,x1t,y1t,z1t)
	Main["SmothCam"]["object1"]:setAlpha(0);
	Main["SmothCam"]["object2"]:setAlpha(0);
	setObjectScale(Main["SmothCam"]["object1"], 0.01);
	setObjectScale(Main["SmothCam"]["object2"], 0.01);
	Main["SmothCam"]["object1"]:move(time, x2, y2, z2, 0, 0, 0, "InOutQuad");
	Main["SmothCam"]["object2"]:move(time, x2t, y2t, z2t, 0, 0, 0, "InOutQuad");
	Main["SmothCam"]["moov"] = 1
	addEventHandler("onClientPreRender",root,camRender);
	setTimer(removeCamHandler,time,1);
	setTimer(destroyElement,time,1,Main["SmothCam"]["object1"]);
	setTimer(destroyElement,time,1,Main["SmothCam"]["object2"]);
	return true
end
function dxDrawLinedRectangle( x, y, width, height, color, _width, postGUI )
	local _width = _width or 1
	dxDrawLine ( x, y, x+width, y, color, _width, postGUI )
	dxDrawLine ( x, y, x, y+height, color, _width, postGUI )
	dxDrawLine ( x, y+height, x+width, y+height, color, _width, postGUI )
	return dxDrawLine ( x+width, y, x+width, y+height, color, _width, postGUI )
end

Main["AirStrikeControl"]["window"][1]   = GuiWindow.create((Main["ScreenSize"][1]-434)/2, (Main["ScreenSize"][2]-444)/2, 434, 244, " ", false);
Main["AirStrikeControl"]["gridlist"][1] = GuiGridList.create(20, 30, 219, 200, false, Main["AirStrikeControl"]["window"][1]);
Main["AirStrikeControl"]["label"][1]    = GuiLabel.create(249, 30, 175, 29, "DRONE DETAILS", false, Main["AirStrikeControl"]["window"][1]);
	guiSetFont(Main["AirStrikeControl"]["label"][1],ChunkfiveFontSmall)
	local weather, blendedInto = getWeather()
	if weather == 8 or weather == 16 then weather = "Stormy, chance of turbulences" elseif weather == 9 or weather == 19 then weather = "Foggy, low visibility" else weather = "Good flight conditions" end
	
Main["AirStrikeControl"]["label"][2]    = GuiLabel.create(249, 77, 175, 80, "< Please select unit\n\nWeather conditions:\n"..weather, false, Main["AirStrikeControl"]["window"][1]);
	
Main["AirStrikeControl"]["button"][1]   = GuiButton.create(279, 167, 116, 25, "Launch", false, Main["AirStrikeControl"]["window"][1]);
Main["AirStrikeControl"]["button"][2]   = GuiButton.create(279, 202, 116, 25, "Abort", false, Main["AirStrikeControl"]["window"][1]);

Main["AirStrikeControl"]["window"][1]:setSizable(false);
Main["AirStrikeControl"]["gridlist"][1]:addColumn(" ", 0.4);
Main["AirStrikeControl"]["gridlist"][1]:addColumn(" ", 0.5);
Main["AirStrikeControl"]["gridlist"][1]:setSortingEnabled(false);
Main["AirStrikeControl"]["label"][1]:setHorizontalAlign("center", false);
Main["AirStrikeControl"]["label"][1]:setVerticalAlign("center", false);
Main["AirStrikeControl"]["label"][2]:setFont("default-bold-small");
--Main["AirStrikeControl"]["gridlist"][1]:setFont(ChunkfiveFontSmall); 
--guiGridListAutoSizeColumn(Main["AirStrikeControl"]["gridlist"][1],0)
--guiGridListAutoSizeColumn(Main["AirStrikeControl"]["gridlist"][1],1)
--guiGridListAutoSizeColumn(Main["AirStrikeControl"]["gridlist"][1],2)
Main["AirStrikeControl"]["button"][1]:setFont(ChunkfiveFontSmall);
Main["AirStrikeControl"]["button"][2]:setFont(ChunkfiveFontSmall);
Main["AirStrikeControl"]["button"][1]:setProperty("NormalTextColour", "FFFFFFFF");
Main["AirStrikeControl"]["button"][2]:setProperty("NormalTextColour", "FFFFFFFF");
Main["AirStrikeControl"]["window"][1]:setVisible(false);

for index, value in ipairs(Main["AirStrikeTypes"]) do
	local Row = Main["AirStrikeControl"]["gridlist"][1]:addRow();
	Main["AirStrikeControl"]["gridlist"][1]:setItemText(Row, 1, value["Name"], false, false);
	Main["AirStrikeControl"]["gridlist"][1]:setItemText(Row, 2, " "..convertNumber(value["Price"]).." $", false, false);
	Main["AirStrikeControl"]["gridlist"][1]:setItemData(Row, 1, value["Abilities"]);
	Main["AirStrikeControl"]["gridlist"][1]:setItemData(Row, 2, value["Price"]);
end

--[[addEvent("AirStrike:MessageBox", true);
addEventHandler("AirStrike:MessageBox", root,
function ( message, boxType, title )
	exports["msgbox"]:guiShowMessageBox( message, boxType, title, "Ok");
end );]]

addEvent("AirStrike:toggleGUI", true);
addEventHandler("AirStrike:toggleGUI", root,
function ()
	Main["AirStrikeControl"]["window"][1]:setVisible(true);
	showCursor(Main["AirStrikeControl"]["window"][1]:getVisible());
end );

addEvent("AirStrike:reG", true)
addEventHandler("AirStrike:reG", root,
function (Pos, creator)
	createProjectile(creator, 20, Pos[1], Pos[2], Pos[3]+50, 2.0, source);
end );

function dxInformation()
	if isTimer(Main["Timer"]) then
		local TD = Main["Timer"]:getDetails();
		--local Min = math.floor(TD/60000)
		--local Sec = math.floor((TD-Min*60000)/1000)
		local fuel = math.floor(TD/1000)
		dxDrawImage(0, 0, Main["ScreenSize"][1], Main["ScreenSize"][2], "Texture/Effect.dds");
		if Main["Type"] == "MK-7" then
			dxDrawFramedText(Main["Type"], 119, 300, 283, 365, tocolor(255, 255, 255, 255), 2, "default-bold", "left", "center", false, false, false, false, false)
			--dxDrawFramedText("Zoom: "..Main["Zooming"], 119, 346, 283, 365, tocolor(255, 255, 255, 255), 1.30, "default-bold", "left", "center", false, false, false, false, false)
			dxDrawFramedText("Fuel: "..fuel, 119, 375, 283, 394, tocolor(255, 255, 255, 255), 1.30, "default-bold", "left", "center", false, false, false, false, false)
			--dxDrawFramedText("Controls:", 119, 404, 283, 423, tocolor(255, 255, 255, 255), 1.30, "default-bold", "left", "center", false, false, false, false, false)
			dxDrawFramedText("LMB: fire", 119, 423, 283, 442, tocolor(255, 255, 255, 255), 1.30, "default-bold", "left", "center", false, false, false, false, false)
			dxDrawFramedText("Moving: W, A, S, D", 119, 442, 283, 461, tocolor(255, 255, 255, 255), 1.30, "default-bold", "left", "center", false, false, false, false, false)
			dxDrawFramedText("Abort: X", 119, 442+40, 283, 461, tocolor(255, 255, 255, 255), 1.30, "default-bold", "left", "center", false, false, false, false, false)
		else
			dxDrawFramedText(Main["Type"], 119, 220, 283, 365, tocolor(255, 255, 255, 255), 2, "default-bold", "left", "center", false, false, false, false, false)
			dxDrawFramedText("Zoom: "..Main["Zooming"].."x", 119, 316, 283, 335, tocolor(255, 255, 255, 255), 1.30, "default-bold", "left", "center", false, false, false, false, false)
			dxDrawFramedText("Fuel: "..fuel, 119, 330, 283, 394, tocolor(255, 255, 255, 255), 1.30, "default-bold", "left", "center", false, false, false, false, false)
			--dxDrawFramedText("Controls:", 119, 378, 283, 397, tocolor(255, 255, 255, 255), 1.30, "default-bold", "left", "center", false, false, false, false, false)
			dxDrawFramedText("LMB: Fire", 119, 403, 283, 422, tocolor(255, 255, 255, 255), 1.30, "default-bold", "left", "center", false, false, false, false, false)
			dxDrawFramedText("Moving: W, A, S, D", 119, 422, 283, 441, tocolor(255, 255, 255, 255), 1.30, "default-bold", "left", "center", false, false, false, false, false)
			dxDrawFramedText("N: Night Cam", 119, 441, 283, 460, tocolor(255, 255, 255, 255), 1.30, "default-bold", "left", "center", false, false, false, false, false)
			dxDrawFramedText("V: Thermal Cam", 119, 460, 283, 479, tocolor(255, 255, 255, 255), 1.30, "default-bold", "left", "center", false, false, false, false, false)
			dxDrawFramedText("B: Normal Cam", 119, 495, 283, 479, tocolor(255, 255, 255, 255), 1.30, "default-bold", "left", "center", false, false, false, false, false)
			dxDrawFramedText("Z: Zoom", 119, 528, 283, 479, tocolor(255, 255, 255, 255), 1.30, "default-bold", "left", "center", false, false, false, false, false)
			dxDrawFramedText("Abort: X", 119, 528+40, 283, 479, tocolor(255, 255, 255, 255), 1.30, "default-bold", "left", "center", false, false, false, false, false)
		end
		dxDrawLinedRectangle(532, 283, 301, 201, tocolor(255, 255, 255, 255), 2, false);
		dxDrawLine(683, 183, 683, 283, tocolor(255, 255, 255, 255), 1, false)
		dxDrawLine(683, 484, 683, 584, tocolor(255, 255, 255, 255), 1, false)
		dxDrawLine(633, 384, 733, 384, tocolor(255, 255, 255, 255), 1, false)
		dxDrawLine(835, 384, 935, 384, tocolor(255, 255, 255, 255), 1, false)
		dxDrawLine(430, 384, 530, 384, tocolor(255, 255, 255, 255), 1, false)
	else
		removeEventHandler("onClientRender", root, dxInformation);
	end
end

--[[addEventHandler("onClientRender", root,
function()
	for index, value in ipairs(Main["Texts"]) do
		if localPlayer:getDimension() == value["Dim"] then
			local PP = {getElementPosition(localPlayer)};
			local SS = {getScreenFromWorldPosition(value["Pos"][1], value["Pos"][2], value["Pos"][3]+1.5)};
			if SS[1] and SS[2] then
				local distance = getDistanceBetweenPoints3D(value["Pos"][1], value["Pos"][2], value["Pos"][3], PP[1], PP[2], PP[3]);
				if distance < 15 then
					dxDrawText(value["Text"], SS[1], SS[2]-3, SS[1], SS[2]-3, tocolor(0, 0, 0, 100), value["Size"]-(distance/15), "default-bold", "center", "top", false, false, false, false, false);
					dxDrawText(value["Text"], SS[1], SS[2], SS[1], SS[2], tocolor(255, 255, 255, 200), value["Size"]-(distance/15), "default-bold", "center", "top", false, false, false, false, false);
				end
			end
		end
	end
end );]]

function ElementsHandler()
	if Main["Type"] ~= nil then
		local Cam = {getCameraMatrix()};
		local PP = {Cam[1],Cam[2],Cam[3]};
		for index, value in ipairs(Element.getAllByType("player")) do
			if localPlayer:getDimension() == value:getDimension() and value ~= localPlayer then
				local PS = {getElementPosition(value)};
				local SS = {getScreenFromWorldPosition(PS[1], PS[2], PS[3]+1.5)};
				if SS[1] and SS[2] then
					local distance = getDistanceBetweenPoints3D(PS[1], PS[2], PS[3], PP[1], PP[2], PP[3]);
					if distance < 200 then
						dxDrawLinedRectangle(			 SS[1]-10,SS[2],    20,   20, tocolor(255, 255, 255, 255), 2, false);
						dxDrawText(value:getName(), SS[1],   SS[2]-23, SS[1],SS[2]-3, tocolor(0, 0, 0, 100), 1.2, "default-bold", "center", "top", false, false, false, false, false);
						dxDrawText(value:getName(), SS[1],   SS[2]-20, SS[1],SS[2], tocolor(255, 255, 255, 200), 1.2, "default-bold", "center", "top", false, false, false, false, false);
					end
				end
			end
		end
		for index, value in ipairs(Element.getAllByType("vehicle")) do
			if localPlayer:getDimension() == value:getDimension() then
				local PS = {getElementPosition(value)};
				local SS = {getScreenFromWorldPosition(PS[1], PS[2], PS[3]+1.5)};
				if SS[1] and SS[2] then
					local distance = getDistanceBetweenPoints3D(PS[1], PS[2], PS[3], PP[1], PP[2], PP[3]);
					if distance < 200 then
						dxDrawLinedRectangle(			  SS[1]-10,SS[2],    20,   20,     tocolor(255, 255, 255, 255), 2, false);
						dxDrawText(value:getName(), SS[1],   SS[2]-23, SS[1],SS[2]-3,tocolor(0, 0, 0, 100), 1.2, "default-bold", "center", "top", false, false, false, false, false);
						dxDrawText(value:getName(), SS[1],   SS[2]-20, SS[1],SS[2],  tocolor(255, 255, 255, 200), 1.2, "default-bold", "center", "top", false, false, false, false, false);
					end
				end
			end
		end
	else
		removeEventHandler("onClientRender", root, ElementsHandler);
	end
end

function SMHandler ( button, press )
	local Cam = {getCameraMatrix()};
	if Main["Type"] ~= nil then
		if button == "w" or button == "arrow_u" then
			smoothMoveCamera(Cam[1], Cam[2], Cam[3], Cam[4], Cam[5], Cam[6],Cam[1], Cam[2]+10, Cam[3], Cam[4], Cam[5]+10, Cam[6], 350);
		elseif button == "s" or button == "arrow_d" then
			smoothMoveCamera(Cam[1], Cam[2], Cam[3], Cam[4], Cam[5], Cam[6],Cam[1], Cam[2]-10, Cam[3], Cam[4], Cam[5]-10, Cam[6], 350);
		elseif button == "d" or button == "arrow_r" then
			smoothMoveCamera(Cam[1], Cam[2], Cam[3], Cam[4], Cam[5], Cam[6],Cam[1]+10, Cam[2], Cam[3], Cam[4]+10, Cam[5], Cam[6], 350);
		elseif button == "a" or button == "arrow_l" then
			smoothMoveCamera(Cam[1], Cam[2], Cam[3], Cam[4], Cam[5], Cam[6],Cam[1]-10, Cam[2], Cam[3], Cam[4]-10, Cam[5], Cam[6], 350);
		elseif button == "mouse1" then
			if isTimer(Main["Flood"]) then return end
			Main["Flood"] = setTimer(function() end, 2000, 1);
			local aSound = playSound3D("Sounds/Missile.mp3", Cam[4], Cam[5], Cam[6]);
			setSoundMaxDistance(aSound, 200);
			triggerServerEvent("AirStrike:SendMissiles", localPlayer, localPlayer, {Cam[4], Cam[5], Cam[6]});
		elseif button == "n" then
			if Main["Type"] == "MK-X" then
				setCameraGoggleEffect("nightvision");
			end
		elseif button == "v" then
			if Main["Type"] == "MK-X" then
				setCameraGoggleEffect("thermalvision");
			end
		elseif button == "b" then
			if Main["Type"] == "MK-X" then
				setCameraGoggleEffect("normal");
			end
		elseif button == "x" then
					fadeCamera(true);
					setCameraTarget(localPlayer,localPlayer);
					setCameraShakeLevel(0);
					--setPlayerHudComponentVisible("all", true);
					setCameraGoggleEffect("normal");
					triggerServerEvent("AirStrike:onGUIClose", localPlayer, localPlayer);
					removeEventHandler("onClientKey", root, SMHandler);
					removeEventHandler("onClientRender", root, dxInformation);
					removeEventHandler("onClientRender", root, ElementsHandler);
		end
	else
		removeEventHandler("onClientKey", root, SMHandler);
	end
end

bindKey("Z", "down",
function ()
	local Cam = {getCameraMatrix()};
	if Main["Type"] ~= nil and Main["Type"] == "MK-X" then
		if Main["Zooming"] < 6 then
			Main["Zooming"] = Main["Zooming"] + 1
			smoothMoveCamera(Cam[1], Cam[2], Cam[3], Cam[4], Cam[5], Cam[6],Cam[1], Cam[2], Cam[3]-8, Cam[4], Cam[5], Cam[6]-8, 100);
		else
			Main["Zooming"] = 0
			--smoothMoveCamera(Cam[1], Cam[2], Cam[3], Cam[4], Cam[5], Cam[6],Cam[1], Cam[2], Cam[3]+(8*5), Cam[4], Cam[5], Cam[6]+(8*5), 500);
			smoothMoveCamera(Cam[1], Cam[2], Cam[3], Cam[4], Cam[5], Cam[6],Cam[1], Cam[2], 130.71, Cam[4], Cam[5], Cam[6], 500);
		end
	end
end );

addEventHandler("onClientResourceStop", resourceRoot,
function ()
	fadeCamera(true);
	setCameraTarget(localPlayer,localPlayer);
	setCameraShakeLevel(0);
	--setPlayerHudComponentVisible("all", true);
	setCameraGoggleEffect("normal");
	triggerServerEvent("AirStrike:onGUIClose", localPlayer, localPlayer);
end );

addEventHandler("onClientKey", resourceRoot,
function (button,press)
	if button == "x" and press == "down" then
					fadeCamera(true);
					setCameraTarget(localPlayer,localPlayer);
					setCameraShakeLevel(0);
					--setPlayerHudComponentVisible("all", true);
					setCameraGoggleEffect("normal");
					triggerServerEvent("AirStrike:onGUIClose", localPlayer, localPlayer);
	end
end );

function BuyAirStrike()
	local Type = Main["AirStrikeControl"]["gridlist"][1]:getItemText(Main["AirStrikeControl"]["gridlist"][1]:getSelectedItem(), 1);
	local Price = Main["AirStrikeControl"]["gridlist"][1]:getItemData(Main["AirStrikeControl"]["gridlist"][1]:getSelectedItem(), 2);
	local Abilities = Main["AirStrikeControl"]["gridlist"][1]:getItemData(Main["AirStrikeControl"]["gridlist"][1]:getSelectedItem(), 1);
	if Player.getMoney() >= Price then
		Main["AirStrikeControl"]["window"][1]:setVisible(false);
		showCursor(false);
		fadeCamera(false);
		if Type == "MK-7" then
		--triggerEvent("sleep:drawDXProgress",resourceRoot,60000*5,1)
			Main["Type"] = "MK-7"
			Main["Timer"] = setTimer(
			function ()
				--triggerEvent("sleep:stopDXProgress",50)
				Main["Sound"] = playSound("Sounds/Crash.m4a");
				setSoundVolume(Main["Sound"], 1.0);
				setSoundPosition(Main["Sound"], 5);
				fadeCamera(false);
				removeEventHandler("onClientRender", root, dxInformation);
				removeEventHandler("onClientRender", root, ElementsHandler);
				removeEventHandler("onClientKey", root, SMHandler);
				Main["Type"] = nil
				Main["Zooming"] = 0
				setTimer(
				function ()
					fadeCamera(true);
					setCameraTarget(localPlayer,localPlayer);
					setCameraShakeLevel(0);
					--setPlayerHudComponentVisible("all", true);
					setCameraGoggleEffect("normal");
					triggerServerEvent("AirStrike:onGUIClose", localPlayer, localPlayer);
				end, 2000, 1);
			end, 5*(60.4*1000), 1);
		else
			--triggerEvent("sleep:drawDXProgress",resourceRoot,60000*10,1)
			Main["Type"] = "MK-X"
			Main["Timer"] = setTimer(
			function ()
				--triggerEvent("sleep:stopDXProgress",50)
				Main["Sound"] = playSound("Sounds/Crash.m4a");
				setSoundVolume(Main["Sound"], 1.0);
				setSoundPosition(Main["Sound"], 5);
				fadeCamera(false);
				removeEventHandler("onClientRender", root, dxInformation);
				removeEventHandler("onClientRender", root, ElementsHandler);
				removeEventHandler("onClientKey", root, SMHandler);
				Main["Type"] = nil
				Main["Zooming"] = 0
				setTimer(
				function ()
					fadeCamera(true);
					setCameraTarget(localPlayer,localPlayer);
					setCameraShakeLevel(0);
					--setPlayerHudComponentVisible("all", true);
					setCameraGoggleEffect("normal");
					triggerServerEvent("AirStrike:onGUIClose", localPlayer, localPlayer);
				end, 2000, 1);
			end, 10*(60.2*1000), 1);
		end
		setTimer(
		function ()
			setCameraMatrix(215.16, 1885.8, 130.71, 215.14, 1889.63, 30.78);
			setCameraShakeLevel(125);
			addEventHandler("onClientRender", root, dxInformation);
			addEventHandler("onClientRender", root, ElementsHandler);
			addEventHandler("onClientKey", root, SMHandler);
			fadeCamera(true);
		end, 1000, 1);
		--setPlayerHudComponentVisible("all", false);
		triggerServerEvent("AirStrike:takeMoney", localPlayer, localPlayer, Price);
	else
		triggerEvent("onTextAdd",resourceRoot,"You need "..convertNumber(Price-Player.getMoney()).." more $ to deploy "..Type.." Armed Drone",240,0,0)
		--exports["msgbox"]:guiShowMessageBox("You need "..convertNumber(Price-Player.getMoney()).." more REP to deploy "..Type.." Armed Drone", "error", "Error", "Ok");
	end
end

addEventHandler("onClientGUIDoubleClick", resourceRoot,
function ()
	if source == Main["AirStrikeControl"]["gridlist"][1] then
		BuyAirStrike();
	end
end );

addEventHandler("onClientGUIClick", resourceRoot,
function ( button )
	if button == "left" then
		if source == Main["AirStrikeControl"]["button"][1] then
			if Main["AirStrikeControl"]["gridlist"][1]:getSelectedItem() ~= -1 then
				BuyAirStrike();
			else
			triggerEvent("onTextAdd",resourceRoot,"Select Armed Drone type!",240,240,240)
				--exports["msgbox"]:guiShowMessageBox("Select Armed Drone type", "error", "Error", "Ok");
			end
		elseif source == Main["AirStrikeControl"]["button"][2] then
			Main["AirStrikeControl"]["window"][1]:setVisible(false);
			showCursor(false);
			triggerServerEvent("AirStrike:onGUIClose", localPlayer, localPlayer);
		elseif source == Main["AirStrikeControl"]["gridlist"][1] then
			if Main["AirStrikeControl"]["gridlist"][1]:getSelectedItem() ~= -1 then
				local Type = Main["AirStrikeControl"]["gridlist"][1]:getItemText(Main["AirStrikeControl"]["gridlist"][1]:getSelectedItem(), 1);
				local Price = Main["AirStrikeControl"]["gridlist"][1]:getItemText(Main["AirStrikeControl"]["gridlist"][1]:getSelectedItem(), 2);
				local Abilities = Main["AirStrikeControl"]["gridlist"][1]:getItemData(Main["AirStrikeControl"]["gridlist"][1]:getSelectedItem(), 1);
				Main["AirStrikeControl"]["label"][2]:setText("Type: "..Type.."\nCost: "..Price.."\n\n"..Abilities);
			else
				Main["AirStrikeControl"]["label"][2]:setText("Please select type");
			end
		end
	end
end );

--[[function outputInteractMessage(hitElem)

if getElementType(hitElem) ~= "player" then return end
hitElem = player
triggerEvent("onInteractAdd",source,"Drone Control\n[E]",240,240,240)
end

addEventHandler("onClientColShapeHit",resourceRoot,outputInteractMessage)]]