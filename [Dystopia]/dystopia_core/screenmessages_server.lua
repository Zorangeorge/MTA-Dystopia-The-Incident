function outputTopBar( message, thePlayer, red, green, blue )
	if isElement( thePlayer ) then
		triggerClientEvent ( thePlayer, "onTextAdd", thePlayer, message, red, green, blue )
	end
end

function outputStatusInfo( message, thePlayer, red, green, blue )
	if isElement( thePlayer ) then
		triggerClientEvent ( thePlayer, "onStatusAdd", thePlayer, message, red, green, blue )
	end
end

function outputInteractInfo( message, thePlayer, red, green, blue )
	if isElement( thePlayer ) then
		triggerClientEvent ( thePlayer, "onInteractAdd", thePlayer, message, red, green, blue )
	end
end


--[[function outputCurrentWorldItem( itemName, thePlayer , full)
	if isElement( thePlayer ) then
		triggerClientEvent ( thePlayer, "currentWorldItemChange", thePlayer, itemName, full )
	end
end

function clearCurrentWorldItem( thePlayer )
	if isElement( thePlayer ) then
		triggerClientEvent ( thePlayer, "clearTheCurrentWorldItem", thePlayer )
	end
end]]