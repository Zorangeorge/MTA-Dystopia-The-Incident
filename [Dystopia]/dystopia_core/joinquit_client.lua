addEventHandler('onClientPlayerJoin', root,
	function()
	
	local player = source
	--local country = exports.admin:getPlayerCountry(player)
		--outputDebugString(tostring(country))
		
		outputTopBar("" .. getPlayerName(source) .. " joined", 219, 75, 219)
		
	end
)

addEventHandler('onClientPlayerChangeNick', root,
	function(oldNick, newNick)
		outputTopBar("" .. oldNick .. " is now known as " .. newNick.."", 219, 75, 219)
	end
)

addEventHandler('onClientPlayerQuit', root,
	function(reason)
		outputTopBar("" .. getPlayerName(source) .. " left [" .. reason .. "]", 219, 75, 219)
	end
)



--[[

setWeaponProperty(22,"pro","flags",0x000002)
setWeaponProperty(22,"std","flags",0x000002)
setWeaponProperty(22,"poor","flags",0x000002)

setWeaponProperty(22,"pro","flags",0x000008)
setWeaponProperty(22,"std","flags",0x000008)
setWeaponProperty(22,"poor","flags",0x000008)

setWeaponProperty(22,"pro","flags",0x000004)
setWeaponProperty(22,"std","flags",0x000004)
setWeaponProperty(22,"poor","flags",0x000004)

setPedWalkingStyle(localPlayer,128)

]]