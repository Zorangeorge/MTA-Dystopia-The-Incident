--[[function playerSkinChanged (oldModel)
	if getElementType(source) == "player" then
		triggerClientEvent("onPlayerModelChange", source)
	end
end

addEventHandler("onElementModelChange",root,playerSkinChanged)]]