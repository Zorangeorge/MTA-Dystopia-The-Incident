local sx, sy = guiGetScreenSize()
local dgs = exports.dgs

local WindowStrongbox = dgs:dgsCreateWindow(198+330, 176, 250, 300, " ", false, nil, 3, slotTex1, nil, nil, tocolor(0,0,0,210), nil, true)--Strongbox window
dgs:dgsWindowSetSizable(WindowStrongbox, false)
dgs:dgsDxGUISetVisible(WindowStrongbox, false)
dgs:dgsSetFont(WindowStrongbox,"pricedown")

local GridlistItems = dgs:dgsCreateGridList(0.04, 0.06, 0.92, 0.72, true, WindowStrongbox, 40, 0x96141414, 0x96141414, 0x96141414, tocolor(219, 67, 59), tocolor(219, 67, 59), tocolor(219, 150, 120),slotTex1)
dgs:dgsGridListAddColumn(GridlistItems, "", 0.9)
dgs:dgsDxGUISetProperty(GridlistItems,"sorting", true)

local window_title = dgs:dgsCreateLabel(0.04, -0.01, 0.9, 0.1, "Strongbox", true, GridlistItems)
dgs:dgsLabelSetHorizontalAlign(window_title, "center")

local Label = dgs:dgsCreateLabel(0.04, 1, 0.9, 0.1, "Slots: 0/0", true, GridlistItems)
dgs:dgsLabelSetHorizontalAlign(Label, "center")

local Take = dgs:dgsCreateButton(0.04, 0.88, 0.92, 0.09, "Take", true, WindowStrongbox, nil, nil, nil, nil, nil, nil, tocolor(219, 67, 59), tocolor(219+30, 67+30, 59+30), tocolor(219, 67, 59))

dgs:dgsSetFont(Take,"pricedown")
dgs:dgsSetFont(Label,"pricedown")
dgs:dgsSetFont(window_title,"pricedown")

--[[local playerList = DGS:dgsCreateGridList (0.04, 0.06, 0.92, 0.72, true, WindowStrongbox )  --Create the grid list element
local column = DGS:dgsGridListAddColumn( playerList, "Player", 0.5 )  --Create a players column in the list
for id, player in ipairs(getElementsByType("player")) do
	local row = DGS:dgsGridListAddRow ( playerList )
	DGS:dgsGridListSetItemText ( playerList, row, column, getPlayerName ( player ) )
end ]]

addEvent("strongbox.window", true)
addEventHandler("strongbox.window", root,
	function (items, slots)
	--if not getPedOccupiedVehicle(localPlayer) then
	if isPlayerUsingStockpile() then return end
		if not items then
			dgs:dgsDxGUISetVisible(WindowStrongbox, false)
			return
		end

		if isInventoryOpen and not dgs:dgsDxGUIGetVisible(WindowStrongbox) then
			local items = fromJSON(items)
			dgs:dgsDxGUISetVisible(WindowStrongbox, true)
			dgs:dgsDxGridListClearRow(GridlistItems)
			for i,item in ipairs (items) do
				local row = dgs:dgsDxGridListAddRow(GridlistItems)
				dgs:dgsDxGridListSetItemText(GridlistItems, row, 1, item)
				--dgs:dgsDxGridListSetItemColor(GridlistItems, row, 1, "#db433b")
			end
			dgs:dgsDxGUISetText(Label, "Slots: "..(#items).."/"..(slots))
		else
			dgs:dgsDxGUISetVisible(WindowStrongbox, false)
		end
		local x,y,z = getElementPosition(localPlayer)
		setTimer(playSound3D,400,1,"sounds/lock.mp3", x, y, z, false)
	end
	--end
)

addEvent("RefreshDraw", true)
addEventHandler("RefreshDraw", root,
	function (cType, t, slots)
		if not cType == "strongbox" then return end
		if t and dgs:dgsDxGUIGetVisible(WindowStrongbox) then
			dgs:dgsDxGUISetVisible(WindowStrongbox, true)
			dgs:dgsDxGridListClearRow(GridlistItems)
			for i,item in ipairs (t) do
				theNewRow = dgs:dgsDxGridListAddRow(GridlistItems)
				dgs:dgsDxGridListSetItemText(GridlistItems, theNewRow, 1, item)
			end
			dgs:dgsDxGUISetText(Label, "Slots: "..(#t).."/"..(slots))
		end
	end
)

local cooldown
addEventHandler("onClientDgsDxMouseClick", root,
	function (button, state)
		if cooldown then
			outputTopBar("Please wait a second", 240,200,0)
			return
		end
		if source == Take and state == "down" then
			local selected = dgs:dgsDxGridListGetSelectedItem(GridlistItems)
			if selected and selected ~= -1 then 
				local output = dgs:dgsDxGridListGetItemText(GridlistItems, selected, 1)
				exports.dgs:dgsDxGridListRemoveRow(GridlistItems, selected)
				triggerServerEvent("inventory.addItem", resourceRoot, output, "strongbox")
				dgs:dgsDxGUISetEnabled(source, false)
				cooldown = true
				setTimer(function(source) cooldown = false dgs:dgsDxGUISetEnabled(source, true) end, 1500, 1, source)
			end
		end
	end
)

function isPlayerUsingStrongbox()
	return dgs:dgsDxGUIGetVisible(WindowStrongbox)
end

addEventHandler("onClientPlayerWasted",localPlayer,function() dgs:dgsDxGUISetVisible(WindowStrongbox, false) end)
addEventHandler("onClientPlayerDamage",localPlayer,function() dgs:dgsDxGUISetVisible(WindowStrongbox, false) end)