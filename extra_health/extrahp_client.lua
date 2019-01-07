local validTypes =
	{
		[ "player" ] = true,
		[ "ped" ] = true,
		[ "vehicle" ] = true
	}
local oldHealth = getElementHealth ( localPlayer )

addEventHandler ( "onClientRender", root,
	function ( )
		local currentHealth = getElementHealth ( localPlayer )
		if ( currentHealth < oldHealth ) then
			if ( isElementInvulnerable ( localPlayer ) ) then
				setElementHealth ( localPlayer, oldHealth )
			else
				local health = getElementExtraHealth ( localPlayer )
				if ( health and health > 0 ) then
					local loss = ( oldHealth - currentHealth )
					setElementExtraHealth ( localPlayer, ( health - loss ) )
					setElementHealth ( localPlayer, oldHealth )
				end
			end
		end
		oldHealth = currentHealth
	end
)

addEventHandler ( "onClientPlayerStealthKill", root,
	function ( target )
		if isElementInvulnerable ( target ) then
			cancelEvent ( )
		end
	end
)

addEventHandler ( "onClientPlayerDamage", localPlayer,
	function ( _, _, _, loss )
		if isElementInvulnerable ( source ) then
			cancelEvent ( )
		else
			local health = getElementExtraHealth ( source )
			if ( health and health > 0 ) then
				setElementExtraHealth ( source, ( health - loss ) )
				cancelEvent ( )
			end
		end
	end
)

addEventHandler ( "onClientPedDamage", root,
	function ( _, _, _, loss )
		if isElementInvulnerable ( source ) then
			cancelEvent ( )
		else
			local health = getElementExtraHealth ( source )
			if ( health and health > 0 ) then
				setElementExtraHealth ( source, ( health - loss ) )
				cancelEvent ( )
			end
		end
	end
)

addEventHandler ( "onClientVehicleDamage", root,
	function ( _, _, loss )
		if ( not isVehicleDamageProof ( source ) ) then
			local health = getElementExtraHealth ( source )
			if ( health and health > 0 ) then
				setElementExtraHealth ( source, ( health - loss ) )
				cancelEvent ( )
			end
		end
	end
)

function getElementExtraHealth ( theElement )
	if ( not theElement or not isElement ( theElement ) ) then
		return false, "Invalid element"
	end

	if ( not validTypes [ getElementType ( theElement ) ] ) then
		return false, "Invalid element type"
	end

	return tonumber ( getElementData ( theElement, "extraHealth:value" ) )
end

function setElementExtraHealth ( theElement, theHealth )
	if ( not theElement or not isElement ( theElement ) ) then
		return false, "Invalid element"
	end

	if ( not validTypes [ getElementType ( theElement ) ] ) then
		return false, "Invalid element type"
	end

	if ( not tonumber ( theHealth ) ) then
		return false, "Invalid health value"
	end

	return setElementData ( theElement, "extraHealth:value", tonumber ( theHealth ) )
end

function isElementWithExtraHealth ( theElement )
	local health, errorMsg = getElementExtraHealth ( theElement )
	if ( not health ) then
		return false, errorMsg
	end

	return ( health > 0 )
end

function setElementInvulnerable ( theElement, theState )
	if ( not theElement or not isElement ( theElement ) ) then
		return false, "Invalid element"
	end

	if ( not validTypes [ getElementType ( theElement ) ] ) then
		return false, "Invalid element type"
	end

	return setElementData ( theElement, "extraHealth:invulnerable", theState )
end

function isElementInvulnerable ( theElement )
	if ( not theElement or not isElement ( theElement ) ) then
		return false, "Invalid element"
	end

	if ( not validTypes [ getElementType ( theElement ) ] ) then
		return false, "Invalid element type"
	end

	return getElementData ( theElement, "extraHealth:invulnerable" )
end