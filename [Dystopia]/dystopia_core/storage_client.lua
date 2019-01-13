local sx, sy = guiGetScreenSize()
local dgs = exports.dgs

local WindowStrongbox = dgs:dgsCreateWindow(198+330, 176, 250, 300, " ", false, nil, 3, slotTex1, nil, nil, tocolor(0,0,0,210), nil, true)
dgs:dgsDxWindowSetSizable(WindowStrongbox, false)
dgs:dgsDxGUISetVisible(WindowStrongbox, false)


local GridlistItems = dgs:dgsCreateGridList(0.04, 0.06, 0.92, 0.72, true, WindowStrongbox, 40, 0x96141414, 0x96141414, 0x96141414, tocolor(219, 67, 59), tocolor(219, 67, 59), tocolor(219, 150, 120),slotTex1)
dgs:dgsGridListAddColumn(GridlistItems, "", 0.9)
dgs:dgsDxGUISetProperty(GridlistItems,"sorting", true)

local window_title = dgs:dgsCreateLabel(0.04, -0.01, 0.9, 0.1, "Stockpile", true, GridlistItems)
dgs:dgsLabelSetHorizontalAlign(window_title, "center")
local Label = dgs:dgsCreateLabel(0.04, 1, 0.9, 0.1, "Slots: 0/0", true, GridlistItems)
dgs:dgsLabelSetHorizontalAlign(Label, "center")
local Take = dgs:dgsDxCreateButton(0.04, 0.88, 0.92, 0.09, "Take", true, WindowStrongbox, nil, nil, nil, nil, nil, nil, tocolor(219, 67, 59), tocolor(219+30, 67+30, 59+30), tocolor(219, 67, 59))

dgs:dgsSetFont(Take,"pricedown")
dgs:dgsSetFont(Label,"pricedown")
dgs:dgsSetFont(window_title,"pricedown")
--dgs:dgsSetFont(WindowStrongbox,"pricedown")
dgs:dgsSetProperty(WindowStrongbox,"font","pricedown")
--dgs:dgsSetProperty(WindowStrongbox,"font","default-bold")
addEvent("storage:stockpile", true)
addEventHandler("storage:stockpile", root,
	function (items, slots, name, container)
	
	if isPlayerUsingStrongbox() then return end
	
		if not items then
			dgs:dgsDxGUISetVisible(WindowStrongbox, false)
			if getElementData(container, "isContainerBeingUsed") == localPlayer then
				setElementData(container, "isContainerBeingUsed", nil)
			end
			return
		end
		if isInventoryOpen and not dgs:dgsDxGUIGetVisible(WindowStrongbox) then
			if isElement(getElementData(container, "isContainerBeingUsed")) then
				--outputChatBox("There's another player interacting with this container!", 255, 0, 0)
				outputTopBar("Container already in use!", 255,100,0)
				return
			end
			dgs:dgsDxGUISetVisible(WindowStrongbox, true)
			setElementData(container, "isContainerBeingUsed", localPlayer)
			dgs:dgsDxGridListClearRow(GridlistItems)
			for i,item in ipairs (items) do
				theNewRow = dgs:dgsDxGridListAddRow(GridlistItems)
				dgs:dgsDxGridListSetItemText(GridlistItems, theNewRow, 1, item)
			end
			dgs:dgsDxGUISetText(Label, "Slots: "..(#items).."/"..(slots))
			if name then
				dgs:dgsDxGUISetText(window_title, name)
			end
		else
			dgs:dgsDxGUISetVisible(WindowStrongbox, false)
			if getElementData(container, "isContainerBeingUsed") == localPlayer then
				setElementData(container, "isContainerBeingUsed", nil)
			end
			--outputChatBox("duh")
		end
	end
)

addEvent("RefreshDraw", true)
addEventHandler("RefreshDraw", root,
	function (cType, t, slots)
		if not cType == "stockpile" then return end
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
			--outputChatBox("Please wait a second.")
			outputTopBar("Please wait a second", 240,200,0)
			return
		end
		if source == Take and state == "down" then
			local selected = dgs:dgsDxGridListGetSelectedItem(GridlistItems)
			if selected and selected ~= -1 then 
				local output = dgs:dgsDxGridListGetItemText(GridlistItems, selected, 1)
				exports.dgs:dgsDxGridListRemoveRow(GridlistItems, selected)
				triggerServerEvent("inventory.addItem", resourceRoot, output, "stockpile")
				dgs:dgsDxGUISetEnabled(source, false)
				cooldown = true
				setTimer(function(source) cooldown = false dgs:dgsDxGUISetEnabled(source, true) end, 1500, 1, source)
			end
		end
	end
)
function isPlayerUsingStockpile()
	return dgs:dgsDxGUIGetVisible(WindowStrongbox)
end

function isPlayerUsingContainer()
	return isPlayerUsingStockpile() and "stockpile" or isPlayerUsingStrongbox() and "strongbox" or false
end

addEventHandler("onClientPlayerWasted",localPlayer,function() dgs:dgsDxGUISetVisible(WindowStrongbox, false) end)
addEventHandler("onClientPlayerDamage",localPlayer,function() dgs:dgsDxGUISetVisible(WindowStrongbox, false) end)

addEvent("onCloseStorageWindow",true)
function closeStorageWindow ()
dgs:dgsDxGUISetVisible(WindowStrongbox, false)
end
addEventHandler("onCloseStorageWindow",localPlayer,closeStorageWindow)