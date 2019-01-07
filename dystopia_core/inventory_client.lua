painTimers = {}
isInventoryOpen = false					   
local playerHasFreeEquipmentSlots 

--local theTick = getTickCount()

addEvent("playerSaveThirst")
addEvent("playerSaveHunger")
addEvent("HeadlampEquipped",true)
addEvent("ScannerEquipped",true)
addEvent("MedikitEquipped",true)
addEvent("ToolboxEquipped",true)


-------------------------------

px,py,pz = getElementPosition(localPlayer)
local itensTable = 
{
                   -- item name, item object id, fix z
                   {"Pistol Ammo",  2039, 0}, -- ITEM ID: 1 
                   {"Shotgun Ammo",  2038, 0}, -- ITEM ID: 2
                   {"Assault Ammo",  2040, 0} , -- 3
                   {"SMG Ammo",  2041, 0}, -- 4
                   {"Chainsaw",  341, 0},  -- 5
                   {"Raider Sword",  339, 0}, -- 6
                   {"M4",  356, 0}, -- 7 
                   {"AK 47",  355, 0}, -- 8
                   {"Rocket Launcher",  359, 0}, -- 9
                   {"Knife",  335, 0}, -- 10
                   {"Hunting Rifle",  357, 0}, -- 11
                   {"Crossbow",  347, 0}, -- 12  
                   {"Sniper Rifle",  358, 0}, -- 13
                   {"Minigun",  362, 0}, --14
                   {"Uzi",  352, 0}, --15
                   {"Vehicle Minigun",  372, 0}, --16
                   {"Combat Shotgun",  351, 0}, --17
                   {"Sawn-off Shotgun",  350, 0}, --18 
                   {"Satchel Charge",  363, 0}, --19
                   {"MP5",  353, 0}, --20
                   {"Grenade",  342, 0}, --21
                   {"Magnum Revolver",  348, 0}, --22
                   {"Stinger Launcher",  360, 0}, --23
                   {"Meat Can",2601, 0}, --24
                   {"Water Bottle",1669, 0}, --25 
				   {"Raw Meat", 2804, 0}, --26
				   {"Machete",321, 0}, --27
				   {"Kitchen Knife",322, 0}, --28
				   {"Meatcleaver",323, 0}, --29
				   {"Broken Bottle",325, 0}, --30
				   {"Nail Bat",326, 0}, --31
				   {"Crowbar",337, 0}, --32
				   {"Sledgehammer",338, 0}, --33
				   {"Pistol",346, 0}, --34
				   {"Molotov",344, 0}, --35
				   {"Nightstick",334, 0}, --36
				   {"Baseball Bat",336, 0}, --37
				   {"Tactical Shield",331, 0}, --38
				   {"Axe",333, 0}, --39
				   {"Binoculars",367, 0}, --40
				   {"Spray Can",365, 0}, --41
				   {"Pump Shotgun",349, 0}, --42
				   {"Body Armor",373, 0}, --43
				   {"Backpack",371, 0}, --44
				   {"Medikit",327, 0}, --45
				   {"Teargas",343, 0}, --46
				   {"Flamethrower",361, 0}, --47
				   {"Bolts",328, 0}, --48 
				   {"Magnum Ammo",3082, 0}, --49  
				   {"Painkillers",2709, 0}, --50
				   {"Rifle Ammo",2042, 0}, --51 
				   {"Fuel Canister",1650, 0},
				   {"Empty Canister",1650, 0},
				   {"Scrap Metal",850, 0},
				   {"Ammo Box",3016, 0},
				   {"Toolbox",2969, 0},
				   {"Alcohol Bottle",2969, 0},
				   {"Rags",2844, 0},
				   {"Empty Bottle",1668, 0},
				   {"Map",3017, 0},
				   {"Survivor Map",3017, 0},
				   {"Military Map",3017, 0},
				   {"Raw Human Meat",2806, 0},
				   {"Roasted Meat",2804, 0},
				   {"Vehicle Parts",2711, 0},
				   {"Roasted Human Meat",2804, 0},
				   {"Plastic Foil",1901, 0},
				   {"Wire",933, 0},
				   {"Fish Can",2601, 0},
				   {"Water Canister",1650, 0},
				   {"Headlamp",15060, 0},
				   {"Thermal Googles",369, 0},
				   {"Wood",1463, 0},
				   {"Laser Pointer",1463, 0},
				   {"Lighter",2351, 0},
				   {"Bandage",2384, 0},
				   {"Night Vision Googles", 368, 0},
				   {"Zip Line", 1955, 0},
				   {"Dirty Water",1669, 0},
				   {"Adrenaline",2709, 0},--
				   {"ZomboKleen",2709, 0},--
				   {"Splint",1279, 0},--
				   {"Road Flare",1319, 0},--
				   {"Hazmat Suit",1576, 0},--
				   {"Camouflage Suit",1575, 0},--
				   {"Scuba Gear", 1010, 0},--
				   {"Watch", 2710, 0},--
				   {"EM Scanner",1615, 0},--
				   {"Radio",330, 0},--
				   {"M37 Stomper",2033, 0},--
				   {"Stomper Ammo",2972, 0},
				   {"Minigun Ammo",2358, 0},--
				   {"Stinger Missile", 3790, 0},--
				   {"Spikestrip", 2899, 0},
				   {"Timed Bomb",1654, 0},--
				   {"Mine",1381, 0},--
				   {"Incendiary Trap",2978, 0},--
				   {"Shards Trap",2978, 0},--
				   {"Agent Pale",366, 0},--
				   {"Soup Can",2601, 0}
				   
}

DGS = exports.dgs
slotTex1 = dxCreateTexture("images/slot1.png")
slotTex2 = dxCreateTexture("images/slot2.png")
slotTex3 = dxCreateTexture("images/slot3.png")

--ChunkfiveFont = DGS:dgsDxGUICreateFont ( "fonts/Chunkfive.otf", 15 )
--ChunkfiveFontSmall = DGS:dgsDxGUICreateFont ( "fonts/Chunkfive.otf", 11 )
--DystopiaFontGUI = DGS:dgsDxGUICreateFont ( "fonts/Dystopia_font.ttf", 15 )
ChunkfiveFont = guiCreateFont ( "fonts/Chunkfive.otf", 15 )
ChunkfiveFontSmall = guiCreateFont ( "fonts/Chunkfive.otf", 11 )
DystopiaFontGUI = guiCreateFont ( "fonts/Dystopia_font.ttf", 15 )
DystopiaFont = dxCreateFont ( "fonts/Dystopia_font.ttf",100,false,"default")
ChunkfiveFontDX = dxCreateFont ( "fonts/Chunkfive.otf", 100,false,"default")
ChunkfiveFontDXSmall = dxCreateFont ( "fonts/Chunkfive.otf", 15,false,"default")
--ChunkFiveDGS = DGS:dgsDxGUICreateFont( "fonts/Chunkfive.otf", 14,false,"default")
--ChunkfiveFontSmallDGS = DGS:dgsDxGUICreateFont( "fonts/Chunkfive.otf", 14,false,"default")
--DystopiaFontDGS = dgsDxGUICreateFontdxCreateFont ( "fonts/Dystopia_font.ttf",100,false,"default")


