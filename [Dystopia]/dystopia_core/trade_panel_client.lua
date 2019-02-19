---------------------Trade interface & co.---------clones manawydan's inventory--------just like the craft_panel hey --need to evaluate and funnel the interaction types so I can use a single fkkng function for the panel-------------
addEvent("synchronizeTrade",true)
addEvent("RefreshDrawTrade",true)
addEvent("OpenTrade",true)

local trader

local screenWidth, screenHeight = guiGetScreenSize ( )

TradeGui = {
    button = {},
    Tradelabel = {}
}
		
		TradeGui.button[1] = DGS:dgsDxCreateButton(198+330, 176, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(TradeGui.button[1], 0.87)
        TradeGui.button[2] = DGS:dgsDxCreateButton(282+330, 176, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(TradeGui.button[2], 0.87)
        TradeGui.button[3] = DGS:dgsDxCreateButton(366+330, 176, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(TradeGui.button[3], 0.87)
        TradeGui.button[4] = DGS:dgsDxCreateButton(198+330, 259, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(TradeGui.button[4], 0.87)
        TradeGui.button[5] = DGS:dgsDxCreateButton(282+330, 259, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(TradeGui.button[5], 0.87)
        TradeGui.button[6] = DGS:dgsDxCreateButton(366+330, 259, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(TradeGui.button[6], 0.87)
        TradeGui.button[7] = DGS:dgsDxCreateButton(198+330, 342, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(TradeGui.button[7], 0.87)
        TradeGui.button[8] = DGS:dgsDxCreateButton(282+330, 342, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(TradeGui.button[8], 0.87)
        TradeGui.button[9] = DGS:dgsDxCreateButton(366+330, 342, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(TradeGui.button[9], 0.87)
				
		TradeGui.Tradelabel[1] = guiCreateLabel(197+330, 149, 267, 60, "Trade", false) -- title shadow
		TradeGui.Tradelabel[2] = guiCreateLabel(198+330, 150, 267, 60, "Trade", false) -- title
		guiSetAlpha(TradeGui.Tradelabel[1], 0.87)
		guiLabelSetColor(TradeGui.Tradelabel[1], 0,0,0)
		guiSetAlpha(TradeGui.Tradelabel[2], 0.87)
		guiSetFont(TradeGui.Tradelabel[2], ChunkfiveFont)
		guiSetFont(TradeGui.Tradelabel[1], ChunkfiveFont)
		
		TradeGui.Tradelabel[3] = guiCreateLabel(197+330, 426, 270, 32, "", false) --item name shadow
		guiLabelSetColor(TradeGui.Tradelabel[3], 0,0,0)
		guiSetAlpha(TradeGui.Tradelabel[3], 0.87)
        TradeGui.Tradelabel[4] = guiCreateLabel(198+330, 427, 270, 32, "", false) --item name
		guiSetAlpha(TradeGui.Tradelabel[4], 0.87)
		TradeGui.Tradelabel[5] = guiCreateLabel(198+330, 446, 470, 180, "", false) --item description
		guiSetFont(TradeGui.Tradelabel[3], ChunkfiveFont)
		guiSetFont(TradeGui.Tradelabel[4], ChunkfiveFont)
		guiSetFont(TradeGui.Tradelabel[5], "default-bold-small") 
        
guiSetVisible(TradeGui.Tradelabel[1],false) 
guiSetVisible(TradeGui.Tradelabel[2],false) 
guiSetVisible(TradeGui.Tradelabel[3],false) 
guiSetVisible(TradeGui.Tradelabel[4],false) 
guiSetVisible(TradeGui.Tradelabel[5],false) 
DGS:dgsDxGUISetVisible(TradeGui.button[1],false)
DGS:dgsDxGUISetVisible(TradeGui.button[2],false)
DGS:dgsDxGUISetVisible(TradeGui.button[3],false)
DGS:dgsDxGUISetVisible(TradeGui.button[4],false)
DGS:dgsDxGUISetVisible(TradeGui.button[5],false)
DGS:dgsDxGUISetVisible(TradeGui.button[6],false)
DGS:dgsDxGUISetVisible(TradeGui.button[7],false)
DGS:dgsDxGUISetVisible(TradeGui.button[8],false)
DGS:dgsDxGUISetVisible(TradeGui.button[9],false)
--guiSetVisible(TradeGui.Tradelabel[1],false)
--guiSetVisible(TradeGui.Tradelabel[2],false)

function table.random ( theTable ) 
    return theTable[math.random ( #theTable )]
end


function startTrade(ped)
iprint("trader is "..tostring(ped))
trader = ped
Open_CloseTrade()
Open_CloseIn()
Open_CloseBelt()
end

--trade lists
randomlowlevel = { "Rags","Wood","Scrap Metal","Plastic Foil","Empty Bottle","Headlamp","Wire","Empty Canister","Map","Dirty Water","Raw Meat","Broken Bottle"}

scavTradLv0 = { "Water Bottle","Meat Can","Kitchen Knife",
			table.random(randomlowlevel),table.random(randomlowlevel),table.random(randomlowlevel),
			table.random(randomlowlevel),table.random(randomlowlevel),table.random(randomlowlevel)}
scavTradLv1 = { "Water Bottle","Meat Can","Kitchen Knife",
			"Map","Pistol","Pistol Ammo",
			table.random(randomlowlevel),table.random(randomlowlevel),table.random(randomlowlevel)}
scavTradLv2 = { "Water Bottle","Soup Can","Knife",
			"Survivor Map","Pistol","Pistol Ammo",
			"Backpack","Pump Shotgun","Shotgun Ammo"}
scavTradLv3 = { "Water Bottle","Soup Can","Knife",
			"Survivor Map","Pistol","Pistol Ammo",
			"Backpack","Combat Shotgun","Shotgun Ammo"}

scavs_kitTable = {"Survivor Kit","Traveler Kit","Hunter Kit","Medic Kit","Scavenger Kit","Wastelander Kit","Bounty Hunter Kit","Empty","Empty" }
bandits_kitTable = {"Robber Kit","Thug Kit","Highwayman Kit","Veteran Kit","Pirate Kit","Infiltrator Kit","Saboteur Kit","Empty","Empty" }
CDF_kitTable = {"Citizen Kit","Vigilante Kit","Medicine Man Kit","Militia Kit","Survivalist Kit","Ranger Kit","Empty","Empty","Empty" }
raider_kitTable = {"Mongrel Kit","Roadrunner Kit","Greasemonkey Kit","Body Snatcher Kit","Unburnt Kit","Man Eater Kit","Pitdog Kit","Berserker Kit","Empty" }
establishment_kitTable = {"Cleaner Kit","Peacekeeper Kit","Recon Kit","Combat Medic Kit","Assault Kit","Support Kit","Demolitions Kit","Sniper Kit","Agent Kit" }
			
PlayersTradeItems={} 
--carTable = {"Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty"} 

--[[function Tradetablesynchronize(table_)
PlayersTradeItems = table_
triggerServerEvent("synchronizeTradeServer",localPlayer,table_)
end
addEventHandler("synchronizeTrade",root,Tradetablesynchronize)]]

--function open_player_trade(player,level,money,tradername,other_player,is_robbed)--add a counter with up and down arrows for incapacitated or robbed players, to allow robbers to take money from them *but one $ at a time*

function getTraderNPCItems(trader) 

local level = getPlayerLevel(localPlayer)
local money = getPlayerMoney()
local npcName = getElementData(trader,"name") or "Trader"
local npcTeam = getElementData(trader,"BotTeam") or getTeamFromName("Scavengers") 
local playerTeam = getPlayerTeam(localPlayer) or getTeamFromName("Scavengers")
local Tradetable = {"Pistol","Pistol Ammo","Pump Shotgun","Water Bottle","Soup Can"}
--depending on player level, faction, standing and trader
--scavTradLv0
	if level == 1 then
		Tradetable = scavTradLv0
		elseif level == 2 then
		Tradetable = scavTradLv1
		elseif level == 3 then
		Tradetable = scavTradLv2
		elseif level >= 4 then
		Tradetable = scavTradLv3
	end

	if npcName == "Quartermaster" or npcName == "Outfitter" then

		if getTeamName(npcTeam) == "Scavengers" then 
			Tradetable = scavs_kitTable 
		elseif getTeamName(npcTeam) == "Raiders" then 
			Tradetable = raider_kitTable 
		elseif getTeamName(npcTeam) == "Establishment" then 
			Tradetable = establishment_kitTable 
		elseif getTeamName(npcTeam) == "Bandits" then 
			Tradetable = bandits_kitTable 
		elseif getTeamName(npcTeam) == "CDF" then 
			Tradetable = CDF_kitTable 
		end
		
	end
	
	if npcName == "Mechanic" then
	Tradetable = {"Vehicle Parts","Toolbox","Fuel Canister","Alcohol Bottle","Rags","Crowbar","Scrap Metal","Wire","Empty Canister"} 
	elseif npcName == "Medic" then
	Tradetable = {"Medikit","Splint","Painkillers","Alcohol Bottle","Bandage","Adrenaline","Rags","Water Bottle","Empty"} 
	elseif npcName == "Bartender" then
	Tradetable = {"Alcohol Bottle","Water Bottle","Roasted Meat","Empty","Empty","Empty","Empty","Empty","Empty"} 
	elseif npcName == "Weapons Dealer" then
	Tradetable = {"Machete","Magnum Revolver","Sawn-off Shotgun","Combat Shotgun","Shotgun Ammo","Magnum Ammo","Laser Pointer","AK 47","Assault Ammo"} 
	end

PlayersTradeItems = Tradetable
--Tradetablesynchronize(Tradetable)
return Tradetable

end

function drawTrade()

if not(PlayersTradeItems)then return end
--if not trader then return end
guiSetText ( TradeGui.Tradelabel[1], getElementData(trader,"name") ) 
guiSetText ( TradeGui.Tradelabel[2], getElementData(trader,"name") )
iprint("draw trader is "..tostring(trader))
PlayersTradeItems = getTraderNPCItems(trader)
--Tradetablesynchronize(PlayersTradeItems)
iprint("drawing trade items")

local b1 = PlayersTradeItems[1] 
local b2 = PlayersTradeItems[2] 
local b3 = PlayersTradeItems[3] 
local b4 = PlayersTradeItems[4] 
local b5 = PlayersTradeItems[5] 
local b6 = PlayersTradeItems[6] 
local b7 = PlayersTradeItems[7] 
local b8 = PlayersTradeItems[8] 
local b9 = PlayersTradeItems[9] --images\interact_icons

if(b1 and b1~="Empty")then
dxDrawImage(205+330, 186, 61, 51, "icons/"..b1..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
end
if(b2 and b2~="Empty")then
dxDrawImage(292+330, 186, 61, 51, "icons/"..b2..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
end
if(b3 and b3~="Empty")then
dxDrawImage(376+330, 186, 61, 51, "icons/"..b3..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
end
if(b4 and b4~="Empty")then
dxDrawImage(205+330, 269, 61, 51, "icons/"..b4..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
end
if(b5 and b5~="Empty")then
dxDrawImage(292+330, 269, 61, 51, "icons/"..b5..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
end
if(b6 and b6~="Empty") then
dxDrawImage(373+330, 269, 61, 51, "icons/"..b6..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
end
if(b7 and b7~="Empty")then
dxDrawImage(208+330, 352, 61, 51, "icons/"..b7..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
end
if(b8 and b8~="Empty")then
dxDrawImage(289+330, 352, 61, 51, "icons/"..b8..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
end
if(b9 and b9~="Empty")then
dxDrawImage(373+330, 352, 61, 51, "icons/"..b9..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)

end
end

--trade item values
ItemTradeValues = {}
ItemTradeValues["Pistol Ammo"] = 30
ItemTradeValues["Shotgun Ammo"] = 30
ItemTradeValues["Assault Ammo"] = 50
ItemTradeValues["SMG Ammo"] = 35
ItemTradeValues["Stomper Ammo"] = 100
ItemTradeValues["Minigun Ammo"] = 200
ItemTradeValues["Stinger Missile"] = 80
ItemTradeValues["Bolts"] = 25
ItemTradeValues["Magnum Ammo"] = 35
ItemTradeValues["Rifle Ammo"] = 50
ItemTradeValues["Ammo Box"] = 100

ItemTradeValues["Knife"] = 45
ItemTradeValues["Raider Sword"] = 50
ItemTradeValues["Nightstick"] = 45
ItemTradeValues["Baseball Bat"] = 40
ItemTradeValues["Tactical Shield"] = 90
ItemTradeValues["Axe"] = 45
ItemTradeValues["Machete"] = 40
ItemTradeValues["Kitchen Knife"] = 30
ItemTradeValues["Meatcleaver"] = 30
ItemTradeValues["Broken Bottle"] = 5
ItemTradeValues["Nail Bat"] = 25
ItemTradeValues["Crowbar"] = 30
ItemTradeValues["Sledgehammer"] = 45

ItemTradeValues["Magnum Revolver"] = 70
ItemTradeValues["Pistol"] = 50
ItemTradeValues["Crossbow"] = 70
ItemTradeValues["Pump Shotgun"] = 80
ItemTradeValues["Combat Shotgun"] = 100
ItemTradeValues["Sawn-off Shotgun"] = 80
ItemTradeValues["Uzi"] = 80
ItemTradeValues["MP5"] = 120
ItemTradeValues["M4"] = 150
ItemTradeValues["AK 47"] = 150
ItemTradeValues["Rifle"] = 130
ItemTradeValues["Sniper Rifle"] = 150

ItemTradeValues["Rocket Launcher"] = 200
ItemTradeValues["Stinger Launcher"] = 200
ItemTradeValues["Vehicle Minigun"] = 200
ItemTradeValues["Minigun"] = 200
ItemTradeValues["Flamethrower"] = 200
ItemTradeValues["Chainsaw"] = 140

ItemTradeValues["Binoculars"] = 40
ItemTradeValues["Spray Can"] = 25
ItemTradeValues["Thermal Googles"] = 70
ItemTradeValues["Night Vision Googles"] = 60
ItemTradeValues["Agent Pale"] = 80

ItemTradeValues["Molotov"] = 60
ItemTradeValues["Grenade"] = 70
ItemTradeValues["Teargas"] = 50
ItemTradeValues["Satchel Charge"] = 100

ItemTradeValues["Laser Pointer"] = 60
ItemTradeValues["Zip Line"] = 60
ItemTradeValues["Hazmat Suit"] = 100
ItemTradeValues["Camouflage Suit"] = 100
ItemTradeValues["Scuba Gear"] = 100
ItemTradeValues["Watch"] = 25
ItemTradeValues["EM Scanner"] = 180
ItemTradeValues["Radio"] = 25
ItemTradeValues["M37 Stomper"] = 100
ItemTradeValues["Body Armor"] = 145
ItemTradeValues["Backpack"] = 125
ItemTradeValues["Headlamp"] = 25
ItemTradeValues["Lighter"] = 15
ItemTradeValues["Road Flare"] = 15

ItemTradeValues["Medikit"] = 100
ItemTradeValues["Bandage"] = 25
ItemTradeValues["Adrenaline"] = 50
ItemTradeValues["ZomboKleen"] = 60
ItemTradeValues["Splint"] = 40
ItemTradeValues["Painkillers"] = 25

ItemTradeValues["Spikestrip"] = 45
ItemTradeValues["Timed Bomb"] = 80
ItemTradeValues["Mine"] = 50
ItemTradeValues["Incendiary Trap"] = 50
ItemTradeValues["Shards Trap"] = 45

ItemTradeValues["Soup Can"] = 35
ItemTradeValues["Meat Can"] = 30
ItemTradeValues["Fish Can"] = 30

ItemTradeValues["Dirty Water"] = 10
ItemTradeValues["Water Bottle"] = 20
ItemTradeValues["Water Canister"] = 30
ItemTradeValues["Alcohol Bottle"] = 45

ItemTradeValues["Raw Meat"] = 15
ItemTradeValues["Roasted Meat"] = 30
ItemTradeValues["Raw Human Meat"] = 10
ItemTradeValues["Roasted Human Meat"] = 25

ItemTradeValues["Toolbox"] = 80
ItemTradeValues["Fuel Canister"] = 40
ItemTradeValues["Empty Canister"] = 10
ItemTradeValues["Scrap Metal"] = 10
ItemTradeValues["Rags"] = 15
ItemTradeValues["Empty Bottle"] = 5
ItemTradeValues["Vehicle Parts"] = 35
ItemTradeValues["Plastic Foil"] = 25
ItemTradeValues["Wire"] = 15
ItemTradeValues["Wood"] = 10

ItemTradeValues["Map"] = 25
ItemTradeValues["Survivor Map"] = 30
ItemTradeValues["Military Map"] = 30

ItemTradeValues["Cleaner Kit"] = 600
ItemTradeValues["Peacekeeper Kit"] = 800
ItemTradeValues["Assault Kit"] = 1400
ItemTradeValues["Demolitions Kit"] = 1600
ItemTradeValues["Recon Kit"] = 1200
ItemTradeValues["Support Kit"] = 1100
ItemTradeValues["Combat Medic Kit"]= 1100
ItemTradeValues["Sniper Kit"] = 1800
ItemTradeValues["Agent Kit"] = 2000

ItemTradeValues["Roadrunner Kit"] = 800	
ItemTradeValues["Man Eater Kit"] = 1200
ItemTradeValues["Unburnt Kit"] = 1400	
ItemTradeValues["Pitdog Kit"] = 1800
ItemTradeValues["Berserker Kit"] = 1600
ItemTradeValues["Body Snatcher Kit"] = 1200
ItemTradeValues["Greasemonkey Kit"] = 1000	
ItemTradeValues["Mongrel Kit"] = 600

ItemTradeValues["Citizen Kit"] = 600
ItemTradeValues["Vigilante Kit"] = 800	
ItemTradeValues["Medicine Man Kit"] = 1000		
ItemTradeValues["Militia Kit"] = 1200
ItemTradeValues["Survivalist Kit"] = 1400		
ItemTradeValues["Ranger Kit"] = 1600		

ItemTradeValues["Robber Kit"] = 800		
ItemTradeValues["Highwayman Kit"] = 1000		
ItemTradeValues["Veteran Kit"] = 1200		
ItemTradeValues["Pirate Kit"] = 1200		
ItemTradeValues["Infiltrator Kit"] = 1400		
ItemTradeValues["Saboteur Kit"] = 1400		
ItemTradeValues["Thug Kit"] = 800

ItemTradeValues["Survivor Kit"] = 400	
ItemTradeValues["Traveler Kit"] = 600
ItemTradeValues["Hunter Kit"] = 1200	
ItemTradeValues["Medic Kit"] = 1200
ItemTradeValues["Scavenger Kit"] = 1200
ItemTradeValues["Wastelander Kit"] = 1400
ItemTradeValues["Bounty Hunter Kit"] = 1600

function getItemSellValue(item)
	if ItemTradeValues[item] then
	local item_value = ItemTradeValues[item]-ItemTradeValues[item]/5*2 -- item value when selling is base item value minus two fifths; e.g. selling a map (base value 25) yelds you only 15$; should I add a 'trading' skill/stat that would influence this equation?
	return item_value
	end
end

function sellItemToTrader(item,slot)

triggerServerEvent("RemoveItemInSync",root,slot)
local item_value = getItemSellValue(item)
outputInteractInfo(item.." > +"..tostring(item_value).."$",100,255,100 )
triggerServerEvent("GiveReputation",localPlayer,item_value)

end

addEvent("ReopenTradePanel",true)
addEventHandler("ReopenTradePanel",root, function()
	local visi = guiGetVisible(TradeGui.Tradelabel[1])
	if not visi then
	Open_CloseTrade(trader)
	end
end)

--[[addEventHandler("RefreshDrawTrade",root, function()
Open_CloseTrade(trader)
Open_CloseTrade(trader)
end)]]



------------------------------------
NPC_trade_mode = false
------------------------------------     
function Open_CloseTrade()

local notvisi = guiGetVisible(TradeGui.Tradelabel[1])

if notvisi then NPC_trade_mode = false else NPC_trade_mode = true end
if  not notvisi then iprint("TRADE OPEN\nTRADE OPEN\nTRADEOPEN") else iprint("TRADEXXXXXXXX\nTRADEXXXXXXXX\nTRADEXXXXXXXX") end
iprint(NPC_trade_mode)

if not notvisi and isPedDead(localPlayer) then return end

if getCameraTarget(localPlayer) ~= localPlayer and not notvisi then return end

guiSetText(TradeGui.Tradelabel[3],"")
guiSetText(TradeGui.Tradelabel[4],"")
guiSetText(TradeGui.Tradelabel[5],"")

guiSetVisible(TradeGui.Tradelabel[1],not(notvisi)) 
guiSetVisible(TradeGui.Tradelabel[2],not(notvisi))  
guiSetVisible(TradeGui.Tradelabel[3],not(notvisi))  
guiSetVisible(TradeGui.Tradelabel[4],not(notvisi))  
guiSetVisible(TradeGui.Tradelabel[5],not(notvisi))  
DGS:dgsDxGUISetVisible(TradeGui.button[1],not(notvisi))
DGS:dgsDxGUISetVisible(TradeGui.button[2],not(notvisi))
DGS:dgsDxGUISetVisible(TradeGui.button[3],not(notvisi))
DGS:dgsDxGUISetVisible(TradeGui.button[4],not(notvisi))
DGS:dgsDxGUISetVisible(TradeGui.button[5],not(notvisi))
DGS:dgsDxGUISetVisible(TradeGui.button[6],not(notvisi))
DGS:dgsDxGUISetVisible(TradeGui.button[7],not(notvisi))
DGS:dgsDxGUISetVisible(TradeGui.button[8],not(notvisi))
DGS:dgsDxGUISetVisible(TradeGui.button[9],not(notvisi))

if notvisi then
removeEventHandler("onClientRender",root,drawTrade)
removeEventHandler("onClientRender",root,forceShowCursor)
else
addEventHandler("onClientRender",root,drawTrade)
addEventHandler("onClientRender",root,forceShowCursor)
triggerEvent("showHelpMessageEvent",root,trade_help_messsage)
end

end

--bindKey("n","down","Trading") -- Trade PANEL KEY 
addCommandHandler("Trading",Open_CloseTrade)
addEventHandler("OpenTrade",root,Open_CloseTrade)

function getTradeValues(item)

local sellvalue = getItemSellValue(item)
local tbldescription = TradeItemDescription[item] or " "
local buyvalue = ItemTradeValues[item]
local description
if buyvalue then
description = "Price: "..buyvalue.."$\n"..tbldescription
else
description = " "
end
	
return description 

end

addEventHandler( "onClientDgsDxMouseEnter", root, --draw Trade labels
function()
if not(PlayersTradeItems)then return end
local b1 = PlayersTradeItems[1] or "Empty"
local b2 = PlayersTradeItems[2] or "Empty"
local b3 = PlayersTradeItems[3] or "Empty"
local b4 = PlayersTradeItems[4] or "Empty"
local b5 = PlayersTradeItems[5] or "Empty"
local b6 = PlayersTradeItems[6] or "Empty"
local b7 = PlayersTradeItems[7] or "Empty"
local b8 = PlayersTradeItems[8] or "Empty"
local b9 = PlayersTradeItems[9] or "Empty"

	function getTradingTextbit (item)
	local textbit
		if item == "Empty" then textbit = "" 
		else  textbit = "Buy "
		end
	return textbit
	end

if(source ==TradeGui.button[1]) then
local textbit = getTradingTextbit (b1)
guiSetText(TradeGui.Tradelabel[3],textbit..b1)
guiSetText(TradeGui.Tradelabel[4],textbit..b1)
guiSetText(TradeGui.Tradelabel[5], getTradeValues(tostring(b1)))

elseif(source ==TradeGui.button[2])then
local textbit = getTradingTextbit (b2)
guiSetText(TradeGui.Tradelabel[3],textbit..b2)
guiSetText(TradeGui.Tradelabel[4],textbit..b2)
guiSetText(TradeGui.Tradelabel[5], getTradeValues(tostring(b2)))

elseif(source ==TradeGui.button[3])then
local textbit = getTradingTextbit (b3)
guiSetText(TradeGui.Tradelabel[3],textbit..b3)
guiSetText(TradeGui.Tradelabel[4],textbit..b3)
guiSetText(TradeGui.Tradelabel[5], getTradeValues(tostring(b3)))

elseif(source ==TradeGui.button[4])then
local textbit = getTradingTextbit (b4)
guiSetText(TradeGui.Tradelabel[3],textbit..b4)
guiSetText(TradeGui.Tradelabel[4],textbit..b4)
guiSetText(TradeGui.Tradelabel[5], getTradeValues(tostring(b4)))

elseif(source ==TradeGui.button[5])then
local textbit = getTradingTextbit (b5)
guiSetText(TradeGui.Tradelabel[3],textbit..b5)
guiSetText(TradeGui.Tradelabel[4],textbit..b5)
guiSetText(TradeGui.Tradelabel[5], getTradeValues(tostring(b5)))

elseif(source ==TradeGui.button[6])then
local textbit = getTradingTextbit (b6)
guiSetText(TradeGui.Tradelabel[3],textbit..b6)
guiSetText(TradeGui.Tradelabel[4],textbit..b6)
guiSetText(TradeGui.Tradelabel[5], getTradeValues(tostring(b6)))

elseif(source ==TradeGui.button[7])then
local textbit = getTradingTextbit (b7)
guiSetText(TradeGui.Tradelabel[3],textbit..b7)
guiSetText(TradeGui.Tradelabel[4],textbit..b7)
guiSetText(TradeGui.Tradelabel[5], getTradeValues(tostring(b7)))

elseif(source ==TradeGui.button[8])then
local textbit = getTradingTextbit (b8)
guiSetText(TradeGui.Tradelabel[3],textbit..b8)
guiSetText(TradeGui.Tradelabel[4],textbit..b8)
guiSetText(TradeGui.Tradelabel[5], getTradeValues(tostring(b8)))
	
elseif(source == TradeGui.button[9])then
local textbit = getTradingTextbit (b9)
guiSetText(TradeGui.Tradelabel[3],textbit..b9)
guiSetText(TradeGui.Tradelabel[4],textbit..b9)
guiSetText(TradeGui.Tradelabel[5], getTradeValues(tostring(b9)))
	
end
end)

function TradeButtonsTriggers(botao,estado)
	
	if estado == "up" then return end

local buyvalue = ItemTradeValues[item]
	
local b1 = PlayersTradeItems[1] 
local b2 = PlayersTradeItems[2] 
local b3 = PlayersTradeItems[3] 
local b4 = PlayersTradeItems[4] 
local b5 = PlayersTradeItems[5] 
local b6 = PlayersTradeItems[6] 
local b7 = PlayersTradeItems[7] 
local b8 = PlayersTradeItems[8] 
local b9 = PlayersTradeItems[9] 

	if(source == TradeGui.button[1]) then
		if(b1 and b1~="Empty")then
			local buyvalue = ItemTradeValues[b1]
			triggerServerEvent("onPlayerBuyItem", localPlayer,b1,buyvalue)
			--Open_CloseTrade()
		end
	elseif(source == TradeGui.button[2]) then
		if(b2 and b2~="Empty")then
			local buyvalue = ItemTradeValues[b2]
			triggerServerEvent("onPlayerBuyItem", localPlayer,b2,buyvalue)
			--Open_CloseTrade()
		end
	elseif(source == TradeGui.button[3]) then
		if(b3 and b3~="Empty")then
			local buyvalue = ItemTradeValues[b3]
			triggerServerEvent("onPlayerBuyItem", localPlayer,b3,buyvalue)
			--Open_CloseTrade()
		end
	elseif(source == TradeGui.button[4]) then
		if(b4 and b4~="Empty")then
			local buyvalue = ItemTradeValues[b4]
			triggerServerEvent("onPlayerBuyItem", localPlayer,b4,buyvalue)
			--Open_CloseTrade()
		end
	elseif(source == TradeGui.button[5]) then
		if(b5 and b5~="Empty")then
			local buyvalue = ItemTradeValues[b5]
			triggerServerEvent("onPlayerBuyItem", localPlayer,b5,buyvalue)
			--Open_CloseTrade()
		end
	elseif(source == TradeGui.button[6]) then
		if(b6 and b6~="Empty")then
			local buyvalue = ItemTradeValues[b6]
			triggerServerEvent("onPlayerBuyItem", localPlayer,b6,buyvalue)
			--Open_CloseTrade()
		end
	elseif(source == TradeGui.button[7]) then
		if(b7 and b7~="Empty")then
			local buyvalue = ItemTradeValues[b7]
			triggerServerEvent("onPlayerBuyItem", localPlayer,b7,buyvalue)
			--Open_CloseTrade()
		end
	elseif(source == TradeGui.button[8]) then
		if(b8 and b8~="Empty")then
			local buyvalue = ItemTradeValues[b8]
			triggerServerEvent("onPlayerBuyItem", localPlayer,b8,buyvalue)
			--Open_CloseTrade()
		end
	elseif(source == TradeGui.button[9]) then
		if(b9 and b9~="Empty")then
			local buyvalue = ItemTradeValues[b9]
			triggerServerEvent("onPlayerBuyItem", localPlayer,b9,buyvalue)
			--Open_CloseTrade()
		end

	end

end
addEventHandler("onClientDgsDxMouseClick", root,TradeButtonsTriggers)