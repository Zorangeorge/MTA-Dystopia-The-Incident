---------------------Craft interface & co.---------clones manawydan's inventory-----------------------
addEvent("synchronizeCraft",true)
addEvent("RefreshDrawCraft",true)
addEvent("OpenCraft",true)

local screenWidth, screenHeight = guiGetScreenSize ( )

CraftGui = {
    button = {},
    craftlabel = {}
}

--[[        CraftGui.button[1] = DGS:dgsDxCreateButton(198+600, 176, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10) --original button positions
        DGS:dgsDxGUISetAlpha(CraftGui.button[1], 0.87)
        CraftGui.button[2] = DGS:dgsDxCreateButton(282+600, 176, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(CraftGui.button[2], 0.87)
        CraftGui.button[3] = DGS:dgsDxCreateButton(366+600, 176, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(CraftGui.button[3], 0.87)
        CraftGui.button[4] = DGS:dgsDxCreateButton(198+600, 259, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(CraftGui.button[4], 0.87)
        CraftGui.button[5] = DGS:dgsDxCreateButton(282+600, 259, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(CraftGui.button[5], 0.87)
        CraftGui.button[6] = DGS:dgsDxCreateButton(366+600, 259, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(CraftGui.button[6], 0.87)
        CraftGui.button[7] = DGS:dgsDxCreateButton(198+600, 342, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(CraftGui.button[7], 0.87)
        CraftGui.button[8] = DGS:dgsDxCreateButton(282+600, 342, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(CraftGui.button[8], 0.87)
        CraftGui.button[9] = DGS:dgsDxCreateButton(366+600, 342, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(CraftGui.button[9], 0.87)]]
		
		CraftGui.button[1] = DGS:dgsDxCreateButton(198+330, 176, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(CraftGui.button[1], 0.87)
        CraftGui.button[2] = DGS:dgsDxCreateButton(282+330, 176, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(CraftGui.button[2], 0.87)
        CraftGui.button[3] = DGS:dgsDxCreateButton(366+330, 176, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(CraftGui.button[3], 0.87)
        CraftGui.button[4] = DGS:dgsDxCreateButton(198+330, 259, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(CraftGui.button[4], 0.87)
        CraftGui.button[5] = DGS:dgsDxCreateButton(282+330, 259, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(CraftGui.button[5], 0.87)
        CraftGui.button[6] = DGS:dgsDxCreateButton(366+330, 259, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(CraftGui.button[6], 0.87)
        CraftGui.button[7] = DGS:dgsDxCreateButton(198+330, 342, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(CraftGui.button[7], 0.87)
        CraftGui.button[8] = DGS:dgsDxCreateButton(282+330, 342, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(CraftGui.button[8], 0.87)
        CraftGui.button[9] = DGS:dgsDxCreateButton(366+330, 342, 78, 78, " ", false,nil,0xFFFFFFFF,1,1,slotTex1,slotTex2,slotTex3,0xFFFFFF10,0xFFFFFF10,0xFFFFFF10)
        DGS:dgsDxGUISetAlpha(CraftGui.button[9], 0.87)
				
		CraftGui.craftlabel[1] = guiCreateLabel(197+330, 149, 267, 60, "Craft", false) -- title shadow
		CraftGui.craftlabel[2] = guiCreateLabel(198+330, 150, 267, 60, "Craft", false) -- title
		guiSetAlpha(CraftGui.craftlabel[1], 0.87)
		guiLabelSetColor(CraftGui.craftlabel[1], 0,0,0)
		guiSetAlpha(CraftGui.craftlabel[2], 0.87)
		guiSetFont(CraftGui.craftlabel[2], ChunkfiveFont)
		guiSetFont(CraftGui.craftlabel[1], ChunkfiveFont)
		
		CraftGui.craftlabel[3] = guiCreateLabel(197+330, 426, 270, 32, "", false) --item name shadow
		guiLabelSetColor(CraftGui.craftlabel[3], 0,0,0)
		guiSetAlpha(CraftGui.craftlabel[3], 0.87)
        CraftGui.craftlabel[4] = guiCreateLabel(198+330, 427, 270, 32, "", false) --item name
		guiSetAlpha(CraftGui.craftlabel[4], 0.87)
		CraftGui.craftlabel[5] = guiCreateLabel(198+330, 448, 270, 150, "", false) --item description
		guiSetFont(CraftGui.craftlabel[3], ChunkfiveFont)
		guiSetFont(CraftGui.craftlabel[4], ChunkfiveFont)
		guiSetFont(CraftGui.craftlabel[5], "default-bold-small") 
        
guiSetVisible(CraftGui.craftlabel[1],false) 
guiSetVisible(CraftGui.craftlabel[2],false) 
guiSetVisible(CraftGui.craftlabel[3],false) 
guiSetVisible(CraftGui.craftlabel[4],false) 
guiSetVisible(CraftGui.craftlabel[5],false) 
DGS:dgsDxGUISetVisible(CraftGui.button[1],false)
DGS:dgsDxGUISetVisible(CraftGui.button[2],false)
DGS:dgsDxGUISetVisible(CraftGui.button[3],false)
DGS:dgsDxGUISetVisible(CraftGui.button[4],false)
DGS:dgsDxGUISetVisible(CraftGui.button[5],false)
DGS:dgsDxGUISetVisible(CraftGui.button[6],false)
DGS:dgsDxGUISetVisible(CraftGui.button[7],false)
DGS:dgsDxGUISetVisible(CraftGui.button[8],false)
DGS:dgsDxGUISetVisible(CraftGui.button[9],false)
--guiSetVisible(CraftGui.craftlabel[1],false)
--guiSetVisible(CraftGui.craftlabel[2],false)

PlayersCraftItems={} 
--carTable = {"Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty"} 
buildmode = false

function crafttablesynchronize(table_)
PlayersCraftItems = table_
triggerServerEvent("synchronizeCraftServer",localPlayer,table_)
end
addEventHandler("synchronizeCraft",root,crafttablesynchronize)

function assesPlayerCraftingResources()

local crafttable = {}
local wood, wood_slot = hasPlayerItem_c ("Wood", localPlayer)
local metal, metal_slot = hasPlayerItem_c ("Scrap Metal", localPlayer)
local wire, wire_slot = hasPlayerItem_c ("Wire", localPlayer)
local rags, rags_slot = hasPlayerItem_c ("Rags", localPlayer)

	if hasPlayerItem_c ("Wood", localPlayer) then
		
		local wood,woodslot = hasPlayerItem_c ("Wood", localPlayer)
		
		if hasPlayerItem_c ("Scrap Metal", localPlayer) then
		table.insert(crafttable,"Nail Bat")
		table.insert(crafttable,"Bolts")
		end
		
		if hasPlayerItem_c ("Scrap Metal", localPlayer) and hasPlayerItem_c ("Wire", localPlayer) then
		table.insert(crafttable,"Crossbow")
		end
		
		if hasPlayerItem_c ("Wire", localPlayer) and hasPlayerItem_c ("Fuel Canister", localPlayer) and hasPlayerItem_c ("Wood", localPlayer)then
		table.insert(crafttable,"Incendiary Trap")
		end
		
		if hasPlayerItem_c ("Wire", localPlayer) and hasPlayerItem_c ("Broken Bottle", localPlayer) and hasPlayerItem_c ("Wood", localPlayer)then
		table.insert(crafttable,"Shards Trap")
		end
		
		if hasPlayerItem_c ("Empty Bottle", localPlayer) then
		local bottles,bottleslot =  hasPlayerItem_c ("Empty Bottle", localPlayer)
		if bottles >= 2 then
		table.insert(crafttable,"Shards Trap")
		end
		end
		
		if hasPlayerItem_c ("Bandage", localPlayer) then
		table.insert(crafttable,"Splint")
		end
		
		if wood >=2 then
		table.insert(crafttable,"Barricade")
		end
		
		if wood >=4 then
			local met,metslot = hasPlayerItem_c ("Scrap Metal", localPlayer)
			if met and met>=2 then
			table.insert(crafttable,"Shelter")
			end
		end
		
	end
	
	if hasPlayerItem_c ("Scrap Metal", localPlayer) then
	 local metal, metal_slot = hasPlayerItem_c ("Scrap Metal", localPlayer)
			
			if metal and metal >=2 then
				
				local rags, rags_slot = hasPlayerItem_c ("Rags", localPlayer)
				if rags then
					table.insert(crafttable,"Raider Sword")
				end
				
				if hasPlayerItem_c ("Wire", localPlayer) then
					table.insert(crafttable,"Wire Fence")
				end
			end
			
			if metal and metal >=3 then
				
				local rags, rags_slot = hasPlayerItem_c ("Rags", localPlayer)
				if rags and rags>=2 then
					table.insert(crafttable,"Bed")
				end
			end
					
	end

	
	if hasPlayerItem_c ("Rags", localPlayer) and hasPlayerItem_c ("Alcohol Bottle", localPlayer) then
			
		table.insert(crafttable,"Bandage")
		table.insert(crafttable,"Molotov")
			
	end 
	
	if hasPlayerItem_c ("Rags", localPlayer)then
	local rags, rags_slot = hasPlayerItem_c ("Rags", localPlayer)
		if rags >= 2 then
		local wire, wire_slot = hasPlayerItem_c ("Wire", localPlayer)
				if wire then
				table.insert(crafttable,"Backpack")
				end
		end
		if rags >= 3 then
		table.insert(crafttable,"Camouflage Suit")
		end
	end
	
	if hasPlayerItem_c ("Empty Bottle", localPlayer)  then
		table.insert(crafttable,"Broken Bottle")
	end 
	
	if hasPlayerItem_c ("Raw Meat", localPlayer) and getElementData(localPlayer,"infirecol") then
	
	table.insert(crafttable,"Roasted Meat")
	
	end

	if hasPlayerItem_c ("Raw Human Meat", localPlayer) and getElementData(localPlayer,"infirecol") then
	
	table.insert(crafttable,"Roasted Human Meat")

	end
	
	if hasPlayerItem_c ("Dirty Water", localPlayer) and getElementData(localPlayer,"infirecol") then
	
	table.insert(crafttable,"Water Bottle")

	end
	
	if hasPlayerItem_c ("Plastic Foil", localPlayer) and hasPlayerItem_c ("Wire", localPlayer) then
	table.insert(crafttable,"Stockpile")
	end

	table.insert(crafttable,9,"Build")
	
crafttablesynchronize(crafttable)
return crafttable

end

function assesPlayerBuildingCategories()

local crafttable = {}
table.insert(crafttable,"Wood Objects")
table.insert(crafttable,"Metal Objects")
table.insert(crafttable,"Structures")
table.insert(crafttable,"Special")
crafttablesynchronize(crafttable)
return crafttable

end

function assesPlayerBuildingCategories()

local crafttable = {}
table.insert(crafttable,"Wood Objects")
table.insert(crafttable,"Metal Objects")
table.insert(crafttable,"Structures")
table.insert(crafttable,"Special")
crafttablesynchronize(crafttable)
return crafttable

end

function drawCraft()

if not(PlayersCraftItems)then return end
if getElementData(localPlayer,"infirecol") then guiSetText ( CraftGui.craftlabel[1], "Cook'n'Craft" ); guiSetText ( CraftGui.craftlabel[2], "Cook'n'Craft" ) else guiSetText ( CraftGui.craftlabel[1], "Craft" ); guiSetText ( CraftGui.craftlabel[2], "Craft" ) end

	if not buildmode then
		assesPlayerCraftingResources() --calculating what the player can craft from the ingredients he has in inventory 
	elseif buildmode == 0 then -- if build level is 'categories' 
		assesPlayerBuildingCategories()
	elseif buildmode == 1 then -- if build level is 'Wood Objects' 
		--assesPlayerAvailableWoodBuildingObjects()
	elseif buildmode == 2 then -- if build level is 'Metal Objects' 
		--assesPlayerAvailableMetalBuildingObjects()
	elseif buildmode == 3 then -- if build level is 'Structures' 
		--assesPlayerAvailableStructuresBuildingObjects()
	elseif buildmode == 4 then -- if build level is 'Special Objects' 
		--assesPlayerAvailableSpecialBuildingObjects()
	end
	
	if buildmode then
		guiSetText ( CraftGui.craftlabel[1], "Build" ) 
		guiSetText ( CraftGui.craftlabel[2], "Build" )
	end
	
crafttablesynchronize(PlayersCraftItems)

local b1 = PlayersCraftItems[1] 
local b2 = PlayersCraftItems[2] 
local b3 = PlayersCraftItems[3] 
local b4 = PlayersCraftItems[4] 
local b5 = PlayersCraftItems[5] 
local b6 = PlayersCraftItems[6] 
local b7 = PlayersCraftItems[7] 
local b8 = PlayersCraftItems[8] 
local b9 = PlayersCraftItems[9] 

if(b1 and b1~="Empty")then
dxDrawImage(205+330, 186, 61, 51, "icons/"..b1..".png", 0, 0, 0, tocolor(255, 255, 255, 150), true)
end
if(b2 and b2~="Empty")then
dxDrawImage(292+330, 186, 61, 51, "icons/"..b2..".png", 0, 0, 0, tocolor(255, 255, 255, 150), true)
end
if(b3 and b3~="Empty")then
dxDrawImage(376+330, 186, 61, 51, "icons/"..b3..".png", 0, 0, 0, tocolor(255, 255, 255, 150), true)
end
if(b4 and b4~="Empty")then
dxDrawImage(205+330, 269, 61, 51, "icons/"..b4..".png", 0, 0, 0, tocolor(255, 255, 255, 150), true)
end
if(b5 and b5~="Empty")then
dxDrawImage(292+330, 269, 61, 51, "icons/"..b5..".png", 0, 0, 0, tocolor(255, 255, 255, 150), true)
end
if(b6 and b6~="Empty") then
dxDrawImage(373+330, 269, 61, 51, "icons/"..b6..".png", 0, 0, 0, tocolor(255, 255, 255, 150), true)
end
if(b7 and b7~="Empty")then
dxDrawImage(208+330, 352, 61, 51, "icons/"..b7..".png", 0, 0, 0, tocolor(255, 255, 255, 150), true)
end
if(b8 and b8~="Empty")then
dxDrawImage(289+330, 352, 61, 51, "icons/"..b8..".png", 0, 0, 0, tocolor(255, 255, 255, 150), true)
end
if(b9 and b9~="Empty")then
dxDrawImage(373+330, 352, 61, 51, "icons/"..b9..".png", 0, 0, 0, tocolor(255, 255, 255, 150), true)

end
end

addEventHandler("RefreshDrawCraft",root,
function()
Open_CloseCraft()
Open_CloseCraft()
end)
        
function Open_CloseCraft(message)

local visi = guiGetVisible(CraftGui.craftlabel[1])
if not visi and isPedDead(localPlayer) then return end
if getCameraTarget(localPlayer) ~= localPlayer and not visi then return end

--[[	if message and message ~= "noMessagePls" then -- what the hell 
	
		local crafttable = assesPlayerCraftingResources()
		
		if #crafttable<1 then 
		--outputTopBar("Ingredients required", 240,240,240)
		outputInteractInfo("[ingredients required]", 240, 240, 240) 
		--return
		end
	end
	]]

guiSetText(CraftGui.craftlabel[3],"")
guiSetText(CraftGui.craftlabel[4],"")
guiSetText(CraftGui.craftlabel[5],"")

guiSetVisible(CraftGui.craftlabel[1],not(visi)) 
guiSetVisible(CraftGui.craftlabel[2],not(visi))  
guiSetVisible(CraftGui.craftlabel[3],not(visi))  
guiSetVisible(CraftGui.craftlabel[4],not(visi))  
guiSetVisible(CraftGui.craftlabel[5],not(visi))  
DGS:dgsDxGUISetVisible(CraftGui.button[1],not(visi))
DGS:dgsDxGUISetVisible(CraftGui.button[2],not(visi))
DGS:dgsDxGUISetVisible(CraftGui.button[3],not(visi))
DGS:dgsDxGUISetVisible(CraftGui.button[4],not(visi))
DGS:dgsDxGUISetVisible(CraftGui.button[5],not(visi))
DGS:dgsDxGUISetVisible(CraftGui.button[6],not(visi))
DGS:dgsDxGUISetVisible(CraftGui.button[7],not(visi))
DGS:dgsDxGUISetVisible(CraftGui.button[8],not(visi))
DGS:dgsDxGUISetVisible(CraftGui.button[9],not(visi))

if visi then
removeEventHandler("onClientRender",root,drawCraft)
removeEventHandler("onClientRender",root,forceShowCursor)
buildmode = false
else
addEventHandler("onClientRender",root,drawCraft)
addEventHandler("onClientRender",root,forceShowCursor)
end
end

bindKey("j","down","Crafting") -- THIS IS THE CRAFT PANEL KEY 
addCommandHandler("Crafting",Open_CloseCraft)
addEventHandler("OpenCraft",root,Open_CloseCraft)

function getCraftingDescription(item)
local description
	if item == "Water Bottle" then description = "\nRequired:\nDirty Water"
	elseif item == "Roasted Meat" then description = "\nRequired:\nRaw Meat"
	elseif item == "Roasted Human Meat" then description = "\nRequired:\nRaw Human Meat"
	elseif item == "Crossbow" then description = "\nRequired:\nWood\nScrap Metal\nWire"
	elseif item == "Nail Bat" then description = "\nRequired:\nWood\nScrap Metal"
	elseif item == "Bolts" then description = "\nRequired:\nWood\nScrap Metal"
	elseif item == "Splint" then description = "\nRequired:\nWood\nBandage"
	elseif item == "Bandage" then description = "\nRequired:\nRags\nAlcohol Bottle"
	elseif item == "Molotov" then description = "\nRequired:\nRags\nAlcohol Bottle"
	elseif item == "Camouflage Suit" then description = "\nRequired:\n3x Rags"
	elseif item == "Stockpile" then description = "\nRequired:\nPlastic Foil\nWire"
	elseif item == "Broken Bottle" then description = "\nRequired:\nEmpty Bottle"
	elseif item == "Shards Trap" then description = "\nRequired:\Broken Bottle\nWood\nWire"
	elseif item == "Incendiary Trap" then description = "\nRequired:\nFuel Canister\nWood\nWire"
	elseif item == "Backpack" then description = "\nRequired:\n2x Rags\nWire"
	elseif item == "Barricade" then description = "\nRequired:\n2x Wood"
	elseif item == "Wire Fence" then description = "\nRequired:\n2x Scrap Metal\nWire"
	else description = ""
	end
return description
end

addEventHandler( "onClientDgsDxMouseEnter", root, --draw Craft labels

function()
if not(PlayersCraftItems)then return end
local b1 = PlayersCraftItems[1] or "Empty"
local b2 = PlayersCraftItems[2] or "Empty"
local b3 = PlayersCraftItems[3] or "Empty"
local b4 = PlayersCraftItems[4] or "Empty"
local b5 = PlayersCraftItems[5] or "Empty"
local b6 = PlayersCraftItems[6] or "Empty"
local b7 = PlayersCraftItems[7] or "Empty"
local b8 = PlayersCraftItems[8] or "Empty"
local b9 = PlayersCraftItems[9] or "Empty"

	if(source ==CraftGui.button[1]) then
	guiSetText(CraftGui.craftlabel[3],b1)
	guiSetText(CraftGui.craftlabel[4],b1)
	guiSetText(CraftGui.craftlabel[5], getCraftingDescription(tostring(b1)))

	elseif(source ==CraftGui.button[2])then
	guiSetText(CraftGui.craftlabel[3],b2)
	guiSetText(CraftGui.craftlabel[4],b2)
	guiSetText(CraftGui.craftlabel[5], getCraftingDescription(tostring(b2)))

	elseif(source ==CraftGui.button[3])then
	guiSetText(CraftGui.craftlabel[3],b3)
	guiSetText(CraftGui.craftlabel[4],b3)
	guiSetText(CraftGui.craftlabel[5], getCraftingDescription(tostring(b3)))

	elseif(source ==CraftGui.button[4])then
	guiSetText(CraftGui.craftlabel[3],b4)
	guiSetText(CraftGui.craftlabel[4],b4)
	guiSetText(CraftGui.craftlabel[5], getCraftingDescription(tostring(b4)))

	elseif(source ==CraftGui.button[5])then
	guiSetText(CraftGui.craftlabel[3],b5)
	guiSetText(CraftGui.craftlabel[4],b5)
	guiSetText(CraftGui.craftlabel[5], getCraftingDescription(tostring(b5)))

	elseif(source ==CraftGui.button[6])then
	guiSetText(CraftGui.craftlabel[3],b6)
	guiSetText(CraftGui.craftlabel[4],b6)
	guiSetText(CraftGui.craftlabel[5], getCraftingDescription(tostring(b6)))

	elseif(source ==CraftGui.button[7])then
	guiSetText(CraftGui.craftlabel[3],b7)
	guiSetText(CraftGui.craftlabel[4],b7)
	guiSetText(CraftGui.craftlabel[5], getCraftingDescription(tostring(b7)))

	elseif(source ==CraftGui.button[8])then
	guiSetText(CraftGui.craftlabel[3],b8)
	guiSetText(CraftGui.craftlabel[4],b8)
	guiSetText(CraftGui.craftlabel[5], getCraftingDescription(tostring(b8)))
		
	elseif(source == CraftGui.button[9])then
	guiSetText(CraftGui.craftlabel[3],b9)
	guiSetText(CraftGui.craftlabel[4],b9)
	guiSetText(CraftGui.craftlabel[5], getCraftingDescription(tostring(b9)))
		
	end
	
end)

function CraftButtonsTriggers(botao,estado)
	
	if estado == "up" then return end
	
local b1 = PlayersCraftItems[1] 
local b2 = PlayersCraftItems[2] 
local b3 = PlayersCraftItems[3] 
local b4 = PlayersCraftItems[4] 
local b5 = PlayersCraftItems[5] 
local b6 = PlayersCraftItems[6] 
local b7 = PlayersCraftItems[7] 
local b8 = PlayersCraftItems[8] 
local b9 = PlayersCraftItems[9] 

	if(source == CraftGui.button[1]) then
		if(b1 and b1~="Empty")then
				if b1 == "Wood Objects" then 
				PlayersCraftItems = {"Wood Panel","Wood Fence","Wood Platform","Wood Ladder","Wood Steps","Wood Chair","Wood Table","Wood Sign","Wood Door"} 
				buildmode = 1 
				return 	
				end		
			if(botao == "left")then
			triggerServerEvent("onPlayerActivateCraftItem", localPlayer,b1,1)
			elseif(botao == "right")then
			triggerServerEvent("onPlayerRetrieveCraftItem", localPlayer,b1,1)
			elseif(botao == "middle")then
			triggerServerEvent("onPlayerToggleCraftItem", localPlayer,b1,1)
			end
			Open_CloseCraft()
		end
		
	elseif(source == CraftGui.button[2]) then
		if(b2 and b2~="Empty")then
			if b2 == "Metal Objects" then 
			buildmode = 2 
			PlayersCraftItems = {"Metal Fence","Metal Barbed Fence","Metal Panel","Metal Grate","Metal Plank","Metal Barrier","Metal Strong Fence","Metal Door","Metal Wall"} 
			return	
			end
			if(botao == "left")then
			triggerServerEvent("onPlayerActivateCraftItem", localPlayer,b2,2)
			elseif(botao == "right")then
			triggerServerEvent("onPlayerRetrieveCraftItem", localPlayer,b2,2)
			elseif(botao == "middle")then
			triggerServerEvent("onPlayerToggleCraftItem", localPlayer,b2,2)
			end
			Open_CloseCraft()
		end
		
	elseif(source == CraftGui.button[3]) then
		if(b3 and b3~="Empty")then
			if b3 == "Structures" then 
			PlayersCraftItems = {"Gate","Shelter","Hut Structure","Outhouse","Scaffold","Reinforced Scaffold","Scaffold Tower","Small Cabin","Large Cabin"} 
			buildmode = 3 
			return 
			end
			if(botao == "left")then
			triggerServerEvent("onPlayerActivateCraftItem", localPlayer,b3,3)
			elseif(botao == "right")then
			triggerServerEvent("onPlayerRetrieveCraftItem", localPlayer,b3,3)
			elseif(botao == "middle")then
			triggerServerEvent("onPlayerToggleCraftItem", localPlayer,b3,3)
			end
			Open_CloseCraft()
		end
		
	elseif(source == CraftGui.button[4]) then
		if(b4 and b4~="Empty")then
			if b4 == "Special" then 
			PlayersCraftItems = {"Fire Bin","Bed","Storage","Workbench","Large Storage","Fish Trap","Potato Farm","Critter Pen","Trading Post"}
			buildmode = 4 
			return 
			end
			if(botao == "left")then
			triggerServerEvent("onPlayerActivateCraftItem", localPlayer,b4,4)
			elseif(botao == "right")then
			triggerServerEvent("onPlayerRetrieveCraftItem", localPlayer,b4,4)
			elseif(botao == "middle")then
			triggerServerEvent("onPlayerToggleCraftItem", localPlayer,b4,4)
			end
			Open_CloseCraft()
		end
		
	elseif(source == CraftGui.button[5]) then
		if(b5 and b5~="Empty")then
			if(botao == "left")then
			triggerServerEvent("onPlayerActivateCraftItem", localPlayer,b5,5)
			elseif(botao == "right")then
			triggerServerEvent("onPlayerRetrieveCraftItem", localPlayer,b5,5)
			elseif(botao == "middle")then
			triggerServerEvent("onPlayerToggleCraftItem", localPlayer,b5,5)
			end
			Open_CloseCraft()
		end
	elseif(source == CraftGui.button[6]) then
		if(b6 and b6~="Empty")then
			if(botao == "left")then
			triggerServerEvent("onPlayerActivateCraftItem", localPlayer,b6,6)
			elseif(botao == "right")then
			triggerServerEvent("onPlayerRetrieveCraftItem", localPlayer,b6,6)
			elseif(botao == "middle")then
			triggerServerEvent("onPlayerToggleCraftItem", localPlayer,b6,6)
			end
			Open_CloseCraft()
		end
	elseif(source == CraftGui.button[7]) then
		if(b7 and b7~="Empty")then
			if(botao == "left")then
			triggerServerEvent("onPlayerActivateCraftItem", localPlayer,b7,7)
			elseif(botao == "right")then
			triggerServerEvent("onPlayerRetrieveCraftItem", localPlayer,b7,7)
			elseif(botao == "middle")then
			triggerServerEvent("onPlayerToggleCraftItem", localPlayer,b7,7)
			end
			Open_CloseCraft()
		end
	elseif(source == CraftGui.button[8]) then
		if(b8 and b8~="Empty")then
			if(botao == "left")then
			triggerServerEvent("onPlayerActivateCraftItem", localPlayer,b8,8)
			elseif(botao == "right")then
			triggerServerEvent("onPlayerRetrieveCraftItem", localPlayer,b8,8)
			elseif(botao == "middle")then
			triggerServerEvent("onPlayerToggleCraftItem", localPlayer,b8,8)
			end
			Open_CloseCraft()
		end
	elseif(source == CraftGui.button[9]) then
	
		if b9 == "Build" then
			outputInteractInfo("[ build mode ]", 240,240,240 )
			buildmode = 0
			return
		end
		
		if(b9 and b9~="Empty")then
			if(botao == "left")then
			triggerServerEvent("onPlayerActivateCraftItem", localPlayer,b9,9)
			elseif(botao == "right")then
			triggerServerEvent("onPlayerRetrieveCraftItem", localPlayer,b9,9)
			elseif(botao == "middle")then
			triggerServerEvent("onPlayerToggleCraftItem", localPlayer,b9,9)
			
			end
			
			Open_CloseCraft()
			
		end

	end
	


end
addEventHandler("onClientDgsDxMouseClick", root,CraftButtonsTriggers)

function returnPlayerCraftItemSlot(item, p) --returns Craft slot it occupies, takes a string: "item name"

local slot = nil
local b1 = PlayersCraftItems[p][1] or false
local b2 = PlayersCraftItems[p][2] or false
local b3 = PlayersCraftItems[p][3] or false
local b4 = PlayersCraftItems[p][4] or false
local b5 = PlayersCraftItems[p][5] or false
local b6 = PlayersCraftItems[p][6] or false
local b7 = PlayersCraftItems[p][7] or false
local b8 = PlayersCraftItems[p][8] or false
local b9 = PlayersCraftItems[p][9] or false

if 	   b1 == item then slot = 1 
elseif b2 == item then slot = 2 
elseif b3 == item then slot = 3 
elseif b4 == item then slot = 4 
elseif b5 == item then slot = 5 
elseif b6 == item then slot = 6 
elseif b7 == item then slot = 7 
elseif b8 == item then slot = 8 
elseif b9 == item then slot = 9 
--else return nil; outputChatBox("nil")
end
return slot
end

function hasPlayerCraftItem_c (item, p) --returns number of (certain) items, takes a string: "item name"

local itemcount = 0
local b1 = PlayersCraftItems[p][1] or false
local b2 = PlayersCraftItems[p][2] or false
local b3 = PlayersCraftItems[p][3] or false
local b4 = PlayersCraftItems[p][4] or false
local b5 = PlayersCraftItems[p][5] or false
local b6 = PlayersCraftItems[p][6] or false
local b7 = PlayersCraftItems[p][7] or false
local b8 = PlayersCraftItems[p][8] or false
local b9 = PlayersCraftItems[p][9] or false

if b1 == item then itemcount = itemcount + 1 end
if b2 == item then itemcount = itemcount + 1 end
if b3 == item then itemcount = itemcount + 1 end
if b4 == item then itemcount = itemcount + 1 end
if b5 == item then itemcount = itemcount + 1 end
if b6 == item then itemcount = itemcount + 1 end
if b7 == item then itemcount = itemcount + 1 end
if b8 == item then itemcount = itemcount + 1 end
if b9 == item then itemcount = itemcount + 1 end

--outputChatBox("Number of items: "..itemcount, p, 0,0,0)

if itemcount > 0 then  return itemcount end -- and
					  
if itemcount == 0  then return false end 

end