InventoryGui = {
    button = {},
    label = {}
}

        --InventoryGui.button[1] = DGS:dgsDxCreateButton(198, 176, 78, 78, " ", false)
        InventoryGui.button[1] = DGS:dgsDxCreateButton(198, 176, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(InventoryGui.button[1], 0.87)
        InventoryGui.button[2] = DGS:dgsDxCreateButton(282, 176, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(InventoryGui.button[2], 0.87)
        InventoryGui.button[3] = DGS:dgsDxCreateButton(366, 176, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(InventoryGui.button[3], 0.87)
        InventoryGui.button[4] = DGS:dgsDxCreateButton(198, 259, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(InventoryGui.button[4], 0.87)
        InventoryGui.button[5] = DGS:dgsDxCreateButton(282, 259, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(InventoryGui.button[5], 0.87)
        InventoryGui.button[6] = DGS:dgsDxCreateButton(366, 259, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(InventoryGui.button[6], 0.87)
        InventoryGui.button[7] = DGS:dgsDxCreateButton(198, 342, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(InventoryGui.button[7], 0.87)
        InventoryGui.button[8] = DGS:dgsDxCreateButton(282, 342, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(InventoryGui.button[8], 0.87)
        InventoryGui.button[9] = DGS:dgsDxCreateButton(366, 342, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(InventoryGui.button[9], 0.87)
		
		InventoryGui.label[5] = guiCreateLabel(375+77, 179, 267, 32, "", false) --item name shadow
		InventoryGui.label[1] = guiCreateLabel(375+78, 180, 267, 32, "", false) --item name
		InventoryGui.label[6] = guiCreateLabel(375+77, 200, 267, 140, "", false) --item description shadow
		InventoryGui.label[2] = guiCreateLabel(375+78, 201, 267, 140, "", false) --item description

		--InventoryGui.label[2] = DGS:dgsDxCreateLabel(375+78, 201, 267, 150, "", false) --item description -- commented out are the original lines; label size was temporarily culled on line above, until I sort out this resolution mess
		--InventoryGui.label[6] = DGS:dgsDxCreateLabel(375+77, 200, 267, 150, "", false) --item description shadow
		InventoryGui.label[4] = guiCreateLabel(197, 149, 267, 60, " ", false) -- inventory title shadow -- "Inventory"
		InventoryGui.label[3] = guiCreateLabel(198, 150, 267, 60, " ", false) -- inventory title -- "Inventory"
		
		guiSetAlpha(InventoryGui.label[3], 0.87)
		guiSetAlpha(InventoryGui.label[1], 0.87)
		guiSetAlpha(InventoryGui.label[2], 0.87)
		guiSetAlpha(InventoryGui.label[6], 0.87)
		guiSetAlpha(InventoryGui.label[4], 0.87)
		guiSetAlpha(InventoryGui.label[5], 0.87)
		
		guiLabelSetColor(InventoryGui.label[4], 0,0,0)
		guiLabelSetColor(InventoryGui.label[5], 0,0,0)
		guiLabelSetColor(InventoryGui.label[6], 0,0,0)

		
		guiSetFont(InventoryGui.label[1], ChunkfiveFont)
		guiSetFont(InventoryGui.label[2], "default-bold-small") 
		guiSetFont(InventoryGui.label[3], ChunkfiveFont)
		guiSetFont(InventoryGui.label[4], ChunkfiveFont)
		guiSetFont(InventoryGui.label[5], ChunkfiveFont)
		guiSetFont(InventoryGui.label[6], "default-bold-small") 

        
guiSetVisible(InventoryGui.label[1],false)
guiSetVisible(InventoryGui.label[2],false) 
guiSetVisible(InventoryGui.label[3],false) 
guiSetVisible(InventoryGui.label[4],false)
guiSetVisible(InventoryGui.label[5],false)
guiSetVisible(InventoryGui.label[6],false)
DGS:dgsDxGUISetVisible(InventoryGui.button[1],false)
DGS:dgsDxGUISetVisible(InventoryGui.button[2],false)
DGS:dgsDxGUISetVisible(InventoryGui.button[3],false)
DGS:dgsDxGUISetVisible(InventoryGui.button[4],false)
DGS:dgsDxGUISetVisible(InventoryGui.button[5],false)
DGS:dgsDxGUISetVisible(InventoryGui.button[6],false)
DGS:dgsDxGUISetVisible(InventoryGui.button[7],false)
DGS:dgsDxGUISetVisible(InventoryGui.button[8],false)
DGS:dgsDxGUISetVisible(InventoryGui.button[9],false)

addEvent("hideInventorySlots", true)

function hideSlotsWhenNoBackpack ()
DGS:dgsDxGUISetVisible(InventoryGui.button[4],false)
DGS:dgsDxGUISetVisible(InventoryGui.button[5],false)
DGS:dgsDxGUISetVisible(InventoryGui.button[6],false)
DGS:dgsDxGUISetVisible(InventoryGui.button[7],false)
DGS:dgsDxGUISetVisible(InventoryGui.button[8],false)
DGS:dgsDxGUISetVisible(InventoryGui.button[9],false)
end
addEventHandler("hideInventorySlots",localPlayer, hideSlotsWhenNoBackpack)

PlayersItens={}

addEvent("synchronizeTables",true)
addEventHandler("synchronizeTables",root, function(table_)
PlayersItens = table_
end)

function drawInventory()

if not(PlayersItens[localPlayer])then return end
local d1 = PlayersItens[localPlayer][1] 
local d2 = PlayersItens[localPlayer][2] 
local d3 = PlayersItens[localPlayer][3] 
local d4 = PlayersItens[localPlayer][4] 
local d5 = PlayersItens[localPlayer][5] 
local d6 = PlayersItens[localPlayer][6] 
local d7 = PlayersItens[localPlayer][7] 
local d8 = PlayersItens[localPlayer][8] 
local d9 = PlayersItens[localPlayer][9] 

if(d1 and d1~="Empty")then
dxDrawImage(205, 186, 61, 51, "icons/"..d1..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
end
if(d2 and d2~="Empty")then
dxDrawImage(292, 186, 61, 51, "icons/"..d2..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
end
if(d3 and d3~="Empty")then
dxDrawImage(376, 186, 61, 51, "icons/"..d3..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
end
	if getElementData(localPlayer,"backpackequipped")==true then
		if(d4 and d4~="Empty")then
		dxDrawImage(205, 269, 61, 51, "icons/"..d4..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		end
		if(d5 and d5~="Empty")then
		dxDrawImage(292, 269, 61, 51, "icons/"..d5..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		end
		if(d6 and d6~="Empty") then
		dxDrawImage(373, 269, 61, 51, "icons/"..d6..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		end
		if(d7 and d7~="Empty")then
		dxDrawImage(208, 352, 61, 51, "icons/"..d7..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		end
		if(d8 and d8~="Empty")then
		dxDrawImage(289, 352, 61, 51, "icons/"..d8..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		end
		if(d9 and d9~="Empty")then
		dxDrawImage(373, 352, 61, 51, "icons/"..d9..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
	 end
end
 
local team = getPlayerTeam(localPlayer)
if not team then triggerServerEvent("ChangePlayerTeam",localPlayer,Scavengers) end 
local teamname = getTeamName(getPlayerTeam(localPlayer)) or "Scavengers"

local neutralalpha
local raidersalpha
local cdfalpha
local banditsalpha
local scavengersalpha
local establishmentalpha

if teamname == "" then neutralalpha= 255 else neutralalpha= 0 end
if teamname == "Raiders" then raidersalpha= 255 else raidersalpha= 0 end
if teamname == "CDF" then cdfalpha= 255 elseif team ~= CDF then cdfalpha= 0  end
if teamname == "Bandits" then banditsalpha= 255 else banditsalpha= 0 end
if teamname == "Scavengers" then scavengersalpha= 255 else scavengersalpha= 0 end
if teamname == "Establishment" then establishmentalpha= 255 else establishmentalpha= 0 end

dxDrawImage(screenWidth-110, (screenHeight-(screenHeight/10)*9)-30,100,100, "images/establishment_logo.png",0,0,0,tocolor(0,0,0,establishmentalpha))	
dxDrawImage(screenWidth-110, (screenHeight-(screenHeight/10)*9)-30,102,102, "images/establishment_logo.png",0,0,0,tocolor(255,255,255,establishmentalpha))

dxDrawImage(screenWidth-110, (screenHeight-(screenHeight/10)*9)-30,100,100, "images/scavengers_logo.png",0,0,0,tocolor(0,0,0,scavengersalpha))
dxDrawImage(screenWidth-110, (screenHeight-(screenHeight/10)*9)-30,102,102, "images/scavengers_logo.png",0,0,0,tocolor(255,255,255,scavengersalpha))

dxDrawImage(screenWidth-110, (screenHeight-(screenHeight/10)*9)-30,100,100, "images/bandits_logo.png",0,0,0,tocolor(0,0,0,banditsalpha))
dxDrawImage(screenWidth-110, (screenHeight-(screenHeight/10)*9)-30,102,102, "images/bandits_logo.png",0,0,0,tocolor(255,255,255,banditsalpha))


dxDrawImage(screenWidth-110, (screenHeight-(screenHeight/10)*9)-30,100,100, "images/cdf_logo.png",0,0,0,tocolor(0,0,0,cdfalpha))
dxDrawImage(screenWidth-110, (screenHeight-(screenHeight/10)*9)-30,102,102, "images/cdf_logo.png",0,0,0,tocolor(255,255,255,cdfalpha))


dxDrawImage(screenWidth-110, (screenHeight-(screenHeight/10)*9)-30,100,100, "images/raiders_logo.png",0,0,0,tocolor(0,0,0,raidersalpha)) 
dxDrawImage(screenWidth-110, (screenHeight-(screenHeight/10)*9)-30,102,102, "images/raiders_logo.png",0,0,0,tocolor(255,255,255,raidersalpha)) 

dxDrawImage(screenWidth-110, (screenHeight-(screenHeight/10)*9)-30,100,100, "images/wanted_logo.png",0,0,0,tocolor(0,0,0,neutralalpha)) 
dxDrawImage(screenWidth-110, (screenHeight-(screenHeight/10)*9)-30,102,102, "images/wanted_logo.png",0,0,0,tocolor(255,255,255,neutralalpha)) 

--------weight text
local weight = equippedWeight()
local screenWidth, screenHeight = guiGetScreenSize()
local a,b,c = 255,255,255
	if weight <= 4 then a,b,c = 255,255,255 --white
	elseif weight > 4 and  weight < 6 then a,b,c = 245,118,49  --dark orange
	else a,b,c = 245,72,49 --red
	end
--[[dxDrawText( "weight:\n"..weight.."/6", 157, 616-150, screenWidth, screenHeight, tocolor ( 0, 0, 0, 200 ), 1.02, "pricedown","left","top" ) -- weight counter shadow
dxDrawText( "weight:\n"..weight.."/6", 158, 617-150, screenWidth, screenHeight, tocolor ( a, b, c, 200 ), 1.0, "pricedown","left","top" ) -- weight counter]]

dxDrawText( "wgt: "..weight.."/6", screenWidth-265-65,screenHeight-97, screenWidth, screenHeight, tocolor ( 0, 0, 0, 200 ), 0.82, "pricedown","left","top" ) -- weight counter shadow
dxDrawText( "wgt: "..weight.."/6", screenWidth-266-65,screenHeight-98, screenWidth, screenHeight, tocolor ( a, b, c, 200 ), 0.82, "pricedown","left","top" ) -- weight counter

--- lives display
local livesnumber = tonumber(getElementData(localPlayer,"lives")) 


if livesnumber == 0 then
                    dxDrawImage(sWidth-18,(screenHeight-(screenHeight/10)*9)-10,16.0,19.0,"images/heart.png",0.0,0.0,0.0,tocolor(0,0,0,100),false)
                    dxDrawImage(sWidth-18,(screenHeight-(screenHeight/10)*9)-10+22,16.0,19.0,"images/heart.png",0.0,0.0,0.0,tocolor(0,0,0,100),false)
                    dxDrawImage(sWidth-18,(screenHeight-(screenHeight/10)*9)-10+44,16.0,19.0,"images/heart.png",0.0,0.0,0.0,tocolor(0,0,0,100),false) 
            
			elseif livesnumber == 1 then
                    dxDrawImage(sWidth-18,(screenHeight-(screenHeight/10)*9)-10,16.0,19.0,"images/heart.png",0.0,0.0,0.0,tocolor(0,0,0,100),false)
                    dxDrawImage(sWidth-18,(screenHeight-(screenHeight/10)*9)-10+22,16.0,19.0,"images/heart.png",0.0,0.0,0.0,tocolor(0,0,0,100),false)
                    dxDrawImage(sWidth-18,(screenHeight-(screenHeight/10)*9)-10+44,16.0,19.0,"images/heart.png",0.0,0.0,0.0,tocolor(240,0,0,210),false) 
            
            elseif livesnumber == 2 then
                    dxDrawImage(sWidth-18,(screenHeight-(screenHeight/10)*9)-10,16.0,19.0,"images/heart.png",0.0,0.0,0.0,tocolor(0,0,0,100),false)
                    dxDrawImage(sWidth-18,(screenHeight-(screenHeight/10)*9)-10+22,16.0,19.0,"images/heart.png",0.0,0.0,0.0,tocolor(240,0,0,210),false) 
                    dxDrawImage(sWidth-18,(screenHeight-(screenHeight/10)*9)-10+44,16.0,19.0,"images/heart.png",0.0,0.0,0.0,tocolor(240,0,0,210),false)
                    
            elseif livesnumber == 3 then
                    dxDrawImage(sWidth-18,(screenHeight-(screenHeight/10)*9)-10,16.0,19.0,"images/heart.png",0.0,0.0,0.0,tocolor(240,0,0,210),false) 
                    dxDrawImage(sWidth-18,(screenHeight-(screenHeight/10)*9)-10+22,16.0,19.0,"images/heart.png",0.0,0.0,0.0,tocolor(240,0,0,210),false)
                    dxDrawImage(sWidth-18,(screenHeight-(screenHeight/10)*9)-10+44,16.0,19.0,"images/heart.png",0.0,0.0,0.0,tocolor(240,0,0,210),false)
					
end  

--level and experience
local x,y = guiGetScreenSize()
local exp_ = (getElementData ( localPlayer, "experience" ) or 1)
local level = (getElementData(localPlayer,"level")or 1)
local a,b = getLevelValues(level) 
local a1,b1
if level == 12 then
a1,b1 = 33000,"Legend" 
else
a1,b1 = getLevelValues(level+1) 
end
if not a then a = 1000000; b = "Legend" end
--local a1,b1 = getLevelValues(level+1)
--if not a1 then a1 = 1000000; b1 = "Legend" end
--local ExpBar = (0.1875*x) * (( exp_ % a )/a) 
local alpha
if b == "Legend" then alpha=0 else alpha = 255 end
dxDrawText(tostring(b),x-81, (y-(y/10)*9)+51, x-41, (y-(y/10)*9)-51,tocolor(0, 0, 0, 255), 0.8, "pricedown", "right", "top", false, false, true, false, false) --level name txt shadow
dxDrawText(tostring(b),x-80, (y-(y/10)*9)+50, x-40, (y-(y/10)*9)-50,tocolor(255, 255, 255, 255), 0.8, "pricedown", "right", "top", false, false, true, false, false) --level name txt
if b == "Legend" then
dxDrawText(tostring(exp_).." xp", x-81, (y-(y/10)*9)+81, x-41, (y-(y/10)*9)-51, tocolor(0, 0, 0, alpha), 1.00, "default", "left", "top", false, false, true, false, false) --xp text shadow for Legend (no more progression possible, so no expreq)
dxDrawText(tostring(exp_).." xp", x-80, (y-(y/10)*9)+80, x-41, (y-(y/10)*9)-50, tocolor(255, 255, 255, alpha), 1.00, "default", "left", "top", false, false, true, false, false) --xp text for Legend (no more progression possible, so no expreq)
else
dxDrawText(tostring(exp_).." / ".. a1.." xp", x-81, (y-(y/10)*9)+81, x-41, (y-(y/10)*9)-51, tocolor(0, 0, 0, alpha), 1.00, "default", "right", "top", false, false, true, false, false) --xp text shadow
dxDrawText(tostring(exp_).." / ".. a1.." xp", x-80, (y-(y/10)*9)+80, x-41, (y-(y/10)*9)-50, tocolor(255, 255, 255, alpha), 1.00, "default", "right", "top", false, false, true, false, false) --xp text
end
 
end
 
addEvent("RefreshDraw",true)
addEventHandler("RefreshDraw",root,
function()
Open_CloseIn()
Open_CloseIn()
Open_CloseBelt()
Open_CloseBelt()
Open_CloseCraft("noMessagePls")
Open_CloseCraft("noMessagePls")
end)

addEvent("SynchronizeAll",true)
addEventHandler("SynchronizeAll",root,
function()
Open_CloseIn()
Open_CloseIn()
Open_CloseBelt()
Open_CloseBelt()

end)
        
function Open_CloseIn()

if getElementData(localPlayer, "carriedObject") then --[[outputInteractInfo( "Drop object first!\n[H]", 255, 255, 255 )]] return end
if isElement(binocularsShader) then destroyElement(binocularsShader ) end
local visi = DGS:dgsDxGUIGetVisible(InventoryGui.button[1])

 ---if crafting recipes available
--[[	 if not visi then 
		assesPlayerCraftingResources()
		if #PlayersCraftItems > 0 then
		outputInteractInfo("Crafting recipes available\n[J] Craft",255,255,255)
		end		
	 end]]
	 
isInventoryOpen = not isInventoryOpen	

if isInventoryOpen == true then disablePlayerMinimap() else enablePlayerMinimap() end

--[[	if isInventoryOpen == false then

	equipment_menu_mode = nil
	DGS:dgsDxLabelSetColor(EquippedGui.label, 255,255,255)
	DGS:dgsDxLabelSetColor(EquippedGui.ammo_label, 150,150,150)

	end]]

guiSetText(InventoryGui.label[1],"")
guiSetText(InventoryGui.label[2],"")
guiSetText(InventoryGui.label[5],"")
guiSetText(InventoryGui.label[6],"")

guiSetVisible(InventoryGui.label[1],not(visi))
guiSetVisible(InventoryGui.label[2],not(visi))
guiSetVisible(InventoryGui.label[3],not(visi)) 
guiSetVisible(InventoryGui.label[4],not(visi))
guiSetVisible(InventoryGui.label[5],not(visi))
guiSetVisible(InventoryGui.label[6],not(visi))
DGS:dgsDxGUISetVisible(InventoryGui.button[1],not(visi))
DGS:dgsDxGUISetVisible(InventoryGui.button[2],not(visi))
DGS:dgsDxGUISetVisible(InventoryGui.button[3],not(visi))

	if getElementData(localPlayer,"backpackequipped") == true then 
		DGS:dgsDxGUISetVisible(InventoryGui.button[4],not(visi))
		DGS:dgsDxGUISetVisible(InventoryGui.button[5],not(visi))
		DGS:dgsDxGUISetVisible(InventoryGui.button[6],not(visi))
		DGS:dgsDxGUISetVisible(InventoryGui.button[7],not(visi))
		DGS:dgsDxGUISetVisible(InventoryGui.button[8],not(visi))
		DGS:dgsDxGUISetVisible(InventoryGui.button[9],not(visi))
	end
	
showCursor(not(visi))



	if(visi)then
	removeEventHandler("onClientRender",root,drawInventory)
	else
	addEventHandler("onClientRender",root,drawInventory)
	end

end

function ToggleInventoryHUD ()
if getElementHealth(localPlayer)<=0 then return end
if getCameraTarget(localPlayer) ~= localPlayer then return end
Open_CloseIn()
Open_CloseBelt()
local tradevisi = guiGetVisible(TradeGui.Tradelabel[1])
if tradevisi then Open_CloseTrade() end
local sound = playSound3D("sounds/openclose.mp3",getElementPosition(localPlayer)) 
setSoundVolume(sound,0.5)
if guiGetVisible(CraftGui.craftlabel[1]) then Open_CloseCraft() end
end

--bindKey("end","down",Open_CloseIn) -- end open/close inventory
bindKey("Q","down","Inventory") -- q open/close inventory
bindKey("End","down","Inventory") -- q open/close inventory
--addCommandHandler("Inventory",Open_CloseIn)
addCommandHandler("Inventory",ToggleInventoryHUD)

function closeInventoryOnWasted ()
	if source == localPlayer then
	local visi = guiGetVisible(InventoryGui.label[1])
		if(visi)then
		Open_CloseIn()
		Open_CloseBelt()
		end
	if isElement(ToonPanel) and guiGetVisible(ToonPanel) then open_closeToonPanel(localPlayer) end
	if guiGetVisible(CraftGui.craftlabel[1]) then Open_CloseCraft() end
	end	
end
addEventHandler("onClientPlayerWasted",root,closeInventoryOnWasted)

addEvent("onCloseInventory",true)
function closeInventoryOnVehicleEnter()
local visi = guiGetVisible(InventoryGui.label[1])
		if(visi)then
		Open_CloseIn()
		Open_CloseBelt()
		end
	if isElement(ToonPanel) and guiGetVisible(ToonPanel) then open_closeToonPanel(localPlayer) end
	if guiGetVisible(CraftGui.craftlabel[1]) then Open_CloseCraft() end
end	

addEventHandler("onCloseInventory",root,closeInventoryOnVehicleEnter)


addEventHandler( "onClientDgsDxMouseLeave", root,
function ()
if not(PlayersItens[localPlayer])then return end
local d1 = PlayersItens[localPlayer][1] or "Empty"
local d2 = PlayersItens[localPlayer][2] or "Empty"
local d3 = PlayersItens[localPlayer][3] or "Empty"
local d4 = PlayersItens[localPlayer][4] or "Empty"
local d5 = PlayersItens[localPlayer][5] or "Empty"
local d6 = PlayersItens[localPlayer][6] or "Empty"
local d7 = PlayersItens[localPlayer][7] or "Empty"
local d8 = PlayersItens[localPlayer][8] or "Empty"
local d9 = PlayersItens[localPlayer][9] or "Empty"
if(source ==InventoryGui.button[1]) then
destroyCursorTooltip()
guiSetText(InventoryGui.label[1],"")
guiSetText(InventoryGui.label[2],"")
guiSetText(InventoryGui.label[5],"")
guiSetText(InventoryGui.label[6],"")
elseif (source ==InventoryGui.button[2]) then
destroyCursorTooltip()
guiSetText(InventoryGui.label[1],"")
guiSetText(InventoryGui.label[2],"")
guiSetText(InventoryGui.label[5],"")
guiSetText(InventoryGui.label[6],"")
elseif (source ==InventoryGui.button[3]) then
destroyCursorTooltip()
guiSetText(InventoryGui.label[1],"")
guiSetText(InventoryGui.label[2],"")
guiSetText(InventoryGui.label[5],"")
guiSetText(InventoryGui.label[6],"")
elseif (source ==InventoryGui.button[4]) then
destroyCursorTooltip()
guiSetText(InventoryGui.label[1],"")
guiSetText(InventoryGui.label[2],"")
guiSetText(InventoryGui.label[5],"")
guiSetText(InventoryGui.label[6],"")
elseif (source ==InventoryGui.button[5]) then
destroyCursorTooltip()
guiSetText(InventoryGui.label[1],"")
guiSetText(InventoryGui.label[2],"")
guiSetText(InventoryGui.label[5],"")
guiSetText(InventoryGui.label[6],"")
elseif (source ==InventoryGui.button[6]) then
destroyCursorTooltip()
guiSetText(InventoryGui.label[1],"")
guiSetText(InventoryGui.label[2],"")
guiSetText(InventoryGui.label[5],"")
guiSetText(InventoryGui.label[6],"")
elseif (source ==InventoryGui.button[7]) then
destroyCursorTooltip()
guiSetText(InventoryGui.label[1],"")
guiSetText(InventoryGui.label[2],"")
guiSetText(InventoryGui.label[5],"")
guiSetText(InventoryGui.label[6],"")
elseif (source ==InventoryGui.button[8]) then
destroyCursorTooltip()
guiSetText(InventoryGui.label[1],"")
guiSetText(InventoryGui.label[2],"")
guiSetText(InventoryGui.label[5],"")
guiSetText(InventoryGui.label[6],"")
elseif (source ==InventoryGui.button[9]) then
destroyCursorTooltip()
guiSetText(InventoryGui.label[1],"")
guiSetText(InventoryGui.label[2],"")
guiSetText(InventoryGui.label[5],"")
guiSetText(InventoryGui.label[6],"")
end
end)


--[[
addEventHandler( "onClientDgsDxMouseLeave", root,
function ()
destroyCursorTooltip()
end)]]



function getItemDescription(item)
local description
if item == "M4" then description = "The workhorse of the US military,\nthis powerful assault rifle became a praised\nand rare item after The Incident."
elseif item == "Pistol Ammo" then description = "A pistol magazine.\nIt holds 10 small caliber rounds."
elseif item == "Shotgun Ammo" then description = "8 shotgun slugs. Guaranteed zombie stoppers."
elseif item == "Assault Ammo" then description = "30 Assault Rifle rounds packed tight\nin a standard magazine."
elseif item == "SMG Ammo" then description = "A small caliber magazine,\nholding 30 rounds."
elseif item == "Chainsaw" then description = "Loud, scary and deadly,\nyou will sure make an impression."
elseif item == "Raider Sword" then description =  "Lethal improvised weapon,\nmade from sharpened pieces of metal.\nInflicts bleeding."
elseif item == "AK 47" then description = "The favourite weapon of guerrillas\nall around the world, the AK 47\nneeds no more presentation."
elseif item == "Rocket Launcher" then description = "A portable one-shot unguided\nanti-vehicle weapon. Dispose after use.\nNotoriously inaccurate."
elseif item == "Knife" then description = "A sharp, full-tang combat knife.\nCan inflict bleeding."
elseif item == "Hunting Rifle" then description = "Powerful semi-automatic rifle,\nwith superior range and accuracy."
elseif item == "Crossbow" then description = "Wooden crossbow, popular with hunters\nbefore The Incident. It's low noise profile\nmakes it perfect for stealthy individuals."
elseif item == "Sniper Rifle" then description = "Long range scoped rifle, a favourite\nof bandits and other cautious people."
elseif item == "Minigun" then description = "Heavy multi-barrel rotary machinegun. Mount it\non vehicles for added firepower\nor use in stationary positions to cover choke-points."
elseif item == "Uzi" then description = "Small and compact sub-machine gun.\nCan be dual-wielded by skilled shooters."
elseif item == "Vehicle Minigun" then description = "Vehicle minigun. Should not be available in inventory.\nIf you read this, please report it as a bug."
elseif item == "Combat Shotgun" then description = "Military issue semi-automatic shotgun.\nUseful against vehicles or clusters of enemies."
elseif item == "Sawn-off Shotgun" then description = "Double-barreled shotgun\nwith an illegal modification.\nIt sure packs a punch!"
elseif item == "Satchel Charge" then description = "Remote controlled explosive device."
elseif item == "MP5" then description = "Quality German made SMG,\npopular with law enforcement\nagencies all over the world."
elseif item == "Grenade" then description = "Regular HE grenade.\nRemove the pin and throw it away."
elseif item == "Magnum Revolver" then description = "Heavy handgun, that compensates\nit's slow rate of fire with\nsheer stopping power."
elseif item == "Stinger Launcher" then description = "A shoulder guided missile launcher.\nBrings down vehicles easily."
elseif item == "Meat Can" then description = "A can of beef. Past expiration date,\nbut you've eaten worse anyway."
elseif item == "Water Bottle"  then description = "A bottle of clean water.\nYou can drink it to relieve thirst\nor to retrieve the bottle."
elseif item == "Raw Meat" then description = "A bloody piece of raw meat.\nPerhaps it's better to cook it first..."
elseif item == "Machete" then description = "Standard issue jungle machete.\nUseful to chop wood... or bodies.\nInflicts bleeding."
elseif item == "Kitchen Knife" then description = "A rusty kitchen knife.\nInflicts bleeding."
elseif item == "Meatcleaver" then description = "Heavy, nasty looking cleaver.\nInflicts bleeding."
elseif item == "Broken Bottle" then description = "A frail improvised weapon\nwith sharp menacing edges.\nInflicts bleeding."
elseif item == "Nail Bat" then description = "A crude improvised weapon.\nCan inflict bleeding."
elseif item == "Crowbar" then description = "Sturdy crowbar, used for\noptimal leverage or bashing heads.\nCan stun enemies with low health."
elseif item == "Sledgehammer" then description = "Heavy metal headed sledgehammer.\nCan stun enemies with low health."
elseif item == "Pistol" then description = "Semi-automatic standard issue pistol.\nCan be dual-wielded with proper skill."
elseif item == "Molotov" then description = "Homemade incendiary device.\nCreates fire that persists for a while."
elseif item == "Nightstick" then description = "Establishment's tool of blunt justice.\nMade from a metal bar with rubber coating.\nCan stun enemies with low health."
elseif item == "Baseball Bat" then description = "A wooden bat. Not many ocassions for\nsports now, but might come in handy.\nCan stun enemies with low health."
elseif item == "Tactical Shield" then description = "(WIP) "
elseif item == "Axe" then description ="Strong wood-cutting axe.\nWorks just the same on limbs.\nCan inflict bleeding."
elseif item == "Binoculars" then description = "Swiss optics.\nUse them to see without beeing seen."
elseif item == "Spray Can" then description = "A can of paint. Use it to leave\nyour mark in the world."
elseif item == "Pump Shotgun" then description = "A regular pump action shotgun,\ndesigned for home defence."
elseif item == "Body Armor" then description = "A thick layer of kevlar\nto delay the inevitable."
elseif item == "Backpack" then description = "A voluminous, sturdy backpack.\nCan hold 6 items."
elseif item == "Medikit" then description = "A medikit for general use.\nWill fully restore health when used.\nMedics can equip it to heal lesser amounts\nwithout consuming the item."
elseif item == "Teargas" then description = "A tear gas grenade, useful to cover retreat,\n helpful when storming a building."
elseif item == "Flamethrower" then description = "(WIP) "
elseif item == "Bolts"  then description = "5 wooden crossbow bolts."
elseif item == "Magnum Ammo" then description = "6 hollow-point rounds, designed to break\non impact, causing maximum damage."
elseif item == "Painkillers" then description = "Over-the-counter analgesic. Stops pain effects.\nProlonged use leads to addiction."
elseif item == "Rifle Ammo" then description = "5 high powered rifle rounds."
elseif item == "Fuel Canister" then description = "A metal canister holding 10 L of fuel."
elseif item == "Empty Canister" then description = "An empty 10 L canister."
elseif item == "Scrap Metal" then description = "Various pieces of metal.\nUseful for crafting."
elseif item == "Ammo Box" then description = "Contains various types of ammunition.\nWe love surprises!"
elseif item == "Toolbox" then description = "A compact toolbox, useful for field repairs\nand various DIY projects.\nTechs can equip it to save inventory space."
elseif item == "Alcohol Bottle" then description = "A well-aged bourbon bottle. Drink it for fun,\nto numb pain or to obtain the bottle.\nProlonged use leads to addiction."
elseif item == "Rags" then description = "Some dirty rags.\nMaybe I can use them?"
elseif item == "Empty Bottle" then description = "An empty bottle. You can fill it up\nfrom a water source or break it\nto obtain an improvised weapon."
elseif item == "Map" then description = "A tarnished map, still readable."
elseif item == "Survivor Map" then description = "This map has seen better days,\nbut it contains a wealth of information."
elseif item == "Military Map" then description = "Military map, featuring fuzzy location labels\nand ambiguous encounter zones."
elseif item == "Raw Human Meat" then description = "A raw piece of human flesh."
elseif item == "Roasted Meat" then description = "A tasty piece of charred meat."
elseif item == "Vehicle Parts" then description = "Rusty vehicle parts for your backyard projects."
elseif item == "Roasted Human Meat" then description = "Some say it tastes like chicken."
elseif item == "Plastic Foil" then description = "A roll of plastic foil.\nProtects things from moisture."
elseif item == "Wire" then description = "Flexible metal wire.\nHanging made easy."
elseif item == "Fish Can" then description = "A can of fish.\nIt did not smell good to begin with."
elseif item == "Water Canister" then description = "A metal canister holding 10 L of water.\nFor those times when you're really thirsty."
elseif item == "Dirty Water" then description = "A bottle with dirty water.\nBetter boil before use."
elseif item == "Headlamp" then description = "A powerful headlamp,\nguaranteed to attract some zeds."
elseif item == "Thermal Googles" then description = "See the world in a whole new light with\nthese state of the art thermal goggles."
elseif item == "Wood" then description = "A pile of wood.\nUseful for crafting."
elseif item == "Laser Pointer" then description = "A redlight laser attachment for your gun.\nGood for letting them know you're coming."
elseif item == "Zip Line" then description = "A one-shot attachment for your crossbow\nthat will get you to high places. Mind your step!"
elseif item == "Night Vision Googles" then description = "A good pair of night-ops googles,\nspec ops surplus from some shady war."
elseif item == "Lighter" then description = "A wind-proof Blippo lighter.\nUse it to make fire."
elseif item == "Bandage" then description = "A sterile coarse bandage,\njust in time to stop that bleeding."
elseif item == "Adrenaline" then description = "An adrenaline dose for your\neveryday emergencies.\nDon't overdose!"
elseif item == "ZomboKleen" then description = "Experimental cure for the zombie infection.\nDoesn't work every time, but it still is an\nitem in high demand these days."
elseif item == "Splint" then description = "A wooden splint to immobilize your fracture.\nCan also be crafted."
elseif item == "Hazmat Suit" then description = "(WIP) Protection suit for hazardous environments.\nShields user from infection, radiation,\nfire and chemical agents."
elseif item == "Road Flare" then description = "Emmits red smoke when deployed,\nvisible from a distance. Use it\nto mark landing zones and areas of interest."
elseif item == "Camouflage Suit" then description = "(WIP) A ghillie-like improvised suit.\nWith high enough skill, it will\nmake you almost invisible when crouched."
elseif item == "Scuba Gear" then description = "(WIP) Diving equipment for the adventurous types.\nWill give you 10 minutes of air\nautonomy when used."
elseif item == "Watch" then description = "A common wrist watch."
elseif item == "EM Scanner" then description = "A handheld surveillance device that\ntracks nearby creatures and vehicles.\nRange: 50 m"
elseif item == "Radio" then description = "A portable short-range radio station.\nCan both emmit and receive,\nemmision range is 500 meters."
elseif item == "M37 Stomper" then description = "Grenade launcher attachment.\nMount it on your assault rifle.\nUse [MMB] to fire it."
elseif item == "Stomper Ammo" then description = "5 Stomper grenades."
elseif item == "Minigun Ammo" then description = "500 Minigun rounds."
elseif item == "Stinger Missile" then description = "(WIP) Guided high-explosive missile\nfor the Stinger Launcher."
elseif item == "Spikestrip" then description = "Metal device used to impede or stop\nthe movement of wheeled vehicles\nby puncturing their tires."
elseif item == "Timed Bomb" then description = "Powerful explosive charge with detonation\ntriggered by a timer. 20 seconds to clear\nthe area after arming it."
elseif item == "Mine" then description = "A proximity-triggered explosive charge."
elseif item == "Incendiary Trap" then description = "A proximity-triggered incendiary charge."
elseif item == "Shards Trap" then description = "A nasty improvised trap made\nfrom broken glass shards.\nWill inflict bleeding if you step on it."
elseif item == "Agent Pale" then description = "Metal canister containing a corrosive\ncrowd control agent, efficient against\n zombies and humans alike."
elseif item == "Soup Can" then description = "Government-issue emergency food.\nBland tasting, but helps with both\nhunger and thirst."
elseif item == "Empty" then description = " "

end
return description
end

addEventHandler( "onClientDgsDxMouseEnter", root, --draw inventory label
function()
if not(PlayersItens[localPlayer])then return end
local d1 = PlayersItens[localPlayer][1] or "Empty"
local d2 = PlayersItens[localPlayer][2] or "Empty"
local d3 = PlayersItens[localPlayer][3] or "Empty"
local d4 = PlayersItens[localPlayer][4] or "Empty"
local d5 = PlayersItens[localPlayer][5] or "Empty"
local d6 = PlayersItens[localPlayer][6] or "Empty"
local d7 = PlayersItens[localPlayer][7] or "Empty"
local d8 = PlayersItens[localPlayer][8] or "Empty"
local d9 = PlayersItens[localPlayer][9] or "Empty"

if(source ==InventoryGui.button[1]) then
createCursorTooltip(d1)
guiSetText(InventoryGui.label[1],d1)
guiSetText(InventoryGui.label[5],d1)
guiSetText(InventoryGui.label[6],getItemDescription(d1))
guiSetText(InventoryGui.label[2],getItemDescription(d1))
	if d1 == "M4" or d1 == "AK 47" or d1 == "Assault Ammo" then setPedWeaponSlot(localPlayer,5) end
	if d1 == "Pistol" or d1 == "Crossbow" or d1 == "Magnum Revolver" or d1 == "Pistol Ammo" or d1 == "Bolts" or d1 == "Magnum Ammo" then setPedWeaponSlot(localPlayer,2) end
	if d1 == "Uzi" or d1 == "Vehicle Minigun" or d1 == "MP5" or d1 == "SMG Ammo" then setPedWeaponSlot(localPlayer,4) end
	if d1 == "Pump Shotgun" or d1 == "Sawn-off Shotgun" or d1 == "Combat Shotgun" or d1 == "Shotgun Ammo" then setPedWeaponSlot(localPlayer,3) end
	if d1 == "Hunting Rifle" or d1 == "Sniper Rifle" or d1 == "Rifle Ammo" or d1 == "Rifle Clip" then setPedWeaponSlot(localPlayer,6) end
	if d1 == "Axe" or d1 == "Nightstick" or d1 == "Knife" or d1 == "Crowbar" or d1 == "Sledgehammer" or d1 == "Raider Sword" or d1 == "Chainsaw" or d1 == "Baseball Bat" then setPedWeaponSlot(localPlayer,1) end
	if d1 == "Rocket Launcher" or d1 == "Stinger Launcher" or d1 == "Flamethrower" then setPedWeaponSlot(localPlayer,7) end
	if d1 == "Grenade" or d1 == "Molotov" or d1 == "Teargas" then setPedWeaponSlot(localPlayer,8) end
	if d1 == "Agent Pale" or d1 == "Spray Can" or d1 == "Binoculars" then setPedWeaponSlot(localPlayer,9) end
	if d1 == "Machete" or d1 == "Kitchen Knife" or d1 == "Meatcleaver" or d1 == "Nail Bat" or d1 == "Broken Bottle" then setPedWeaponSlot(localPlayer,10) end
	
elseif(source ==InventoryGui.button[2])then
createCursorTooltip(d2)
guiSetText(InventoryGui.label[1],d2)
guiSetText(InventoryGui.label[5],d2)
guiSetText(InventoryGui.label[6],getItemDescription(d2))
guiSetText(InventoryGui.label[2],getItemDescription(d2))
	if d2 == "M4" or d2 == "AK 47" or d2 == "Assault Ammo" then setPedWeaponSlot(localPlayer,5) end
	if d2 == "Pistol" or d2 == "Crossbow" or d2 == "Magnum Revolver" or d2 == "Pistol Ammo" or d2 == "Bolts" or d2 == "Magnum Ammo" then setPedWeaponSlot(localPlayer,2) end
	if d2 == "Uzi" or d2 == "Vehicle Minigun" or d2 == "MP5" or d2 == "SMG Ammo" then setPedWeaponSlot(localPlayer,4) end
	if d2 == "Pump Shotgun" or d2 == "Sawn-off Shotgun" or d2 == "Combat Shotgun" or d2 == "Shotgun Ammo" then setPedWeaponSlot(localPlayer,3) end
	if d2 == "Hunting Rifle" or d2 == "Sniper Rifle" or d2 == "Rifle Ammo" or d2 == "Rifle Clip" then setPedWeaponSlot(localPlayer,6) end
	if d2 == "Axe" or d2 == "Nightstick" or d2 == "Knife" or d2 == "Crowbar" or d2 == "Sledgehammer" or d2 == "Raider Sword" or d2 == "Chainsaw" or d2 == "Baseball Bat" then setPedWeaponSlot(localPlayer,1) end
	if d2 == "Rocket Launcher" or d2 == "Stinger Launcher" or d2 == "Flamethrower" then setPedWeaponSlot(localPlayer,7) end
	if d2 == "Grenade" or d2 == "Molotov" or d2 == "Teargas" then setPedWeaponSlot(localPlayer,8) end
	if d2 == "Agent Pale" or d2 == "Spray Can" or d2 == "Binoculars" then setPedWeaponSlot(localPlayer,9) end
	if d2 == "Machete" or d2 == "Kitchen Knife" or d2 == "Meatcleaver" or d2 == "Nail Bat" or d2 == "Broken Bottle" then setPedWeaponSlot(localPlayer,10) end
	
elseif(source ==InventoryGui.button[3])then
createCursorTooltip(d3)
guiSetText(InventoryGui.label[1],d3)
guiSetText(InventoryGui.label[5],d3)
guiSetText(InventoryGui.label[6],getItemDescription(d3))
guiSetText(InventoryGui.label[2],getItemDescription(d3))
	if d3 == "M4" or d3 == "AK 47" or d3 == "Assault Ammo" then setPedWeaponSlot(localPlayer,5) end
	if d3 == "Pistol" or d3 == "Crossbow" or d3 == "Magnum Revolver" or d3 == "Pistol Ammo" or d3 == "Bolts" or d3 == "Magnum Ammo" then setPedWeaponSlot(localPlayer,2) end
	if d3 == "Uzi" or d3 == "Vehicle Minigun" or d3 == "MP5" or d3 == "SMG Ammo" then setPedWeaponSlot(localPlayer,4) end
	if d3 == "Pump Shotgun" or d3 == "Sawn-off Shotgun" or d3 == "Combat Shotgun" or d3 == "Shotgun Ammo" then setPedWeaponSlot(localPlayer,3) end
	if d3 == "Hunting Rifle" or d3 == "Sniper Rifle" or d3 == "Rifle Ammo" or d3 == "Rifle Clip" then setPedWeaponSlot(localPlayer,6) end
	if d3 == "Axe" or d3 == "Nightstick" or d3 == "Knife" or d3 == "Crowbar" or d3 == "Sledgehammer" or d3 == "Raider Sword" or d3 == "Chainsaw" or d3 == "Baseball Bat" then setPedWeaponSlot(localPlayer,1) end
	if d3 == "Rocket Launcher" or d3 == "Stinger Launcher" or d3 == "Flamethrower" then setPedWeaponSlot(localPlayer,7) end
	if d3 == "Grenade" or d3 == "Molotov" or d3 == "Teargas" then setPedWeaponSlot(localPlayer,8) end
	if d3 == "Agent Pale" or d3 == "Spray Can" or d3 == "Binoculars" then setPedWeaponSlot(localPlayer,9) end
	if d3 == "Machete" or d3 == "Kitchen Knife" or d3 == "Meatcleaver" or d3 == "Nail Bat" or d3 == "Broken Bottle" then setPedWeaponSlot(localPlayer,10) end
	
elseif(source ==InventoryGui.button[4])then
createCursorTooltip(d4)
guiSetText(InventoryGui.label[1],d4)
guiSetText(InventoryGui.label[5],d4)
guiSetText(InventoryGui.label[6],getItemDescription(d4))
guiSetText(InventoryGui.label[2],getItemDescription(d4))
	if d4 == "M4" or d4 == "AK 47" or d4 == "Assault Ammo" then setPedWeaponSlot(localPlayer,5) end
	if d4 == "Pistol" or d4 == "Crossbow" or d4 == "Magnum Revolver" or d4 == "Pistol Ammo" or d4 == "Bolts" or d4 == "Magnum Ammo" then setPedWeaponSlot(localPlayer,2) end
	if d4 == "Uzi" or d4 == "Vehicle Minigun" or d4 == "MP5" or d4 == "SMG Ammo" then setPedWeaponSlot(localPlayer,4) end
	if d4 == "Pump Shotgun" or d4 == "Sawn-off Shotgun" or d4 == "Combat Shotgun" or d4 == "Shotgun Ammo" then setPedWeaponSlot(localPlayer,3) end
	if d4 == "Hunting Rifle" or d4 == "Sniper Rifle" or d4 == "Rifle Ammo" or d4 == "Rifle Clip" then setPedWeaponSlot(localPlayer,6) end
	if d4 == "Axe" or d4 == "Nightstick" or d4 == "Knife" or d4 == "Crowbar" or d4 == "Sledgehammer" or d4 == "Raider Sword" or d4 == "Chainsaw" or d4 == "Baseball Bat" then setPedWeaponSlot(localPlayer,1) end
	if d4 == "Rocket Launcher" or d4 == "Stinger Launcher" or d4 == "Flamethrower" then setPedWeaponSlot(localPlayer,7) end
	if d4 == "Grenade" or d4 == "Molotov" or d4 == "Teargas" then setPedWeaponSlot(localPlayer,8) end
	if d4 == "Agent Pale" or d4 == "Spray Can" or d4 == "Binoculars" then setPedWeaponSlot(localPlayer,9) end
	if d4 == "Machete" or d4 == "Kitchen Knife" or d4 == "Meatcleaver" or d4 == "Nail Bat" or d4 == "Broken Bottle" then setPedWeaponSlot(localPlayer,10) end

elseif(source ==InventoryGui.button[5])then
createCursorTooltip(d5)
guiSetText(InventoryGui.label[1],d5)
guiSetText(InventoryGui.label[5],d5)
guiSetText(InventoryGui.label[6],getItemDescription(d5))
guiSetText(InventoryGui.label[2],getItemDescription(d5))
	if d5 == "M4" or d5 == "AK 47" or d5 == "Assault Ammo" then setPedWeaponSlot(localPlayer,5) end
	if d5 == "Pistol" or d5 == "Crossbow" or d5 == "Magnum Revolver" or d5 == "Pistol Ammo" or d5 == "Bolts" or d5 == "Magnum Ammo" then setPedWeaponSlot(localPlayer,2) end
	if d5 == "Uzi" or d5 == "Vehicle Minigun" or d5 == "MP5" or d5 == "SMG Ammo" then setPedWeaponSlot(localPlayer,4) end
	if d5 == "Pump Shotgun" or d5 == "Sawn-off Shotgun" or d5 == "Combat Shotgun" or d5 == "Shotgun Ammo" then setPedWeaponSlot(localPlayer,3) end
	if d5 == "Hunting Rifle" or d5 == "Sniper Rifle" or d5 == "Rifle Ammo" or d5 == "Rifle Clip" then setPedWeaponSlot(localPlayer,6) end
	if d5 == "Axe" or d5 == "Nightstick" or d5 == "Knife" or d5 == "Crowbar" or d5 == "Sledgehammer" or d5 == "Raider Sword" or d5 == "Chainsaw" or d5 == "Baseball Bat" then setPedWeaponSlot(localPlayer,1) end
	if d5 == "Rocket Launcher" or d5 == "Stinger Launcher" or d5 == "Flamethrower" then setPedWeaponSlot(localPlayer,7) end
	if d5 == "Grenade" or d5 == "Molotov" or d5 == "Teargas" then setPedWeaponSlot(localPlayer,8) end
	if d5 == "Agent Pale" or d5 == "Spray Can" or d5 == "Binoculars" then setPedWeaponSlot(localPlayer,9) end
	if d5 == "Machete" or d5 == "Kitchen Knife" or d5 == "Meatcleaver" or d5 == "Nail Bat" or d5 == "Broken Bottle" then setPedWeaponSlot(localPlayer,10) end

elseif(source ==InventoryGui.button[6])then
createCursorTooltip(d6)
guiSetText(InventoryGui.label[1],d6)
guiSetText(InventoryGui.label[5],d6)
guiSetText(InventoryGui.label[6],getItemDescription(d6))
guiSetText(InventoryGui.label[2],getItemDescription(d6))
	if d6 == "M4" or d6 == "AK 47" or d6 == "Assault Ammo" then setPedWeaponSlot(localPlayer,5) end
	if d6 == "Pistol" or d6 == "Crossbow" or d6 == "Magnum Revolver" or d6 == "Pistol Ammo" or d6 == "Bolts" or d6 == "Magnum Ammo" then setPedWeaponSlot(localPlayer,2) end
	if d6 == "Uzi" or d6 == "Vehicle Minigun" or d6 == "MP5" or d6 == "SMG Ammo" then setPedWeaponSlot(localPlayer,4) end
	if d6 == "Pump Shotgun" or d6 == "Sawn-off Shotgun" or d6 == "Combat Shotgun" or d6 == "Shotgun Ammo" then setPedWeaponSlot(localPlayer,3) end
	if d6 == "Hunting Rifle" or d6 == "Sniper Rifle" or d6 == "Rifle Ammo" or d6 == "Rifle Clip" then setPedWeaponSlot(localPlayer,6) end
	if d6 == "Axe" or d6 == "Nightstick" or d6 == "Knife" or d6 == "Crowbar" or d6 == "Sledgehammer" or d6 == "Raider Sword" or d6 == "Chainsaw" or d6 == "Baseball Bat" then setPedWeaponSlot(localPlayer,1) end
	if d6 == "Rocket Launcher" or d6 == "Stinger Launcher" or d6 == "Flamethrower" then setPedWeaponSlot(localPlayer,7) end
	if d6 == "Grenade" or d6 == "Molotov" or d6 == "Teargas" then setPedWeaponSlot(localPlayer,8) end
	if d6 == "Agent Pale" or d6 == "Spray Can" or d6 == "Binoculars" then setPedWeaponSlot(localPlayer,9) end
	if d6 == "Machete" or d6 == "Kitchen Knife" or d6 == "Meatcleaver" or d6 == "Nail Bat" or d6 == "Broken Bottle" then setPedWeaponSlot(localPlayer,10) end

elseif(source ==InventoryGui.button[7])then
createCursorTooltip(d7)
guiSetText(InventoryGui.label[1],d7)
guiSetText(InventoryGui.label[5],d7)
guiSetText(InventoryGui.label[6],getItemDescription(d7))
guiSetText(InventoryGui.label[2],getItemDescription(d7))
	if d7 == "M4" or d7 == "AK 47" or d7 == "Assault Ammo" then setPedWeaponSlot(localPlayer,5) end
	if d7 == "Pistol" or d7 == "Crossbow" or d7 == "Magnum Revolver" or d7 == "Pistol Ammo" or d7 == "Bolts" or d7 == "Magnum Ammo" then setPedWeaponSlot(localPlayer,2) end
	if d7 == "Uzi" or d7 == "Vehicle Minigun" or d7 == "MP5" or d7 == "SMG Ammo" then setPedWeaponSlot(localPlayer,4) end
	if d7 == "Pump Shotgun" or d7 == "Sawn-off Shotgun" or d7 == "Combat Shotgun" or d7 == "Shotgun Ammo" then setPedWeaponSlot(localPlayer,3) end
	if d7 == "Hunting Rifle" or d7 == "Sniper Rifle" or d7 == "Rifle Ammo" or d7 == "Rifle Clip" then setPedWeaponSlot(localPlayer,6) end
	if d7 == "Axe" or d7 == "Nightstick" or d7 == "Knife" or d7 == "Crowbar" or d7 == "Sledgehammer" or d7 == "Raider Sword" or d7 == "Chainsaw" or d7 == "Baseball Bat" then setPedWeaponSlot(localPlayer,1) end
	if d7 == "Rocket Launcher" or d7 == "Stinger Launcher" or d7 == "Flamethrower" then setPedWeaponSlot(localPlayer,7) end
	if d7 == "Grenade" or d7 == "Molotov" or d7 == "Teargas" then setPedWeaponSlot(localPlayer,8) end
	if d7 == "Agent Pale" or d7 == "Spray Can" or d7 == "Binoculars" then setPedWeaponSlot(localPlayer,9) end
	if d7 == "Machete" or d7 == "Kitchen Knife" or d7 == "Meatcleaver" or d7 == "Nail Bat" or d7 == "Broken Bottle" then setPedWeaponSlot(localPlayer,10) end

elseif(source ==InventoryGui.button[8])then
createCursorTooltip(d8)
guiSetText(InventoryGui.label[1],d8)
guiSetText(InventoryGui.label[5],d8)
guiSetText(InventoryGui.label[6],getItemDescription(d8))
guiSetText(InventoryGui.label[2],getItemDescription(d8))--**
	if d8 == "M4" or d8 == "AK 47" or d8 == "Assault Ammo" then setPedWeaponSlot(localPlayer,5) end
	if d8 == "Pistol" or d8 == "Crossbow" or d8 == "Magnum Revolver" or d8 == "Pistol Ammo" or d8 == "Bolts" or d8 == "Magnum Ammo" then setPedWeaponSlot(localPlayer,2) end
	if d8 == "Uzi" or d8 == "Vehicle Minigun" or d8 == "MP5" or d8 == "SMG Ammo" then setPedWeaponSlot(localPlayer,4) end
	if d8 == "Pump Shotgun" or d8 == "Sawn-off Shotgun" or d8 == "Combat Shotgun" or d8 == "Shotgun Ammo" then setPedWeaponSlot(localPlayer,3) end
	if d8 == "Hunting Rifle" or d8 == "Sniper Rifle" or d8 == "Rifle Ammo" or d8 == "Rifle Clip" then setPedWeaponSlot(localPlayer,6) end
	if d8 == "Axe" or d8 == "Nightstick" or d8 == "Knife" or d8 == "Crowbar" or d8 == "Sledgehammer" or d8 == "Raider Sword" or d8 == "Chainsaw" or d8 == "Baseball Bat" then setPedWeaponSlot(localPlayer,1) end
	if d8 == "Rocket Launcher" or d8 == "Stinger Launcher" or d8 == "Flamethrower" then setPedWeaponSlot(localPlayer,7) end
	if d8 == "Grenade" or d8 == "Molotov" or d8 == "Teargas" then setPedWeaponSlot(localPlayer,8) end
	if d8 == "Agent Pale" or d8 == "Spray Can" or d8 == "Binoculars" then setPedWeaponSlot(localPlayer,9) end
	if d8 == "Machete" or d8 == "Kitchen Knife" or d8 == "Meatcleaver" or d8 == "Nail Bat" or d8 == "Broken Bottle" then setPedWeaponSlot(localPlayer,10) end

elseif(source ==InventoryGui.button[9])then
createCursorTooltip(d9)
guiSetText(InventoryGui.label[1],d9)
guiSetText(InventoryGui.label[5],d9)
guiSetText(InventoryGui.label[6],getItemDescription(d9))
guiSetText(InventoryGui.label[2],getItemDescription(d9))
	if d9 == "M4" or d9 == "AK 47" or d9 == "Assault Ammo" then setPedWeaponSlot(localPlayer,5) end
	if d9 == "Pistol" or d9 == "Crossbow" or d9 == "Magnum Revolver" or d9 == "Pistol Ammo" or d9 == "Bolts" or d9 == "Magnum Ammo" then setPedWeaponSlot(localPlayer,2) end
	if d9 == "Uzi" or d9 == "Vehicle Minigun" or d9 == "MP5" or d9 == "SMG Ammo" then setPedWeaponSlot(localPlayer,4) end
	if d9 == "Pump Shotgun" or d9 == "Sawn-off Shotgun" or d9 == "Combat Shotgun" or d9 == "Shotgun Ammo" then setPedWeaponSlot(localPlayer,3) end
	if d9 == "Hunting Rifle" or d9 == "Sniper Rifle" or d9 == "Rifle Ammo" or d9 == "Rifle Clip" then setPedWeaponSlot(localPlayer,6) end
	if d9 == "Axe" or d9 == "Nightstick" or d9 == "Knife" or d9 == "Crowbar" or d9 == "Sledgehammer" or d9 == "Raider Sword" or d9 == "Chainsaw" or d9 == "Baseball Bat" then setPedWeaponSlot(localPlayer,1) end
	if d9 == "Rocket Launcher" or d9 == "Stinger Launcher" or d9 == "Flamethrower" then setPedWeaponSlot(localPlayer,7) end
	if d9 == "Grenade" or d9 == "Molotov" or d9 == "Teargas" then setPedWeaponSlot(localPlayer,8) end
	if d9 == "Agent Pale" or d9 == "Spray Can" or d9 == "Binoculars" then setPedWeaponSlot(localPlayer,9) end
	if d9 == "Machete" or d9 == "Kitchen Knife" or d9 == "Meatcleaver" or d9 == "Nail Bat" or d9 == "Broken Bottle" then setPedWeaponSlot(localPlayer,10) end

end
end)

--itemsThatGetUsed = {"Pistol Ammo","Shotgun Ammo","Assault Ammo","SMG Ammo","Magnum Ammo","Bolts","Ammo Box","Rifle Ammo"}

function buttonsTrigers(botao,estado)
if estado == "up" then return end
if isTimer(busyTimer) then --[[outputTopBar("Please wait a second", 240,200,0); outputDebugString(getPlayerName(localPlayer).." clicks like crazy!")]] return end

if not(PlayersItens[localPlayer])then return end
local d1 = PlayersItens[localPlayer][1] 
local d2 = PlayersItens[localPlayer][2] 
local d3 = PlayersItens[localPlayer][3] 
local d4 = PlayersItens[localPlayer][4] 
local d5 = PlayersItens[localPlayer][5] 
local d6 = PlayersItens[localPlayer][6] 
local d7 = PlayersItens[localPlayer][7] 
local d8 = PlayersItens[localPlayer][8] 
local d9 = PlayersItens[localPlayer][9] 



if(source == InventoryGui.button[1]) then
	if(d1 and d1~="Empty")then
		if(botao == "left")then
			if getKeyState("lctrl") or getKeyState("rctrl") then
				triggerServerEvent("onPlayerInteractInventoryItem", localPlayer,d1,1)
				busyTimer = setTimer(function()end,1000,1)
				
			else
				--if playerHasFreeEquipmentSlots == true then -- TODO: BUG: this causes a bug, preventing players to use any item from inv. if they have 9 items equipped; needs a fix: i need to sort items into categories and determine here what rules apply for each
					triggerServerEvent("onPlayerUseItem", localPlayer,d1,1)
					busyTimer = setTimer(function()end,1000,1)
					
				--else 
					--triggerServerEvent("ServerBottomNotification",resourceRoot, "[ no free slot! ]")
					--return
				--end
			end
		elseif(botao == "right")then
		
			if NPC_trade_mode then sellItemToTrader(d1,1); busyTimer = setTimer(function()end,1000,1) return end
		
			if not isPlayerUsingContainer()  and  NPC_trade_mode==false then
				triggerServerEvent("onPlayerDropItem", localPlayer,d1,1)
				busyTimer = setTimer(function()end,1000,1)
			else
				triggerServerEvent("inventory.moveToContainer", resourceRoot, d1, 1, isPlayerUsingContainer())
															
				busyTimer = setTimer(function()end,1000,1)
   
			end
		elseif(botao == "middle")then
			triggerServerEvent("onPlayerInteractInventoryItem", localPlayer,d1,1)
			
			busyTimer = setTimer(function()end,1000,1)
		end
	end
	
elseif(source == InventoryGui.button[2]) then
	if(d2 and d2~="Empty")then
		if(botao == "left")then
			if getKeyState("lctrl") or getKeyState("rctrl") then
				triggerServerEvent("onPlayerInteractInventoryItem", localPlayer,d2,2)
				
				busyTimer = setTimer(function()end,1000,1)
			else
			if playerHasFreeEquipmentSlots == true then 
				triggerServerEvent("onPlayerUseItem", localPlayer,d2,2)
				
				busyTimer = setTimer(function()end,1000,1)
			else 
				triggerServerEvent("ServerBottomNotification",resourceRoot, "[ no free slot! ]")
				return
			end
			end
		elseif(botao == "right")then
			if NPC_trade_mode then sellItemToTrader(d2,2); busyTimer = setTimer(function()end,1000,1) return end
			
			if not isPlayerUsingContainer()  and not NPC_trade_mode then
				triggerServerEvent("onPlayerDropItem", localPlayer,d2,2)
				busyTimer = setTimer(function()end,1000,1)
			else
				triggerServerEvent("inventory.moveToContainer", resourceRoot, d2, 2, isPlayerUsingContainer())
				busyTimer = setTimer(function()end,1000,1)
			end
		elseif(botao == "middle")then
			triggerServerEvent("onPlayerInteractInventoryItem", localPlayer,d2,2)
			
			busyTimer = setTimer(function()end,1000,1)
		end
	end
	
elseif(source == InventoryGui.button[3]) then
	if(d3 and d3~="Empty")then
		if(botao == "left")then
			if getKeyState("lctrl") or getKeyState("rctrl") then
				triggerServerEvent("onPlayerInteractInventoryItem", localPlayer,d3,3)
				
				busyTimer = setTimer(function()end,1000,1)
			else
			if playerHasFreeEquipmentSlots == true then 
				triggerServerEvent("onPlayerUseItem", localPlayer,d3,3)
				
				busyTimer = setTimer(function()end,1000,1)
			else 
				triggerServerEvent("ServerBottomNotification",resourceRoot, "[ no free slot! ]")
				return
			end
			end
		elseif(botao == "right")then
			if NPC_trade_mode then sellItemToTrader(d3,3); busyTimer = setTimer(function()end,1000,1) return end
			if not isPlayerUsingContainer() and not NPC_trade_mode then
				triggerServerEvent("onPlayerDropItem", localPlayer,d3,3)
				busyTimer = setTimer(function()end,1000,1)
			else
				triggerServerEvent("inventory.moveToContainer", resourceRoot, d3, 3, isPlayerUsingContainer())
				busyTimer = setTimer(function()end,1000,1)
			end
		elseif(botao == "middle")then
			triggerServerEvent("onPlayerInteractInventoryItem", localPlayer,d3,3)
			
			busyTimer = setTimer(function()end,1000,1)
		end
	end
	
elseif(source == InventoryGui.button[4]) then
	if(d4 and d4~="Empty")then
	if(botao == "left")then
		if getKeyState("lctrl") or getKeyState("rctrl") then
				triggerServerEvent("onPlayerInteractInventoryItem", localPlayer,d4,4)
				
				busyTimer = setTimer(function()end,1000,1)
		else
		if playerHasFreeEquipmentSlots == true then 
			triggerServerEvent("onPlayerUseItem", localPlayer,d4,4)
			
			busyTimer = setTimer(function()end,1000,1)
		else 
			triggerServerEvent("ServerBottomNotification",resourceRoot, "[ no free slot! ]")
			return
		end
		end
	elseif(botao == "right")then
		if NPC_trade_mode then sellItemToTrader(d4,4); busyTimer = setTimer(function()end,1000,1) return end
		if not isPlayerUsingContainer() and not NPC_trade_mode then
			triggerServerEvent("onPlayerDropItem", localPlayer,d4,4)
			busyTimer = setTimer(function()end,1000,1)
		else
			triggerServerEvent("inventory.moveToContainer", resourceRoot, d4, 4, isPlayerUsingContainer())
			busyTimer = setTimer(function()end,1000,1)
		end
	elseif(botao == "middle")then
	triggerServerEvent("onPlayerInteractInventoryItem", localPlayer,d4,4)
	
	busyTimer = setTimer(function()end,1000,1)
	end
	end
	
elseif(source == InventoryGui.button[5]) then
	if(d5 and d5~="Empty")then
	if(botao == "left")then
		if getKeyState("lctrl") or getKeyState("rctrl") then
				triggerServerEvent("onPlayerInteractInventoryItem", localPlayer,d5,5)
				
				busyTimer = setTimer(function()end,1000,1)
		else
	
		if playerHasFreeEquipmentSlots == true then 
			triggerServerEvent("onPlayerUseItem", localPlayer,d5,5)
			
			busyTimer = setTimer(function()end,1000,1)
		else 
			triggerServerEvent("ServerBottomNotification",resourceRoot, "[ no free slot! ]")
			return
		end
		end
	elseif(botao == "right")then
		if NPC_trade_mode then sellItemToTrader(d5,5); busyTimer = setTimer(function()end,1000,1) return end
		if not isPlayerUsingContainer() and not NPC_trade_mode then
			triggerServerEvent("onPlayerDropItem", localPlayer,d5,5)
			busyTimer = setTimer(function()end,1000,1)
		else
			triggerServerEvent("inventory.moveToContainer", resourceRoot, d5, 5, isPlayerUsingContainer())
			busyTimer = setTimer(function()end,1000,1)
		end
	elseif(botao == "middle")then
	triggerServerEvent("onPlayerInteractInventoryItem", localPlayer,d5,5)
	
	busyTimer = setTimer(function()end,1000,1)
	end
	end
	
elseif(source == InventoryGui.button[6]) then
	if(d6 and d6~="Empty")then
	if(botao == "left")then
		if getKeyState("lctrl") or getKeyState("rctrl") then
				triggerServerEvent("onPlayerInteractInventoryItem", localPlayer,d6,6)
				
				busyTimer = setTimer(function()end,1000,1)
			else
	
		if playerHasFreeEquipmentSlots == true then 
			triggerServerEvent("onPlayerUseItem", localPlayer,d6,6)
			
			busyTimer = setTimer(function()end,1000,1)
		else 
			triggerServerEvent("ServerBottomNotification",resourceRoot, "[ no free slot! ]")
			return
		end
		end
	elseif(botao == "right")then
		if NPC_trade_mode then sellItemToTrader(d6,6); busyTimer = setTimer(function()end,1000,1) return end
		if not isPlayerUsingContainer() and not NPC_trade_mode then
			triggerServerEvent("onPlayerDropItem", localPlayer,d6,6)
			busyTimer = setTimer(function()end,1000,1)
		else
			triggerServerEvent("inventory.moveToContainer", resourceRoot, d6, 6, isPlayerUsingContainer())
			busyTimer = setTimer(function()end,1000,1)
		end
	elseif(botao == "middle")then
	triggerServerEvent("onPlayerInteractInventoryItem", localPlayer,d6,6)
	
	busyTimer = setTimer(function()end,1000,1)
	end
	end
	
elseif(source == InventoryGui.button[7]) then
	if(d7 and d7~="Empty")then
	if(botao == "left")then
			if getKeyState("lctrl") or getKeyState("rctrl") then
				triggerServerEvent("onPlayerInteractInventoryItem", localPlayer,d7,7)
				
				busyTimer = setTimer(function()end,1000,1)
			else
		if playerHasFreeEquipmentSlots == true then 
			triggerServerEvent("onPlayerUseItem", localPlayer,d7,7)
			
				busyTimer = setTimer(function()end,1000,1)

		else 
			triggerServerEvent("ServerBottomNotification",resourceRoot, "[ no free slot! ]")
			return
		end
		end
	elseif(botao == "right")then
		if NPC_trade_mode then sellItemToTrader(d7,7); busyTimer = setTimer(function()end,1000,1) return end
		if not isPlayerUsingContainer() and not NPC_trade_mode then
			triggerServerEvent("onPlayerDropItem", localPlayer,d7,7)
				busyTimer = setTimer(function()end,1000,1)
		else
			triggerServerEvent("inventory.moveToContainer", resourceRoot, d7, 7, isPlayerUsingContainer())
			busyTimer = setTimer(function()end,1000,1)
		end

	elseif(botao == "middle")then
	triggerServerEvent("onPlayerInteractInventoryItem", localPlayer,d7,7)
	
		busyTimer = setTimer(function()end,1000,1)

	end
	end
	
elseif(source == InventoryGui.button[8]) then
	if(d8 and d8~="Empty")then
	if(botao == "left")then
			if getKeyState("lctrl") or getKeyState("rctrl") then
				triggerServerEvent("onPlayerInteractInventoryItem", localPlayer,d8,8)
				
				busyTimer = setTimer(function()end,1000,1)
			else
		if playerHasFreeEquipmentSlots == true then 
			triggerServerEvent("onPlayerUseItem", localPlayer,d8,8)
			
				busyTimer = setTimer(function()end,1000,1)

		else 
			triggerServerEvent("ServerBottomNotification",resourceRoot, "[ no free slot! ]")
			return
		end
		end
	elseif(botao == "right")then
		if NPC_trade_mode then sellItemToTrader(d8,8); busyTimer = setTimer(function()end,1000,1) return end
		if not isPlayerUsingContainer() and not NPC_trade_mode then
		triggerServerEvent("onPlayerDropItem", localPlayer,d8,8)
		busyTimer = setTimer(function()end,1000,1)
		else
			triggerServerEvent("inventory.moveToContainer", resourceRoot, d8, 8, isPlayerUsingContainer())
			busyTimer = setTimer(function()end,1000,1)
		end

	elseif(botao == "middle")then
	triggerServerEvent("onPlayerInteractInventoryItem", localPlayer,d8,8)
	
		busyTimer = setTimer(function()end,1000,1)

	end
	end
	
elseif(source == InventoryGui.button[9]) then
	if(d9 and d9~="Empty")then
	if(botao == "left")then
		if getKeyState("lctrl") or getKeyState("rctrl") then
				triggerServerEvent("onPlayerInteractInventoryItem", localPlayer,d9,9)
				
				busyTimer = setTimer(function()end,1000,1)
		else
		if playerHasFreeEquipmentSlots == true then 
			triggerServerEvent("onPlayerUseItem", localPlayer,d9,9)
			
				busyTimer = setTimer(function()end,1000,1)

		else 
			triggerServerEvent("ServerBottomNotification",resourceRoot, "[ no free slot! ]")
			return
		end
		end
	elseif(botao == "right")then
			if NPC_trade_mode then sellItemToTrader(d9,9); busyTimer = setTimer(function()end,1000,1) return end
			if not isPlayerUsingContainer() and not NPC_trade_mode then

			triggerServerEvent("onPlayerDropItem", localPlayer,d9,9)
			busyTimer = setTimer(function()end,1000,1)
	else
			triggerServerEvent("inventory.moveToContainer", resourceRoot, d9, 9, isPlayerUsingContainer())
			busyTimer = setTimer(function()end,1000,1)
	end

	elseif(botao == "middle")then
			triggerServerEvent("onPlayerInteractInventoryItem", localPlayer,d9,9)
			
			busyTimer = setTimer(function()end,1000,1)

	end
	end

end

end
addEventHandler("onClientDgsDxMouseClick",root,buttonsTrigers)
-- left button click use item
-- rigth button click drop item
-- middle click move item to belt or backpack

addEventHandler("onClientResourceStart",root,
	function()
	setElementData(localPlayer,"pistolammo",1)
	setElementData(localPlayer,"taserammo",1)
	setElementData(localPlayer,"crossbowammo",1)
	setElementData(localPlayer,"smgammo",1)
	setElementData(localPlayer,"shotgunammo",1)
	setElementData(localPlayer,"assaultammo",1)
	setElementData(localPlayer,"rifleammo",1)
	triggerServerEvent("AddTableToClient", localPlayer,localPlayer)
	end)

------------NO AMMO SCRIPT------------- blocks 'fire' when you have only one bullet left, in order to preserve the weapon; HUD changes also done, to mask the single 'ghost' bullet, anyway it's still buggy, needs further testing
function noammo_fire () 
if getPedWeaponSlot(getLocalPlayer()) <= 1 or getPedWeaponSlot(getLocalPlayer()) >= 8 then
	enableFire ()
elseif getPedWeaponSlot(getLocalPlayer()) > 1 and getPedWeaponSlot(getLocalPlayer()) < 8 and  getPedTotalAmmo(getLocalPlayer()) > 1 then
	enableFire ()	
elseif getPedWeaponSlot(getLocalPlayer()) > 1 and getPedWeaponSlot(getLocalPlayer()) < 8 and  getPedTotalAmmo(getLocalPlayer()) < 2 then
	disableFire ()
end	
end
addEventHandler ( "onClientPlayerWeaponFire", getLocalPlayer(), noammo_fire )
function noammo_switch () 
if getPedWeaponSlot(getLocalPlayer()) <= 1 or getPedWeaponSlot(getLocalPlayer()) >= 10 or getPedWeaponSlot(getLocalPlayer()) == 8 then
	enableFire ()
elseif getPedWeapon(getLocalPlayer())== 43 then
	disableFire()
elseif getPedWeaponSlot(getLocalPlayer()) > 1 and getPedWeaponSlot(getLocalPlayer()) < 10 and  getPedTotalAmmo(getLocalPlayer()) > 1 then
	enableFire ()	
elseif getPedWeaponSlot(getLocalPlayer()) > 1 and getPedWeaponSlot(getLocalPlayer()) < 10 and getPedWeaponSlot(getLocalPlayer()) ~= 8  and getPedTotalAmmo(getLocalPlayer()) < 2 then
	disableFire ()
end	
end

addEventHandler ( "onClientPlayerWeaponSwitch", getLocalPlayer(), noammo_switch )
function enableFire ()
toggleControl( "fire", true )
end

function checkweapattachmentmessages ()
if getPedWeapon(localPlayer) == 23 and getElementData(localPlayer,"zipline")== true then 
	outputStatusInfo("Zip Line", 255,255,255)
end
if getPedWeapon(localPlayer) == 30 or getPedWeapon(localPlayer) == 31 then 
	if getElementData(localPlayer,"stomperequipped") == true and getElementData(localPlayer,"stomperammo") >= 1 then 
	outputTopBar("HINT: Aim and press [E] to fire the Stomper", 255,200,0)
	end
end
end
addEventHandler ( "onClientPlayerWeaponSwitch", getLocalPlayer(), checkweapattachmentmessages )

function disableFire ()
toggleControl( "fire", false )
	if getPedWeapon(localPlayer) ~= 43 then -- exclude binoculars; other non ammo weapons are already excluded
	outputStatusInfo("No ammo", 255,255,255)
	end
	
end
------------------------

addEventHandler( "onClientKey", root, function(button,press)   ----------- KEY FOR EQUIPPED WEAPON DROP
if not gChatting then 
      
	   if button == "delete" and press == true then
	  
	  if getElementData(localPlayer, "sleeping")== true or getElementData(localPlayer,"incapacitated")== true then return end
	  
			if getPedWeapon(localPlayer) == 0 then
				setPedAnimation( localPlayer, "PLAYIDLES", "stretch",500, false, false, true, false)
				
			--elseif getPedWeapon(localPlayer) ~= 0 then
				--triggerServerEvent ( "weaponRetrieve", root, localPlayer, getPedWeapon(localPlayer), getPedTotalAmmo(localPlayer) )
				--setPedWeaponSlot(localPlayer,0)
			end
		end
end
		end)
--------------------------------------

function hasPlayerItem_c (item, p) --returns number of inquired items and last used slot, input is a string: "item name"
local itemcount = 0
local slot = nil
local d1 = PlayersItens[p][1] or false
local d2 = PlayersItens[p][2] or false
local d3 = PlayersItens[p][3] or false
local d4 = PlayersItens[p][4] or false
local d5 = PlayersItens[p][5] or false
local d6 = PlayersItens[p][6] or false
local d7 = PlayersItens[p][7] or false
local d8 = PlayersItens[p][8] or false
local d9 = PlayersItens[p][9] or false

if d1 == item then itemcount = itemcount + 1; slot = 1 end
if d2 == item then itemcount = itemcount + 1; slot = 2 end
if d3 == item then itemcount = itemcount + 1; slot = 3  end
if d4 == item then itemcount = itemcount + 1; slot = 4  end
if d5 == item then itemcount = itemcount + 1; slot = 5  end
if d6 == item then itemcount = itemcount + 1; slot = 6  end
if d7 == item then itemcount = itemcount + 1; slot = 7  end
if d8 == item then itemcount = itemcount + 1; slot = 8  end
if d9 == item then itemcount = itemcount + 1; slot = 9  end

if itemcount > 0 then  return itemcount, slot end -- and
					  
if itemcount == 0  then return false end 

end

function hasPlayerItem_c_slots (item, p) --returns table of inquired items used slots, input is a string: "item name"
--local itemcount = 0
local slots = {}
--local slot = nil
local d1 = PlayersItens[p][1] or false
local d2 = PlayersItens[p][2] or false
local d3 = PlayersItens[p][3] or false
local d4 = PlayersItens[p][4] or false
local d5 = PlayersItens[p][5] or false
local d6 = PlayersItens[p][6] or false
local d7 = PlayersItens[p][7] or false
local d8 = PlayersItens[p][8] or false
local d9 = PlayersItens[p][9] or false

if d1 == item then  table.insert(slots,1,true) end
if d2 == item then  table.insert(slots,2,true) end
if d3 == item then  table.insert(slots,3,true)  end
if d4 == item then  table.insert(slots,4,true)  end
if d5 == item then  table.insert(slots,5,true)  end
if d6 == item then  table.insert(slots,6,true)  end
if d7 == item then  table.insert(slots,7,true)  end
if d8 == item then  table.insert(slots,8,true)  end
if d9 == item then  table.insert(slots,9,true)  end

	if slots ~= {} then  
		return slots 
	else 
		return	false 
	end 

end

function equippedWeight () --retrievs the equipped items weight --clientside variation (there's an identical one on the server)

local weight = 0
local slot1 =  getPedWeapon (localPlayer,1)
local slot2 =  getPedWeapon (localPlayer,2)
local slot3 =  getPedWeapon (localPlayer,3)
local slot4 =  getPedWeapon (localPlayer,4)
local slot5 =  getPedWeapon (localPlayer,5)
local slot6 =  getPedWeapon (localPlayer,6)
local slot7 =  getPedWeapon (localPlayer,7) 
local slot8 =  getPedWeapon (localPlayer,8) 
local slot9 =  getPedWeapon (localPlayer,9) 
local slot10 =  getPedWeapon (localPlayer,10)
local slot11 =  getPedWeapon (localPlayer,11)

if slot1 == 0 then weight = weight 
elseif slot1 == 4 then weight = weight+0.5
elseif slot1 == 7 then weight = weight+3
elseif slot1 == 9 then weight = weight+4
else weight = weight+2
end  

if slot2 == 0 then weight = weight 
elseif slot2 == 23 then weight = weight+3
else weight = weight+2
end

if slot3 == 0 then weight = weight 
elseif slot3 == 26 then weight = weight+2
else weight = weight+3
end

if slot4 == 0 then weight = weight 
elseif slot4 == 29 then weight = weight+3
else weight = weight+2
end

if slot5 == 0 then weight = weight 
else weight = weight+3
end

if slot6 == 0 then weight = weight 
else weight = weight+3
end

if slot7 == 0 then weight = weight 
else weight = weight+4
end

if slot8 == 0 then weight = weight 
elseif slot8 == 16 or slot8 == 17 or slot8 == 18 then weight = weight+getPedTotalAmmo(localPlayer,8)*0.5
elseif slot8 == 39 then weight = weight+getPedTotalAmmo(localPlayer,8)
end

if slot9 == 42 then weight = weight+2
end

if slot10 == 0 then weight = weight 
elseif slot10 == 11 then weight = weight+0.5
elseif slot10 == 12 then weight = weight+1
elseif slot10 == 14 then weight = weight+0.5
else weight = weight+2
end

--[[if slot11 == 0 then weight = weight  -- disabled, googles have no weight
elseif slot11 == 44 then weight = weight+0.5
elseif slot11 == 45 then weight = weight+0.5
else weight = weight --this is the 'parachute' case, 0 weight for now
end

if getElementData(localPlayer,"headlampequipped") == true then 
weight = weight+0.5
end
]]

if getElementData(localPlayer,"medikitequipped") == true then 
weight = weight+0.5
end

if getElementData(localPlayer,"toolboxequipped") == true then 
weight = weight+0.5
end

return weight

end
addCommandHandler("weightclient", equippedWeight )

--[[addEventHandler( "onClientKey", root, function(button,press)   ----------- change weapons while inventory is open
        if isCursorShowing() == true and button == "mouse_wheel_up" and press == true then
			prevWeapon()
			
		elseif isCursorShowing() == true and button == "mouse_wheel_down" and press == true then
			nextWeapon()
		end
end)]]

function nextWeapon() -- find next populated weapon slot
    local wep = nil
    local slot = getPedWeaponSlot(localPlayer)
    local slotHasWep = false
   
    -- Keep looking forwards for a slot that contains a weapon.
    while (slotHasWep == false) do
        -- Keep 'slot' in the range of 0-12 and increment it.
        if (slot == 12) then
            slot = 0
        else
            slot = slot + 1
        end
       
        if (slot == 0) then
            -- Allow the player to select fists.
            slotHasWep = true
            break
        else
            -- Check if there is a weapon and if it has any ammo.
            wep = getPedWeapon(localPlayer, slot)
            slotHasWep = ((wep ~= 0) and (getPedTotalAmmo(localPlayer, slot) ~= 0))
            if (slotHasWep) then break end
        end
    end
   
    setPedWeaponSlot(localPlayer, slot)

end

function prevWeapon() -- find previous populated weapon slot
    local wep = nil
    local slot = getPedWeaponSlot(localPlayer)
    local slotHasWep = false
   
    -- Keep looking backwards for a slot that contains a weapon.
    while (slotHasWep == false) do
        -- Keep 'slot' in the range of 0-12 and decrement it.
        if (slot == 0) then
            slot = 12
        else
            slot = slot - 1
        end
       
        if (slot == 0) then
            -- Allow the player to select fists.
            slotHasWep = true
            break
        else
            -- Check if there is a weapon and if it has any ammo.
            wep = getPedWeapon(localPlayer, slot)
            slotHasWep = ((wep ~= 0) and (getPedTotalAmmo(localPlayer, slot) ~= 0))
            if (slotHasWep) then break end
        end
    end
   
    setPedWeaponSlot(localPlayer, slot)
end



-------------AMMO MANAGER-----------------------------------------------
function capturePlayerAmmo ()

local old_pistolammo = getElementData(localPlayer,"pistolammo") or 1
local old_taserammo = getElementData(localPlayer,"taserammo") or 1
local old_crossbowammo = getElementData(localPlayer,"crossbowammo") or 1
local old_smgammo = getElementData(localPlayer,"smgammo") or 1
local old_shotgunammo = getElementData(localPlayer,"shotgunammo") or 1
local old_assaultammo = getElementData(localPlayer,"assaultammo") or 1
local old_rifleammo = getElementData(localPlayer,"rifleammo") or 1
local old_stomperammo = getElementData(localPlayer,"stomperammo") or 1
local old_projectileammo = getElementData(localPlayer,"projectile") or 0

if getPedWeapon(localPlayer,2) == 0 then end

if getPedWeapon(localPlayer,2) == 22 then 
	if getPedTotalAmmo(localPlayer,2) ~= old_pistolammo then
		setElementData(localPlayer,"pistolammo", getPedTotalAmmo(localPlayer, 2)) 
	end
end

if getPedWeapon(localPlayer,2) == 23 then 
	if getPedTotalAmmo(localPlayer,2) ~= old_crossbowammo then
		setElementData(localPlayer,"crossbowammo", getPedTotalAmmo(localPlayer, 2)) 
	end
end

if getPedWeapon(localPlayer,2) == 24 then 
	if getPedTotalAmmo(localPlayer,2) ~= old_taserammo then
		setElementData(localPlayer,"taserammo", getPedTotalAmmo(localPlayer, 2)) 
	end
end

if getPedWeapon(localPlayer,3) == 0 then end

if (getPedWeapon(localPlayer,3) ~= 0) then 
	if getPedTotalAmmo(localPlayer,3) ~= old_shotgunammo then
		setElementData(localPlayer,"shotgunammo", getPedTotalAmmo(localPlayer, 3)) 
	end
end

if getPedWeapon(localPlayer,4) == 0 then 
end

if (getPedWeapon(localPlayer,4) ~= 0) then 
if getPedTotalAmmo(localPlayer,4) ~= old_smgammo then
setElementData(localPlayer,"smgammo", getPedTotalAmmo(localPlayer, 4)) 
end
end

if getPedWeapon(localPlayer,5) == 0 then 
end

if (getPedWeapon(localPlayer,5) ~= 0) then 
if getPedTotalAmmo(localPlayer,5) ~= old_assaultammo then
setElementData(localPlayer,"assaultammo", getPedTotalAmmo(localPlayer, 5)) 
end
end

if getPedWeapon(localPlayer,6) == 0 then 
end

if (getPedWeapon(localPlayer,6) ~= 0) then 
if getPedTotalAmmo(localPlayer,6) ~= old_rifleammo then
setElementData(localPlayer,"rifleammo", getPedTotalAmmo(localPlayer, 6)) 
end
end

if getPedWeapon(localPlayer,8) == 0 then 
end

if (getPedWeapon(localPlayer,8) ~= 0) then 
if getPedTotalAmmo(localPlayer,8) ~= old_projectileammo then
setElementData(localPlayer,"projectile", getPedTotalAmmo(localPlayer, 8)) 
end
end

--[[local beltpistolslot = returnPlayerBeltItemSlot("Pistol Ammo", localPlayer)
local beltboltsslot = returnPlayerBeltItemSlot("Bolts", localPlayer)
local beltslugsslot = returnPlayerBeltItemSlot("Shotgun Ammo", localPlayer)
local beltassaultslot = returnPlayerBeltItemSlot("Assault Ammo", localPlayer)
local beltsmgslot = returnPlayerBeltItemSlot("SMG Ammo", localPlayer)
local beltrifleslot = returnPlayerBeltItemSlot("Rifle Ammo", localPlayer)
local belttaserslot = returnPlayerBeltItemSlot("Magnum Ammo", localPlayer)
local beltstomperslot = returnPlayerBeltItemSlot("Stomper Ammo", localPlayer)
local stomperammo = getElementData(localPlayer,"stomperammo") or 0

local changed = nil
if getElementData(localPlayer,"pistolammo") < 11 and beltpistolslot ~= nil then PlayersBeltItens[localPlayer][beltpistolslot] = "Empty"; changed = 1 end
if getElementData(localPlayer,"crossbowammo") < 6 and beltboltsslot ~= nil then PlayersBeltItens[localPlayer][beltboltsslot] = "Empty"; changed = 1 end
if getElementData(localPlayer,"taserammo") < 7 and belttaserslot ~= nil then PlayersBeltItens[localPlayer][belttaserslot] = "Empty"; changed = 1 end
if getElementData(localPlayer,"shotgunammo") < 9 and beltslugsslot ~= nil then PlayersBeltItens[localPlayer][beltslugsslot] = "Empty"; changed = 1 end
if getElementData(localPlayer,"smgammo") < 31 and beltsmgslot ~= nil then PlayersBeltItens[localPlayer][beltsmgslot] = "Empty"; changed = 1 end
if getElementData(localPlayer,"assaultammo") < 31 and beltassaultslot ~= nil then PlayersBeltItens[localPlayer][beltassaultslot] = "Empty"; changed = 1 end
if getElementData(localPlayer,"rifleammo") < 6 and beltrifleslot ~= nil then PlayersBeltItens[localPlayer][beltrifleslot] = "Empty"; changed = 1 end
if stomperammo < 5 and beltstomperslot ~= nil then PlayersBeltItens[localPlayer][beltstomperslot] = "Empty"; changed = 1 end

if changed ~= nil then triggerEvent("SynchronizeAll",localPlayer); changed = nil end]]

end
setTimer(capturePlayerAmmo, 500, 0)

function outputAmmo () --temporary test function
local pistolammo = getElementData(localPlayer,"pistolammo") or 1
local taserammo = getElementData(localPlayer,"taserammo") or 1
local crossbowammo = getElementData(localPlayer,"crossbowammo") or 1
local smgammo = getElementData(localPlayer,"smgammo") or 1
local shotgunammo = getElementData(localPlayer,"shotgunammo") or 1
local assaultammo = getElementData(localPlayer,"assaultammo") or 1
local rifleammo = getElementData(localPlayer,"rifleammo") or 1

local ammo = {pistolammo,taserammo,crossbowammo,smgammo,shotgunammo,assaultammo,rifleammo}
	
	for _,ammotype in pairs(ammo) do
		if ammotype <= 0 then setElementData(localPlayer,tostring(ammotype), 1) end
	end
	
	outputChatBox("Pistol: "..(pistolammo)..", Magnum: "..taserammo..", Bolts: "..crossbowammo..", SMG: "..smgammo..", Slugs: "..shotgunammo..", Assault: "..assaultammo..", Rifle: "..rifleammo)
end

function resetAllOnWasted () -- clears the inventory/belt items, the ammo stash and the 'infected' status
	if source == localPlayer then 
	setElementData(localPlayer,"pistolammo", 1)
	setElementData(localPlayer,"crossbowammo", 1)
	setElementData(localPlayer,"taserammo", 1)
	setElementData(localPlayer,"shotgunammo", 1)
	setElementData(localPlayer,"smgammo", 1)
	setElementData(localPlayer,"assaultammo", 1)
	setElementData(localPlayer,"rifleammo", 1)
	setElementData(localPlayer,"stomperammo", 0)
	PlayersItens[localPlayer]={"Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty"}
	PlayersBeltItens[localPlayer]={"Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty"}
	triggerEvent("RefreshDraw",localPlayer)
	triggerEvent("synchronizeTables",localPlayer,PlayersItens)
	triggerEvent("synchronizeBelt",localPlayer,PlayersBeltItens)
	triggerEvent("ClearInfection",localPlayer) -- event is in the zombie resource, perhaps this needs a check to see if zombies is running, otherwise it will spit an error
	setElementData(localPlayer,"minorfracture",false,true)
	setElementData(localPlayer,"majorfracture",false,true)
	setElementData(localPlayer,"currentmap", false)
	setElementData(localPlayer,"carriedObject", false,true)
	setElementData(localPlayer,"projectile", 0,true)
	setElementData(localPlayer,"watch",false)
	setElementData(localPlayer,"backpackequipped", false,true)
	setElementData(localPlayer,"toolboxequipped", false,true)
	setElementData(localPlayer,"medikitequipped", false,true)
	setElementData(localPlayer,"headlampequipped", false,true)
	setElementData(localPlayer,"scannerequipped", false,true)
	setElementData(localPlayer,"stomperequipped", false,true)
	setElementData(localPlayer,"glasstraps", 0,true)
	setElementData(localPlayer,"incendiarytraps", 0,true)
	setElementData(localPlayer,"explosivetraps", 0,true)
	setElementData(localPlayer,"timedbombs", 0,true)
	setPedWalkingStyle(localPlayer,0)
	setElementData(localPlayer,"drunk",false)
	triggerEvent( "switchDoF", root, false )
	for _,painEffect in pairs(painTimers) do if isTimer(painEffect) then killTimer(painEffect) end end
	end
	if 	isTimer(adrenalineTimer) then 
		killTimer(adrenalineTimer)
		killTimer(adrenalinelevelTimer)
	end	
	triggerEvent("CloseScanner",localPlayer)
end
addEventHandler("onClientPlayerWasted", localPlayer, resetAllOnWasted)

addEvent("takeAllPlayerGear_client",true)
function takePlayerGear_clientfunc () -- takes the inventory/belt items and the ammo stash
	setElementData(localPlayer,"pistolammo", 1)
	setElementData(localPlayer,"crossbowammo", 1)
	setElementData(localPlayer,"taserammo", 1)
	setElementData(localPlayer,"shotgunammo", 1)
	setElementData(localPlayer,"smgammo", 1)
	setElementData(localPlayer,"assaultammo", 1)
	setElementData(localPlayer,"rifleammo", 1)
	setElementData(localPlayer,"stomperammo", 0)
	PlayersItens[localPlayer]={"Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty"}
	PlayersBeltItens[localPlayer]={"Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty"}
	triggerEvent("RefreshDraw",localPlayer)
	triggerEvent("synchronizeTables",localPlayer,PlayersItens)
	triggerEvent("synchronizeBelt",localPlayer,PlayersBeltItens)
	setElementData(localPlayer,"currentmap", false)
	setElementData(localPlayer,"carriedObject", false,true)
	setElementData(localPlayer,"projectile", 0,true)
	setElementData(localPlayer,"watch",false)
	setElementData(localPlayer,"backpackequipped", false,true)
	setElementData(localPlayer,"toolboxequipped", false,true)
	setElementData(localPlayer,"medikitequipped", false,true)
	setElementData(localPlayer,"headlampequipped", false,true)
	setElementData(localPlayer,"scannerequipped", false,true)
	setElementData(localPlayer,"stomperequipped", false,true)
	setElementData(localPlayer,"glasstraps", 0,true)
	setElementData(localPlayer,"incendiarytraps", 0,true)
	setElementData(localPlayer,"explosivetraps", 0,true)
	setElementData(localPlayer,"timedbombs", 0,true)
	triggerEvent( "switchDoF", root, false )
	triggerEvent("CloseScanner",localPlayer)
end
addEventHandler("takeAllPlayerGear_client", root, takePlayerGear_clientfunc)



---------------------BELT interface & co.--------------------------------

BeltGui = {
    button = {},
    label = {}
}

        BeltGui.button[1] = DGS:dgsDxCreateButton(20, 23, 61, 61, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(BeltGui.button[1], 0.87)
		BeltGui.button[2] = DGS:dgsDxCreateButton(86, 23, 61, 61, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(BeltGui.button[2], 0.87)
        BeltGui.button[3] = DGS:dgsDxCreateButton(152, 23, 61, 61, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(BeltGui.button[3], 0.87)
        BeltGui.button[4] = DGS:dgsDxCreateButton(218, 23, 61, 61, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(BeltGui.button[4], 0.87)
        BeltGui.button[5] = DGS:dgsDxCreateButton(284, 23, 61, 61, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(BeltGui.button[5], 0.87)
        BeltGui.button[6] = DGS:dgsDxCreateButton(350, 23, 61, 61, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(BeltGui.button[6], 0.87)
        BeltGui.button[7] = DGS:dgsDxCreateButton(416, 23, 61, 61, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(BeltGui.button[7], 0.87)
        BeltGui.button[8] = DGS:dgsDxCreateButton(482, 23, 61, 61, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(BeltGui.button[8], 0.87)
        BeltGui.button[9] = DGS:dgsDxCreateButton(548, 23, 61, 61, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(BeltGui.button[9], 0.87)
        BeltGui.label = DGS:dgsDxCreateLabel(22, 87, 267, 32, "", false) 
		BeltGui.labelshadow = DGS:dgsDxCreateLabel(21, 86, 267, 32, "", false)
		DGS:dgsDxGUISetFont(BeltGui.label, ChunkfiveFontDXSmall)
        DGS:dgsDxGUISetFont(BeltGui.labelshadow, ChunkfiveFontDXSmall)
		BeltGui.labelTitle = DGS:dgsDxCreateLabel(530, 92, 267, 32, "Utility", false) 
		BeltGui.labelTitle_shadow = DGS:dgsDxCreateLabel(529, 91, 267, 32, "Utility", false)
        DGS:dgsDxGUISetFont(BeltGui.labelTitle, "pricedown")
		DGS:dgsDxGUISetAlpha(BeltGui.labelTitle, 0.87)
		DGS:dgsDxGUISetAlpha(BeltGui.labelTitle_shadow, 0.87)
		DGS:dgsDxGUISetFont(BeltGui.labelTitle_shadow, "pricedown")
		DGS:dgsDxLabelSetColor(BeltGui.labelTitle_shadow,0,0,0)
		DGS:dgsDxLabelSetColor(BeltGui.labelshadow,0,0,0)
        
DGS:dgsDxGUISetVisible(BeltGui.label,false)
DGS:dgsDxGUISetVisible(BeltGui.labelshadow,false)
DGS:dgsDxGUISetVisible(BeltGui.labelTitle,false) 
DGS:dgsDxGUISetVisible(BeltGui.labelTitle_shadow,false) 
DGS:dgsDxGUISetVisible(BeltGui.button[1],false)
DGS:dgsDxGUISetVisible(BeltGui.button[2],false)
DGS:dgsDxGUISetVisible(BeltGui.button[3],false)
DGS:dgsDxGUISetVisible(BeltGui.button[4],false)
DGS:dgsDxGUISetVisible(BeltGui.button[5],false)
DGS:dgsDxGUISetVisible(BeltGui.button[6],false)
DGS:dgsDxGUISetVisible(BeltGui.button[7],false)
DGS:dgsDxGUISetVisible(BeltGui.button[8],false)
DGS:dgsDxGUISetVisible(BeltGui.button[9],false)

PlayersBeltItens={}

addEvent("synchronizeBelt",true)
function tablesynchronize(table_)
PlayersBeltItens = table_
end
addEventHandler("synchronizeBelt",root,tablesynchronize)

function getInfoForBeltAmmo (item)

local ammotext

local pistolammo = getElementData(localPlayer,"pistolammo") or 1 --THIS STUFF NEEDS TO GO GLOBAL, I USE IT TOO MANY TIMES ALREADY!!!
local taserammo = getElementData(localPlayer,"taserammo") or 1
local crossbowammo = getElementData(localPlayer,"crossbowammo") or 1
local smgammo = getElementData(localPlayer,"smgammo") or 1
local shotgunammo = getElementData(localPlayer,"shotgunammo") or 1
local assaultammo = getElementData(localPlayer,"assaultammo") or 1
local rifleammo = getElementData(localPlayer,"rifleammo") or 1
local stomperammo = getElementData(localPlayer,"stomperammo") or 0

	if item == "Pistol Ammo" then ammotext = (pistolammo-1).." bullets"; 
			elseif item == "Magnum Ammo" then ammotext = (taserammo-1).." bullets"
			elseif item == "Bolts" then ammotext = (crossbowammo-1).." bolts"
			elseif item == "SMG Ammo" then ammotext = (smgammo-1).." bullets"
			elseif item == "Shotgun Ammo" then ammotext = (shotgunammo-1).." slugs"
			elseif item == "Assault Ammo" then ammotext = (assaultammo-1).." bullets"
			elseif item == "Rifle Ammo" then ammotext = (rifleammo-1).." bullets"
			elseif item == "Stomper Ammo" then ammotext = stomperammo.." grenades"
			
	else 
	return false
	end
	
	return ammotext
end

function drawBelt()

if not(PlayersBeltItens[localPlayer])then return end

local b1 = PlayersBeltItens[localPlayer][1] 
local b2 = PlayersBeltItens[localPlayer][2] 
local b3 = PlayersBeltItens[localPlayer][3] 
local b4 = PlayersBeltItens[localPlayer][4] 
local b5 = PlayersBeltItens[localPlayer][5] 
local b6 = PlayersBeltItens[localPlayer][6] 
local b7 = PlayersBeltItens[localPlayer][7] 
local b8 = PlayersBeltItens[localPlayer][8] 
local b9 = PlayersBeltItens[localPlayer][9] 

if(b1 and b1~="Empty")then
dxDrawImage(23, 30, 51, 41, "icons/"..b1..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
end
if(b2 and b2~="Empty")then
dxDrawImage(89, 30, 51, 41, "icons/"..b2..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
end
if(b3 and b3~="Empty")then
dxDrawImage(155, 30, 51, 41, "icons/"..b3..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
end
if(b4 and b4~="Empty")then
dxDrawImage(221, 30, 51, 41, "icons/"..b4..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
end
if(b5 and b5~="Empty")then
dxDrawImage(287, 30, 51, 41, "icons/"..b5..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
end
if(b6 and b6~="Empty") then
dxDrawImage(353, 30, 51, 41, "icons/"..b6..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
end
if(b7 and b7~="Empty")then
dxDrawImage(419, 30, 51, 41, "icons/"..b7..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
end
if(b8 and b8~="Empty")then
dxDrawImage(485, 30, 51, 41, "icons/"..b8..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
end
if(b9 and b9~="Empty")then
dxDrawImage(551, 30, 51, 41, "icons/"..b9..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
end

end

-----------Equipped Items
EquippedGui = {
    button = {},
    label = {}
}

        EquippedGui.button[1] = DGS:dgsDxCreateButton(20, 650-150, 61, 61, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(EquippedGui.button[1], 0.87)
		EquippedGui.button[2] = DGS:dgsDxCreateButton(86, 650-150, 61, 61, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(EquippedGui.button[2], 0.87)
        EquippedGui.button[3] = DGS:dgsDxCreateButton(152, 650-150, 61, 61, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(EquippedGui.button[3], 0.87)
        EquippedGui.button[4] = DGS:dgsDxCreateButton(218, 650-150, 61, 61, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(EquippedGui.button[4], 0.87)
        EquippedGui.button[5] = DGS:dgsDxCreateButton(284, 650-150, 61, 61, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(EquippedGui.button[5], 0.87)
        EquippedGui.button[6] = DGS:dgsDxCreateButton(350, 650-150, 61, 61, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(EquippedGui.button[6], 0.87)
        EquippedGui.button[7] = DGS:dgsDxCreateButton(416, 650-150, 61, 61, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(EquippedGui.button[7], 0.87)
        EquippedGui.button[8] = DGS:dgsDxCreateButton(482, 650-150, 61, 61, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(EquippedGui.button[8], 0.87)
        EquippedGui.button[9] = DGS:dgsDxCreateButton(548, 650-150, 61, 61, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(EquippedGui.button[9], 0.87)

        EquippedGui.label = DGS:dgsDxCreateLabel(22, 623-153, 267, 32, "EquipmEnt", false) 
        DGS:dgsDxGUISetFont(EquippedGui.label, "pricedown")
		DGS:dgsDxGUISetAlpha(EquippedGui.label, 0.87)
		EquippedGui.label_shadow = DGS:dgsDxCreateLabel(21, 622-153, 267, 32, "EquipmEnt", false) 
        DGS:dgsDxGUISetFont(EquippedGui.label_shadow, "pricedown")
		DGS:dgsDxGUISetAlpha(EquippedGui.label_shadow, 0.87)
		DGS:dgsDxLabelSetColor(EquippedGui.label_shadow, 0,0,0)
		
		EquippedGui.label_button = guiCreateButton(22, 623-153, 120, 30, " ", false)
		guiSetAlpha(EquippedGui.label_button, 0)
		guiMoveToBack (EquippedGui.label_button)
		
		EquippedGui.ammo_button = guiCreateButton(22+138, 623-153, 80, 30, " ", false)
		guiSetAlpha(EquippedGui.ammo_button, 0)
		guiMoveToBack (EquippedGui.ammo_button)
		
		EquippedGui.ammo_label = DGS:dgsDxCreateLabel(22+138, 623-153, 267, 32, "ammo", false) 
        DGS:dgsDxGUISetFont(EquippedGui.ammo_label, "pricedown")
		DGS:dgsDxGUISetAlpha(EquippedGui.ammo_label, 0.87)
		DGS:dgsDxLabelSetColor(EquippedGui.ammo_label, 150,150,150)
		
		EquippedGui.ammo_label_shadow = DGS:dgsDxCreateLabel(21+138, 622-150, 267, 32, "ammo", false) 
        DGS:dgsDxGUISetFont(EquippedGui.ammo_label_shadow, "pricedown")
		DGS:dgsDxGUISetAlpha(EquippedGui.ammo_label_shadow, 0.87)
		DGS:dgsDxLabelSetColor(EquippedGui.ammo_label_shadow, 0,0,0)
		
		EquippedGui.equip_separator_label = DGS:dgsDxCreateLabel(22+125, 623-153, 267, 32, "|", false) 
		EquippedGui.equip_separator_label_shadow = DGS:dgsDxCreateLabel(21+125, 622-153, 267, 32, "|", false)
		DGS:dgsDxGUISetFont(EquippedGui.equip_separator_label, "pricedown")
		DGS:dgsDxGUISetFont(EquippedGui.equip_separator_label_shadow, "pricedown")
		DGS:dgsDxLabelSetColor(EquippedGui.equip_separator_label_shadow, 0,0,0)
		
		EquippedGui.label_eq = DGS:dgsDxCreateLabel(22, 715-150, 200, 200, "M1: Use\nM2: Unequip", false)
        DGS:dgsDxGUISetFont(EquippedGui.label_eq, "default-bold-small")
		DGS:dgsDxGUISetAlpha(EquippedGui.label_eq, 0.87)
        
DGS:dgsDxGUISetVisible(EquippedGui.label,false)
DGS:dgsDxGUISetVisible(EquippedGui.ammo_label,false)
DGS:dgsDxGUISetVisible(EquippedGui.equip_separator_label_shadow,false)
DGS:dgsDxGUISetVisible(EquippedGui.equip_separator_label,false)
DGS:dgsDxGUISetVisible(EquippedGui.label_eq,false) 
DGS:dgsDxGUISetVisible(EquippedGui.label_shadow,false) 
DGS:dgsDxGUISetVisible(EquippedGui.ammo_label_shadow,false) 
DGS:dgsDxGUISetVisible(EquippedGui.button[1],false)
DGS:dgsDxGUISetVisible(EquippedGui.button[2],false)
DGS:dgsDxGUISetVisible(EquippedGui.button[3],false)
DGS:dgsDxGUISetVisible(EquippedGui.button[4],false)
DGS:dgsDxGUISetVisible(EquippedGui.button[5],false)
DGS:dgsDxGUISetVisible(EquippedGui.button[6],false)
DGS:dgsDxGUISetVisible(EquippedGui.button[7],false)
DGS:dgsDxGUISetVisible(EquippedGui.button[8],false)
DGS:dgsDxGUISetVisible(EquippedGui.button[9],false)

equipment_menu_mode = "equipment" --can be "equipment" or "ammo"

function clickEquipment (butt,state)
--if equipment_menu_mode == nil then equipment_menu_mode = "equipment" end
	if equipment_menu_mode == "equipment" then 
		return
	else
		equipment_menu_mode = "equipment"
		DGS:dgsDxLabelSetColor(EquippedGui.label, 255,255,255)
		DGS:dgsDxLabelSetColor(EquippedGui.ammo_label, 150,150,150)

		iprint("equipment mode")
	end 
end

function clickAmmo (butt,state)
--if equipment_menu_mode == nil then equipment_menu_mode = "ammo" end
	if equipment_menu_mode == "ammo" then 
		return
	else
		equipment_menu_mode = "ammo"
		DGS:dgsDxLabelSetColor(EquippedGui.label, 150,150,150)
		DGS:dgsDxLabelSetColor(EquippedGui.ammo_label, 255,255,255)
		iprint("ammo mode")
	end 
end

addEventHandler("onClientGUIClick",EquippedGui.label_button,clickEquipment)
addEventHandler("onClientGUIClick",EquippedGui.ammo_button,clickAmmo)



addEvent("UnequipHeadlamp",true)
addEvent("UnequipMedikit",true)
addEvent("UnequipToolbox",true)
addEvent("UnequipBackpack",true)

function unequipHeadlamp()
setElementData(localPlayer,"headlampequipped",false,true)
end

function unequipMedikit()
setElementData(localPlayer,"medikitequipped",false,true)
end

function unequipToolbox()
setElementData(localPlayer,"toolboxequipped",false,true)
end

function unequipBackpack()
setElementData(localPlayer,"backpackequipped",false,true)
end

addEventHandler("UnequipHeadlamp",root,unequipHeadlamp)
addEventHandler("UnequipMedikit",root,unequipMedikit)
addEventHandler("UnequipToolbox",root,unequipToolbox)
addEventHandler("UnequipBackpack",root,unequipBackpack)

function equipHeadlamp()
setElementData(localPlayer,"headlampequipped",true,true)
toggleFlashLight()
end

function equipMedikit()
setElementData(localPlayer,"medikitequipped",true,true)
end

function equipToolbox()
setElementData(localPlayer,"toolboxequipped",true,true)
end

addEventHandler("HeadlampEquipped", localPlayer,equipHeadlamp)
addEventHandler("MedikitEquipped", localPlayer,equipMedikit)
addEventHandler("ToolboxEquipped", localPlayer,equipToolbox)

function getPlayerEquippedItems(ped)

local tempPlayersEquippedItems = {}
	
	if ped and isElement(ped) and getElementType(ped) == "ped" or getElementType(ped) == "player" then
		for i=1,11 do
			local wep = getPedWeapon(localPlayer,i)
			
			
			if wep and wep ~= 0 and i == 1 then
			
				if wep == 1 then
				table.insert(tempPlayersEquippedItems,"Tactical Shield")
				elseif wep == 2 then
				table.insert(tempPlayersEquippedItems,"Axe")
				elseif wep == 3 then
				table.insert(tempPlayersEquippedItems,"Nightstick")
				elseif wep == 4 then
				table.insert(tempPlayersEquippedItems,"Knife")
				elseif wep == 5 then
				table.insert(tempPlayersEquippedItems,"Baseball Bat")
				elseif wep == 6 then
				table.insert(tempPlayersEquippedItems,"Crowbar")
				elseif wep == 7 then
				table.insert(tempPlayersEquippedItems,"Sledgehammer")
				elseif wep == 8 then
				table.insert(tempPlayersEquippedItems,"Raider Sword")
				elseif wep == 9 then
				table.insert(tempPlayersEquippedItems,"Chainsaw")
				end
			
			elseif wep and wep ~= 0 and i == 2 then

			if wep == 22 then
				table.insert(tempPlayersEquippedItems,"Pistol")
				elseif wep == 23 then
				table.insert(tempPlayersEquippedItems,"Crossbow")
				elseif wep == 24 then
				table.insert(tempPlayersEquippedItems,"Magnum Revolver")
				end
			
			elseif wep and  wep ~= 0 and i == 3 then
			
				if wep == 25 then
				table.insert(tempPlayersEquippedItems,"Pump Shotgun")
				elseif wep == 26 then
				table.insert(tempPlayersEquippedItems,"Sawn-off Shotgun")
				elseif wep == 27 then
				table.insert(tempPlayersEquippedItems,"Combat Shotgun")
				end
			
			elseif wep and  wep ~= 0 and i == 4 then
			
				if wep == 28 then
				table.insert(tempPlayersEquippedItems,"Uzi")
				elseif wep == 29 then
				table.insert(tempPlayersEquippedItems,"MP5")
				elseif wep == 32 then
				table.insert(tempPlayersEquippedItems,"Vehicle Minigun")
				end
			
			elseif wep and  wep ~= 0 and i == 5 then
			
				if wep == 30 then
				table.insert(tempPlayersEquippedItems,"AK 47")
				elseif wep == 31 then
				table.insert(tempPlayersEquippedItems,"M4")
				end
			
			elseif wep and  wep ~= 0 and i == 6 then
			
				if wep == 33 then
				table.insert(tempPlayersEquippedItems,"Hunting Rifle")
				elseif wep == 34 then
				table.insert(tempPlayersEquippedItems,"Sniper Rifle")
				end
			
			elseif wep and  wep ~= 0 and i == 7 then
			
				if wep == 35 then
				table.insert(tempPlayersEquippedItems,"Rocket Launcher")
				elseif wep == 36 then
				table.insert(tempPlayersEquippedItems,"Stinger Launcher")
				end
			
			elseif wep and  wep ~= 0 and i == 9 then
			
				if wep == 41 then
				table.insert(tempPlayersEquippedItems,"Spray Can")
				elseif wep == 42 then
				table.insert(tempPlayersEquippedItems,"Agent Pale")
				elseif wep == 43 then
				table.insert(tempPlayersEquippedItems,"Binoculars")
				end
				
			elseif wep and  wep ~= 0 and i == 10 then
			
				if wep == 10 then
				table.insert(tempPlayersEquippedItems,"Machete")
				elseif wep == 11 then
				table.insert(tempPlayersEquippedItems,"Kitchen Knife")
				elseif wep == 12 then
				table.insert(tempPlayersEquippedItems,"Meatcleaver")
				elseif wep == 14 then
				table.insert(tempPlayersEquippedItems,"Broken Bottle")
				elseif wep == 15 then
				table.insert(tempPlayersEquippedItems,"Nail Bat")
				end
				
			elseif wep and  wep ~= 0 and i == 11 then
			
				if wep == 44 then
				table.insert(tempPlayersEquippedItems,"Night Vision Googles")
				elseif wep == 45 then
				table.insert(tempPlayersEquippedItems,"Thermal Googles")
				elseif wep == 46 then
				table.insert(tempPlayersEquippedItems,"Backpack")
				end
			
			elseif wep and  wep ~= 0 and i == 8 then --(wep==16 or wep==17 or wep==39 or wep==18) 
			
				if wep == 16 then
					local throwingnumber = getPedTotalAmmo(localPlayer,8)
					for i= 1,throwingnumber do table.insert(tempPlayersEquippedItems,"Grenade") end
				elseif wep == 17 then
				local throwingnumber = getPedTotalAmmo(localPlayer,8)
					for i= 1,throwingnumber do table.insert(tempPlayersEquippedItems,"Teargas")  end
				elseif wep == 18 then
				local throwingnumber = getPedTotalAmmo(localPlayer,8)
					for i= 1,throwingnumber do table.insert(tempPlayersEquippedItems,"Molotov")  end
				elseif wep == 39 then
				local throwingnumber = getPedTotalAmmo(localPlayer,8)
					for i= 1,throwingnumber do table.insert(tempPlayersEquippedItems,"Satchel Charge")  end
				end
		
			end
				
		end	
	
		if getElementData(localPlayer,"toolboxequipped")== true then 
			table.insert(tempPlayersEquippedItems,"Toolbox")
		end
		
		if getElementData(localPlayer,"medikitequipped")== true then 
			table.insert(tempPlayersEquippedItems,"Medikit")
		end
		
		if getElementData(localPlayer,"headlampequipped")== true then 
			table.insert(tempPlayersEquippedItems,"Headlamp")
		end
		
		local explosivetraps = getElementData(localPlayer,"explosivetraps") or 0
		local incendiarytraps = getElementData(localPlayer,"incendiarytraps") or 0
		local glasstraps = getElementData(localPlayer,"glasstraps") or 0
		local timedbombs = getElementData(localPlayer,"timedbombs") or 0
		local spikestrips = getElementData(localPlayer,"spikestrips") or 0
		
		if explosivetraps > 0 then
			for i = 1,explosivetraps do
				table.insert(tempPlayersEquippedItems,"Mine")
			end
		end
		
		if spikestrips > 0 then
			for i = 1,spikestrips do
				table.insert(tempPlayersEquippedItems,"Spikestrip")
			end
		end
		
		if incendiarytraps > 0 then
			for i = 1,incendiarytraps do
				table.insert(tempPlayersEquippedItems,"Incendiary Trap")
			end
		end
		
		if glasstraps > 0 then
			for i = 1,glasstraps do
				table.insert(tempPlayersEquippedItems,"Shards Trap")
			end
		end
		
		if timedbombs > 0 then
			for i = 1,timedbombs do
				table.insert(tempPlayersEquippedItems,"Timed Bomb")
			end
		end
		
		if getElementData(localPlayer,"zipline")== true then 
			table.insert(tempPlayersEquippedItems,"Zip Line")
		end
		
		if getElementData(localPlayer,"stomperequipped")== true then 
			table.insert(tempPlayersEquippedItems,"M37 Stomper")
		end
		
		if getElementData(localPlayer,"laserpointer") == true then 
			table.insert(tempPlayersEquippedItems,"Laser Pointer")
		end

		if getElementData(localPlayer,"watch") == true then 
			table.insert(tempPlayersEquippedItems,"Watch")
		end
		
		if getElementData(localPlayer,"backpackequipped")== true then 
			table.insert(tempPlayersEquippedItems,"Backpack")
		end

		if getElementData(localPlayer,"camoequipped")== true then 
			table.insert(tempPlayersEquippedItems,"Camouflage Suit")
		end

		if getElementData(localPlayer,"hazmatequipped")== true then 
			table.insert(tempPlayersEquippedItems,"Hazmat Suit")
		end
		
		if table.getn(tempPlayersEquippedItems) >= 9 then -- check if player has free equipment slots
			playerHasFreeEquipmentSlots = false  
			if getElementData(localPlayer,"equipment_slots_free") ~= false then
			setElementData(localPlayer,"equipment_slots_free",false,true)
			end
		else 
			playerHasFreeEquipmentSlots = true 
			if getElementData(localPlayer,"equipment_slots_free") ~= true then			
			setElementData(localPlayer,"equipment_slots_free",true,true)
			end
		end
	
	else 
			table.insert(tempPlayersEquippedItems,"Empty")
	end
	
	return tempPlayersEquippedItems
	
end


function getPlayerEquippedAmmo()

local ammo = {}
local pistolammo = getElementData(localPlayer,"pistolammo") or 1
local taserammo = getElementData(localPlayer,"taserammo") or 1
local crossbowammo = getElementData(localPlayer,"crossbowammo") or 1
local smgammo = getElementData(localPlayer,"smgammo") or 1
local shotgunammo = getElementData(localPlayer,"shotgunammo") or 1
local assaultammo = getElementData(localPlayer,"assaultammo") or 1
local rifleammo = getElementData(localPlayer,"rifleammo") or 1
local stomperammo = getElementData(localPlayer,"stomperammo") or 1

if pistolammo and pistolammo >= 11 then
table.insert(ammo,"Pistol Ammo")
end
if taserammo and taserammo >= 7 then
table.insert(ammo,"Magnum Ammo")
end
if crossbowammo and crossbowammo >= 6 then
table.insert(ammo,"Bolts")
end
if smgammo and smgammo >= 31 then
table.insert(ammo,"SMG Ammo")
end
if shotgunammo and shotgunammo >= 9 then
table.insert(ammo,"Shotgun Ammo")
end
if assaultammo and assaultammo >= 31 then
table.insert(ammo,"Assault Ammo")
end
if rifleammo and rifleammo >= 6 then
table.insert(ammo,"Rifle Ammo")
end
if stomperammo and stomperammo >= 5 then
table.insert(ammo,"Stomper Ammo")
end
--ammo = {pistolammo,taserammo,crossbowammo,smgammo,shotgunammo,assaultammo,rifleammo}

return ammo

end

PlayersEquippedItems = {}

function drawEquipped()

if equipment_menu_mode == "equipment" then
	PlayersEquippedItems = getPlayerEquippedItems(localPlayer)
elseif  equipment_menu_mode == "ammo" then
	PlayersEquippedItems = getPlayerEquippedAmmo(localPlayer)
end

if not PlayersEquippedItems then return end
local e1 = PlayersEquippedItems[1] 
local e2 = PlayersEquippedItems[2] 
local e3 = PlayersEquippedItems[3] 
local e4 = PlayersEquippedItems[4] 
local e5 = PlayersEquippedItems[5] 
local e6 = PlayersEquippedItems[6] 
local e7 = PlayersEquippedItems[7] 
local e8 = PlayersEquippedItems[8] 
local e9 = PlayersEquippedItems[9] 
DGS:dgsDxGUISetAlpha(EquippedGui.button[1],0.3)
DGS:dgsDxGUISetAlpha(EquippedGui.button[2],0.3)
DGS:dgsDxGUISetAlpha(EquippedGui.button[3],0.3)
DGS:dgsDxGUISetAlpha(EquippedGui.button[4],0)
DGS:dgsDxGUISetAlpha(EquippedGui.button[5],0)
DGS:dgsDxGUISetAlpha(EquippedGui.button[6],0)
DGS:dgsDxGUISetAlpha(EquippedGui.button[7],0)
DGS:dgsDxGUISetAlpha(EquippedGui.button[8],0)
DGS:dgsDxGUISetAlpha(EquippedGui.button[9],0)

if(e1 and e1~="Empty")then
dxDrawImage(23, 657-150, 51, 41, "icons/"..e1..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
DGS:dgsDxGUISetAlpha(EquippedGui.button[1],0.87)
end
if(e2 and e2~="Empty")then
dxDrawImage(89, 657-150, 51, 41, "icons/"..e2..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
DGS:dgsDxGUISetAlpha(EquippedGui.button[2],0.87)
end
if(e3 and e3~="Empty")then
dxDrawImage(155, 657-150, 51, 41, "icons/"..e3..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
DGS:dgsDxGUISetAlpha(EquippedGui.button[3],0.87)
end
if(e4 and e4~="Empty")then
dxDrawImage(221, 657-150, 51, 41, "icons/"..e4..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
DGS:dgsDxGUISetAlpha(EquippedGui.button[4],0.87)
end
if(e5 and e5~="Empty")then
dxDrawImage(287, 657-150, 51, 41, "icons/"..e5..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
DGS:dgsDxGUISetAlpha(EquippedGui.button[5],0.87)
end
if(e6 and e6~="Empty") then
dxDrawImage(353, 657-150, 51, 41, "icons/"..e6..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
DGS:dgsDxGUISetAlpha(EquippedGui.button[6],0.87)
end
if(e7 and e7~="Empty")then
dxDrawImage(419, 657-150, 51, 41, "icons/"..e7..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
DGS:dgsDxGUISetAlpha(EquippedGui.button[7],0.87)
end
if(e8 and e8~="Empty")then
dxDrawImage(485, 657-150, 51, 41, "icons/"..e8..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
DGS:dgsDxGUISetAlpha(EquippedGui.button[8],0.87)
end
if(e9 and e9~="Empty")then
dxDrawImage(551, 657-150, 51, 41, "icons/"..e9..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
DGS:dgsDxGUISetAlpha(EquippedGui.button[9],0.87)
end

end
      
function Open_CloseBelt()

if getElementData(localPlayer, "carriedObject") then --[[outputInteractInfo( "Drop object first!\n[H]", 255, 255, 255 )]] return end

local visi = DGS:dgsDxGUIGetVisible(BeltGui.label)
DGS:dgsDxGUISetText(BeltGui.label,"")
DGS:dgsDxGUISetText(BeltGui.labelshadow,"")
DGS:dgsDxGUISetVisible(BeltGui.label,not(visi)) 
DGS:dgsDxGUISetVisible(BeltGui.labelshadow,not(visi)) 
DGS:dgsDxGUISetVisible(BeltGui.labelTitle_shadow,not(visi))
DGS:dgsDxGUISetVisible(BeltGui.labelTitle,not(visi))
DGS:dgsDxGUISetVisible(BeltGui.button[1],not(visi))
DGS:dgsDxGUISetVisible(BeltGui.button[2],not(visi))
DGS:dgsDxGUISetVisible(BeltGui.button[3],not(visi))
DGS:dgsDxGUISetVisible(BeltGui.button[4],not(visi))
DGS:dgsDxGUISetVisible(BeltGui.button[5],not(visi))
DGS:dgsDxGUISetVisible(BeltGui.button[6],not(visi))
DGS:dgsDxGUISetVisible(BeltGui.button[7],not(visi))
DGS:dgsDxGUISetVisible(BeltGui.button[8],not(visi))
DGS:dgsDxGUISetVisible(BeltGui.button[9],not(visi))
DGS:dgsDxGUISetText(EquippedGui.label_eq,"")
DGS:dgsDxGUISetVisible(EquippedGui.ammo_label,not(visi)) 
DGS:dgsDxGUISetVisible(EquippedGui.equip_separator_label,not(visi)) 
DGS:dgsDxGUISetVisible(EquippedGui.equip_separator_label_shadow,not(visi)) 
DGS:dgsDxGUISetVisible(EquippedGui.label,not(visi)) 
DGS:dgsDxGUISetVisible(EquippedGui.label_eq,not(visi))
DGS:dgsDxGUISetVisible(EquippedGui.label_shadow,not(visi))
DGS:dgsDxGUISetVisible(EquippedGui.ammo_label_shadow,not(visi))
DGS:dgsDxGUISetVisible(EquippedGui.button[1],not(visi))
DGS:dgsDxGUISetVisible(EquippedGui.button[2],not(visi))
DGS:dgsDxGUISetVisible(EquippedGui.button[3],not(visi))
DGS:dgsDxGUISetVisible(EquippedGui.button[4],not(visi))
DGS:dgsDxGUISetVisible(EquippedGui.button[5],not(visi))
DGS:dgsDxGUISetVisible(EquippedGui.button[6],not(visi))
DGS:dgsDxGUISetVisible(EquippedGui.button[7],not(visi))
DGS:dgsDxGUISetVisible(EquippedGui.button[8],not(visi))
DGS:dgsDxGUISetVisible(EquippedGui.button[9],not(visi))

showCursor(not(visi))
if(visi)then
removeEventHandler("onClientRender",root,drawBelt)
removeEventHandler("onClientRender",root,drawEquipped)
else
addEventHandler("onClientRender",root,drawBelt)
addEventHandler("onClientRender",root,drawEquipped)
end
end
--bindKey("q","down","Belt") -- THIS IS THE SECONDARY BELTS KEY BIND----------------------------------- KEY KEY KEY
addCommandHandler("Belt",Open_CloseBelt)

addEventHandler( "onClientDgsDxMouseEnter", root, --draw belt labels
function()
if not(PlayersBeltItens[localPlayer])then return end
local b1 = PlayersBeltItens[localPlayer][1] or "Empty"
local b2 = PlayersBeltItens[localPlayer][2] or "Empty"
local b3 = PlayersBeltItens[localPlayer][3] or "Empty"
local b4 = PlayersBeltItens[localPlayer][4] or "Empty"
local b5 = PlayersBeltItens[localPlayer][5] or "Empty"
local b6 = PlayersBeltItens[localPlayer][6] or "Empty"
local b7 = PlayersBeltItens[localPlayer][7] or "Empty"
local b8 = PlayersBeltItens[localPlayer][8] or "Empty"
local b9 = PlayersBeltItens[localPlayer][9] or "Empty"

if(source ==BeltGui.button[1]) then
DGS:dgsDxGUISetText(BeltGui.label,b1)
DGS:dgsDxGUISetText(BeltGui.labelshadow,b1)
createBeltCursorTooltip(b1)

elseif(source ==BeltGui.button[2])then
DGS:dgsDxGUISetText(BeltGui.label,b2)
DGS:dgsDxGUISetText(BeltGui.labelshadow,b2)
createBeltCursorTooltip(b2)

elseif(source ==BeltGui.button[3])then
DGS:dgsDxGUISetText(BeltGui.label,b3)
DGS:dgsDxGUISetText(BeltGui.labelshadow,b3)
createBeltCursorTooltip(b3)

elseif(source ==BeltGui.button[4])then
DGS:dgsDxGUISetText(BeltGui.label,b4)
DGS:dgsDxGUISetText(BeltGui.labelshadow,b4)
createBeltCursorTooltip(b4)

elseif(source ==BeltGui.button[5])then
DGS:dgsDxGUISetText(BeltGui.label,b5)
DGS:dgsDxGUISetText(BeltGui.labelshadow,b5)
createBeltCursorTooltip(b5)

elseif(source ==BeltGui.button[6])then
DGS:dgsDxGUISetText(BeltGui.label,b6)
DGS:dgsDxGUISetText(BeltGui.labelshadow,b6)
createBeltCursorTooltip(b6)

elseif(source ==BeltGui.button[7])then
DGS:dgsDxGUISetText(BeltGui.label,b7)
DGS:dgsDxGUISetText(BeltGui.labelshadow,b7)
createBeltCursorTooltip(b7)

elseif(source ==BeltGui.button[8])then
DGS:dgsDxGUISetText(BeltGui.label,b8)
DGS:dgsDxGUISetText(BeltGui.labelshadow,b8)
createBeltCursorTooltip(b8)
	
elseif(source ==BeltGui.button[9])then
DGS:dgsDxGUISetText(BeltGui.label,b9)
DGS:dgsDxGUISetText(BeltGui.labelshadow,b9)
createBeltCursorTooltip(b9)
	
end
end)

addEventHandler( "onClientDgsDxMouseLeave", root, --draw belt labels
function()
if not(PlayersBeltItens[localPlayer])then return end
local b1 = PlayersBeltItens[localPlayer][1] or "Empty"
local b2 = PlayersBeltItens[localPlayer][2] or "Empty"
local b3 = PlayersBeltItens[localPlayer][3] or "Empty"
local b4 = PlayersBeltItens[localPlayer][4] or "Empty"
local b5 = PlayersBeltItens[localPlayer][5] or "Empty"
local b6 = PlayersBeltItens[localPlayer][6] or "Empty"
local b7 = PlayersBeltItens[localPlayer][7] or "Empty"
local b8 = PlayersBeltItens[localPlayer][8] or "Empty"
local b9 = PlayersBeltItens[localPlayer][9] or "Empty"

if(source ==BeltGui.button[1]) then
DGS:dgsDxGUISetText(BeltGui.label,"")
DGS:dgsDxGUISetText(BeltGui.labelshadow,"")
destroyBeltCursorTooltip()

elseif(source ==BeltGui.button[2])then
DGS:dgsDxGUISetText(BeltGui.label,"")
DGS:dgsDxGUISetText(BeltGui.labelshadow,"")
destroyBeltCursorTooltip()

elseif(source ==BeltGui.button[3])then
DGS:dgsDxGUISetText(BeltGui.label,"")
DGS:dgsDxGUISetText(BeltGui.labelshadow,"")
destroyBeltCursorTooltip()

elseif(source ==BeltGui.button[4])then
DGS:dgsDxGUISetText(BeltGui.label,"")
DGS:dgsDxGUISetText(BeltGui.labelshadow,"")
destroyBeltCursorTooltip()

elseif(source ==BeltGui.button[5])then
DGS:dgsDxGUISetText(BeltGui.label,"")
DGS:dgsDxGUISetText(BeltGui.labelshadow,"")
destroyBeltCursorTooltip()

elseif(source ==BeltGui.button[6])then
DGS:dgsDxGUISetText(BeltGui.label,"")
DGS:dgsDxGUISetText(BeltGui.labelshadow,"")
destroyBeltCursorTooltip()

elseif(source ==BeltGui.button[7])then
DGS:dgsDxGUISetText(BeltGui.label,"")
DGS:dgsDxGUISetText(BeltGui.labelshadow,"")
destroyBeltCursorTooltip()

elseif(source ==BeltGui.button[8])then
DGS:dgsDxGUISetText(BeltGui.label,"")
DGS:dgsDxGUISetText(BeltGui.labelshadow,"")
destroyBeltCursorTooltip()
	
elseif(source ==BeltGui.button[9])then
DGS:dgsDxGUISetText(BeltGui.label,"")
DGS:dgsDxGUISetText(BeltGui.labelshadow,"")
destroyBeltCursorTooltip()
	
end
end)

function beltButtonsTrigers(botao,estado)
if estado == "up" then return end
	if isTimer(busyTimer) then 
		--outputDebugString(getPlayerName(localPlayer).." clicks like crazy!") 
		return 
	end
if not(PlayersBeltItens[localPlayer])then return end
local b1 = PlayersBeltItens[localPlayer][1] 
local b2 = PlayersBeltItens[localPlayer][2] 
local b3 = PlayersBeltItens[localPlayer][3] 
local b4 = PlayersBeltItens[localPlayer][4] 
local b5 = PlayersBeltItens[localPlayer][5] 
local b6 = PlayersBeltItens[localPlayer][6] 
local b7 = PlayersBeltItens[localPlayer][7] 
local b8 = PlayersBeltItens[localPlayer][8] 
local b9 = PlayersBeltItens[localPlayer][9] 

if(source == BeltGui.button[1]) then
if(b1 and b1~="Empty")then
if(botao == "left")then
triggerServerEvent("onPlayerActivateBeltItem", localPlayer,b1,1)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "right")then
triggerServerEvent("onPlayerRetrieveBeltItem", localPlayer,b1,1)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "middle")then
triggerServerEvent("onPlayerToggleBeltItem", localPlayer,b1,1)
				busyTimer = setTimer(function()end,1000,1)

end
end
elseif(source == BeltGui.button[2]) then
if(b2 and b2~="Empty")then
if(botao == "left")then
triggerServerEvent("onPlayerActivateBeltItem", localPlayer,b2,2)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "right")then
triggerServerEvent("onPlayerRetrieveBeltItem", localPlayer,b2,2)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "middle")then
triggerServerEvent("onPlayerToggleBeltItem", localPlayer,b2,2)
				busyTimer = setTimer(function()end,1000,1)

end
end
elseif(source == BeltGui.button[3]) then
if(b3 and b3~="Empty")then
if(botao == "left")then
triggerServerEvent("onPlayerActivateBeltItem", localPlayer,b3,3)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "right")then
triggerServerEvent("onPlayerRetrieveBeltItem", localPlayer,b3,3)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "middle")then
triggerServerEvent("onPlayerToggleBeltItem", localPlayer,b3,3)
				busyTimer = setTimer(function()end,1000,1)

end
end
elseif(source == BeltGui.button[4]) then
if(b4 and b4~="Empty")then
if(botao == "left")then
triggerServerEvent("onPlayerActivateBeltItem", localPlayer,b4,4)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "right")then
triggerServerEvent("onPlayerRetrieveBeltItem", localPlayer,b4,4)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "middle")then
triggerServerEvent("onPlayerToggleBeltItem", localPlayer,b4,4)
				busyTimer = setTimer(function()end,1000,1)

end
end
elseif(source == BeltGui.button[5]) then
if(b5 and b5~="Empty")then
if(botao == "left")then
triggerServerEvent("onPlayerActivateBeltItem", localPlayer,b5,5)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "right")then
triggerServerEvent("onPlayerRetrieveBeltItem", localPlayer,b5,5)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "middle")then
triggerServerEvent("onPlayerToggleBeltItem", localPlayer,b5,5)
				busyTimer = setTimer(function()end,1000,1)

end
end
elseif(source == BeltGui.button[6]) then
if(b6 and b6~="Empty")then
if(botao == "left")then
triggerServerEvent("onPlayerActivateBeltItem", localPlayer,b6,6)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "right")then
triggerServerEvent("onPlayerRetrieveBeltItem", localPlayer,b6,6)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "middle")then
triggerServerEvent("onPlayerToggleBeltItem", localPlayer,b6,6)
				busyTimer = setTimer(function()end,1000,1)

end
end
elseif(source == BeltGui.button[7]) then
if(b7 and b7~="Empty")then
if(botao == "left")then
triggerServerEvent("onPlayerActivateBeltItem", localPlayer,b7,7)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "right")then
triggerServerEvent("onPlayerRetrieveBeltItem", localPlayer,b7,7)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "middle")then
triggerServerEvent("onPlayerToggleBeltItem", localPlayer,b7,7)
				busyTimer = setTimer(function()end,1000,1)

end
end
elseif(source == BeltGui.button[8]) then
if(b8 and b8~="Empty")then
if(botao == "left")then
triggerServerEvent("onPlayerActivateBeltItem", localPlayer,b8,8)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "right")then
triggerServerEvent("onPlayerRetrieveBeltItem", localPlayer,b8,8)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "middle")then
triggerServerEvent("onPlayerToggleBeltItem", localPlayer,b8,8)
				busyTimer = setTimer(function()end,1000,1)

end
end
elseif(source == BeltGui.button[9]) then
if(b9 and b9~="Empty")then
if(botao == "left")then
triggerServerEvent("onPlayerActivateBeltItem", localPlayer,b9,9)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "right")then
triggerServerEvent("onPlayerRetrieveBeltItem", localPlayer,b9,9)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "middle")then
triggerServerEvent("onPlayerToggleBeltItem", localPlayer,b9,9)
				busyTimer = setTimer(function()end,1000,1)

end
end
end
end
addEventHandler("onClientDgsDxMouseClick", root,beltButtonsTrigers)

function equippedButtonsTrigers(botao,estado)
if estado == "up" then return end
	if isTimer(busyTimer) then 
	--outputDebugString(getPlayerName(localPlayer).." clicks like crazy!") 
	return 
	end
if not(PlayersEquippedItems)then return end
local e1 = PlayersEquippedItems[1] 
local e2 = PlayersEquippedItems[2] 
local e3 = PlayersEquippedItems[3] 
local e4 = PlayersEquippedItems[4] 
local e5 = PlayersEquippedItems[5] 
local e6 = PlayersEquippedItems[6] 
local e7 = PlayersEquippedItems[7] 
local e8 = PlayersEquippedItems[8] 
local e9 = PlayersEquippedItems[9] 

if(source == EquippedGui.button[1]) then
if(e1 and e1~="Empty")then
if(botao == "left")then
triggerServerEvent("onPlayerActivateEquippedItem", localPlayer,e1,1)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "right")then
triggerServerEvent("onPlayerRetrieveEquippedItem", localPlayer,e1,1)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "middle")then
triggerServerEvent("onPlayerToggleEquippedItem", localPlayer,e1,1)
				busyTimer = setTimer(function()end,1000,1)

end
end
elseif(source == EquippedGui.button[2]) then
if(e2 and e2~="Empty")then
if(botao == "left")then
triggerServerEvent("onPlayerActivateEquippedItem", localPlayer,e2,2)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "right")then
triggerServerEvent("onPlayerRetrieveEquippedItem", localPlayer,e2,2)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "middle")then
triggerServerEvent("onPlayerToggleEquippedItem", localPlayer,e1,1)
				busyTimer = setTimer(function()end,1000,1)

end
end
elseif(source == EquippedGui.button[3]) then
if(e3 and e3~="Empty")then
if(botao == "left")then
triggerServerEvent("onPlayerActivateEquippedItem", localPlayer,e3,3)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "right")then
triggerServerEvent("onPlayerRetrieveEquippedItem", localPlayer,e3,3)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "middle")then
triggerServerEvent("onPlayerToggleEquippedItem", localPlayer,e1,1)
				busyTimer = setTimer(function()end,1000,1)

end
end
elseif(source == EquippedGui.button[4]) then
if(e4 and e4~="Empty")then
if(botao == "left")then
triggerServerEvent("onPlayerActivateEquippedItem", localPlayer,e4,4)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "right")then
triggerServerEvent("onPlayerRetrieveEquippedItem", localPlayer,e4,4)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "middle")then
triggerServerEvent("onPlayerToggleEquippedItem", localPlayer,e1,1)
				busyTimer = setTimer(function()end,1000,1)

end
end
elseif(source == EquippedGui.button[5]) then
if(e5 and e5~="Empty")then
if(botao == "left")then
triggerServerEvent("onPlayerActivateEquippedItem", localPlayer,e5,5)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "right")then
triggerServerEvent("onPlayerRetrieveEquippedItem", localPlayer,e5,5)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "middle")then
triggerServerEvent("onPlayerToggleEquippedItem", localPlayer,e1,1)
				busyTimer = setTimer(function()end,1000,1)

end
end
elseif(source == EquippedGui.button[6]) then
if(e6 and e6~="Empty")then
if(botao == "left")then
triggerServerEvent("onPlayerActivateEquippedItem", localPlayer,e6,6)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "right")then
triggerServerEvent("onPlayerRetrieveEquippedItem", localPlayer,e6,6)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "middle")then
triggerServerEvent("onPlayerToggleEquippedItem", localPlayer,e1,1)
				busyTimer = setTimer(function()end,1000,1)

end
end
elseif(source == EquippedGui.button[7]) then
if(e7 and e7~="Empty")then
if(botao == "left")then
triggerServerEvent("onPlayerActivateEquippedItem", localPlayer,e7,7)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "right")then
triggerServerEvent("onPlayerRetrieveEquippedItem", localPlayer,e7,7)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "middle")then
triggerServerEvent("onPlayerToggleEquippedItem", localPlayer,e1,1)
				busyTimer = setTimer(function()end,1000,1)

end
end
elseif(source == EquippedGui.button[8]) then
if(e8 and e8~="Empty")then
if(botao == "left")then
triggerServerEvent("onPlayerActivateEquippedItem", localPlayer,e8,8)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "right")then
triggerServerEvent("onPlayerRetrieveEquippedItem", localPlayer,e8,8)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "middle")then
triggerServerEvent("onPlayerToggleEquippedItem", localPlayer,e1,1)
				busyTimer = setTimer(function()end,1000,1)

end
end
elseif(source == EquippedGui.button[9]) then
if(e9 and e9~="Empty")then
if(botao == "left")then
triggerServerEvent("onPlayerActivateEquippedItem", localPlayer,e9,9)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "right")then
triggerServerEvent("onPlayerRetrieveEquippedItem", localPlayer,e9,9)
				busyTimer = setTimer(function()end,1000,1)

elseif(botao == "middle")then
triggerServerEvent("onPlayerToggleEquippedItem", localPlayer,e1,1)
				busyTimer = setTimer(function()end,1000,1)

end
end
end
end
addEventHandler("onClientDgsDxMouseClick", root,equippedButtonsTrigers)

function returnPlayerBeltItemSlot(item, p) --returns belt slot it occupies, takes a string: "item name"

	if not PlayersBeltItens[p] then return end

	local i = 1
	while i <= 9 do
		if PlayersBeltItens[p][i] == nil then PlayersBeltItens[p][i] = "Empty" end
		i = i+1
	end

local slot = nil
local b1 = PlayersBeltItens[p][1] or false
local b2 = PlayersBeltItens[p][2] or false
local b3 = PlayersBeltItens[p][3] or false
local b4 = PlayersBeltItens[p][4] or false
local b5 = PlayersBeltItens[p][5] or false
local b6 = PlayersBeltItens[p][6] or false
local b7 = PlayersBeltItens[p][7] or false
local b8 = PlayersBeltItens[p][8] or false
local b9 = PlayersBeltItens[p][9] or false

	if 	   b1 == item then slot = 1 
	elseif b2 == item then slot = 2 
	elseif b3 == item then slot = 3 
	elseif b4 == item then slot = 4 
	elseif b5 == item then slot = 5 
	elseif b6 == item then slot = 6 
	elseif b7 == item then slot = 7 
	elseif b8 == item then slot = 8 
	elseif b9 == item then slot = 9 
	else return false
	end
return slot
end

function hasPlayerBeltItem_c (item, p) --returns number of (certain) items or false, takes a string: "item name"

local itemcount = 0
local b1 = PlayersBeltItens[p][1] or false
local b2 = PlayersBeltItens[p][2] or false
local b3 = PlayersBeltItens[p][3] or false
local b4 = PlayersBeltItens[p][4] or false
local b5 = PlayersBeltItens[p][5] or false
local b6 = PlayersBeltItens[p][6] or false
local b7 = PlayersBeltItens[p][7] or false
local b8 = PlayersBeltItens[p][8] or false
local b9 = PlayersBeltItens[p][9] or false

if b1 == item then itemcount = itemcount + 1 end
if b2 == item then itemcount = itemcount + 1 end
if b3 == item then itemcount = itemcount + 1 end
if b4 == item then itemcount = itemcount + 1 end
if b5 == item then itemcount = itemcount + 1 end
if b6 == item then itemcount = itemcount + 1 end
if b7 == item then itemcount = itemcount + 1 end
if b8 == item then itemcount = itemcount + 1 end
if b9 == item then itemcount = itemcount + 1 end

--outputDebugString("Number of belt items: "..itemcount, 0,0,0)

if itemcount > 0 then  return itemcount end 
					  
if itemcount <= 0  then return false end 

end

function switchEquippedSlotOnHover(item)
if item == "Pistol" or item == "Crossbow" or item == "Magnum Revolver" then setPedWeaponSlot(localPlayer,2)
elseif  item == "M4" or item == "AK 47" then setPedWeaponSlot(localPlayer,5)
elseif  item == "Night Vision Googles" or item == "Thermal Googles" then setPedWeaponSlot(localPlayer,11)
elseif  item == "Uzi" or item == "Vehicle Minigun" or item == "MP5" then setPedWeaponSlot(localPlayer,4)
elseif  item == "Pump Shotgun" or item == "Sawn-off Shotgun" or item == "Combat Shotgun" then setPedWeaponSlot(localPlayer,3)
elseif  item == "Rocket Launcher" or item == "Stinger Launcher" or item == "Flamethrower" then setPedWeaponSlot(localPlayer,7)
elseif  item == "Hunting Rifle" or item == "Sniper Rifle" then setPedWeaponSlot(localPlayer,6)
elseif  item == "Axe" or item == "Nightstick" or item == "Knife" or item == "Crowbar" or item == "Sledgehammer" or item == "Raider Sword" or item == "Chainsaw" or item == "Baseball Bat" then setPedWeaponSlot(localPlayer,1)
elseif item == "Grenade" or item == "Molotov" or item == "Teargas" then setPedWeaponSlot(localPlayer,8)
elseif item == "Agent Pale" or item == "Spray Can" or item == "Binoculars" then setPedWeaponSlot(localPlayer,9) 
elseif item == "Machete" or item == "Kitchen Knife" or item == "Meatcleaver" or item == "Nail Bat" or item == "Broken Bottle" then setPedWeaponSlot(localPlayer,10) 
end
end

addEventHandler( "onClientDgsDxMouseEnter", root, --draw equipment tooltips
function()
local PlayersEquippedItems = getPlayerEquippedItems(localPlayer)
if not(PlayersEquippedItems)then return end
local b1 = PlayersEquippedItems[1] or "Empty"
local b2 = PlayersEquippedItems[2] or "Empty"
local b3 = PlayersEquippedItems[3] or "Empty"
local b4 = PlayersEquippedItems[4] or "Empty"
local b5 = PlayersEquippedItems[5] or "Empty"
local b6 = PlayersEquippedItems[6] or "Empty"
local b7 = PlayersEquippedItems[7] or "Empty"
local b8 = PlayersEquippedItems[8] or "Empty"
local b9 = PlayersEquippedItems[9] or "Empty"

if(source ==EquippedGui.button[1]) then
createequippCursorTooltip(b1)
switchEquippedSlotOnHover(b1)

elseif(source ==EquippedGui.button[2])then
createequippCursorTooltip(b2)
switchEquippedSlotOnHover(b2)

elseif(source ==EquippedGui.button[3])then
createequippCursorTooltip(b3)
switchEquippedSlotOnHover(b3)

elseif(source ==EquippedGui.button[4])then
createequippCursorTooltip(b4)
switchEquippedSlotOnHover(b4)

elseif(source ==EquippedGui.button[5])then
createequippCursorTooltip(b5)
switchEquippedSlotOnHover(b5)

elseif(source ==EquippedGui.button[6])then
createequippCursorTooltip(b6)
switchEquippedSlotOnHover(b6)

elseif(source ==EquippedGui.button[7])then
createequippCursorTooltip(b7)
switchEquippedSlotOnHover(b7)

elseif(source ==EquippedGui.button[8])then
createequippCursorTooltip(b8)
switchEquippedSlotOnHover(b8)
	
elseif(source ==EquippedGui.button[9])then
createequippCursorTooltip(b9)
switchEquippedSlotOnHover(b9)
	
end
end)

addEventHandler( "onClientDgsDxMouseLeave", root, --destroy equipment tooltips
function()
local PlayersEquippedItems = getPlayerEquippedItems(localPlayer)
if not(PlayersEquippedItems)then return end
local b1 = PlayersEquippedItems[1] or "Empty"
local b2 = PlayersEquippedItems[2] or "Empty"
local b3 = PlayersEquippedItems[3] or "Empty"
local b4 = PlayersEquippedItems[4] or "Empty"
local b5 = PlayersEquippedItems[5] or "Empty"
local b6 = PlayersEquippedItems[6] or "Empty"
local b7 = PlayersEquippedItems[7] or "Empty"
local b8 = PlayersEquippedItems[8] or "Empty"
local b9 = PlayersEquippedItems[9] or "Empty"

if(source ==EquippedGui.button[1]) then

destroyequippCursorTooltip()

elseif(source ==EquippedGui.button[2])then

destroyequippCursorTooltip()

elseif(source ==EquippedGui.button[3])then

destroyequippCursorTooltip()

elseif(source ==EquippedGui.button[4])then

destroyequippCursorTooltip()

elseif(source ==EquippedGui.button[5])then

destroyequippCursorTooltip()

elseif(source ==EquippedGui.button[6])then

destroyequippCursorTooltip()

elseif(source ==EquippedGui.button[7])then

destroyequippCursorTooltip()

elseif(source ==EquippedGui.button[8])then

destroyequippCursorTooltip()
	
elseif(source ==EquippedGui.button[9])then

destroyequippCursorTooltip()
	
end
end)

---------DRUNK--------------------
addEvent("Drunk",true)
tempwalk = nil
function drunkdelayed4secs () --delays effect a bit to have time to drop the bottle
setTimer(youredrunk,4000,1)
end

function youredrunk () -- 'drunk' function; needs 'near_death_blur' resource on (does it still? check!)
local screenX, screenY = guiGetScreenSize()
local initialwalkingstyle = getPedWalkingStyle(localPlayer)
if (initialwalkingstyle) then tempwalk = initialwalkingstyle end

setElementData(localPlayer,"drunk",true)
triggerEvent( "switchDoF", root, true )
setPedControlState("walk",true)
toggleControl ( "sprint", false )
toggleControl ( "jump", false )
setPedWalkingStyle(localPlayer, 126) --drunk walking
if getCameraShakeLevel(localPlayer) < 200 then setCameraShakeLevel(200) end
if isElement(drunkShader) then destroyElement(drunkShader) end
drunkShader = guiCreateStaticImage( 0, 0, screenX, screenY, "shaders/drunkshader.png", false ) --shader
guiMoveToBack(drunkShader)
guiSetAlpha(drunkShader,240)
outputStatusInfo("Drunk!", 250,100,0 )
setTimer(clearDrunk,20000,1)
end

function clearDrunk ()
setElementData(localPlayer,"drunk",false)
triggerEvent( "switchDoF", root, false )
if tempwalk ~= nil then setPedWalkingStyle(localPlayer, tempwalk) else setPedWalkingStyle(localPlayer, 0) end
setCameraShakeLevel(1)
setPedControlState("walk",false)
toggleControl ( "sprint", true )
toggleControl ( "jump", true )
setTimer(removedrunkshader,3000,1)
setTimer(function() outputStatusInfo("Sober", 255,255,255 ) end,3500,1)
tempwalk = nil
end

function removedrunkshader()
setTimer(function() if isElement(drunkShader) then guiSetAlpha(drunkShader,200) end end,1000,1)
setTimer(function() if isElement(drunkShader) then guiSetAlpha(drunkShader,150) end end,1500,1)
setTimer(function() if isElement(drunkShader) then guiSetAlpha(drunkShader,100) end end,2000,1)
setTimer(function() if isElement(drunkShader) then guiSetAlpha(drunkShader,50) end end,2500,1)
setTimer(function() if isElement(drunkShader) then destroyElement(drunkShader) end end,3000,1)
end
addEventHandler("Drunk", localPlayer, drunkdelayed4secs)

--------------PAIN; FIRE----------------------

addEvent("PainkillersTaken",true)
addEvent("FireBurnPain",true)
addEvent("FireColHeals",true)
addEvent("FireColHealStops",true)

function startPainTimer()
local randchance = math.random(1,20)
local randinterval = math.random(2000,6000)  
paintimer = setTimer( painEffect, randinterval, randchance) -- adjust here effect frequency and duration
table.insert(painTimers,paintimer)
setElementData(localPlayer,"pain", true,true)
setTimer(setElementData,randinterval*randchance,1,localPlayer,"pain", false,true)
end

function startLightPainTimer()
local randchance = math.random(1,3)
local randinterval = math.random(2000,6000) 
lightpaintimer = setTimer( painEffect, randinterval, randchance) -- adjust here effect frequency and duration
table.insert(painTimers,lightpaintimer)
setElementData(localPlayer,"pain", true,true)
setTimer(setElementData,randinterval*randchance,1,localPlayer,"pain", false,true)
end

function startFireDamage()
if getElementModel(localPlayer) == 288 then return end
startLightPainTimer()
	setTimer(function()
	local health = getElementHealth(localPlayer)
	local damage = math.random(2,5)
	setElementHealth(localPlayer,health-damage)
	outputStatusInfo("-"..damage.." hp", 200,0,0)
	end
	,1000,5)
end

function startFireColHealing()

if isTimer(fireHealingTimer) then killTimer(fireHealingTimer) end
fireHealingTimer = setTimer(
	function()
	local health = getElementHealth(localPlayer)
	local healingamount = 1 -- how much health you gain by standing next to a fire place?
	if health >= 100 or health <= 0 then return end
	setElementHealth(localPlayer,health+healingamount)
	outputStatusInfo("+"..healingamount.." hp", 0,200,0)
	end
,6000,0)

end

function stopFireColHealing()
if isTimer(fireHealingTimer) then killTimer(fireHealingTimer); 
--outputDebugString("fireCol healing stopped") 
end
end

function painEffect() 
 
local x,y,z = getElementPosition(localPlayer)

	if getElementData(localPlayer,"drunk") == true then 
		outputStatusInfo("Alcohol fades the pain", 255,255,255)
		for _,painEffect in pairs(painTimers) do 
			if isTimer(painEffect) then killTimer(painEffect) end 
		end 
		painTimers = {}
		setElementData(localPlayer,"pain",false,true)
	return
	end

	if getElementData(localPlayer,"painkillerstaken") == true then 
		outputStatusInfo("Pain subsides", 255,255,255)
		for _,painEffect in pairs(painTimers) do 
		if isTimer(painEffect) then killTimer(painEffect) end
		end 
	setElementData(localPlayer,"pain",false,true)
	painTimers = {}
	setElementData(localPlayer,"painkillerstaken",false) 
	return
	end

createExplosion(x,y,z-10, 8, false, 1, false)
triggerEvent("PainDrainsStamina", localPlayer)
outputStatusInfo ("-100 stamina", 250,100,0)	
local anim = nil 
	if getPedMoveState ( localPlayer ) == "stand" or getPedMoveState ( localPlayer ) == "walk" then anim ="IDLE_tired" 
	elseif  getPedMoveState ( localPlayer ) == "powerwalk" or getPedMoveState ( localPlayer ) == "jog" or getPedMoveState ( localPlayer ) == "sprint" then anim = "FALL_collapse" 
	elseif getPedMoveState ( localPlayer ) == "crouch" or getPedMoveState ( localPlayer ) == "crawl" then anim ="cower"
	else anim = "FALL_collapse"
	end
	
	if not painsound then
	painsound = playSound("sounds/pain.mp3",false)
	setSoundVolume(painsound,0.5)
	setTimer(function() if painsound then painsound = nil end end,3000,1)
	end
	
	setPedAnimation( localPlayer, "ped", anim, 1000, false, true, true, false) 
end

function stopPain()
setElementData(localPlayer,"painkillerstaken",true)
setElementData(localPlayer,"pain",false,true)
setTimer(function () setElementData(localPlayer,"painkillerstaken",false) end, 30000, 1)
end
addEventHandler("PainkillersTaken",localPlayer,stopPain)
addEventHandler("FireBurnPain",localPlayer,startFireDamage)
addEventHandler("FireColHeals",localPlayer,startFireColHealing)
addEventHandler("FireColHealStops",localPlayer,stopFireColHealing)
addCommandHandler("testpain", startPainTimer)

----SPRAY DRAW_TAG
addEvent("ShowDrawingWindow",true)
function toggleSprayDrawWindow()

local visi = exports.drawtag:isDrawingWindowVisible()

if visi == true then return else exports.drawtag:showDrawingWindow(true) end

end
addEventHandler("ShowDrawingWindow",root,toggleSprayDrawWindow)

function cancelVehicleObjectDamage() --obj attached to a vehicle are invulnerable

				if getElementAttachedTo(source) then
					if getElementType(getElementAttachedTo(source)) == "vehicle" then
						cancelEvent()
					end
				end 

end
addEventHandler("onClientObjectDamage",root,cancelVehicleObjectDamage)

itemhighlighted = "Empty"

function createCursorTooltip(item)
if not isCursorShowing() then return end
if item and item ~= "Empty" then
itemhighlighted = item
addEventHandler("onClientRender",root,drawCursorTooltip)
end
end

function destroyCursorTooltip()

removeEventHandler("onClientRender",root,drawCursorTooltip)
itemhighlighted = "Empty"

end

function getCursorTooltipText(item)
--local DGS = exports.dgs
local tooltiptext = " "
local action = " "
if isPlayerUsingContainer() then action = "Transfer" else action = "Drop" end
local type1 = "[LMB] Toggle\n[RMB] "..action.."\n[MMB] Equip" --map
local type2 = "[LMB] Equip\n[RMB] "..action.."" --weapon
local type3 = "[LMB] Craft\n[RMB] "..action.."" --crafting
local type4 = "[LMB] Reload\n[RMB] "..action.."\n[MMB] Equip" --ammo
local type5 = "[LMB] Drink\n[RMB] "..action.."" --drink
local type6 = "[LMB] Eat\n[RMB] "..action.."" --food
local type7 = "[LMB] Use\n[RMB] "..action.."\n[MMB] Equip" --medikit, toolbox, bandage, lighter
local type8 = "[LMB] Refill/Craft\n[RMB] "..action.."" --empty bottle, 
local type9 = "[LMB] Install on current weapon\n[RMB] "..action.."" --laser tag
local type10 = "[LMB] Install on crossbow\n[RMB] "..action.."" --zip line
local type11 = "[LMB] Use\n[RMB] "..action.."" --fuel canister
local type12 = "[LMB] Refill\n[RMB] "..action.."" --empty canister
local type12 = "[LMB] Drink\n[RMB] "..action.."" --alcohol
local type13 = "[LMB] Open\n[RMB] "..action.."" --ammo box
local type14 = "[LMB] Install on vehicle\n[RMB] "..action.."" --veh part
local type15 = "[LMB] Refill\n[RMB] "..action.."" --empty canister
local type16 = "[LMB] Deploy\n[RMB] "..action.."\n[MMB] Equip" --traps
local type17 = "[RMB] "..action.."\n[MMB] Equip" --radio
local type18 = "[RMB] "..action.."\n[MMB] Equip" --scanner


if item == "Empty" then return 
elseif item == "Map" then tooltiptext = type1
elseif item == "Pistol Ammo" then tooltiptext = type4
elseif item == "Shotgun Ammo" then tooltiptext = type4 
elseif item == "Assault Ammo" then tooltiptext = type4 
elseif item == "SMG Ammo" then tooltiptext = type4 
elseif item == "Chainsaw" then tooltiptext = type2 
elseif item == "Raider Sword" then tooltiptext = type2 
elseif item == "AK 47" then tooltiptext = type2 
elseif item == "Rocket Launcher" then tooltiptext = type2 
elseif item == "Knife" then tooltiptext = type2 
elseif item == "Hunting Rifle" then tooltiptext = type2 
elseif item == "Crossbow" then tooltiptext = type2 
elseif item == "Sniper Rifle" then tooltiptext = type2 
elseif item == "Minigun" then tooltiptext = type14 
elseif item == "Uzi" then tooltiptext = type2 
elseif item == "Vehicle Minigun" then tooltiptext = "You shouldn't have this!" 
elseif item == "Combat Shotgun" then tooltiptext = type2 
elseif item == "Sawn-off Shotgun" then tooltiptext = type2 
elseif item == "Satchel Charge" then tooltiptext = type2 
elseif item == "MP5" then tooltiptext = type2
elseif item == "Grenade" then tooltiptext = type2 
elseif item == "Magnum Revolver" then tooltiptext = type2 
elseif item == "Stinger Launcher" then tooltiptext = type2 
elseif item == "Meat Can" then tooltiptext = type6 
elseif item == "Water Bottle"  then tooltiptext = type5 
elseif item == "Raw Meat" then tooltiptext = type6 
elseif item == "Machete" then tooltiptext = type2 
elseif item == "Kitchen Knife" then tooltiptext = type2
elseif item == "Meatcleaver" then tooltiptext = type2 
elseif item == "Broken Bottle" then tooltiptext = type2
elseif item == "Nail Bat" then tooltiptext = type2 
elseif item == "Crowbar" then tooltiptext = type2 
elseif item == "Sledgehammer" then tooltiptext = type2 
elseif item == "Pistol" then tooltiptext = type2 
elseif item == "Molotov" then tooltiptext = type2
elseif item == "Nightstick" then tooltiptext = type2 
elseif item == "Baseball Bat" then tooltiptext = type2
elseif item == "Tactical Shield" then tooltiptext = type2 
elseif item == "Axe" then tooltiptext = type2 
elseif item == "Binoculars" then tooltiptext = type2 
elseif item == "Spray Can" then tooltiptext = type2 
elseif item == "Pump Shotgun" then tooltiptext = type2 
elseif item == "Body Armor" then tooltiptext = type2 
elseif item == "Backpack" then tooltiptext = type2 
elseif item == "Medikit" then tooltiptext = type7 
elseif item == "Teargas" then tooltiptext = type2 
elseif item == "Flamethrower" then tooltiptext = type2 
elseif item == "Bolts"  then tooltiptext = type4 
elseif item == "Magnum Ammo" then tooltiptext = type4 
elseif item == "Painkillers" then tooltiptext = type7
elseif item == "Rifle Ammo" then tooltiptext = type4 
elseif item == "Fuel Canister" then tooltiptext = type11 
elseif item == "Empty Canister" then tooltiptext = type15 
elseif item == "Scrap Metal" then tooltiptext = type3 
elseif item == "Ammo Box" then tooltiptext = type13 
elseif item == "Toolbox" then tooltiptext = type7 
elseif item == "Alcohol Bottle" then tooltiptext = type12 
elseif item == "Rags" then tooltiptext = type3 
elseif item == "Empty Bottle" then tooltiptext = type8 
elseif item == "M4" then tooltiptext = type2 
elseif item == "Survivor Map" then tooltiptext = type1 
elseif item == "Military Map" then tooltiptext = type1 
elseif item == "Raw Human Meat" then tooltiptext = type6 
elseif item == "Roasted Meat" then tooltiptext = type6 
elseif item == "Vehicle Parts" then tooltiptext = type14 
elseif item == "Roasted Human Meat" then tooltiptext = type6 
elseif item == "Plastic Foil" then tooltiptext = type3 
elseif item == "Wire" then tooltiptext = type3 
elseif item == "Fish Can" then tooltiptext = type6 
elseif item == "Water Canister" then tooltiptext = type5 
elseif item == "Dirty Water" then tooltiptext = type5 
elseif item == "Headlamp" then tooltiptext = type2 
elseif item == "Thermal Googles" then tooltiptext = type2
elseif item == "Wood" then tooltiptext = type3 
elseif item == "Laser Pointer" then tooltiptext = type9 
elseif item == "Zip Line" then tooltiptext = type10 
elseif item == "Night Vision Googles" then tooltiptext = type2 
elseif item == "Lighter" then tooltiptext = type7 
elseif item == "Bandage" then tooltiptext = type7 

elseif item == "Adrenaline" then tooltiptext = type7 
elseif item == "ZomboKleen" then tooltiptext = type7 
elseif item == "Splint" then tooltiptext = type7 
elseif item == "Road Flare" then tooltiptext = type7 
elseif item == "Hazmat Suit" then tooltiptext = type2 
elseif item == "Camouflage Suit" then tooltiptext = type2 
elseif item == "Scuba Gear" then tooltiptext = type2 
elseif item == "Watch" then tooltiptext = type2 
elseif item == "EM Scanner" then tooltiptext = type18 
elseif item == "Radio" then tooltiptext = type17 
elseif item == "M37 Stomper" then tooltiptext = type9 
elseif item == "Stomper Ammo" then tooltiptext = type17 
elseif item == "Minigun Ammo" then tooltiptext = type2 
elseif item == "Stinger Missile" then tooltiptext = type2
elseif item == "Spikestrip" then tooltiptext = type16 
elseif item == "Timed Bomb" then tooltiptext = type16 
elseif item == "Mine" then tooltiptext = type16 
elseif item == "Incendiary Trap" then tooltiptext = type16 
elseif item == "Shards Trap" then tooltiptext = type16 
elseif item == "Agent Pale" then tooltiptext = type2 
elseif item == "Soup Can" then tooltiptext = type6 
else tooltiptext = "Tooltip N/A"
end
return tooltiptext
end

function drawCursorTooltip()
if not isCursorShowing() then return end
local item = itemhighlighted
local x,y,x1,y1,z1 = getCursorPosition()
local screenW,screenH = guiGetScreenSize()
local text = getCursorTooltipText(item)
local tooltipshadow = dxDrawText(text, x*screenW+9, y*screenH+4, x*screenW+200, y*screenH+200, tocolor(0, 0, 0, 255), 0.1, ChunkfiveFontDX, "left", "top", false, false, true, false, false)
local tooltip = dxDrawText(text, x*screenW+10, y*screenH+5, x*screenW+200, y*screenH+200, tocolor(255, 255, 255, 222), 0.1, ChunkfiveFontDX, "left", "top", false, false, true, false, false)
end

beltitemhighlighted = "Empty"

function createBeltCursorTooltip(item)
if not isCursorShowing() then return end
	if item and item ~= "Empty" then
	beltitemhighlighted = item
	addEventHandler("onClientRender",root,drawBeltCursorTooltip)
	end
end

function destroyBeltCursorTooltip()
	removeEventHandler("onClientRender",root,drawBeltCursorTooltip)
	beltitemhighlighted = "Empty"
end

function getBeltCursorTooltipText(item)
local tooltiptext = ""
local type1 = "[LMB] Toggle\n[RMB] Unequip\n[M] Quick display" --map
local type2 = "[LMB] Deploy\n[RMB] Unequip" --spikestrip
local type3 = "[LMB] Light fire\n[RMB] Unequip" --lighter
local type4 = "[LMB] Use\n[RMB] Unequip" --medical
local type5 = "[K] Toggle\n[RMB] Unequip" --scanner
local type6 = "[RMB] Unequip" --radio

if item == "Empty" then return 
elseif item == "Map" then tooltiptext = type1
elseif item == "Survivor Map" then tooltiptext = type1 
elseif item == "Military Map" then tooltiptext = type1 
elseif item == "Pistol Ammo" then tooltiptext = ""..getInfoForBeltAmmo(item).."\n[RMB] Unequip"
elseif item == "Shotgun Ammo" then tooltiptext = ""..getInfoForBeltAmmo(item).."\n[RMB] Unequip" 
elseif item == "Assault Ammo" then tooltiptext = ""..getInfoForBeltAmmo(item).."\n[RMB] Unequip" 
elseif item == "SMG Ammo" then tooltiptext = ""..getInfoForBeltAmmo(item).."\n[RMB] Unequip" 
elseif item == "Bolts"  then tooltiptext = ""..getInfoForBeltAmmo(item).."\n[RMB] Unequip" 
elseif item == "Magnum Ammo" then tooltiptext = ""..getInfoForBeltAmmo(item).."\n[RMB] Unequip" 
elseif item == "Rifle Ammo" then tooltiptext = ""..getInfoForBeltAmmo(item).."\n[RMB] Unequip" 
elseif item == "Stomper Ammo" then tooltiptext = ""..getInfoForBeltAmmo(item).."\n[RMB] Unequip" 
elseif item == "Lighter" then tooltiptext = type3 
elseif item == "EM Scanner" then tooltiptext = type5 
elseif item == "Spikestrip" then tooltiptext = type2 
elseif item == "Road Flare" then tooltiptext = type2 
elseif item == "Bandage" then tooltiptext = type4 
elseif item == "Painkillers" then tooltiptext = type4
elseif item == "Adrenaline" then tooltiptext = type4
elseif item == "ZomboKleen" then tooltiptext = type4
elseif item == "Radio" then tooltiptext = type6
end
return tooltiptext
end

function drawBeltCursorTooltip()
if not isCursorShowing() then return end
local item = beltitemhighlighted
local x,y,x1,y1,z1 = getCursorPosition()
local screenW,screenH = guiGetScreenSize()
local text = getBeltCursorTooltipText(item)
local tooltipshadow = dxDrawText(text, x*screenW+9, y*screenH+4, x*screenW+200, y*screenH+200, tocolor(0, 0, 0, 255), 0.1, ChunkfiveFontDX, "left", "top", false, false, true, false, false)
local tooltip = dxDrawText(text, x*screenW+10, y*screenH+5, x*screenW+200, y*screenH+200, tocolor(255, 255, 255, 222), 0.1, ChunkfiveFontDX, "left", "top", false, false, true, false, false)

end

equippitemhighlighted = "Empty"

function createequippCursorTooltip(item)
if not isCursorShowing() then return end
	if item and item ~= "Empty" then
	equippitemhighlighted = item
	addEventHandler("onClientRender",root,drawequippCursorTooltip)
	end
end

function destroyequippCursorTooltip()
	removeEventHandler("onClientRender",root,drawequippCursorTooltip)
	equippitemhighlighted = "Empty"
end

function getequippCursorTooltipText(item)
local tooltiptext = ""
local type1 = "[RMB] Unequip" --weapons
local type3 = "[LMB] Toggle\n[RMB] Unequip" --headlamp,laser
local type4 = "[LMB] Use\n[RMB] Unequip" --medical, toolbox
local type5 = "[LMB] Deploy\n[RMB] Unequip" --traps

if item == "Empty" then return 

elseif item == "Pistol" or item == "M4"  or item == "AK 47"  or item == "Hunting Rifle"  or item == "Vehicle Minigun" or item == "Crossbow"  or item == "Sniper Rifle"  or item == "Uzi"  or item == "Combat Shotgun"  or item == "Sawn-off Shotgun"  or item == "Magnum Revolver" or item == "Pump Shotgun" then tooltiptext = type1 

elseif item == "Medikit" or item == "Toolbox" then tooltiptext = type4 

elseif item == "Mine" or item == "Incendiary Trap" or  item == "Shards Trap" or  item == "Timed Bomb" then tooltiptext = type5 

elseif item == "Headlamp" or item == "Scuba Gear" or item == "Laser Pointer" then tooltiptext = type3 

elseif item == "Raider Sword"  or item == "Rocket Launcher" or item == "Knife"  or  item == "Satchel Charge"  or item == "MP5"  or item == "Grenade"  or item == "Machete" or item == "Kitchen knife"  or item == "Meatcleaver"  or item == "Broken Bottle"  or item == "Nail Bat"  or item == "Crowbar"  or item == "Sledgehammer"  or item == "Molotov"  or item == "Nightstick" or item == "Baseball Bat"   or item == "Tactical Shield"  or item == "Axe"  or item == "Binoculars"  or item == "Spray Can"  or item == "Backpack"   or item == "Teargas"  or item == "Thermal Googles"  or item == "Night Vision Googles"  or item == "Watch" or item == "Hazmat Suit"   or item == "Camouflage Suit"  or item == "Scuba Gear"  or item == "Agent Pale" or item == "Stinger Launcher" or item == "Flamethrower" or item == "M37 Stomper" or item == "Zip Line" then tooltiptext = type1
elseif item == "Pistol Ammo" then tooltiptext = (getElementData(localPlayer,"pistolammo")-1).." bullets\n[RMB] Retrieve ammo" 
elseif item == "Magnum Ammo" then tooltiptext = (getElementData(localPlayer,"taserammo")-1).." bullets\n[RMB] Retrieve ammo" 
elseif item == "Bolts" then tooltiptext = (getElementData(localPlayer,"crossbowammo")-1).." bolts\n[RMB] Retrieve ammo"
elseif item == "Shotgun Ammo" then tooltiptext = (getElementData(localPlayer,"shotgunammo")-1).." slugs\n[RMB] Retrieve ammo" 
elseif item == "SMG Ammo" then tooltiptext = (getElementData(localPlayer,"smgammo")-1).." slugs\n[RMB] Retrieve ammo" 
elseif item == "Assault Ammo" then tooltiptext = (getElementData(localPlayer,"assaultammo")-1).." bullets\n[RMB] Retrieve ammo"
elseif item == "Rifle Ammo" then tooltiptext = (getElementData(localPlayer,"rifleammo")-1).." bullets\n[RMB] Retrieve ammo"
elseif item == "Stomper Ammo" then tooltiptext = getElementData(localPlayer,"stomperammo").." grenades\n[RMB] Retrieve ammo"
end
return tooltiptext
end

function drawequippCursorTooltip()
if not isCursorShowing() then return end
local item = equippitemhighlighted
local x,y,x1,y1,z1 = getCursorPosition()
local screenW,screenH = guiGetScreenSize()
local text = getequippCursorTooltipText(item)
local tooltipshadow = dxDrawText(text, x*screenW+9, y*screenH+4, x*screenW+200, y*screenH+200, tocolor(0, 0, 0, 255), 0.1, ChunkfiveFontDX, "left", "top", false, false, true, false, false)
local tooltip = dxDrawText(text, x*screenW+10, y*screenH+5, x*screenW+200, y*screenH+200, tocolor(255, 255, 255, 222), 0.1, ChunkfiveFontDX, "left", "top", false, false, true, false, false)

end

addEvent("AdrenalineUsed",true)

adrenalinelevel = 0

function adrenalineEffects ()

local health = getElementHealth(localPlayer)

	if adrenalinelevel == 0 then
			adrenalinelevel = 1
			setElementData(localPlayer,"adrenaline",1,true)
			adrenalineTimer = setTimer(setElementData,60000,1,localPlayer,"adrenaline",false,true)
			adrenalinelevelTimer = setTimer(function () adrenalinelevel = 0 end,60000,1)
			outputStatusInfo("Adrenaline!",0,102,255)
			setCameraShakeLevel(1)
			stamina = stamina_MAX
	elseif adrenalinelevel == 1 then
			adrenalinelevel = 2
			if 	isTimer(adrenalineTimer) then 
				killTimer(adrenalineTimer)
				killTimer(adrenalinelevelTimer)
			end
			setElementData(localPlayer,"adrenaline",2,true)
			adrenalineTimer = setTimer(setElementData,120000,1,localPlayer,"adrenaline",false,true)
			adrenalinelevelTimer = setTimer(function () adrenalinelevel = 0 end,120000,1)
			outputStatusInfo("Double dose!",0,102,255)
			setCameraShakeLevel(1)
			stamina = stamina_MAX
	elseif adrenalinelevel == 2 then
			stamina = 0
			adrenalinelevel = 0
			setElementData(localPlayer,"adrenaline",false)
			outputStatusInfo("Overdose: -10 hp!", 255,0,0)
			if health <= 10 then 
				killPed(localPlayer)
			else 
				setElementHealth(localPlayer,health-10)
			end
			
			if 	isTimer(adrenalineTimer) then 
				killTimer(adrenalineTimer)
				killTimer(adrenalinelevelTimer)
			end	
	end
end

addEventHandler("AdrenalineUsed",root,adrenalineEffects)

	
bindKey("F6","down","savechar")

addEvent("carry.fixPosition", true)
addEventHandler("carry.fixPosition", root,
	function (object)
		local x, y, z = getElementPosition(object)
		--outputChatBox(table.concat({x, y, z}, ","))
		triggerServerEvent("carry.fixPosition_pong", resourceRoot, object, x, y, z)
	end
)

addEventHandler("onClientRender", root,
	function ()
		if getKeyState("lalt") or getKeyState("ralt") then
			if not getElementData(localPlayer, "isPressingAlt") then
				setElementData(localPlayer, "isPressingAlt", true)
				if currentGadget ~= "Empty" then
				outputStatusInfo("Gadget ready",255,255,255)
				end
			end
		else
			if getElementData(localPlayer, "isPressingAlt") then
				setElementData(localPlayer, "isPressingAlt", false)
			end
		end
	end
)

function disableWeaponSwitchInInvo ( prevSlot, newSlot ) --disable weapon switching while inventory is open
	if isInventoryOpen then 
		cancelEvent() 
	end
end
addEventHandler ( "onClientPlayerWeaponSwitch", root, disableWeaponSwitchInInvo )