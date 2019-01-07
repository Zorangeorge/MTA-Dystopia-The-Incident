local validTypes =
	{
		[ "player" ] = true,
		[ "ped" ] = true,
		[ "vehicle" ] = true
	}

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